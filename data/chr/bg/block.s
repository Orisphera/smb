.ifndef	BLOCK_BG
BLOCK_BG = 1

	.export tile_bg_block_q
tile_bg_block_q:
	.incbin	"data/chr.smb/tile_bg_53.bin"
	.incbin	"data/chr.smb/tile_bg_54.bin"
	.incbin	"data/chr.smb/tile_bg_55.bin"
	.incbin	"data/chr.smb/tile_bg_56.bin"

	.export tile_bg_block_empty
tile_bg_block_empty:
	.incbin	"data/chr.smb/tile_bg_57.bin"
	.incbin	"data/chr.smb/tile_bg_58.bin"
	.incbin	"data/chr.smb/tile_bg_59.bin"
	.incbin	"data/chr.smb/tile_bg_5A.bin"

.endif	; BLOCK_BG
