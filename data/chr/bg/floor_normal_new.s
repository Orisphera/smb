.ifndef	FLOOR_NORMAL_S
FLOOR_NORMAL_S = 1

	.export chr_bg_floor_normal
chr_bg_floor_normal:
	.incbin	"data/chr.smb2/chr_bg_B4.bin"
	.incbin	"data/chr.smb2/chr_bg_B5.bin"
	.incbin	"data/chr.smb2/chr_bg_B6.bin"
	.incbin	"data/chr.smb2/chr_bg_B7.bin"

.endif	; FLOOR_NORMAL_S
