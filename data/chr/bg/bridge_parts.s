.ifndef	BRIDGE_PARTS
BRIDGE_PARTS = 1

	.export tile_bg_bridge_parts
tile_bg_bridge_parts:
		.incbin	"data/chr.smb/tile_bg_C0.bin"
		.incbin	"data/chr.smb/tile_bg_C1.bin"

.endif	; BRIDGE_PARTS
