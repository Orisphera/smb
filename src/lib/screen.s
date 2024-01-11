.include	"../../inc/engine/unk.i"

	.export screen_proc
screen_proc:
	lda	eng_screen_proc_id
	jsr	eng_farjump
	.addr	screen_init
	.addr	screen_color_init_1
	.addr	screen_stat_bg_0
	.addr	screen_stat_bg_1
	.addr	screen_msg_time_up
	.addr	screen_msg_time_reset
	.addr	screen_msg_world_game_over
	.if	.defined(SMB2)
		.addr	sub_C5D0
	.elseif	.defined(ANN)
		.addr	screen_score_disp_end
	.endif
	.addr	screen_msg_time_reset
	.addr	screen_bg
	.addr	screen_color_init_2
	.addr	screen_color_init_3
	.addr	screen_color_init_4
	.addr	screen_title_bg
	.addr	screen_title_cursor
	.addr	screen_title_score
; ------------------------------------------------------------
screen_init:
	jsr	oam_init
	jsr	nt_init
	lda	eng_game_mode
	beq	screen_proc_next_b ; if (eng_game_mode != title) {
		ldx	#3
		jmp	screen_proc_next_pal_set
	; }
; ------------------------------------------------------------
screen_color_init_1:
	lda	eng_bg_col
	pha
	lda	eng_player_status
	pha

	lda	#0
	sta	eng_player_status
	lda	#2
	sta	eng_bg_col
	jsr	screen_color_player

	pla
	sta	eng_player_status
	pla
	sta	eng_bg_col

	jmp	screen_proc_next
; ------------------------------------------------------------
screen_palette_types:
	.byte	1, 2, 3, 4
; ----------------------------
screen_color_init_2:
	ldy	eng_area_type
	ldx	screen_palette_types, y

screen_proc_next_pal_set:
	stx	nmi_addrs_ctl

screen_proc_next_b:
	jmp	screen_proc_next
; ------------------------------------------------------------
data_85D7_entry_size	= 4

data_85CB:
	.byte	$00, $09, $0A, $04

data_85CF:
	.byte	$22, $22, $0F, $0F
	.byte	$0F, $22, $0F, $0F

tbl_85D7:
data_85D7_0:
	.byte	$22, $16, $27, $18
	.if	.defined(SMB)
	data_85D7_1:
		.byte	$22, $30, $27, $19
	.endif
data_85D7_2:
	.byte	$22, $37, $27, $16
; --------------------------
screen_color_init_3:
	ldy	eng_bg_col
	beq	:+ ; if (eng_bg_col) {
		lda	data_85CB-4, y
		sta	nmi_addrs_ctl
	: ; }

	inc	eng_screen_proc_id

screen_color_player:
	ldx	ppu_nmi_buffer+0
	ldy	#(data_85D7_0-tbl_85D7)
	.if	.defined(SMB)
		lda	eng_player_id
		beq	:+ ; if (eng_player_id != 0) {
			ldy	#(data_85D7_1-tbl_85D7)
		: ; }
	.endif
	lda	eng_player_status
	cmp	#2
	bne	:+ ; if (eng_player_status == 2) {
		ldy	#(data_85D7_2-tbl_85D7)
	: ; }
	lda	#data_85D7_entry_size-1
	sta	zp_byte_00
	: ; for (x = ppu_nmi_buffer[0], y = entry_base, i = 3; i >= 0; x++, y++, i--) {
		lda	tbl_85D7, y
		sta	ppu_nmi_buffer+4, x

		iny
		inx
		dec	zp_byte_00
		bpl	:-
	; }

	ldx	ppu_nmi_buffer+0
	ldy	eng_bg_col
	bne	:+ ; if (!eng_bg_col) {
		ldy	eng_area_type
	: ; }
	lda	data_85CF, y
	sta	ppu_nmi_buffer+4, x
	lda	#$3F
	sta	ppu_nmi_buffer+1, x
	lda	#$10
	sta	ppu_nmi_buffer+2, x
	lda	#4
	sta	ppu_nmi_buffer+3, x
	lda	#0
	sta	ppu_nmi_buffer+8, x
	txa
	clc
	adc	#7

screen_color_player_end:
	sta	ppu_nmi_buffer+0
	rts