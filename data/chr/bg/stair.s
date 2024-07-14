.ifndef	STAIR_S
STAIR_S = 1

	.export tile_bg_stair
tile_bg_stair:
	.incbin	"data/chr.smb/tile_bg_AB.bin"
	.incbin	"data/chr.smb/tile_bg_AC.bin"
	.incbin	"data/chr.smb/tile_bg_AD.bin"
	.incbin	"data/chr.smb/tile_bg_AE.bin"

.endif	; STAIR
