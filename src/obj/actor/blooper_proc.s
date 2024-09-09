.include	"math.i"
.include	"mem.i"
.include	"joypad.i"

; -----------------------------------------------------------
BLOOPER_ACCEL_OFFSET_Y		= 1
BLOOPER_MOTION_TIMER		= 2
BLOOPER_VELOC_X_Y_OFFSET	= 2
BLOOPER_ACCEL_Y_THRESH		= 32
; -----------------------------------------------------------
actor_proc_blooper_flip_chance:
	.ifndef	PAL
		.byte	MOD_64, MOD_4
	.else
		.byte	MOD_8, MOD_2
	.endif
; ----------------------------
	.export actor_proc_blooper
actor_proc_blooper:
	lda	state_actor, x
	and	#actor_states::bit_5
	bne	:++++++ ; if (!(actor.state & 0x20)) {
		ldy	game_hard_mode_b
		lda	srand+1, x
		and	actor_proc_blooper_flip_chance, y
		bne	:+++ ; if (!(flip_chance[is_hard] & srand[1])) {
			txa
			lsr	a
			bcc	:+ ; if ((actor_index % 2)) {
				ldy	motion_dir_player

				bcs	:++
			: ; } else {
				ldy	#DIR_LEFT

				jsr	col_player_bullet_diff
				bpl	:+ ; if (col_player_bullet_diff() < 0) {
					dey
				; }
			: ; }
			sty	motion_dir_actor, x
		: ; }

		jsr	actor_proc_swim

		lda	pos_y_lo_actor, x
		sec
		sbc	accel_y_actor_c, x
		cmp	#BLOOPER_ACCEL_Y_THRESH
		bcc	:+ ; if ((actor.pos_y.lo - actor.accel_y) >= threshold) {
			sta	pos_y_lo_actor, x
		: ; }

		ldy	motion_dir_actor, x
		dey
		bne	:+ ; if () {
			lda	pos_x_lo_actor, x
			clc
			adc	veloc_x_actor, x
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_actor, x
			adc	#0
			sta	pos_x_hi_actor, x

			rts
		: ; } else {
			lda	pos_x_lo_actor, x
			sec
			sbc	veloc_x_actor, x
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_actor, x
			sbc	#0
			sta	pos_x_hi_actor, x

			rts
		; }
	: ; } else {
		jmp	motion_fall_slow
	; }
; -----------------------------------------------------------
actor_proc_swim:
	lda	veloc_y_actor, x
	and	#MOD_4_2_UP
	bne	:++++ ; if ((this.veloc_y % 4) >= 2) {
		lda	frame_count
		and	#MOD_8
		pha

		lda	veloc_y_actor, x
		lsr	a
		bcs	:++ ; if (!(this.veloc_y % 2)) {
			pla
			bne	:+ ; if (!(frame_count % 8)) {
				lda	accel_y_actor_c, x
				clc
				adc	#BLOOPER_ACCEL_OFFSET_Y
				sta	accel_y_actor_c, x
				sta	veloc_x_actor, x
				cmp	#BLOOPER_VELOC_X_Y_OFFSET
				bne	:+ ; if (this.veloc_x == veloc_x_y_offset) {
					inc	veloc_y_actor, x
				; }
			: ; }

			rts
		: ; } else {
			pla
			bne	:+ ; if (!(frame_count % 8)) {
				lda	accel_y_actor_c, x
				sec
				sbc	#BLOOPER_ACCEL_OFFSET_Y
				sta	accel_y_actor_c, x
				sta	veloc_x_actor, x
				bne	:+ ; if (this.veloc_x == 0) {
					inc	veloc_y_actor, x

					lda	#BLOOPER_MOTION_TIMER
					sta	timer_actor, x
				; }
			: ; }

			rts
		; }
	: ; } else {
		lda	timer_actor, x
		beq	:+++
		: ; if (this.timer != 0 || (this.pos_y + 16) < player.pos_y) {
			lda	frame_count
			lsr	a
			bcs	:+ ; if (!(frame_count % 2)) {
				inc	pos_y_lo_actor, x
			: ; }

			rts
		: lda	pos_y_lo_actor, x
		adc	#BLOOPER_PLAYER_MOTION_OFFSET_Y
		cmp	pos_y_lo_player
		bcc	:--- ; } else {
			lda	#0
			sta	veloc_y_actor, x

			rts
		; }
	; }

