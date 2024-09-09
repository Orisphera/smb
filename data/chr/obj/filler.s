.ifndef	FILLER_A
FILLER_A = 1

	.export	chr_obj_filler
chr_obj_filler:
	.incbin	"../../chr.smb/chr_obj_FF.bin"

.endif	; FILLER_A
