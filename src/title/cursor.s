.include	"mem.i"
.include	"const.i"
.include	"chr.i"
.include	"charmap.i"

.if	.defined(CONS)
; -----------------------------------------------------------
.if	.defined(SMBV1)
	TITLE_CURSOR_COL	= PPU_BG_COL_9
.elseif	.defined(SMBV2)
	TITLE_CURSOR_COL	= PPU_BG_COL_11
.endif

	.export title_cursor_data
title_cursor_data:
	.if	.defined(SMBV1)
	.byte	(:++++)-(:+)
	.endif
        : .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_18+TITLE_CURSOR_COL
	.byte	NMI_INC_ROW|((:++)-(:+))
title_cursor_data_tiles:
	: .byte	chr_bg::cursor
	.byte	" "
	.byte	" "
	: .byte	NMI_LIST_END
	:
title_cursor_data_end:

.if	.defined(SMBV2)
title_cursor_tiles:
	.byte	chr_bg::cursor
	.byte	" "
	.byte	chr_bg::cursor
.endif
; ----------------------------
	.export title_cursor_draw, title_cursor_draw_xfer
title_cursor_draw:
.if	.defined(SMBV1)
	ldy     #(title_cursor_data_end-title_cursor_data)-1
	: ; for (a in title_cursor_data) {
		lda     title_cursor_data, y
		sta     ppu_displist, y

		dey
		bpl     :-
	; }
.elseif	.defined(SMBV2)
	lda	#nmi_addr::title_cursor_data
	sta	nmi_buffer_ptr
.endif

title_cursor_draw_xfer:
.if	.defined(SMBV1)
        lda     player_count
        beq     :+ ; if (player_count) {
		lda     #' '
		sta     ppu_displist_payload+0
		lda     #chr_bg::cursor
		sta     ppu_displist_payload+2
	: ; }
.elseif	.defined(SMBV2)
	ldy	player_id
	lda	title_cursor_tiles, y
	sta	title_cursor_data_tiles
	lda	title_cursor_tiles+1, y
	sta	title_cursor_data_tiles+2
.endif

	rts

.endif
