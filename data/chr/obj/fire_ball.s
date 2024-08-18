.ifndef	FIRE_BALL
FIRE_BALL = 1

	.export tile_obj_fire_ball
tile_obj_fire_ball:
	.incbin	"../../chr.smb/tile_obj_64.bin"
	.incbin	"../../chr.smb/tile_obj_65.bin"

.endif	; FIRE_BALL
