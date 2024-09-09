.ifndef	PLAYER_CROUCH
PLAYER_CROUCH = 1

	.export chr_obj_player_crouch
chr_obj_player_crouch:
	.incbin	"../../chr.smb/chr_obj_58.bin"
	.incbin	"../../chr.smb/chr_obj_59.bin"
	.incbin	"../../chr.smb/chr_obj_5A.bin"

.endif	; PLAYER_CROUCH
