.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/chr.i"
.include	"engine/charmap.i"

.if	.defined(CONS)
; -----------------------------------------------------------
title_cursor_data:
	.byte   (:++++)-(:+)
        : .dbyt   PPU_VRAM_BG1+$249
	.byte	NMI_INC_ROW|((:++)-(:+))
	: .byte	tile_bg::cursor
	.byte	" "
	.byte	" "
	: .byte	NMI_DATA_END
	:
title_cursor_data_end:
; ----------------------------
	.export title_cursor_draw
title_cursor_draw:
	ldy     #(title_cursor_data_end-title_cursor_data)-1
	: ; for (a in title_cursor_data) {
		lda     title_cursor_data,y
		sta     ppu_nmi_buffer_0,y

		dey
		bpl     :-
	; }

        lda     player_count
        beq     :+ ; if (player_count) {
		lda     #' '
		sta     ppu_nmi_buffer_0_data+3
		lda     #tile_bg::cursor
		sta     ppu_nmi_buffer_0_data+5
	: ; }

	rts
.endif
