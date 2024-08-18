.ifndef	BRICK_NEW
BRICK_NEW = 1

	.export tile_obj_brick
tile_obj_brick:
	.incbin	"../../chr.smb2/tile_obj_85.bin"
	.incbin	"../../chr.smb2/tile_obj_86.bin"

.endif	; BRICK_NEW
