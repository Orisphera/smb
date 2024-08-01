.include	"system/cpu.i"

.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/misc.i"
.include	"engine/sound.i"

.include	"engine/unk.i"

POWERUP_ACTOR_IDX	= (ENG_ACTOR_MAX-1)
POWERUP_OFFSET_BLOCK_Y	= 8
POWERUP_VELOC_Y		= 16
POWERUP_COL_BOX		= 3
POWERUP_CUE_DISPLAY_FRAMES	= 24
POWERUP_CUE_SPAWNED_FRAMES	= 68
POWERUP_CUE_UNITS		= (MOD_4+1)
POWERUP_CUE_DISPLAY	= (POWERUP_CUE_DISPLAY_FRAMES/POWERUP_CUE_UNITS)
POWERUP_CUE_SPAWNED	= (POWERUP_CUE_SPAWNED_FRAMES/POWERUP_CUE_UNITS)

	.export actor_init_powerup, actor_init_powerup_b
actor_init_powerup_b:
	lda	#actor::power_up
	sta	actor_id+POWERUP_ACTOR_IDX
	lda	pos_x_hi_block, x
	sta	pos_x_hi_actor+POWERUP_ACTOR_IDX
	lda	pos_x_lo_block, x
	sta	pos_x_lo_actor+POWERUP_ACTOR_IDX
	lda	#1
	sta	pos_y_hi_actor+POWERUP_ACTOR_IDX
	lda	pos_y_lo_block, x
	sec
	sbc	#POWERUP_OFFSET_BLOCK_Y
	sta	pos_y_lo_actor+POWERUP_ACTOR_IDX

actor_init_powerup:
	lda	#actor_modes::active
	sta	state_actor+POWERUP_ACTOR_IDX
	sta	actor_mode+POWERUP_ACTOR_IDX
	lda	#POWERUP_COL_BOX
	sta	col_box_actor+POWERUP_ACTOR_IDX

	lda	eng_powerup_type
	cmp	#powerup_type::star
	bcs	:++ ; if (this.type < star) {
		lda	player_status
		cmp	#2
		bcc	:+ ; if (player.status >= 2) {
			lsr	a
		: ; }
		sta	eng_powerup_type
	: ; }

	lda	#obj_attr::priority_low|obj_attr::color0
	sta	attr_actor+POWERUP_ACTOR_IDX
	lda	#sfx_pulse2::spawn_powerup
	sta	apu_pulse2_queue
	rts
; ------------------------------------------------------------
	.export actor_proc_powerup
actor_proc_powerup:
	ldx	#POWERUP_ACTOR_IDX
	stx	actor_index
	lda	state_actor+POWERUP_ACTOR_IDX
	beq	:+++++ ; if (this.state != dead) {
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
		bne	:++++ ; if (this.spawned && !eng_timer_ctl && this.type == star) {
			jsr	actor_proc_bounce
			jsr	col_actor_bounce_proc
			jmp	:++++
		: ; } else if (this.spawned && !eng_timer_ctl && this.type.in(mushroom_a, mushroom_b, type_03, type_04)) {
			jsr	actor_proc_base
			jsr	col_actor_ground_proc
			jmp	:+++
		: ; } else if (!this.spawned) {
			lda	frame_count
			and	#MOD_4
			bne	:+ ; if (!(frame_count % 4)) {
				dec	pos_y_lo_actor+POWERUP_ACTOR_IDX
				lda	state_actor+POWERUP_ACTOR_IDX
				inc	state_actor+POWERUP_ACTOR_IDX
				cmp	#POWERUP_CUE_SPAWNED
				bcc	:+ ; if (this.state >= cue_spawned) {
					lda	#POWERUP_VELOC_Y
					sta	veloc_x_actor, x
					lda	#actor_states::spawned
					sta	state_actor+POWERUP_ACTOR_IDX
					asl	a
					sta	attr_actor+POWERUP_ACTOR_IDX
					rol	a
					sta	motion_dir_actor, x
				; }
			: ; }

			lda	state_actor+POWERUP_ACTOR_IDX
			cmp	#POWERUP_CUE_DISPLAY
			bcc	:++
		: ; }

		; if (this.state > cue_display) {
			jsr	lib_calc_actor_pos
			jsr	lib_actor_bits_get
			jsr	col_actor_box
			jsr	render_powerup
			jsr	col_player_actor_proc
			jsr	col_actor_oob_proc
		; }
	: ; }

	rts
