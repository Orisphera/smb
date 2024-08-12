.ifndef	ONEUP
ONEUP = 1

	.export tile_obj_oneup_left, tile_obj_oneup_right
tile_obj_oneup_left:
	.incbin	"../../chr.smb/tile_obj_FD.bin"
tile_obj_oneup_right:
	.incbin	"../../chr.smb/tile_obj_FE.bin"

.endif	; ONEUP
