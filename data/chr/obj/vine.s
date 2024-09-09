.ifndef	VINE
VINE = 1

	.export	chr_obj_vine
chr_obj_vine:
	.incbin	"../../chr.smb/chr_obj_E0.bin"
	.incbin	"../../chr.smb/chr_obj_E1.bin"

.endif	; VINE
