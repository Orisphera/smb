.include	"../../inc/engine/unk.i"

; -----------------------------------------------------------
title_cursor_data:
	.byte   $07
        .byte   $22
	.byte	$49
	.byte	$83
	.byte	$CE
	.byte	$24
	.byte	$24
	.byte	$00
title_cursor_data_end:
; ----------------------------
	.export title_cursor_draw
title_cursor_draw:
	ldy     #(title_cursor_data_end-title_cursor_data)-1
	: ; for (a in title_cursor_data) {
		lda     title_cursor_data,y
		sta     ppu_nmi_buffer,y

		dey
		bpl     :-
	; }

        lda     eng_player_count
        beq     :+ ; if (eng_player_count) {
		lda     #$24
		sta     ppu_nmi_buffer+4
		lda     #$CE
		sta     ppu_nmi_buffer+6
	: ; }

	rts
