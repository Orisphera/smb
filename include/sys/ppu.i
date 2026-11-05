.ifndef PPU_I
PPU_I = 1

.include	"sys/cpu.i"

; References
; 1 - Ricoh RP2C02 Picture Processing Unit - December 3rd, 1982
; 2 - Ricoh RP2A03 Custom CPU - December 3rd, 1982

; Object Attribute RAM (OAM) [1](11.1.2)(p. 5)
	OBJ_POS_V	= 0	; object vertical (y) position
	OBJ_CHR_NO	= 1	; object CHR ID
	OBJ_ATTR	= 2	; object attributes
	OBJ_POS_H	= 3	; object horizontal (x) position
	OBJ_SIZE	= 4	; sizeof (OBJ)
	OBJ_MAX		= 64	; sizeof (OAM)/sizeof (OBJ)

	; Object Attributes
	.enum	obj_attr
		color0		= 0			; palette line 0
		color1		= 1			; palette line 1
		color2		= 2			; palette line 2
		color3		= 3			; palette line 3
		color_bits	= 3			; palette line ID

		priority_bit	= %00100000		; OBJ/BG priority
		priority_low	= priority_bit		; OBJ low
		priority_high	= 0			; OBJ high

		h_flip		= %01000000		; flip horizontal
		v_flip		= %10000000		; flip vertical
		flip_bits	= (h_flip|v_flip)	; orientation
		hv_flip		= flip_bits		; flip horizontal/vertical
		no_flip		= 0			; no orientation change
	.endenum

; Control Register 0 [1](11.2.2)(p. 6)
PPU_CTLR0	= $2000
	; Control Register 0 Flags
	.enum	ppu_ctlr0
		bg_bits		= %00000011	; nametable ID
		bg1		= 0		; nametable 1
		bg2		= 1		; nametable 2
		bg3		= 2		; nametable 3
		bg4		= 3		; nametable 4
		bg_parity	= %00000001	; nametable odd/even
		bg_row		= %00000010	; nametable row
		bg_row_1	= bg_row	; nametable row 1
		bg_row_0	= 0		; nametable row 0
		bg_odd		= bg_parity	; nametable odd
		bg_even		= 0		; nametable even

		inc_bit		= %00000100	; VRAM auto-increment
		inc_32		= inc_bit	; VRAM auto-increment 32 (row)
		inc_1		= 0		; VRAM auto-increment 1 (column)

		obj_seg_bit	= %00001000	; OBJ CHR segment ID
		obj_seg1	= obj_seg_bit	; OBJ CHR segment 1
		obj_seg0	= 0		; OBJ CHR segment 0
		bg_seg_bit	= %00010000	; BG CHR segment ID
		bg_seg1		= bg_seg_bit	; BG CHR segment 1
		bg_seg0		= 0		; BG CHR segment 0

		sprite_16_bit	= %00100000	; sprite height
		sprite_16	= sprite_16_bit	; sprite height 2 CHR
		sprite_8	= 0		; sprite height 1 CHR

		int		= %10000000	; vertical interrupt enable
	.endenum
PPU_SPR16_LO	= 0	; low CHR page selection for sprite 16
PPU_SPR16_HI	= 1	; high CHR page selection for sprite 16

; Control Register 1 [1](11.2.3)(p. 6)
PPU_CTLR1	= $2001
	; Control Register 1 Flags
	.enum	ppu_ctlr1
		monotone_bit	= %00000001	; monotone display bit
		monotone	= monotone_bit	; monotone on
		color		= 0		; monotone off (color)

		bglblk_bit	= %00000010	; BG left column blanking
		bglblk_off	= bglblk_bit	; BG left column show
		bglblk_on	= 0		; BG left column blanked
		objlblk_bit	= %00000100	; OBJ left column blanking
		objlblk_off	= objlblk_bit	; OBJ left column show
		objlblk_on	= 0		; OBJ left column blanked
		bgblk_bit	= %00001000	; BG blanking
		bgblk_off	= bgblk_bit	; BG show
		bgblk_on	= 0		; BG blanked
		objblk_bit	= %00010000	; OBJ blanking
		objblk_off	= objblk_bit	; OBJ show
		objblk_on	= 0		; OBJ blanked

		blank_none	= (bglblk_off|objlblk_off|bgblk_off|objblk_off)	; all show
		blank_left	= (bglblk_on|objlblk_on|bgblk_off|objblk_off)	; left column blanked
		blank_all	= (bglblk_on|objlblk_on|bgblk_on|objblk_on)	; all blanked

		red		= %00100000	; red emphasis
		green		= %01000000	; green emphasis
		blue		= %10000000	; blue emphasis
		emph		= (red|green|blue)
	.endenum

