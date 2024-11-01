.include	"joypad.i"
.include	"mem.i"
.include	"tunables.i"

actor_proc_spring_pos_y:
	.byte	8, 16, 8, 0
; -----------------------------
	.export actor_proc_spring
actor_proc_spring:
	jsr	lib_actor_bits_get
	lda	eng_timer_ctl
	bne	actor_proc_spring_ctd
	lda	eng_spring_ani
	beq	actor_proc_spring_ctd ; if (!eng_timer_ctl && eng_spring_ani) {
		tay
		dey
		tya
		and	#%00000010
		bne	:+ ; if (!((eng_spring_ani - 1) & 0x02)) {
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
		bne	actor_proc_spring_skip_accel ; if ((eng_spring_ani - 1) >= 1 && (joypad_a_b & 0x80) && !(joypad_a_b & joypad_a_b_held 0x80)) {
			.if	.defined(SMB2M)
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
				: ; if (SMB2M && course_no.in(2, 3, 7)) {
					lda	#SPRING_SPECIAL_ACCEL_Y
				: ; }
			.elseif	.defined(ANN)
				ldy	ENG_HARDMODE_VAR
				beq	:+ ; if (ANN && hard_mode) {
					jsr	game_hard_mode_spring
				: ; }
			.endif
			sta	accel_y_spring

			.if	.defined(SMB2M)
				pla
				tay
			.endif
		actor_proc_spring_skip_accel: ; }
		cpy	#3
		bne	:+ ; if ((eng_spring_ani - 1) == 3) {
			lda	accel_y_spring
			sta	veloc_y_player

			.if	.defined(PAL)
				lda	#64
				sta	accel_y_player
			.endif

			lda	#0
			sta	eng_spring_ani
		; }
	: ; }

actor_proc_spring_ctd:
	jsr	lib_calc_actor_pos
	jsr	render_actor
	jsr	col_actor_oob_proc

	lda	eng_spring_ani
	beq	:+
	lda	timer_spring
	bne	:+ ; if (eng_spring_ani && !timer_spring) {
		lda	#4
		sta	timer_spring
		inc	eng_spring_ani
	: ; }

	rts
