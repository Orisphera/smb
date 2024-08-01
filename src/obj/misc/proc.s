.include	"engine/mem.i"
.include	"engine/tunables.i"

.include	"engine/unk.i"

; ----------------------------------------------------------
MISC_ACCEL_Y_INC		= 80
MISC_VELOC_Y_MAX_ABS_6		= 6
MISC_GRAVITY_INIT		= 0
MISC_VELOC_Y_STATE_CUTOFF	= 5
; -----------------------------------------------------------
	.export	misc_proc
misc_proc:
	ldx	#ENG_MISC_MAX-1
	: ; for (obj of misc) {
		stx	actor_index
		lda	state_misc, x
		beq	:++++
		asl	a
		bcc	:+ ; if (this.spawned) {
			jsr	misc_proc_hammer
			jmp	:++++
		: ; } else if (this.state != init) {
			ldy	state_misc, x
			dey
			beq	:+ ; if (this.state != 1) {
				inc	state_misc, x

				lda	pos_x_lo_misc, x
				clc
				adc	eng_scroll_amount
				sta	pos_x_lo_misc, x
				lda	pos_x_hi_misc, x
				adc	#0
				sta	pos_x_hi_misc, x

				lda	state_misc, x
				cmp	#actor_states::bit_5|actor_states::bit_4|actor_states::init
				bne	:++ ; if (this.state_bit_5 & this.state_bit_4 && this.state == init) {
					lda	#actor_states::init
					sta	state_misc, x
					jmp	:+++
				; }
			: ; } else {
				txa
				clc
				adc	#ENG_MISC_OFF
				tax

				lda	#MISC_ACCEL_Y_INC
				sta	motion_gravity_accel_y_inc
				lda	#MISC_VELOC_Y_MAX_ABS_6
				sta	motion_gravity_veloc_y_max_abs
				lsr	a
				sta	motion_gravity_accel_y_dec
				lda	#MISC_GRAVITY_INIT
				jsr	motion_gravity

				ldx	actor_index
				lda	veloc_y_misc, x
				cmp	#MISC_VELOC_Y_STATE_CUTOFF
				bne	:+ ; if (this.veloc_y == cutoff) {
					inc	state_misc, x
				; }
			; }

			: ; if (this.state < 0x30) {
				jsr	lib_calc_misc_pos
				jsr	lib_misc_bits_get
				jsr	col_misc_box
				jsr	render_coin_score
			; }
		: ; }

		dex
		bpl	:-----
	; }

	rts
