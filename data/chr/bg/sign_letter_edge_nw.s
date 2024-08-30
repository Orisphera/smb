.ifndef	SIGN_LETTER_EDGE
SIGN_LETTER_EDGE = 1

	.export	tile_bg_sign_letter_edge
tile_bg_sign_letter_edge:
	.incbin	"data/chr.smb/tile_bg_42.bin"
	.incbin	"data/chr.smb/tile_bg_43.bin"

        .export tile_bg_sign_nw
tile_bg_sign_nw:
        .incbin "data/chr.smb/tile_bg_44.bin"

.endif	; SIGN_LETTER_EDGE
