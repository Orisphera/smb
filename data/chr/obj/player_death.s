.ifndef	PLAYER_DEATH
PLAYER_DEATH = 1

	.export chr_obj_player_death
chr_obj_player_death:
	.incbin	"../../chr.smb/chr_obj_9E.bin"
	.incbin	"../../chr.smb/chr_obj_9F.bin"

.endif	; PLAYER_DEATH
