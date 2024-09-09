.ifndef	HAMMER
HAMMER = 1

	.export	chr_obj_hammer
chr_obj_hammer:
	.incbin	"../../chr.smb/chr_obj_80.bin"
	.incbin	"../../chr.smb/chr_obj_81.bin"
	.incbin	"../../chr.smb/chr_obj_82.bin"
	.incbin	"../../chr.smb/chr_obj_83.bin"

.endif	; HAMMER
