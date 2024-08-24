.ifndef PPU_I
PPU_I = 1

; References
; 1 - Ricoh RP2C02 Picture Processing Unit - December 3rd, 1982
; 2 - Ricoh RP2A03 Custom CPU - December 3rd, 1982

; Object Attribute RAM (OAM) [1](11.1.2)(p. 5)
	OBJ_POS_V	= 0
	OBJ_CHR_NO	= 1
	OBJ_ATTR	= 2
	OBJ_POS_H	= 3
	OBJ_SIZE	= 4
	OBJ_MAX		= 64

	.enum	obj_attr
		color0		= 0
		color1		= 1
		color2		= 2
		color3		= 3
		color_bits	= 3

		priority_high	= $00
		priority_low	= $20
		priority_bit	= $20
		h_flip		= $40
		v_flip		= $80
		no_flip		= $00
	.endenum

; Control Register 0 [1](11.2.2)(p. 6)
PPU_CTLR0	= $2000
	.enum   ppu_ctlr0
		bg_parity = 1
		bg_even	= 0
		bg_odd	= 1
		bg1	= 0
		bg2	= 1
		bg3	= 2
		bg4	= 3
		bg_bits	= 3
		inc_1	= 0
		inc_32	= 4
		inc_bit	= 4

		obj_seg0	= 0
		obj_seg1	= 8
		bg_seg0		= 0
		bg_seg1		= 16

		sprite_8	= 0
		sprite_16	= 32

		int		= 128
	.endenum
PPU_CTLR0_INC_PAGESIZE	= 32

; Control Register 1 [1](11.2.3)(p. 6)
PPU_CTLR1	= $2001
	.enum   ppu_ctlr1
		color		= 0
		monotone	= 1
		bglblk_on	= 0
		bglblk_off	= 2
		objlblk_on	= 0
		objlblk_off	= 4
		bgblk_on	= 0
		bgblk_off	= 8
		objblk_on	= 0
		objblk_off	= 16
		red		= 32
		green		= 64
		blue		= 128
	.endenum

; Status Register [1](11.2.4)(p. 6)
PPU_SR		= $2002

; OAM Address Register [1](11.2.5)(p. 7)
PPU_OAM_AR	= $2003

; OAM Write [1](11.2.6)(p. 7)
PPU_OAM_WRITE	= $2004

; Scroll Register H,V [1](11.2.7)(p. 7)
PPU_SCC_H_V	= $2005
PPU_SCANLINE_240	= $F0

; VRAM Address Register H,L [1](11.2.8)(p. 7)
PPU_VRAM_AR	= $2006

; VRAM Read/Write [1](11.2.8)(p. 7)
PPU_VRAM_IO	= $2007

; Video RAM (VRAM) [1](11.2.9)(p. 7)
PPU_VRAM_OBJ_CHR	= $0000
PPU_VRAM_BG_CHR		= $1000
PPU_VRAM_BG1		= $2000
PPU_VRAM_BG2		= $2400
PPU_VRAM_BG3		= $2800
PPU_VRAM_BG4		= $2C00
PPU_VRAM_COLOR		= $3F00
PPU_ADDR_SIZE		= 2

; Character Format [1](11.2.9.1)(p. 7)
PPU_TILE_SIZE		= $10
PPU_TILE_HEIGHT_PX	= 8
PPU_TILE_WIDTH_PX	= 8
PPU_COLOR_ROW_SIZE	= 4
PPU_COLOR_INDEX_MASK	= 3

; Background Format [1](11.2.9.2)(p. 8)
PPU_VRAM_BG_VIS		= $3C0
PPU_BG_COLOR_LINE_0	= 0
PPU_BG_COLOR_LINE_1	= 1
PPU_BG_COLOR_LINE_2	= 2
PPU_BG_COLOR_LINE_3	= 3
PPU_TILE_PER_LINE	= $20

; Color Generator [1](11.2.10)(p. 9)
PPU_COLOR_LINE_SIZE	= 4
PPU_COLOR_PAGE_SIZE	= (4*PPU_COLOR_LINE_SIZE)
PPU_COLOR_PAGE_BG	= PPU_VRAM_COLOR
PPU_COLOR_PAGE_OBJ	= (PPU_VRAM_COLOR+PPU_COLOR_PAGE_SIZE)
PPU_COLOR_TOTAL_SIZE	= (2*PPU_COLOR_PAGE_SIZE)
PPU_COLOR_GREY		= $00
PPU_COLOR_AZURE		= $01
PPU_COLOR_BLUE		= $02
PPU_COLOR_VIOLET	= $03
PPU_COLOR_MAGENTA	= $04
PPU_COLOR_ROSE		= $05
PPU_COLOR_RED		= $06
PPU_COLOR_ORANGE	= $07
PPU_COLOR_YELLOW	= $08
PPU_COLOR_YGREEN	= $09
PPU_COLOR_GREEN		= $0A
PPU_COLOR_SPRING	= $0B
PPU_COLOR_CYAN		= $0C
PPU_COLOR_VSBLACK	= $0D
PPU_COLOR_BLACK		= $0E
PPU_COLOR_PITCH		= $0F
PPU_COLOR_LEV0		= $00
PPU_COLOR_LEV1		= $10
PPU_COLOR_LEV2		= $20
PPU_COLOR_LEV3		= $30

; Object DMA [2](11.5)(p. 9)
OBJ_DMA		= $4014

.endif	; PPU_I
