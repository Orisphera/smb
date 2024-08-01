.include	"system/cpu.i"

.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/tiles.i"
.include	"engine/sound.i"

.include	"engine/unk.i"

OBJ_MISC_POWERUP_ACTOR	= (ENG_ACTOR_MAX-1)

	.export obj_spec_powerup_init
	.export obj_spec_powerup_init_b
obj_spec_powerup_init:
	lda	#actor::power_up
	sta	actor_id+OBJ_MISC_POWERUP_ACTOR
	lda	pos_x_hi_spec, x
	sta	pos_x_hi_actor+OBJ_MISC_POWERUP_ACTOR
	lda	pos_x_lo_spec, x
	sta	pos_x_lo_actor+OBJ_MISC_POWERUP_ACTOR
	lda	#1
	sta	pos_y_hi_actor+OBJ_MISC_POWERUP_ACTOR
	lda	pos_y_lo_spec, x
	sec
	sbc	#8
	sta	pos_y_lo_actor+OBJ_MISC_POWERUP_ACTOR

obj_spec_powerup_init_b:
	lda	#actor_modes::active
	sta	state_actor+OBJ_MISC_POWERUP_ACTOR
	sta	actor_mode+OBJ_MISC_POWERUP_ACTOR
	lda	#3
	sta	col_box_actor+OBJ_MISC_POWERUP_ACTOR

	lda	eng_powerup_type
	cmp	#powerup_type::star
	bcs	:++ ; if (powerup.type < star) {
		lda	player_status
		cmp	#2
		bcc	:+ ; if (player.status >= 2) {
			lsr	a
		: ; }
		sta	eng_powerup_type
	: ; }

	lda	#$20
	sta	byte_3CA
	lda	#pulse_queue::pulse_2
	sta	apu_pulse2_queue
	rts
; ------------------------------------------------------------
	.export obj_spec_powerup_do
obj_spec_powerup_do:
	ldx	#OBJ_MISC_POWERUP_ACTOR
	stx	actor_index
	lda	state_actor+OBJ_MISC_POWERUP_ACTOR
	beq	:+++++ ; if (powerup.state != state_00) {
		asl	a
		bcc	:++
		lda	eng_timer_ctl
		bne	:++++
		lda	eng_powerup_type
		beq	:+
		cmp	#powerup_type::mushroom_b
		beq	:+
		.if	.defined(SMB2M)
			cmp	#powerup_type::type_04
			beq	:+
			cmp	#powerup_type::type_05
			beq	:+
		.endif
		cmp	#powerup_type::star
		bne	:++++ ; if ((powerup.state & 0x80) && !eng_timer_ctl && powerup.type == star) {
			jsr	actor_proc_bounce
			jsr	col_actor_bounce_proc
			jmp	:++++
		: ; } else if ((powerup.state & 0x80) && !eng_timer_ctl && powerup.type.in(mushroom_a, mushroom_b, type_03, type_04)) {
			jsr	actor_proc_base
			jsr	col_actor_ground_proc
			jmp	:+++
		: ; } else if (!eng_timer_ctl) {
			lda	frame_count
			and	#3
			bne	:+ ; if (frame_count % 4) {
				dec	pos_y_lo_actor+OBJ_MISC_POWERUP_ACTOR
				lda	state_actor+OBJ_MISC_POWERUP_ACTOR
				inc	state_actor+OBJ_MISC_POWERUP_ACTOR
				cmp	#%00010000|actor_states::state_1
				bcc	:+ ; if (powerup.state >= 0x11) {
					lda	#16
					sta	veloc_x_actor, x
					lda	#%10000000
					sta	state_actor+OBJ_MISC_POWERUP_ACTOR
					asl	a
					sta	byte_3CA
					rol	a
					sta	motion_dir_actor, x
				; }
			: ; }

			lda	state_actor+OBJ_MISC_POWERUP_ACTOR
			cmp	#actor_states::state_6
			bcc	:++
		: ; }

		; if ((!(powerup.state & 0x80) && eng_timer_ctl) || powerup.type.in(mushroom_a, star, mushroom_b) || powerup.state >= 6) {
			jsr	lib_calc_actor_pos
			jsr	lib_actor_bits_get
			jsr	col_actor_box
			jsr	render_powerup
			jsr	col_player_actor_proc
			jsr	col_actor_oob_proc
		; }
	: ; }

	rts
