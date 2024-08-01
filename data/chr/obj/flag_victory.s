.ifndef	FLAG_VICTORY
FLAG_VICTORY = 1

	.export tile_obj_flag_victory

tile_obj_flag_victory:
	.incbin	"../../chr.smb/tile_obj_54.bin"
	.incbin	"../../chr.smb/tile_obj_55.bin"
	.incbin	"../../chr.smb/tile_obj_56.bin"
	.incbin	"../../chr.smb/tile_obj_57.bin"

.endif	; FLAG_VICTORY
