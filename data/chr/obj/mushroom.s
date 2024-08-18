.ifndef	MUSHROOM
MUSHROOM = 1

	.export tile_obj_mushroom_nw
tile_obj_mushroom_nw:
	.incbin	"../../chr.smb/tile_obj_76.bin"

	.export tile_obj_mushroom_ne
tile_obj_mushroom_ne:
	.incbin	"../../chr.smb/tile_obj_77.bin"

	.export tile_obj_mushroom_sw
tile_obj_mushroom_sw:
	.incbin	"../../chr.smb/tile_obj_78.bin"

	.export tile_obj_mushroom_se
tile_obj_mushroom_se:
	.incbin	"../../chr.smb/tile_obj_79.bin"

.endif	; MUSHROOM
