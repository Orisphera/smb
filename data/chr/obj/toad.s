.ifndef	TOAD
TOAD = 1

	.export chr_obj_toad
chr_obj_toad:
	.incbin	"../../chr.smb/chr_obj_CD.bin"
	.incbin	"../../chr.smb/chr_obj_CE.bin"
	.incbin	"../../chr.smb/chr_obj_CF.bin"

.endif	; TOAD
