.ifndef	TREE_NEW
TREE_NEW = 1

	.export tile_bg_tree
tile_bg_tree:
		.incbin	"data/chr.smb2/tile_bg_B8.bin"
		.incbin	"data/chr.smb2/tile_bg_B9.bin"
		.incbin	"data/chr.smb2/tile_bg_BA.bin"
		.incbin	"data/chr.smb2/tile_bg_BB.bin"
		.incbin	"data/chr.smb2/tile_bg_BC.bin"
		.incbin	"data/chr.smb2/tile_bg_BD.bin"

.endif	; TREE_NEW
