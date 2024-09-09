.ifndef	PLAT_C
PLAT_C = 1

	.export	chr_obj_plat_norm
chr_obj_plat_norm:
	.incbin	"../../chr.smb2/chr_obj_5B.bin"

.endif	; PLAT_C
