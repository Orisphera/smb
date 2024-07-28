.include	"../../inc/engine/mem.i"

.if	.defined(CONS)
; -----------------------------------------------------------
title_cursor_data:
	.byte   title_cursor_data_end-title_cursor_data_start
title_cursor_data_start:
        .byte   $22
	.byte	$49
	.byte	$83
	.byte	$CE
	.byte	$24
	.byte	$24
	.byte	0
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
		lda     #$24
		sta     ppu_nmi_buffer_0_data+3
		lda     #$CE
		sta     ppu_nmi_buffer_0_data+5
	: ; }

	rts
.endif
