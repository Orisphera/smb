.ifndef	ONEUP_NEW_B
ONEUP_NEW_B = 1

	.export tile_obj_oneup_left, tile_obj_oneup_right
tile_obj_oneup_left:
	.incbin	"../../chr.smb2/tile_obj_FD.bin"
tile_obj_oneup_right:
	.incbin	"../../chr.smb2/tile_obj_FE.bin"

.endif	; ONEUP_NEW_B
