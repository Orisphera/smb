.ifndef	STAIR_S
STAIR_S = 1

	.export chr_bg_stair
chr_bg_stair:
	.incbin	"data/chr.smb/chr_bg_AB.bin"
	.incbin	"data/chr.smb/chr_bg_AC.bin"
	.incbin	"data/chr.smb/chr_bg_AD.bin"
	.incbin	"data/chr.smb/chr_bg_AE.bin"

.endif	; STAIR
