.ifndef	BRICK
BRICK = 1

	.export chr_obj_brick
chr_obj_brick:
	.incbin	"../../chr.smb/chr_obj_85.bin"
	.incbin	"../../chr.smb/chr_obj_86.bin"

.endif	; BRICK
