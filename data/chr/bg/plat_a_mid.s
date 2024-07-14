.ifndef	PLAT_A_MID
PLAT_A_MID = 1

	.export tile_bg_plat_a_mid
tile_bg_plat_a_mid:
	.incbin	"data/chr.smb/tile_bg_2C.bin"
	.incbin	"data/chr.smb/tile_bg_2D.bin"

.endif	; PLAT_A_MID
