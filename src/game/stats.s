.include	"system/cpu.i"
.include	"system/ppu.i"
.include	"system/ctrl.i"
.if	.defined(VS)
	.include	"system/vs.i"
.endif

.include	"mem.i"
.include	"joypad.i"

; -----------------------------------------------------------
STATS_UPPER_ROW	= PPU_BG_ROW_3
STATS_LOWER_ROW	= PPU_BG_ROW_7

.if	.defined(SMBV1)
STATS_STAT0_COL	= PPU_BG_COL_16
.elseif	.defined(SMB2)
STATS_STAT0_COL	= PPU_BG_COL_15
.elseif	.defined(ANN)
STATS_STAT0_COL	= PPU_BG_COL_17
.endif

STATS_STAT0_LEN		= STAT_LEN_MAX
STATS_SCORE_COL		= PPU_BG_COL_2
STATS_SCORE_A_LEN	= STAT_LEN_MAX
STATS_SCORE_B_LEN	= STAT_LEN_MAX

STATS_COIN_COL		= PPU_BG_COL_13
.if	.defined(CONS)
STATS_COIN_LEN	= 2
.elseif	.defined(VS)
STATS_COIN_LEN	= 3
.endif
STATS_COIN_A_LEN	= STATS_COIN_LEN
STATS_COIN_B_LEN	= STATS_COIN_LEN

STATS_TIME_COL		= PPU_BG_COL_26

STAT_ENTRIES_SKIP	= 1
STAT_ENTRIES_MAX	= 6
; -----------------------------------------------------------
stats_print_num_arg		= zp_byte_00
stats_print_num_buffer_idx	= zp_byte_02
stats_print_num_score_digits	= zp_byte_03

stats_data:
	.byte	STATS_LOWER_ROW|STATS_STAT0_COL, STATS_STAT0_LEN
	.byte	STATS_UPPER_ROW|STATS_SCORE_COL, STATS_SCORE_A_LEN

	.if	.defined(SMBV1)
		.byte	STATS_UPPER_ROW|STATS_SCORE_COL, STATS_SCORE_B_LEN
	.endif

	.byte	STATS_UPPER_ROW|STATS_COIN_COL, STATS_COIN_A_LEN

	.if	.defined(SMBV1)
		.byte	STATS_UPPER_ROW|STATS_COIN_COL, STATS_COIN_B_LEN
	.endif

	.byte	STATS_UPPER_ROW|STATS_TIME_COL, STATS_TIME_LEN

stats_offsets:
	.byte	stats_score_top_end-stats_tbl
	.byte	stats_score_player_a_end-stats_tbl

	.if	.defined(SMBV1)
		.byte	stats_score_player_b_end-stats_tbl
	.endif

	.byte	stats_coin_player_a_end-stats_tbl

	.if	.defined(SMBV1)
		.byte	stats_coin_player_b_end-stats_tbl
	.endif

	.byte	stats_time_end-stats_tbl
; ----------------------------
	.export	stats_print_num
stats_print_num:
	sta	stats_print_num_arg
	jsr	stats_print_num_do
	lda	stats_print_num_arg
	lsr	a
	lsr	a
	lsr	a
	lsr	a
; ----------------------------
stats_print_num_do:
	clc
	adc	#STAT_ENTRIES_SKIP
	and	#%00001111
	cmp	#STAT_ENTRIES_MAX
	bcs	:+++ ; if (++arg < 6) {
		pha

		asl	a
		tay
		ldx	ppu_displist_offset
		lda	#>PPU_VRAM_BG1
		cpy	#0
		bne	:+ ; if ((2*arg) == 0) {
			lda	#>(PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_0)
		: ; }
		sta	ppu_displist_addr_dbyt, x

		lda	stats_data, y
		sta	ppu_displist_addr_dbyt+1, x
		lda	stats_data+1, y
		sta	ppu_displist_count, x
		sta	stats_print_num_score_digits
		stx	stats_print_num_buffer_idx

		pla
		tax
		lda	stats_offsets, x
		sec
		sbc	stats_data+1, y
		tay
		ldx	stats_print_num_buffer_idx
		: ; for (digit of game.stats) {
			lda	stats_tbl, y
			sta	ppu_displist_payload, x

			inx
			iny
			dec	stats_print_num_score_digits
			bne	:-
		; }
		lda	#NMI_LIST_END
		sta	ppu_displist_payload, x

		inx
		inx
		inx
		stx	ppu_displist_offset
	: ; }

	rts
; -----------------------------------------------------------
	.export stats_calc
stats_calc:
	lda	proc_id_system
	.if	.defined(SMBV1)
		cmp	#0
	.endif
	beq	:++ ; if (proc_id_system != title) {
		ldx	#STAT_LEN_MAX-1
		: ; for (digit of game.stats) {
			lda	score_digit_mod+1, x
			clc
			adc	stats_tbl, y
			bmi	stats_calc_dec
			cmp	#10
			bcs	stats_calc_inc

		stats_calc_store:
			sta	stats_tbl, y

			dey
			dex
			bpl	:-
		; }
	: ; }

	lda	#0
	ldx	#STAT_LEN_MAX
	: ; for (digit of score_digit_mod) {
		sta	score_digit_mod, x

		dex
		bpl	:-
	; }

	rts
; ----------------------------
stats_calc_dec:
	dec	score_digit_mod, x
	lda	#9
	bne	stats_calc_store

stats_calc_inc:
	sec
	sbc	#10
	inc	score_digit_mod, x
	jmp	stats_calc_store
; -----------------------------------------------------------
	.export stats_score_hi_check
stats_score_hi_check:
	ldx	#(STAT_LEN_MAX)-1
	.if	.defined(SMBV1)
		jsr	stats_score_hi_check_do
		ldx	#(2*STAT_LEN_MAX)-1
	.endif
; ----------------------------
stats_score_hi_check_do:
	ldy	#STAT_LEN_MAX-1
	sec
	: ; for (digit of score_top) {
		lda	stats_score_player, x
		sbc	stats_score_top, y

		dex
		dey
		bpl	:-
	; }

	bcc	:++ ; if (player.score > score_top) {
		inx
		iny
		: ; for (digit of score_top) {
			lda	stats_score_player, x
			sta	stats_score_top, y

			inx
			iny
			cpy	#STAT_LEN_MAX
			bcc	:-
		; }
	: ; }

	rts
