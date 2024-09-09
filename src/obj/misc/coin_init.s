.include	"mem.i"
.include	"tunables.i"
.include	"sound.i"

; -----------------------------------------------------------
MISC_COIN_BLOCK_OFFSET_Y	= 16
MISC_COIN_BLOCK_B_OFFSET_Y	= 32
MISC_COIN_POS_X_CLAMP		= %00000101
MISC_COIN_HEAD_SLOTS		= 5
MISC_COIN_VELOC_Y		= <-5
; -----------------------------------------------------------
	.export misc_init_coin_a, misc_init_coin_b
misc_init_coin_a:
	jsr	misc_init_coin_block_alloc
	lda	pos_x_hi_block, x
	sta	pos_x_hi_misc, y
	lda	pos_x_lo_block, x
	ora	#MISC_COIN_POS_X_CLAMP
	sta	pos_x_lo_misc, y
	lda	pos_y_lo_block, x
	sbc	#MISC_COIN_BLOCK_OFFSET_Y
	sta	pos_y_lo_misc, y
	jmp	misc_init_coin
; -----------------------------
misc_init_coin_b:
	jsr	misc_init_coin_block_alloc
	lda	block_page_loc, x
	sta	pos_x_hi_misc, y
	lda	eng_buffer_ptr
	asl	a
	asl	a
	asl	a
	asl	a
	ora	#MISC_COIN_POS_X_CLAMP
	sta	pos_x_lo_misc, y
	lda	pos_y_block_proc
	adc	#MISC_COIN_BLOCK_B_OFFSET_Y
	sta	pos_y_lo_misc, y

misc_init_coin:
	lda	#MISC_COIN_VELOC_Y
	sta	veloc_y_misc, y
	lda	#sfx_pulse2::coin_01|misc_states::coin_01
	sta	pos_y_hi_misc, y
	sta	state_misc, y
	sta	apu_pulse2_queue
	stx	actor_index
	jsr	misc_proc_coin_add
	inc	eng_bonus_oneup_tally
	rts
; -----------------------------
misc_init_coin_block_alloc:
	ldy	#ENG_MISC_MAX-1
	: ; for (obj of misc) {
		lda	state_misc, y
		beq	:+

		dey
		cpy	#MISC_COIN_HEAD_SLOTS
		bne	:- ; if (index == coin_head_end) {
			ldy	#ENG_MISC_MAX-1
		; }
	: ; }
	sty	misc_block_id
	rts
