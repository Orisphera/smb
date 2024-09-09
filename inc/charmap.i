.ifndef CHARMAP_I
CHARMAP_I = 1

.include	"tunables.i"

	.charmap	'0', ENG_FONT_TILE_BASE+$00
	.charmap	'1', ENG_FONT_TILE_BASE+$01
	.charmap	'2', ENG_FONT_TILE_BASE+$02
	.charmap	'3', ENG_FONT_TILE_BASE+$03
	.charmap	'4', ENG_FONT_TILE_BASE+$04
	.charmap	'5', ENG_FONT_TILE_BASE+$05
	.charmap	'6', ENG_FONT_TILE_BASE+$06
	.charmap	'7', ENG_FONT_TILE_BASE+$07
	.charmap	'8', ENG_FONT_TILE_BASE+$08
	.charmap	'9', ENG_FONT_TILE_BASE+$09
	.charmap	'A', ENG_FONT_TILE_BASE+$0A
	.charmap	'B', ENG_FONT_TILE_BASE+$0B
	.charmap	'C', ENG_FONT_TILE_BASE+$0C
	.charmap	'D', ENG_FONT_TILE_BASE+$0D
	.charmap	'E', ENG_FONT_TILE_BASE+$0E
	.charmap	'F', ENG_FONT_TILE_BASE+$0F
	.charmap	'G', ENG_FONT_TILE_BASE+$10
	.charmap	'H', ENG_FONT_TILE_BASE+$11
	.charmap	'I', ENG_FONT_TILE_BASE+$12
	.charmap	'J', ENG_FONT_TILE_BASE+$13
	.charmap	'K', ENG_FONT_TILE_BASE+$14
	.charmap	'L', ENG_FONT_TILE_BASE+$15
	.charmap	'M', ENG_FONT_TILE_BASE+$16
	.charmap	'N', ENG_FONT_TILE_BASE+$17
	.charmap	'O', ENG_FONT_TILE_BASE+$18
	.charmap	'P', ENG_FONT_TILE_BASE+$19
	.charmap	'Q', ENG_FONT_TILE_BASE+$1A
	.charmap	'R', ENG_FONT_TILE_BASE+$1B
	.charmap	'S', ENG_FONT_TILE_BASE+$1C
	.charmap	'T', ENG_FONT_TILE_BASE+$1D
	.charmap	'U', ENG_FONT_TILE_BASE+$1E
	.charmap	'V', ENG_FONT_TILE_BASE+$1F
	.charmap	'W', ENG_FONT_TILE_BASE+$20
	.charmap	'X', ENG_FONT_TILE_BASE+$21
	.charmap	'Y', ENG_FONT_TILE_BASE+$22
	.charmap	'Z', ENG_FONT_TILE_BASE+$23
	.charmap	' ', ENG_FONT_TILE_BASE+$24
	.charmap	'-', ENG_FONT_TILE_BASE+$28
	.charmap	'x', ENG_FONT_TILE_BASE+$29
	.charmap	'!', ENG_FONT_TILE_BASE+$2B
	; NOTE: This is the HUD coin icon in the 
	;   stock art set
	.charmap	'$', ENG_FONT_TILE_BASE+$2E
	.charmap	'.', ENG_FONT_TILE_BASE+$AF
	; NOTE: This is the copyright icon in the
	;   stock art set
	.charmap	'c', ENG_FONT_TILE_BASE+$CF
	.if	.defined(VS_SMB)
	.charmap	$27, ENG_FONT_TILE_BASE+$FA
	.endif

.endif	; CHARMAP_I
