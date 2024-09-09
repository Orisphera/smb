.ifndef	BULLET
BULLET = 1

	.export chr_obj_bullet
chr_obj_bullet:
	.incbin	"../../chr.smb/chr_obj_E7.bin"
	.incbin	"../../chr.smb/chr_obj_E8.bin"
	.incbin	"../../chr.smb/chr_obj_E9.bin"
	.incbin	"../../chr.smb/chr_obj_EA.bin"

.endif	; BULLET
