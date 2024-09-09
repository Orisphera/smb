.ifndef	CHEEP
CHEEP = 1

	.export chr_obj_cheep
chr_obj_cheep:
	.incbin	"../../chr.smb/chr_obj_B2.bin"
	.incbin	"../../chr.smb/chr_obj_B3.bin"
	.incbin	"../../chr.smb/chr_obj_B4.bin"
	.incbin	"../../chr.smb/chr_obj_B5.bin"
	.incbin	"../../chr.smb/chr_obj_B6.bin"
	.incbin	"../../chr.smb/chr_obj_B7.bin"

.endif	; CHEEP
