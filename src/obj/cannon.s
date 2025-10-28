.include	"math.i"
.include	"joypad.i"
.include	"mem.i"
.include	"misc.i"
.include	"sound.i"

cannon_proc_masks:
	.byte	MOD_16
	.byte	MOD_8
; -----------------------------
	.export cannon_proc
cannon_proc:
	lda	course_type
	beq	:+++++ ; if (course_type != water) {
		ldx	#2
		: ; for (actor_index = 2; actor_index >= 0; actor_index--) {
			stx	actor_index
			lda	proc_id_actor, x
			bne	:++
			lda	srand+1, x
			ldy	game_hard_mode_b
			and	cannon_proc_masks, y
			cmp	#ENG_ACTOR_MAX
			bcs	:++
			tay
			lda	pos_y_hi_cannon, y
			beq	:++ ; if (
			;	actor.mode == dead
			;	&& (srand[actor_index+1] & player_proc_cannon_masks[game_hard_mode_b]) < ENG_ACTOR_MAX
			;	&& (pos_y_hi_cannon[(srand[actor_index+1])])
			; ) {
				lda	timer_cannon, y
				beq	:+ ; if (timer_cannon[rand_masked]) {
					sbc	#0
					sta	timer_cannon, y
					jmp	:++
				: ; } else {
					lda	game_timer_stop
					bne	:+ ; if (!game_timer_stop) {
						lda	#14
						sta	timer_cannon, y
						lda	pos_y_hi_cannon, y
						sta	pos_x_hi_actor, x
						lda	pos_x_lo_cannon, y
						sta	pos_x_lo_actor, x
						lda	pos_y_lo_cannon, y
						sec
						sbc	#8
						sta	pos_y_lo_actor, x
						lda	#proc_id_actors::active
						sta	pos_y_hi_actor, x
						sta	proc_id_actor, x
						lsr	a
						sta	state_actor, x
						lda	#9
						sta	col_box_actor, x
						lda	#actor::bullet
						sta	obj_id_actor, x
						jmp	:++
					; }
				; }
			: ; }

			; if (this.mode != dead || rand_masked >= 6 || !pos_y_hi_cannon[rand_masked] || timer_cannon[rand_masked] || game_timer_stop) {
				lda	obj_id_actor, x
				cmp	#actor::bullet
				bne	:+ ; if (this.obj_id_actor == bullet) {
					jsr	actor_oob_proc
			
					lda	proc_id_actor, x
					beq	:+ ; if (this.mode != dead) {
						jsr	pos_bits_get_actor

						jsr	cannon_bullet_proc
					; }
				; }
			: ; }
		
			dex
			bpl	:----
		; }
	: ; }

	rts
; -----------------------------------------------------------
cannon_bullet_veloc_x:
	.byte	BULLET_VELOC_X_ABS, <-BULLET_VELOC_X_ABS
; -----------------------------
cannon_bullet_proc:
	lda	game_timer_stop
	bne	:++++ ; if (!game_timer_stop) {
		lda	state_actor, x
		bne	:++ ; if (this.state == dead) {
			lda	bits_offscr_actor
			and	#%00001100
			cmp	#%00001100
			beq	:+++++ ; if ((bits_offscr_actor & 0x0C) != 0x0C) {
				ldy	#DIR_RIGHT
				jsr	col_player_bullet_diff
				bmi	:+ ; if (col_player_bullet_diff() >= 0) {
					iny
				: ; }
				sty	motion_dir_actor, x
				dey
				lda	cannon_bullet_veloc_x, y
				sta	veloc_x_actor, x
				lda	col_player_bullet_diff_pos_x_rel
				adc	#40
				cmp	#80
				bcc	:++++ ; if ((col_player_bullet_diff_pos_x_rel + 40) >= 80) {
					lda	#actor_states::state_1
					sta	state_actor, x
					lda	#BULLET_ANI_TIMER
					sta	timer_ani_actor, x
					lda	#sfx_pulse_2::blast
					sta	apu_sfx_pulse_2_req
				; }
			; }
		: ; }

		lda	state_actor, x
		and	#actor_states::bit_5
		beq	:+ ; if (this.state & bit_5) {
			jsr	motion_y
		: ; }
	
		jsr	motion_x
	: ; }

	; if (game_timer_stop || this.state != 0 || ((bits_offscr_actor & 0x0C) != 0x0C && (zp_byte_00 + 0x28) >= 0x50)) {
		jsr	pos_bits_get_actor
		jsr	pos_calc_x_rel_actor

		jsr	col_actor_box
		jsr	col_player_actor_proc

		jmp	render_actor
	: ; } else {
		jsr	actor_erase
		rts
	; }
