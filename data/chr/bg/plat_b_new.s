.ifndef	PLAT_B_BG
PLAT_B_BG = 1

	.export chr_bg_plat_b
chr_bg_plat_b:
	.incbin	"data/chr.smb2/chr_bg_4B.bin"
	.incbin	"data/chr.smb2/chr_bg_4C.bin"
	.incbin	"data/chr.smb/chr_bg_4D.bin"
	.incbin	"data/chr.smb2/chr_bg_4E.bin"
	.incbin	"data/chr.smb2/chr_bg_4F.bin"
	.incbin	"data/chr.smb2/chr_bg_50.bin"
	.incbin	"data/chr.smb2/chr_bg_51.bin"
	.incbin	"data/chr.smb2/chr_bg_52.bin"

.endif	; PLAT_B_BG
