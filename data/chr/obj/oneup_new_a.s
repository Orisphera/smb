.ifndef	ONEUP_NEW_A
ONEUP_NEW_A = 1

	.export chr_obj_oneup_left, chr_obj_oneup_right
chr_obj_oneup_left:
	.incbin	"../../chr.vs/chr_obj_FD.bin"
chr_obj_oneup_right:
	.incbin	"../../chr.vs/chr_obj_FE.bin"

.endif	; ONEUP_NEW_A
