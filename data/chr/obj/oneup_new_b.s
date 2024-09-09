.ifndef	ONEUP_NEW_B
ONEUP_NEW_B = 1

	.export chr_obj_oneup_left, chr_obj_oneup_right
chr_obj_oneup_left:
	.incbin	"../../chr.smb2/chr_obj_FD.bin"
chr_obj_oneup_right:
	.incbin	"../../chr.smb2/chr_obj_FE.bin"

.endif	; ONEUP_NEW_B