; Status Register [1](11.2.4)(p. 6)
PPU_SR		= $2002
	.enum	ppu_sr
		strike		= %01000000	; OBJ 0 strike
		int		= %10000000	; vertical interrupt occurred
	.endenum

; OAM Address Register [1](11.2.5)(p. 7)
PPU_OAM_AR	= $2003

; OAM Write [1](11.2.6)(p. 7)
PPU_OAM_WRITE	= $2004

; Scroll Register H,V [1](11.2.7)(p. 7)
PPU_SCC_H_V	= $2005

; VRAM Address Register H,L [1](11.2.8)(p. 7)
PPU_VRAM_AR	= $2006

; VRAM Read/Write [1](11.2.8)(p. 7)
PPU_VRAM_IO	= $2007

; Video RAM (VRAM) [1](11.2.9)(p. 7)
PPU_VRAM_BG_SIZE	= $400	; sizeof (BG)
PPU_VRAM_CHR0		= $0000	; CHR bank 0
PPU_VRAM_CHR1		= $1000	; CHR bank 1
PPU_VRAM_CHR_SIZE	= $1000 ; CHR bank size
PPU_VRAM_BG		= $2000	; nametables
PPU_VRAM_BG1		= (PPU_VRAM_BG+(PPU_VRAM_BG_SIZE*0))	; nametable 1
PPU_VRAM_BG2		= (PPU_VRAM_BG+(PPU_VRAM_BG_SIZE*1))	; nametable 2
PPU_VRAM_BG3		= (PPU_VRAM_BG+(PPU_VRAM_BG_SIZE*2))	; nametable 3
PPU_VRAM_BG4		= (PPU_VRAM_BG+(PPU_VRAM_BG_SIZE*3))	; nametable 4
PPU_VRAM_COLOR		= $3F00	; color generator
PPU_ADDR_SIZE		= 2	; sizeof (PPU_VRAM_AR)
PPU_ADDR_MASK		= $3FFF	; address bits

; Character Format [1](11.2.9.1)(p. 7)
PPU_CHR_SIZE		= 16	; sizeof (CHR)
PPU_CHR_SIDE_PX		= 8	; side length of CHR in pixels
PPU_CHR_HEIGHT_PX	= PPU_CHR_SIDE_PX	; height of CHR in pixels
PPU_CHR_HEIGHT_DBL_PX	= (PPU_CHR_HEIGHT_PX*2)	; height of doubled (sprite16) CHR in pixels
PPU_CHR_WIDTH_PX	= PPU_CHR_SIDE_PX	; width of CHR in pixels

; Background Format [1](11.2.9.2)(p. 8)
PPU_VRAM_ATTR_BITS	= 2	; number of bits in an attribute
PPU_VRAM_ATTR_ENTRIES	= (BITS_IN_BYTE/PPU_VRAM_ATTR_BITS) ; number of attributes in a single byte
PPU_VRAM_ATTR_SIZE	= (256/PPU_VRAM_ATTR_ENTRIES) ; sizeof (ATTR)
PPU_VRAM_BG_ATTR	= (PPU_VRAM_BG_SIZE-PPU_VRAM_ATTR_SIZE)
PPU_VRAM_COLUMN_COUNT	= 32	; columns (width) of nametable
PPU_VRAM_COLUMN_MASK	= %00011111 ; column mask for nametable addresses
PPU_VRAM_ROW_COUNT	= 30	; rows (height) of nametable
PPU_VRAM_ROW_MASK_HI	= %00000011 ; row mask for nametable addresses, high byte 
PPU_VRAM_ROW_MASK_LO	= %11100000 ; row mask for nametable addresses, low byte
PPU_VRAM_WIDTH_PX	= (PPU_VRAM_COLUMN_COUNT*PPU_CHR_WIDTH_PX)	; nametable width in pixels
PPU_VRAM_HEIGHT_PX	= (PPU_VRAM_ROW_COUNT*PPU_CHR_HEIGHT_PX)	; nametable height in pixels
PPU_BG_COLOR_LINE_0	= 0	; palette line 0
PPU_BG_COLOR_LINE_1	= 1	; palette line 1
PPU_BG_COLOR_LINE_2	= 2	; palette line 2
PPU_BG_COLOR_LINE_3	= 3	; palette line 3
PPU_BG_ATTR_MASK_0	= ((PPU_VRAM_ATTR_ENTRIES-1)<<(3*PPU_VRAM_ATTR_BITS)) ; mask of bits for attr entry 0
PPU_BG_ATTR_MASK_1	= ((PPU_VRAM_ATTR_ENTRIES-1)<<(2*PPU_VRAM_ATTR_BITS)) ; mask of bits for attr entry 1
PPU_BG_ATTR_MASK_2	= ((PPU_VRAM_ATTR_ENTRIES-1)<<(1*PPU_VRAM_ATTR_BITS)) ; mask of bits for attr entry 2
PPU_BG_ATTR_MASK_3	= ((PPU_VRAM_ATTR_ENTRIES-1)<<(0*PPU_VRAM_ATTR_BITS)) ; mask of bits for attr entry 3

