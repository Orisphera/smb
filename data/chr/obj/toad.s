.ifndef	TOAD
TOAD = 1

	.export tile_obj_toad
tile_obj_toad:
	.incbin	"../../chr.smb/tile_obj_CD.bin"
	.incbin	"../../chr.smb/tile_obj_CE.bin"
	.incbin	"../../chr.smb/tile_obj_CF.bin"

.endif	; TOAD
