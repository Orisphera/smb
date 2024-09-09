.ifndef	PLAYER_CLIMB_LARGE
PLAYER_CLIMB_LARGE = 1

	.export chr_obj_player_climb_large
chr_obj_player_climb_large:
	.incbin	"../../chr.smb/chr_obj_5C.bin"
	.incbin	"../../chr.smb/chr_obj_5D.bin"
	.incbin	"../../chr.smb/chr_obj_5E.bin"
	.incbin	"../../chr.smb/chr_obj_5F.bin"

.endif	; PLAYER_CLIMB_LARGE
