.ifndef	SIGN_LETTER_EDGE
SIGN_LETTER_EDGE = 1

	.export	chr_bg_sign_letter_edge
chr_bg_sign_letter_edge:
	.incbin	"data/chr.smb/chr_bg_42.bin"
	.incbin	"data/chr.smb/chr_bg_43.bin"

        .export chr_bg_sign_nw
chr_bg_sign_nw:
        .incbin "data/chr.smb/chr_bg_44.bin"

.endif	; SIGN_LETTER_EDGE
