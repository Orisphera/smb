.include	"system/cpu.i"

.include	"math.i"
.include	"mem.i"
.include	"tunables.i"
.include	"misc.i"
.include	"sound.i"

; -----------------------------------------------------------
POWERUP_OFFSET_BLOCK_Y	= 8
POWERUP_VELOC_Y		= 16
POWERUP_COL_BOX		= col_boxes::box_3

POWERUP_CUE_DISPLAY_FRAMES	= 24
POWERUP_CUE_SPAWNED_FRAMES	= 68
POWERUP_CUE_UNITS		= (MOD_4+1)
POWERUP_CUE_DISPLAY		= (POWERUP_CUE_DISPLAY_FRAMES/POWERUP_CUE_UNITS)
POWERUP_CUE_SPAWNED		= (POWERUP_CUE_SPAWNED_FRAMES/POWERUP_CUE_UNITS)
; -----------------------------------------------------------
	.export actor_init_powerup, actor_init_powerup_b
	.export	actor_B_19_init
actor_init_powerup_b:
	lda	#actor::power_up
	sta	obj_id_actor+POWERUP_ACTOR_IDX
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
actor_B_19_init:
	lda	#proc_id_actors::active
	sta	state_actor+POWERUP_ACTOR_IDX
	sta	proc_id_actor+POWERUP_ACTOR_IDX
	lda	#POWERUP_COL_BOX
	sta	col_box_actor+POWERUP_ACTOR_IDX

	lda	actor_powerup_type
	cmp	#powerup_type::star
	bcs	:++ ; if (this.type < star) {
		lda	player_status
		cmp	#player_statuses::power_firefl
		bcc	:+ ; if (player.status >= firefl) {
			lsr	a
		: ; }
		sta	actor_powerup_type
	: ; }

	lda	#obj_attr::priority_low|obj_attr::color0
	sta	attr_actor+POWERUP_ACTOR_IDX
	lda	#sfx_pulse_2::spawn_powerup
	sta	apu_sfx_pulse_2_req
	rts
; ------------------------------------------------------------
	.export actor_proc_powerup
	.export	actor_B_19_proc
actor_proc_powerup:
actor_B_19_proc:
	ldx	#POWERUP_ACTOR_IDX
	stx	actor_index
	lda	state_actor+POWERUP_ACTOR_IDX
	beq	:+++++ ; if (this.state != dead) {
		asl	a
		bcc	:++
		lda	game_timer_stop
		bne	:++++
		lda	actor_powerup_type
		beq	:+
		cmp	#powerup_type::mushroom_oneup
		beq	:+
		.if	.defined(SMBV2)
			cmp	#powerup_type::mushroom_poison
			beq	:+
			cmp	#powerup_type::type_05
			beq	:+
		.endif
		cmp	#powerup_type::star
		bne	:++++ ; if (this.spawned && !game_timer_stop && this.type == star) {
			jsr	actor_proc_bounce
			jsr	col_actor_bounce_proc
			jmp	:++++
		: ; } else if (this.spawned && !game_timer_stop && this.type.in(mushroom, type_05)) {
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
			jsr	pos_calc_x_rel_actor
			jsr	pos_bits_get_actor

			jsr	col_actor_box

			jsr	render_powerup

			jsr	col_player_actor_proc
			jsr	col_actor_oob_proc
		; }
	: ; }

	rts
