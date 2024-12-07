.include	"mem.i"
.include	"tunables.i"
.include	"math.i"

BUBBLE_PLAYER_OFFSET_Y		= 8
BUBBLE_PLAYER_DIR_OFFSET_X	= 8
BUBBLE_POS_Y_MIN		= 32

bubble_idx	= zp_byte_07

	.export	bubble_init, bubble_proc
bubble_proc:
	lda	srand+1, x
	and	#MOD_2
	sta	bubble_idx
	lda	pos_y_lo_bubble, x
	cmp	#OAM_INIT_SCANLINE
	bne	:++
	lda	timer_bubble
	bne	:++++ ; if () {
		; if () {
		bubble_init:
			ldy	#0
			lda	disp_dir_player
			lsr	a
			bcc	:+ ; if (this.disp_dir == right) {
				ldy	#BUBBLE_PLAYER_DIR_OFFSET_X
			: ; }
			tya
			adc	pos_x_lo_player
			sta	pos_x_lo_bubble, x
			lda	pos_x_hi_player
			adc	#0
			sta	pos_x_hi_bubble, x
			lda	pos_y_lo_player
			clc
			adc	#BUBBLE_PLAYER_OFFSET_Y
			sta	pos_y_lo_bubble, x
			lda	#1
			sta	pos_y_hi_bubble, x

			ldy	bubble_idx
			lda	bubble_timers, y
			sta	timer_bubble
		: ; }

		ldy	bubble_idx
		lda	accel_y1_bubble, x
		sec
		sbc	bubble_accel_y, y
		sta	accel_y1_bubble, x
		lda	pos_y_lo_bubble, x
		sbc	#0
		cmp	#BUBBLE_POS_Y_MIN
		bcs	:+ ; if (this.pos_y < MIN) {
			lda	#OAM_INIT_SCANLINE
		: ; }
		sta	pos_y_lo_bubble, x
	: ; }

	rts
; -----------------------------
bubble_accel_y:
	.byte	<-1, 80

bubble_timers:
	.byte	64, 32
