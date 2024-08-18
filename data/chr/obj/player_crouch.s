.ifndef	PLAYER_CROUCH
PLAYER_CROUCH = 1

	.export tile_obj_player_crouch
tile_obj_player_crouch:
	.incbin	"../../chr.smb/tile_obj_58.bin"
	.incbin	"../../chr.smb/tile_obj_59.bin"
	.incbin	"../../chr.smb/tile_obj_5A.bin"

.endif	; PLAYER_CROUCH
