.ifndef	BRICK_NEW
BRICK_NEW = 1

	.export chr_obj_brick
chr_obj_brick:
	.incbin	"../../chr.smb2/chr_obj_85.bin"
	.incbin	"../../chr.smb2/chr_obj_86.bin"

.endif	; BRICK_NEW
