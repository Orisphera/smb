.ifndef	SIGN_TEXT_VS
SIGN_TEXT_VS = 1

	.export chr_bg_sign_text_vs
chr_bg_sign_text_vs:
	.incbin	"data/chr.vs/chr_bg_EC.bin"
	.incbin	"data/chr.vs/chr_bg_ED.bin"
	.incbin	"data/chr.vs/chr_bg_EE.bin"
	.incbin	"data/chr.vs/chr_bg_EF.bin"

.endif	; SIGN_TEXT_VS
