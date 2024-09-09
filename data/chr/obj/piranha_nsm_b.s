.ifndef	PIRANHA_NSM_B
PIRANHA_NSM_B = 1

	.export chr_obj_piranha_b
chr_obj_piranha_b:
	.incbin	"../../chr.ann/chr_obj_EB.bin"
	.incbin	"../../chr.ann/chr_obj_EC.bin"
	.incbin	"../../chr.ann/chr_obj_ED.bin"

	.export chr_obj_nsm_char_c
chr_obj_nsm_char_c:
	.incbin	"../../chr.ann/chr_obj_EE.bin"

.endif	; PIRANHA_NSM_B
