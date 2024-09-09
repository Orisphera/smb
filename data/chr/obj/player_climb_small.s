.ifndef	PLAYER_CLIMB_SMALL
PLAYER_CLIMB_SMALL = 1

	.export chr_obj_player_climb_small
chr_obj_player_climb_small:
	.incbin	"../../chr.smb/chr_obj_90.bin"
	.incbin	"../../chr.smb/chr_obj_91.bin"
	.incbin	"../../chr.smb/chr_obj_92.bin"
	.incbin	"../../chr.smb/chr_obj_93.bin"

.endif	; PLAYER_CLIMB_SMALL
