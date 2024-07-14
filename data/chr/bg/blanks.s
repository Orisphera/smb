.ifndef	BLANKS
BLANKS = 1

	.export tile_bg_blanks
tile_bg_blanks:
	.incbin	"data/chr.smb/tile_bg_24.bin"
	.incbin	"data/chr.smb/tile_bg_25.bin"
	.incbin	"data/chr.smb/tile_bg_26.bin"
	.incbin	"data/chr.smb/tile_bg_27.bin"

.endif	; BLANKS
