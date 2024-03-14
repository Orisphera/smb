; -----------------------------------------------------------
.if	.defined(CONS)
	SCREEN_TITLE_BG_SIZE	= $3A
	TITLE_TBL_400		= tbl_400
	TITLE_NMI_ADDR		= ppu_nmi_buffer
	TITLE_COLOR_ID		= $05
.elseif	.defined(VS)
	SCREEN_TITLE_BG_SIZE	= $5A
	TITLE_TBL_400		= VS_RAM+$400
	TITLE_NMI_ADDR		= nmi_addr_1C
	TITLE_COLOR_ID		= $1C
.endif

.if	.defined(CONS)
SCREEN_TITLE_BG_ADDR	= $1EC0
.elseif	.defined(VS)
SCREEN_TITLE_BG_ADDR_0	= $1EA0
SCREEN_TITLE_BG_ADDR_1	= $1A00
SCREEN_TITLE_BG_ADDR_2	= $1A60
SCREEN_TITLE_BG_ADDR_3	= $1AC0
SCREEN_TITLE_BG_ADDR_4	= $1B10
SCREEN_TITLE_BG_ADDR_5	= $1B80
SCREEN_TITLE_BG_ADDR_6	= $1C00
SCREEN_TITLE_BG_ADDR_7	= $1C80

screen_title_bg_addr_hi:
	.byte	>(SCREEN_TITLE_BG_ADDR_0)
	.byte	>(SCREEN_TITLE_BG_ADDR_1)
	.byte	>(SCREEN_TITLE_BG_ADDR_2)
	.byte	>(SCREEN_TITLE_BG_ADDR_3)
	.byte	>(SCREEN_TITLE_BG_ADDR_4)
	.byte	>(SCREEN_TITLE_BG_ADDR_5)
	.byte	>(SCREEN_TITLE_BG_ADDR_6)
	.byte	>(SCREEN_TITLE_BG_ADDR_7)

screen_title_bg_addr_lo:
	.byte	<(SCREEN_TITLE_BG_ADDR_0)
	.byte	<(SCREEN_TITLE_BG_ADDR_1)
	.byte	<(SCREEN_TITLE_BG_ADDR_2)
	.byte	<(SCREEN_TITLE_BG_ADDR_3)
	.byte	<(SCREEN_TITLE_BG_ADDR_4)
	.byte	<(SCREEN_TITLE_BG_ADDR_5)
	.byte	<(SCREEN_TITLE_BG_ADDR_6)
	.byte	<(SCREEN_TITLE_BG_ADDR_7)
.endif

screen_title_bg:
	lda	eng_game_mode
	bne	screen_title_end

	.if	.defined(CONS)
		lda	#>(SCREEN_TITLE_BG_ADDR)
		sta	PPU_VRAM_AR
		lda	#<(SCREEN_TITLE_BG_ADDR)
		sta	PPU_VRAM_AR
	.elseif	.defined(VS)
		ldy	#0
	sub_88F7:
		lda	#vs_req::chr_high|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_SR
		lda	screen_title_bg_addr_hi, y
		sta	PPU_VRAM_AR
		lda	screen_title_bg_addr_lo, y
		sta	PPU_VRAM_AR
	.endif

	lda	#>(TITLE_NMI_ADDR)
	sta	zp_addr_00+1
	ldy	#<(TITLE_NMI_ADDR)
	sty	zp_addr_00
	lda	PPU_VRAM_IO
	: ; for () {
		lda	PPU_VRAM_IO
		sta	(zp_addr_00), y
		iny
		bne	:+
		inc	zp_addr_00+1
		:

		lda	zp_addr_00+1
		cmp	#>(TITLE_TBL_400)
		bne	:--
		cpy	#SCREEN_TITLE_BG_SIZE
		bcc	:--
	; }

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_SR
	.endif

	lda	#TITLE_COLOR_ID
	jmp	screen_color_init_4_end
; ----------------------------
screen_title_cursor:
	lda	eng_game_mode
	bne	screen_title_end
	ldx	#0
	: ; for (byte of ppu_nmi_buffer) {
		sta	ppu_nmi_buffer, x
		sta	tbl_400, x
		dex
		bne	:-
	; }

	.if	.defined(CONS)
		jsr	title_cursor_draw
	.endif
screen_proc_next:
	inc	eng_screen_proc_id
	rts
; ----------------------------
screen_title_score:
	lda	#$FA
	jsr	sub_BC36

	.export screen_title_end
screen_title_end:
	inc	eng_gameplay_mode
	rts
