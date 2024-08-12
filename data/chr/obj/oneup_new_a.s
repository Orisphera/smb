.ifndef	ONEUP_NEW_A
ONEUP_NEW_A = 1

	.export tile_obj_oneup_left, tile_obj_oneup_right
tile_obj_oneup_left:
	.incbin	"../../chr.vs/tile_obj_FD.bin"
tile_obj_oneup_right:
	.incbin	"../../chr.vs/tile_obj_FE.bin"

.endif	; ONEUP_NEW_A
