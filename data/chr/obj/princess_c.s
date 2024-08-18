.ifndef	PRINCESS_C
PRINCESS_C = 1

	.export tile_obj_princess_c
tile_obj_princess_c:
	.incbin	"../../chr.smb/tile_obj_DA.bin"
	.incbin	"../../chr.smb/tile_obj_DB.bin"

.endif	; PRINCESS_C
