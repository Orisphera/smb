.ifndef	POST_A
POST_A = 1

	.export chr_bg_post_a
chr_bg_post_a:
	.incbin	"data/chr.ann/chr_bg_80.bin"
	.incbin	"data/chr.ann/chr_bg_81.bin"

.endif	; POST_A
