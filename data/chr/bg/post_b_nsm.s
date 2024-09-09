.ifndef	POST_B
POST_B = 1

	.export chr_bg_post_b
chr_bg_post_b:
	.incbin	"data/chr.ann/chr_bg_A0.bin"
	.incbin	"data/chr.ann/chr_bg_A1.bin"

.endif	; POST_B
