.include	"sys/ppu.i"

.include	"math.i"
.include	"mem.i"
.include	"modes.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"
.include	"joypad.i"
.include	"sound.i"
.include	"macros.i"

; ------------------------------------------------------------
OOB_PROC_OFFSET_X		= 72
OOB_PROC_SPEC_ENEMY_LEFT_OFF	= 56
; ------------------------------------------------------------
oob_proc_offset_x_left_hi	= zp_byte_00
oob_proc_offset_x_left_lo	= zp_byte_01
oob_proc_offset_x_right_hi	= zp_byte_02
oob_proc_offset_x_right_lo	= zp_byte_03

	.export actor_oob_proc
actor_oob_proc:
	lda	obj_id_actor, x
	cmp	#actor::cheep_fly
	beq	:++++ ; if (actor.id != cheep_fly) {
		lda	pos_x_lo_screen_left
		ldy	obj_id_actor, x
		cpy	#actor::hammer_bro
		beq	:+
		.if	.defined(SMBV2)
			cpy	#actor::piranha_plant_b
			beq	:+
		.endif
		cpy	#actor::piranha_plant
		bne	:++
		: ; if (actor.id.in(hammer_bro, piranha_plant)) {
			adc	#OOB_PROC_SPEC_ENEMY_LEFT_OFF
		: ; }
		sbc	#<OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_left_lo
	
		lda	pos_x_hi_screen_left
		sbc	#>OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_left_hi
		lda	pos_x_lo_screen_right
		adc	#<OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_right_lo
		lda	pos_x_hi_screen_right
		adc	#>OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_right_hi

		lda	pos_x_lo_actor, x
		cmp	oob_proc_offset_x_left_lo
		lda	pos_x_hi_actor, x
		sbc	oob_proc_offset_x_left_hi
		bmi	:+
		lda	pos_x_lo_actor, x
		cmp	oob_proc_offset_x_right_lo
		lda	pos_x_hi_actor, x
		sbc	oob_proc_offset_x_right_hi
		bmi	:++
		lda	state_actor, x
		cmp	#actor_states::state_5
		beq	:++
		cpy	#actor::piranha_plant
		beq	:++
		.if	.defined(SMBV2)
			cpy	#actor::piranha_plant_b
			beq	:++
		.endif
		cpy	#actor::flag_enemy
		beq	:++
		cpy	#actor::flag_victory
		beq	:++
		cpy	#actor::spring
		beq	:++
		: ; if (
		;	actor.pos_x < screen.pos_x_left
		;	|| (
		;		actor.pos_x >= screen.pos_x_right
		;		&& actor.state &= state_5
		;		&& actor.id.not_in(piranha_plant, flag_enemy, flag_victory, spring)
		;		&& (!SMBV2 || actor.id != piranha_plant_b)
		;	) {
			jsr	actor_erase
		: ; }
	; }

	rts
