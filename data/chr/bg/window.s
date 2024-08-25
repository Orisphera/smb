.ifndef WINDOW_S
WINDOW_S = 1

	.export tile_bg_window_button
tile_bg_window_button:
	.incbin	"data/chr.vs/tile_bg_F0.bin"
	.incbin	"data/chr.vs/tile_bg_F1.bin"
	.incbin	"data/chr.vs/tile_bg_F2.bin"
	.incbin	"data/chr.vs/tile_bg_F3.bin"

	.incbin	"data/chr.vs/tile_bg_F4.bin"
	.incbin	"data/chr.vs/tile_bg_F5.bin"
	.incbin	"data/chr.vs/tile_bg_F6.bin"
	.incbin	"data/chr.vs/tile_bg_F7.bin"
	.incbin	"data/chr.vs/tile_bg_F8.bin"
	.incbin	"data/chr.vs/tile_bg_F9.bin"

	.export tile_bg_window_apostrophe
tile_bg_window_apostrophe:
	.incbin	"data/chr.vs/tile_bg_FA.bin"

	.export tile_bg_window_rub
tile_bg_window_rub:
	.incbin	"data/chr.vs/tile_bg_FB.bin"
	.incbin	"data/chr.vs/tile_bg_FC.bin"

	.export tile_bg_window_end
tile_bg_window_end:
	.incbin	"data/chr.vs/tile_bg_FD.bin"
	.incbin	"data/chr.vs/tile_bg_FE.bin"

.endif	; WINDOW
