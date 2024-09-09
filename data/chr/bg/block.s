.ifndef	BLOCK_BG
BLOCK_BG = 1

	.export chr_bg_block_q
chr_bg_block_q:
	.incbin	"data/chr.smb/chr_bg_53.bin"
	.incbin	"data/chr.smb/chr_bg_54.bin"
	.incbin	"data/chr.smb/chr_bg_55.bin"
	.incbin	"data/chr.smb/chr_bg_56.bin"

	.export chr_bg_block_empty
chr_bg_block_empty:
	.incbin	"data/chr.smb/chr_bg_57.bin"
	.incbin	"data/chr.smb/chr_bg_58.bin"
	.incbin	"data/chr.smb/chr_bg_59.bin"
	.incbin	"data/chr.smb/chr_bg_5A.bin"

.endif	; BLOCK_BG
