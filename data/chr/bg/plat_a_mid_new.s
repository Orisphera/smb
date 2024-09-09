.ifndef	PLAT_A_MID
PLAT_A_MID = 1

	.export chr_bg_plat_a_mid
chr_bg_plat_a_mid:
	.incbin	"data/chr.smb2/chr_bg_2C.bin"
	.incbin	"data/chr.smb2/chr_bg_2D.bin"

.endif	; PLAT_A_MID
