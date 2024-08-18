.ifndef	BLOOPER
BLOOPER = 1

	.export tile_obj_blooper
tile_obj_blooper:
	.incbin	"../../chr.smb/tile_obj_DC.bin"
	.incbin	"../../chr.smb/tile_obj_DD.bin"
	.incbin	"../../chr.smb/tile_obj_DE.bin"
	.incbin	"../../chr.smb/tile_obj_DF.bin"

.endif	; BLOOPER
