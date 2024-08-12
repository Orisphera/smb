.ifndef	DIGITS_B
DIGITS_B = 1

	.export tile_obj_digits_10, tile_obj_digits_20
	.export tile_obj_digits_40, tile_obj_digits_50
	.export tile_obj_digits_80, tile_obj_digits_0
tile_obj_digits_10:
	.incbin	"../../chr.smb/tile_obj_F6.bin"

tile_obj_digits_20:
	.incbin	"../../chr.smb/tile_obj_F7.bin"

tile_obj_digits_40:
	.incbin	"../../chr.smb/tile_obj_F8.bin"

tile_obj_digits_50:
	.incbin	"../../chr.smb/tile_obj_F9.bin"

tile_obj_digits_80:
	.incbin	"../../chr.smb/tile_obj_FA.bin"

tile_obj_digits_0:
	.incbin	"../../chr.smb/tile_obj_FB.bin"

.endif	; DIGITS_B
