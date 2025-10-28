.include	"math.i"
.include	"joypad.i"
.include	"mem.i"
.include	"mem_low.i"
.include	"misc.i"
.include	"sound.i"

	.export	proj_proc
proj_proc:
	lda	player_status
	cmp	#player_statuses::power_firefl
	bcc	:++ ; if (player.status >= power_firefl) {
		lda	joypad_a_b
		and	#joypad_button::face_b
		beq	:+
		and	joypad_a_b_held
		bne	:+
		lda	proj_counter
		and	#MOD_2
		tax
		lda	state_proj, x
		bne	:+
		ldy	pos_y_hi_player
		dey
		bne	:+
		lda	player_crouching
		bne	:+
		lda	state_player
		cmp	#player_state::climb
		beq	:+ ; if (
			;	(pressed_b)
			;	&& !(held_b)
			;	&& this.state[proj_counter % 1] == inactive
			;	&& !(--player.pos_y.hi)
			;	&& !player.crouching
			;	&& player.state != climb
			; ) {
			lda	#sfx_pulse_1::proj
			sta	apu_sfx_pulse_1_req
			lda	#proj_states::state_2
			sta	state_proj, x
			ldy	timer_ani_player
			sty	timer_proj_throw
			dey
			sty	timer_ani_proj
			inc	proj_counter
		: ; }
	
		ldx	#0
		jsr	proj_proc_do
		ldx	#1
		jsr	proj_proc_do
	: ; }

	lda	course_type
	bne	:++ ; if (course.type == water) {
		ldx	#3-1
		: ; for (x = 3-1; x >= 0; x--) {
			stx	actor_index
			jsr	bubble_proc

			jsr	pos_calc_x_rel_bubble
			jsr	pos_bits_get_bubble

			jsr	bubble_render

			dex
			bpl	:-
		; }
	: ; }
	rts
; ----------------------------------------------------------------------
proj_proc_veloc_x:
	.byte	PROJ_VELOC_X_ABS, <-PROJ_VELOC_X_ABS
; ----------------------------------
proj_proc_do:
	stx	actor_index
	lda	state_proj, x
	asl	a
	bcs	:+++ ; if (proj.bit_7) {
		ldy	state_proj, x
		beq	proj_proc_do_rts
		dey
		beq	:+ ; if (proj.state == state_1) {
			lda	pos_x_lo_player
			adc	#4
			sta	pos_x_lo_proj, x
			lda	pos_x_hi_player
			adc	#0
			sta	pos_x_hi_proj, x
			lda	pos_y_lo_player
			sta	pos_y_lo_proj, x
			lda	#1
			sta	pos_y_hi_proj, x
			ldy	disp_dir_player
			dey
			lda	proj_proc_veloc_x, y
			sta	veloc_x_proj, x
			lda	#PROJ_VELOC_Y
			sta	veloc_y_proj, x
			lda	#col_boxes::box_7
			sta	col_box_proj, x
			dec	state_proj, x
		: ; }
		txa
		clc
		adc	#ENG_PROJ_OFF
		tax

		lda	#PROJ_ACCEL_Y_INC
		sta	motion_gravity_accel_y_inc
		lda	#PROJ_VELOC_Y_MAX
		sta	motion_gravity_veloc_y_max_abs
		lda	#0
		jsr	motion_gravity
		jsr	motion_x_do

		ldx	actor_index
		jsr	pos_calc_x_rel_proj
		jsr	pos_bits_get_proj
		jsr	col_proj_box
		jsr	col_proj_proc

		lda	bits_offscr_proj
		and	#%11001100
		bne	:+ ; if () {
			jsr	col_proj_actor_proc
			jmp	render_proj
		: ; } else {
			lda	#proj_states::inactive
			sta	state_proj, x
		proj_proc_do_rts:
			rts
		; }
	: ; } else {
		jsr	pos_calc_x_rel_proj
		jmp	render_proj_hit
	; }
