.include	"../../inc/engine/mem.i"
.include	"../../inc/engine/chr.i"
.include	"../../inc/engine/charmap.i"

.if	.defined(CONS)
; -----------------------------------------------------------
title_cursor_data:
	.byte   title_cursor_data_end-title_cursor_data_start
title_cursor_data_start:
        .dbyt   PPU_VRAM_BG1+$249
	.byte	%10000000|(title_cursor_data_string_end-title_cursor_data_string_start)
title_cursor_data_string_start:
	.byte	tile_bg::cursor
	.byte	"  "
title_cursor_data_string_end:
	.byte	NMI_DATA_END
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
