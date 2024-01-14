; -----------------------------------------------------------
SCREEN_TITLE_BG_ADDR	= $1EC0
SCREEN_TITLE_BG_SIZE	= $3A

screen_title_bg:
	lda	eng_game_mode
	bne	screen_title_end
	lda	#>(SCREEN_TITLE_BG_ADDR)
	sta	PPU_VRAM_AR
	lda	#<(SCREEN_TITLE_BG_ADDR)
	sta	PPU_VRAM_AR
	lda	#>(ppu_nmi_buffer)
	sta	zp_addr_00+1
	ldy	#<(ppu_nmi_buffer)
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
		cmp	#>(tbl_400)
		bne	:--
		cpy	#SCREEN_TITLE_BG_SIZE
		bcc	:--
	; }

	lda	#5
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

	jsr	title_cursor_draw
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
