.ifndef	MUSHROOM_NEW_B
MUSHROOM_NEW_B = 1

	.export tile_obj_mushroom_ne
tile_obj_mushroom_ne:
	.incbin	"../../chr.smb2/tile_obj_DA.bin"

	.export tile_obj_mushroom_sw
tile_obj_mushroom_sw:
	.incbin	"../../chr.smb2/tile_obj_DB.bin"

.endif	; MUSHROOM_NEW_B
