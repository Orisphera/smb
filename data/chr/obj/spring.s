.ifndef	SPRING
SPRING = 1

	.export tile_obj_spring
tile_obj_spring:
	.incbin	"../../chr.smb/tile_obj_F0.bin"
	.incbin	"../../chr.smb/tile_obj_F1.bin"
	.incbin	"../../chr.smb/tile_obj_F2.bin"
	.incbin	"../../chr.smb/tile_obj_F3.bin"

.endif	; SPRING
