.ifndef	FLAG_ENEMY
FLAG_ENEMY = 1

	.export	chr_obj_flag_enemy
chr_obj_flag_enemy:
	.incbin	"../../chr.smb/chr_obj_7E.bin"
	.incbin	"../../chr.smb/chr_obj_7F.bin"

.endif	; FLAG_ENEMY
