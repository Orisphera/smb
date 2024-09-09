.ifndef	SPRING
SPRING = 1

	.export chr_obj_spring
chr_obj_spring:
	.incbin	"../../chr.smb/chr_obj_F0.bin"
	.incbin	"../../chr.smb/chr_obj_F1.bin"
	.incbin	"../../chr.smb/chr_obj_F2.bin"
	.incbin	"../../chr.smb/chr_obj_F3.bin"

.endif	; SPRING
