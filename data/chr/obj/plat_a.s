.ifndef	PLAT_A
PLAT_A = 1

	.export	chr_obj_plat_norm
chr_obj_plat_norm:
	.incbin	"../../chr.smb/chr_obj_5B.bin"

.endif	; PLAT_A
