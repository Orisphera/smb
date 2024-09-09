.ifndef	CLOUD_SMALL
CLOUD_SMALL = 1

	.export chr_bg_cloud_small
chr_bg_cloud_small:
	.incbin	"data/chr.smb/chr_bg_B0.bin"
	.incbin	"data/chr.smb/chr_bg_B1.bin"
	.incbin	"data/chr.smb/chr_bg_B2.bin"
	.incbin	"data/chr.smb/chr_bg_B3.bin"

.endif	; CLOUD_SMALL
