.ifndef WINDOW_S
WINDOW_S = 1

	.export chr_bg_window_button
chr_bg_window_button:
	.incbin	"data/chr.vs/chr_bg_F0.bin"
	.incbin	"data/chr.vs/chr_bg_F1.bin"
	.incbin	"data/chr.vs/chr_bg_F2.bin"
	.incbin	"data/chr.vs/chr_bg_F3.bin"

	.export	chr_bg_window_box
	.export	chr_bg_window_box_nw
	.export	chr_bg_window_box_sw
	.export	chr_bg_window_box_n_s
	.export	chr_bg_window_box_ne
	.export	chr_bg_window_box_w_e
	.export	chr_bg_window_box_se
chr_bg_window_box:
chr_bg_window_box_nw:
	.incbin	"data/chr.vs/chr_bg_F4.bin"
chr_bg_window_box_sw:
	.incbin	"data/chr.vs/chr_bg_F5.bin"
chr_bg_window_box_n_s:
	.incbin	"data/chr.vs/chr_bg_F6.bin"
chr_bg_window_box_ne:
	.incbin	"data/chr.vs/chr_bg_F7.bin"
chr_bg_window_box_w_e:
	.incbin	"data/chr.vs/chr_bg_F8.bin"
chr_bg_window_box_se:
	.incbin	"data/chr.vs/chr_bg_F9.bin"

	.export chr_bg_window_apostrophe
chr_bg_window_apostrophe:
	.incbin	"data/chr.vs/chr_bg_FA.bin"

	.export chr_bg_window_rub
chr_bg_window_rub:
	.incbin	"data/chr.vs/chr_bg_FB.bin"
	.incbin	"data/chr.vs/chr_bg_FC.bin"

	.export chr_bg_window_end
chr_bg_window_end:
	.incbin	"data/chr.vs/chr_bg_FD.bin"
	.incbin	"data/chr.vs/chr_bg_FE.bin"

.endif	; WINDOW
