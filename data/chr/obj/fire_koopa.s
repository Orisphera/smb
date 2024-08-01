.ifndef	FIRE_KOOPA
FIRE_KOOPA = 1

	.export tile_obj_fire_koopa, tile_obj_fire_koopa_end
tile_obj_fire_koopa:
	.incbin	"../../chr.smb/tile_obj_51.bin"
	.incbin	"../../chr.smb/tile_obj_52.bin"
	.incbin	"../../chr.smb/tile_obj_53.bin"
tile_obj_fire_koopa_end:

.endif	; FIRE_KOOPA
