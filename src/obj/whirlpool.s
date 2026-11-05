.include	"mem.i"
.include	"mem_low.i"

	.export whirlpool_proc
whirlpool_proc:
	lda	course_type
	bne	:+++ ; if (course.type == water) {
		sta	game_whirlpool_flag

		lda	game_timer_stop
		bne	:+++ ; if (!game_timer_stop) {
			ldy	#5-1
			: ; for (y = 5-1; y >= 0; y--) {
				lda	pos_x_lo_cannon, y
				clc
				adc	pos_y_lo_cannon, y
				sta	zp_byte_02

				lda	pos_y_hi_cannon, y
				beq	:+ ; if (actor.pos_y.hi > 0) {
					adc	#0
					sta	zp_byte_01
					lda	pos_x_lo_player
					sec
					sbc	pos_x_lo_cannon, y

					lda	pos_x_hi_player
					sbc	pos_y_hi_cannon, y
					bmi	:+ ; if ((this.pos_x.hi - actor.pos_y.hi) >= 0) {
						lda	zp_byte_02
						sec
						sbc	pos_x_lo_player
						lda	zp_byte_01
						sbc	pos_x_hi_player
						bpl	whirlpool_proc_do
					; }
				: ; }
			
				dey
				bpl	:--
			; }
		; }
	: ; }

	rts
; ----------------------------------
whirlpool_proc_do:
	lda	pos_y_lo_cannon, y
	lsr	a
	sta	zp_byte_00
	lda	pos_x_lo_cannon, y
	clc
	adc	zp_byte_00
	sta	zp_byte_01
	lda	pos_y_hi_cannon, y
	adc	#0
	sta	zp_byte_00

	lda	frame_count
	lsr	a
	bcc	:+++ ; if (frame_count % 2) {
		lda	zp_byte_01
		sec
		sbc	pos_x_lo_player
		lda	zp_byte_00
		sbc	pos_x_hi_player
		bpl	:+ ; if (actor.pos_y.hi >= this.pos_x.hi) {
			lda	pos_x_lo_player
			sec
			sbc	#<1
			sta	pos_x_lo_player
			lda	pos_x_hi_player
			sbc	#>1
		jmp	:++
		: lda	collision_player
		lsr	a
		bcc	:++ ; } else if (player.collision == right) {
			lda	pos_x_lo_player
			clc
			adc	#<1
			sta	pos_x_lo_player
			lda	pos_x_hi_player
			adc	#>1
		: ; }

		; if (this.pos_y.hi >= this.pos_x.hi || this.collision == right) {
			sta	pos_x_hi_player
		; }
	: ; }

	lda	#16
	sta	motion_gravity_accel_y_inc
	lda	#1
	sta	game_whirlpool_flag
	sta	motion_gravity_veloc_y_max_abs
	lsr	a
	tax
	jmp	motion_gravity
