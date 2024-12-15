.include	"joypad.i"
.include	"mem.i"
.include	"tunables.i"

TIMER_SPRING_CONTINUE	= 4

actor_proc_spring_pos_y:
	.byte	8, 16, 8, 0
; -----------------------------
	.export actor_proc_spring
	.export	actor_B_1D_proc
actor_proc_spring:
actor_B_1D_proc:
	jsr	pos_bits_get_actor

	lda	game_timer_stop
	bne	actor_proc_spring_ctd
	lda	player_on_spring
	beq	actor_proc_spring_ctd ; if (!game_timer_stop && player.on_spring) {
		tay
		dey
		tya
		and	#%00000010
		bne	:+ ; if (!((player.on_spring - 1) & 0x02)) {
			inc	pos_y_lo_player
			inc	pos_y_lo_player
			jmp	:++
		: ; } else {
			dec	pos_y_lo_player
			dec	pos_y_lo_player
		: ; }

		lda	veloc_x_actor, x
		clc
		adc	actor_proc_spring_pos_y, y
		sta	pos_y_lo_actor, x

		cpy	#1
		bcc	actor_proc_spring_skip_accel
		lda	joypad_a_b
		and	#joypad_button::face_a
		beq	actor_proc_spring_skip_accel
		and	joypad_a_b_held
		bne	actor_proc_spring_skip_accel ; if ((player.on_spring - 1) >= 1 && (joypad_a_b & 0x80) && !(joypad_a_b & joypad_a_b_held 0x80)) {
			.if	.defined(SMBV2)
				tya
				pha
			.endif

			lda	#SPRING_ACCEL_Y
			.if	.defined(SMB2)
				ldy	course_no
				cpy	#course::no_02
				beq	:+
				cpy	#course::no_03
				beq	:+
				cpy	#course::no_07
				bne	:++
				: ; if (SMBV2 && course_no.in(2, 3, 7)) {
					lda	#SPRING_SPECIAL_ACCEL_Y
				: ; }
			.elseif	.defined(ANN)
				ldy	ENG_HARDMODE_VAR
				beq	:+ ; if (ANN && hard_mode) {
					jsr	game_hard_mode_spring
				: ; }
			.endif
			sta	accel_y_spring

			.if	.defined(SMBV2)
				pla
				tay
			.endif
		actor_proc_spring_skip_accel: ; }
		cpy	#3
		bne	:+ ; if ((player.on_spring - 1) == 3) {
			lda	accel_y_spring
			sta	veloc_y_player

			.if	.defined(PAL)
				lda	#64
				sta	accel_y_player_spring
			.endif

			lda	#0
			sta	player_on_spring
		; }
	: ; }

actor_proc_spring_ctd:
	jsr	pos_calc_x_rel_actor
	jsr	render_actor
	jsr	col_actor_oob_proc

	lda	player_on_spring
	beq	:+
	lda	timer_spring
	bne	:+ ; if (player.on_spring && spring.timer == 0) {
		lda	#TIMER_SPRING_CONTINUE
		sta	timer_spring
		inc	player_on_spring
	: ; }

	rts
