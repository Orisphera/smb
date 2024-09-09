.ifndef	SIGN_TEXT_SMB2
SIGN_TEXT_SMB2 = 1

	.export chr_bg_sign_text_smb2
chr_bg_sign_text_smb2:
	.incbin	"data/chr.smb2/chr_bg_EC.bin"
	.incbin	"data/chr.smb2/chr_bg_ED.bin"
	.incbin	"data/chr.smb2/chr_bg_EE.bin"
	.incbin	"data/chr.smb2/chr_bg_EF.bin"
	.incbin	"data/chr.smb2/chr_bg_F0.bin"

.endif	; SIGN_TEXT_SMB2
