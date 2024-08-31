.ifndef	PIRANHA_NSM_B
PIRANHA_NSM_B = 1

	.export tile_obj_piranha_b
tile_obj_piranha_b:
	.incbin	"../../chr.ann/tile_obj_EB.bin"
	.incbin	"../../chr.ann/tile_obj_EC.bin"
	.incbin	"../../chr.ann/tile_obj_ED.bin"

	.export tile_obj_nsm_char_c
tile_obj_nsm_char_c:
	.incbin	"../../chr.ann/tile_obj_EE.bin"

.endif	; PIRANHA_NSM_B
