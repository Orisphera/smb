.ifndef	BLOOPER
BLOOPER = 1

	.export chr_obj_blooper
chr_obj_blooper:
	.incbin	"../../chr.smb/chr_obj_DC.bin"
	.incbin	"../../chr.smb/chr_obj_DD.bin"
	.incbin	"../../chr.smb/chr_obj_DE.bin"
	.incbin	"../../chr.smb/chr_obj_DF.bin"

.endif	; BLOOPER
