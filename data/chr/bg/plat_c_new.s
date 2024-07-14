.ifndef	PLAT_C
PLAT_C = 1

	.export tile_bg_plat_c
tile_bg_plat_c:
		.incbin	"data/chr.smb2/tile_bg_6B.bin"
		.incbin	"data/chr.smb2/tile_bg_6C.bin"
		.incbin	"data/chr.smb2/tile_bg_6D.bin"
		.incbin	"data/chr.smb2/tile_bg_6E.bin"
		.incbin	"data/chr.smb2/tile_bg_6F.bin"
		.incbin	"data/chr.smb2/tile_bg_70.bin"
		.incbin	"data/chr.smb2/tile_bg_71.bin"
		.incbin	"data/chr.smb2/tile_bg_72.bin"
		.incbin	"data/chr.smb2/tile_bg_73.bin"
		.incbin	"data/chr.smb2/tile_bg_74.bin"

.endif	; PLAT_C
