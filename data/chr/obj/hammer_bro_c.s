.ifndef	HAMMER_BRO_C
HAMMER_BRO_C = 1

	.export chr_obj_hammer_bro_c
chr_obj_hammer_bro_c:
	.incbin	"../../chr.smb/chr_obj_D1.bin"
	.incbin	"../../chr.smb/chr_obj_D2.bin"
	.incbin	"../../chr.smb/chr_obj_D3.bin"
	.incbin	"../../chr.smb/chr_obj_D4.bin"
	.incbin	"../../chr.smb/chr_obj_D5.bin"

.endif	; HAMMER_BRO_C
