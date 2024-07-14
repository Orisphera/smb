.ifndef	POST_B
POST_B = 1

	.export tile_bg_post_b
tile_bg_post_b:
	.incbin	"data/chr.ann/tile_bg_A0.bin"
	.incbin	"data/chr.ann/tile_bg_A1.bin"

.endif	; POST_B
