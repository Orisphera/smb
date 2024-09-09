.ifndef	FLAG_VICTORY
FLAG_VICTORY = 1

	.export chr_obj_flag_victory

chr_obj_flag_victory:
	.incbin	"../../chr.smb/chr_obj_54.bin"
	.incbin	"../../chr.smb/chr_obj_55.bin"
	.incbin	"../../chr.smb/chr_obj_56.bin"
	.incbin	"../../chr.smb/chr_obj_57.bin"

.endif	; FLAG_VICTORY