PPU_BG_COLOR_LINE_0_ALL	= ((PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_0<<2)|PPU_BG_COLOR_LINE_0)	; BG attr all palette 0
PPU_BG_COLOR_LINE_1_ALL	= ((PPU_BG_COLOR_LINE_1<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)	; BG attr all palette 1
PPU_BG_COLOR_LINE_2_ALL	= ((PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_2<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_2)	; BG attr all palette 2
PPU_BG_COLOR_LINE_3_ALL	= ((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_3<<2)|PPU_BG_COLOR_LINE_3)	; BG attr all palette 3

PPU_BG_ROW_0		= (PPU_VRAM_COLUMN_COUNT*0)	; nametable row offset 0
PPU_BG_ROW_1		= (PPU_VRAM_COLUMN_COUNT*1)	; nametable row offset 1
PPU_BG_ROW_2		= (PPU_VRAM_COLUMN_COUNT*2)	; nametable row offset 2
PPU_BG_ROW_3		= (PPU_VRAM_COLUMN_COUNT*3)	; nametable row offset 3
PPU_BG_ROW_4		= (PPU_VRAM_COLUMN_COUNT*4)	; nametable row offset 4
PPU_BG_ROW_5		= (PPU_VRAM_COLUMN_COUNT*5)	; nametable row offset 5
PPU_BG_ROW_6		= (PPU_VRAM_COLUMN_COUNT*6)	; nametable row offset 6
PPU_BG_ROW_7		= (PPU_VRAM_COLUMN_COUNT*7)	; nametable row offset 7

PPU_BG_ROW_8		= (PPU_VRAM_COLUMN_COUNT*8)	; nametable row offset 8
PPU_BG_ROW_9		= (PPU_VRAM_COLUMN_COUNT*9)	; nametable row offset 9
PPU_BG_ROW_10		= (PPU_VRAM_COLUMN_COUNT*10)	; nametable row offset 10
PPU_BG_ROW_11		= (PPU_VRAM_COLUMN_COUNT*11)	; nametable row offset 11
PPU_BG_ROW_12		= (PPU_VRAM_COLUMN_COUNT*12)	; nametable row offset 12
PPU_BG_ROW_13		= (PPU_VRAM_COLUMN_COUNT*13)	; nametable row offset 13
PPU_BG_ROW_14		= (PPU_VRAM_COLUMN_COUNT*14)	; nametable row offset 14
PPU_BG_ROW_15		= (PPU_VRAM_COLUMN_COUNT*15)	; nametable row offset 15

PPU_BG_ROW_16		= (PPU_VRAM_COLUMN_COUNT*16)	; nametable row offset 16
PPU_BG_ROW_17		= (PPU_VRAM_COLUMN_COUNT*17)	; nametable row offset 17
PPU_BG_ROW_18		= (PPU_VRAM_COLUMN_COUNT*18)	; nametable row offset 18
PPU_BG_ROW_19		= (PPU_VRAM_COLUMN_COUNT*19)	; nametable row offset 19
PPU_BG_ROW_20		= (PPU_VRAM_COLUMN_COUNT*20)	; nametable row offset 20
PPU_BG_ROW_21		= (PPU_VRAM_COLUMN_COUNT*21)	; nametable row offset 21
PPU_BG_ROW_22		= (PPU_VRAM_COLUMN_COUNT*22)	; nametable row offset 22
PPU_BG_ROW_23		= (PPU_VRAM_COLUMN_COUNT*23)	; nametable row offset 23

PPU_BG_ROW_24		= (PPU_VRAM_COLUMN_COUNT*24)	; nametable row offset 24
PPU_BG_ROW_25		= (PPU_VRAM_COLUMN_COUNT*25)	; nametable row offset 25
PPU_BG_ROW_26		= (PPU_VRAM_COLUMN_COUNT*26)	; nametable row offset 26
PPU_BG_ROW_27		= (PPU_VRAM_COLUMN_COUNT*27)	; nametable row offset 27
PPU_BG_ROW_28		= (PPU_VRAM_COLUMN_COUNT*28)	; nametable row offset 28
PPU_BG_ROW_29		= (PPU_VRAM_COLUMN_COUNT*29)	; nametable row offset 29

PPU_BG_COL_0		= 0	; nametable column offset 0
PPU_BG_COL_1		= 1	; nametable column offset 1
PPU_BG_COL_2		= 2	; nametable column offset 2
PPU_BG_COL_3		= 3	; nametable column offset 3
PPU_BG_COL_4		= 4	; nametable column offset 4
PPU_BG_COL_5		= 5	; nametable column offset 5
PPU_BG_COL_6		= 6	; nametable column offset 6
PPU_BG_COL_7		= 7	; nametable column offset 7
PPU_BG_COL_8		= 8	; nametable column offset 8
PPU_BG_COL_9		= 9	; nametable column offset 9
PPU_BG_COL_10		= 10	; nametable column offset 10
PPU_BG_COL_11		= 11	; nametable column offset 11
PPU_BG_COL_12		= 12	; nametable column offset 12
PPU_BG_COL_13		= 13	; nametable column offset 13
PPU_BG_COL_14		= 14	; nametable column offset 14
PPU_BG_COL_15		= 15	; nametable column offset 15
PPU_BG_COL_16		= 16	; nametable column offset 16
PPU_BG_COL_17		= 17	; nametable column offset 17
PPU_BG_COL_18		= 18	; nametable column offset 18
PPU_BG_COL_19		= 19	; nametable column offset 19
PPU_BG_COL_20		= 20	; nametable column offset 20
PPU_BG_COL_21		= 21	; nametable column offset 21
PPU_BG_COL_22		= 22	; nametable column offset 22
PPU_BG_COL_23		= 23	; nametable column offset 23
PPU_BG_COL_24		= 24	; nametable column offset 24
PPU_BG_COL_25		= 25	; nametable column offset 25
PPU_BG_COL_26		= 26	; nametable column offset 26
PPU_BG_COL_27		= 27	; nametable column offset 27
PPU_BG_COL_28		= 28	; nametable column offset 28
PPU_BG_COL_29		= 29	; nametable column offset 29
PPU_BG_COL_30		= 30	; nametable column offset 30
PPU_BG_COL_31		= 31	; nametable column offset 31

; Color Generator [1](11.2.10)(p. 9)
PPU_COLOR_INDEX_MASK	= %00000011	; mask for color access
PPU_COLOR_LINE_SIZE	= 4		; sizeof (COLOR_LINE)
PPU_COLOR_LINE_COUNT	= 4		; number of lines in a palette page
PPU_COLOR_PAGE_SIZE	= (PPU_COLOR_LINE_COUNT*PPU_COLOR_LINE_SIZE)		; sizeof (COLOR_PAGE)
PPU_COLOR_PAGE_BG	= PPU_VRAM_COLOR			; BG palette entries
PPU_COLOR_PAGE_OBJ	= (PPU_VRAM_COLOR+PPU_COLOR_PAGE_SIZE)	; OBJ palette entries
PPU_COLOR_TOTAL_SIZE	= (2*PPU_COLOR_PAGE_SIZE)		; sizeof (COLOR)
PPU_COLOR_GREY		= 0	; color: grey
PPU_COLOR_AZURE		= 1	; color: azure
PPU_COLOR_BLUE		= 2	; color: blue
PPU_COLOR_VIOLET	= 3	; color: violet
PPU_COLOR_MAGENTA	= 4	; color: magenta
PPU_COLOR_ROSE		= 5	; color: rose
PPU_COLOR_RED		= 6	; color: red
PPU_COLOR_ORANGE	= 7	; color: orange
PPU_COLOR_YELLOW	= 8	; color: yellow
PPU_COLOR_YGREEN	= 9	; color: ygreen
PPU_COLOR_GREEN		= 10	; color: green
PPU_COLOR_SPRING	= 11	; color: spring
PPU_COLOR_CYAN		= 12	; color: cyan
PPU_COLOR_VSBLACK	= 13	; color: vsblack
PPU_COLOR_BLACK		= 14	; color: black
PPU_COLOR_PITCH		= 15	; color: pitch
PPU_COLOR_LEV0		= (0<<4)	; color: brightness 0
PPU_COLOR_LEV1		= (1<<4)	; color: brightness 1
PPU_COLOR_LEV2		= (2<<4)	; color: brightness 2
PPU_COLOR_LEV3		= (3<<4)	; color: brightness 3
PPU_COLOR_LEV		= PPU_COLOR_LEV1

; Object DMA [2](11.5)(p. 9)
OBJ_DMA		= $4014

.endif	; PPU_I
