.ifndef	PLAYER_CLIMB_SMALL
PLAYER_CLIMB_SMALL = 1

	.export tile_obj_player_climb_small
tile_obj_player_climb_small:
	.incbin	"../../chr.smb/tile_obj_90.bin"
	.incbin	"../../chr.smb/tile_obj_91.bin"
	.incbin	"../../chr.smb/tile_obj_92.bin"
	.incbin	"../../chr.smb/tile_obj_93.bin"

.endif	; PLAYER_CLIMB_SMALL
