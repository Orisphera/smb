.ifndef	PLAYER_DEATH
PLAYER_DEATH = 1

	.export tile_obj_player_death
tile_obj_player_death:
	.incbin	"../../chr.smb/tile_obj_9E.bin"
	.incbin	"../../chr.smb/tile_obj_9F.bin"

.endif	; PLAYER_DEATH
