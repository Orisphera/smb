.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/chr.i"
.include	"engine/charmap.i"

.if	.defined(CONS)
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	TITLE_CURSOR_COL	= PPU_BG_COL_9
.elseif	.defined(SMB2M)
	TITLE_CURSOR_COL	= PPU_BG_COL_11
.endif

	.export title_cursor_data
title_cursor_data:
	.if	.defined(SMB)|.defined(VS_SMB)
	.byte	(:++++)-(:+)
	.endif
        : .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_18+TITLE_CURSOR_COL
	.byte	NMI_INC_ROW|((:++)-(:+))
	: .byte	tile_bg::cursor
	.byte	" "
	.byte	" "
	: .byte	NMI_LIST_END
	:
title_cursor_data_end:

.if	.defined(SMB2M)
title_cursor_tiles:
	.byte	tile_bg::cursor
	.byte	" "
	.byte	tile_bg::cursor
.endif
; ----------------------------
	.export title_cursor_draw
title_cursor_draw:
.if	.defined(SMB)|.defined(VS_SMB)
	ldy     #(title_cursor_data_end-title_cursor_data)-1
	: ; for (a in title_cursor_data) {
		lda     title_cursor_data, y
		sta     nmi_list_0, y

		dey
		bpl     :-
	; }

	.export title_cursor_draw_xfer
title_cursor_draw_xfer:
        lda     player_count
        beq     :+ ; if (player_count) {
		lda     #' '
		sta     nmi_list_0_tile+0
		lda     #tile_bg::cursor
		sta     nmi_list_0_tile+2
	: ; }
.elseif	.defined(SMB2M)
	lda	#nmi_addr::title_cursor_data
	sta	nmi_addrs_ctl

	.export title_cursor_draw_xfer
title_cursor_draw_xfer:
	ldy	player_id
	lda	title_cursor_tiles, y
	sta	title_cursor_data+3
	lda	title_cursor_tiles+1, y
	sta	title_cursor_data+5
.endif

	rts

.endif
