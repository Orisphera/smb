.ifndef	BRICK
BRICK = 1

	.export tile_obj_brick
tile_obj_brick:
	.incbin	"../../chr.smb/tile_obj_85.bin"
	.incbin	"../../chr.smb/tile_obj_86.bin"

.endif	; BRICK
