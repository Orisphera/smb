.ifndef	AXE_NSM
AXE_NSM = 1

	.export chr_bg_axe
chr_bg_axe:
		.incbin	"data/chr.ann/chr_bg_7B.bin"
		.incbin	"data/chr.ann/chr_bg_7C.bin"
		.incbin	"data/chr.ann/chr_bg_7D.bin"
		.incbin	"data/chr.ann/chr_bg_7E.bin"

.endif	; AXE_NSM
