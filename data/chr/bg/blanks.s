.ifndef	BLANKS
BLANKS = 1

	.export chr_bg_blanks
chr_bg_blanks:
	.incbin	"data/chr.smb/chr_bg_24.bin"
	.incbin	"data/chr.smb/chr_bg_25.bin"
	.incbin	"data/chr.smb/chr_bg_26.bin"
	.incbin	"data/chr.smb/chr_bg_27.bin"

.endif	; BLANKS
