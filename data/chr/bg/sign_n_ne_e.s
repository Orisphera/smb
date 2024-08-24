.ifndef	SIGN_N_NE_E
SIGN_N_NE_E = 1

	.export tile_bg_sign_n
	.export tile_bg_sign_ne
	.export tile_bg_sign_e
tile_bg_sign_n:
	.incbin	"data/chr.smb/tile_bg_48.bin"

tile_bg_sign_ne:
	.incbin	"data/chr.smb/tile_bg_49.bin"

tile_bg_sign_e:
	.incbin	"data/chr.smb/tile_bg_4A.bin"

.endif	; SIGN_N_NE_E
