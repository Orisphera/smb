.ifndef	PRINCESS_C
PRINCESS_C = 1

	.export chr_obj_princess_c
chr_obj_princess_c:
	.incbin	"../../chr.smb/chr_obj_DA.bin"
	.incbin	"../../chr.smb/chr_obj_DB.bin"

.endif	; PRINCESS_C
