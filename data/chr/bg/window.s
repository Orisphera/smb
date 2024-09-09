.ifndef WINDOW_S
WINDOW_S = 1

	.export tile_bg_window_button
tile_bg_window_button:
	.incbin	"data/chr.vs/tile_bg_F0.bin"
	.incbin	"data/chr.vs/tile_bg_F1.bin"
	.incbin	"data/chr.vs/tile_bg_F2.bin"
	.incbin	"data/chr.vs/tile_bg_F3.bin"

	.export	tile_bg_window_box
	.export	tile_bg_window_box_nw
	.export	tile_bg_window_box_sw
	.export	tile_bg_window_box_n_s
	.export	tile_bg_window_box_ne
	.export	tile_bg_window_box_w_e
	.export	tile_bg_window_box_se
tile_bg_window_box:
tile_bg_window_box_nw:
	.incbin	"data/chr.vs/tile_bg_F4.bin"
tile_bg_window_box_sw:
	.incbin	"data/chr.vs/tile_bg_F5.bin"
tile_bg_window_box_n_s:
	.incbin	"data/chr.vs/tile_bg_F6.bin"
tile_bg_window_box_ne:
	.incbin	"data/chr.vs/tile_bg_F7.bin"
tile_bg_window_box_w_e:
	.incbin	"data/chr.vs/tile_bg_F8.bin"
tile_bg_window_box_se:
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
