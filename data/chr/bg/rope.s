.ifndef ROPE_S
ROPE_S = 1

	.export chr_bg_rope
chr_bg_rope:
	.incbin	"data/chr.smb/chr_bg_99.bin"
	.incbin	"data/chr.smb/chr_bg_9A.bin"

.endif	; ROPE
