.ifndef	ONEUP
ONEUP = 1

	.export chr_obj_oneup_left, chr_obj_oneup_right
chr_obj_oneup_left:
	.incbin	"../../chr.smb/chr_obj_FD.bin"
chr_obj_oneup_right:
	.incbin	"../../chr.smb/chr_obj_FE.bin"

.endif	; ONEUP
