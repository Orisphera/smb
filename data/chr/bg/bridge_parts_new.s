.ifndef BRIDGE_PARTS
BRIDGE_PARTS = 1

	.export chr_bg_bridge_parts
chr_bg_bridge_parts:
	.incbin	"data/chr.smb2/chr_bg_C0.bin"
	.incbin	"data/chr.smb2/chr_bg_C1.bin"

.endif	; BRIDGE_PARTS
