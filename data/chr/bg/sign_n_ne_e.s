.ifndef	SIGN_N_NE_E
SIGN_N_NE_E = 1

	.export chr_bg_sign_n
	.export chr_bg_sign_ne
	.export chr_bg_sign_e
chr_bg_sign_n:
	.incbin	"data/chr.smb/chr_bg_48.bin"

chr_bg_sign_ne:
	.incbin	"data/chr.smb/chr_bg_49.bin"

chr_bg_sign_e:
	.incbin	"data/chr.smb/chr_bg_4A.bin"

.endif	; SIGN_N_NE_E
