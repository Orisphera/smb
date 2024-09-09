.ifndef	DIGITS_B
DIGITS_B = 1

	.export chr_obj_digits_10, chr_obj_digits_20
	.export chr_obj_digits_40, chr_obj_digits_50
	.export chr_obj_digits_80, chr_obj_digits_0
chr_obj_digits_10:
	.incbin	"../../chr.smb/chr_obj_F6.bin"

chr_obj_digits_20:
	.incbin	"../../chr.smb/chr_obj_F7.bin"

chr_obj_digits_40:
	.incbin	"../../chr.smb/chr_obj_F8.bin"

chr_obj_digits_50:
	.incbin	"../../chr.smb/chr_obj_F9.bin"

chr_obj_digits_80:
	.incbin	"../../chr.smb/chr_obj_FA.bin"

chr_obj_digits_0:
	.incbin	"../../chr.smb/chr_obj_FB.bin"

.endif	; DIGITS_B
