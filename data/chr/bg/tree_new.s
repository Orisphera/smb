.ifndef	TREE_NEW
TREE_NEW = 1

	.export chr_bg_tree
chr_bg_tree:
		.incbin	"data/chr.smb2/chr_bg_B8.bin"
		.incbin	"data/chr.smb2/chr_bg_B9.bin"
		.incbin	"data/chr.smb2/chr_bg_BA.bin"
		.incbin	"data/chr.smb2/chr_bg_BB.bin"
		.incbin	"data/chr.smb2/chr_bg_BC.bin"
		.incbin	"data/chr.smb2/chr_bg_BD.bin"

.endif	; TREE_NEW
