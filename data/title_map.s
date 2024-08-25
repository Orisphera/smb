.include	"system/ppu.i"

.include	"engine/tunables.i"
.include	"engine/chr.i"
.include	"engine/charmap.i"

.if	.defined(SMB)
.segment	"CHR0DATA"
.elseif	.defined(VS_SMB)
.segment	"CHR1DATA"
.endif

SIGN_BLANK	= tile_bg::blanks+2

	.export title_map, title_map_end
title_map:
	.dbyt	PPU_VRAM_BG1+$A6
	.byte	NMI_REPEAT|20, SIGN_BLANK

	.dbyt	PPU_VRAM_BG1+$C6
	.byte	NMI_REPEAT|20, SIGN_BLANK

	.dbyt	PPU_VRAM_BG1+$E6
	.byte	NMI_REPEAT|20, SIGN_BLANK

	.dbyt	PPU_VRAM_BG1+$106
	.byte	NMI_REPEAT|20, SIGN_BLANK

	.dbyt	PPU_VRAM_BG1+$85
	.byte	title_pos_85_end-title_pos_85
title_pos_85:
	.byte	tile_bg::sign_nw
title_pos_85_end:

	.dbyt	PPU_VRAM_BG1+$86
	.byte	NMI_REPEAT|20, tile_bg::sign_n

	.dbyt	PPU_VRAM_BG1+$9A
	.byte	title_pos_9A_end-title_pos_9A
title_pos_9A:
	.byte	tile_bg::sign_ne
title_pos_9A_end:

	.dbyt	PPU_VRAM_BG1+$A5
	.byte	NMI_INC_ROW|NMI_REPEAT|9, tile_bg::sign_w

	.dbyt	PPU_VRAM_BG1+$BA
	.byte	NMI_INC_ROW|NMI_REPEAT|9, tile_bg::sign_e

	.dbyt	PPU_VRAM_BG1+$A6
	.byte	title_pos_A6_end-title_pos_A6
title_pos_A6:
	.if	.defined(VS_SMB)
		.byte	tile_bg::sign_text_b+8
		.byte	tile_bg::sign_text_b+8
		.byte	tile_bg::sign_text_b+0
		.byte	tile_bg::sign_text_b+1
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
	.endif

	.byte	tile_bg::sign_text_b+0
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+8
	.byte	tile_bg::sign_text_b+8
	.byte	tile_bg::sign_text_b+14
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+0
	.byte	tile_bg::sign_text_b+10
	.byte	tile_bg::sign_text_b+14
	.byte	tile_bg::sign_text_b+1
title_pos_A6_end:

	.dbyt	PPU_VRAM_BG1+$C6
	.byte	title_pos_C6_end-title_pos_C6
title_pos_C6:
	.if	.defined(VS_SMB)
		.byte	tile_bg::sign_text_b+11
		.byte	tile_bg::sign_text_b+11
		.byte	tile_bg::sign_text_b+2
		.byte	tile_bg::sign_text_b+3
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
	.endif

	.byte	tile_bg::sign_text_b+2
	.byte	tile_bg::sign_text_b+3
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+9
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+12
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+15
title_pos_C6_end:

	.dbyt	PPU_VRAM_BG1+$E6
	.byte	title_pos_E6_end-title_pos_E6
title_pos_E6:
	.if	.defined(VS_SMB)
		.byte	tile_bg::sign_text_vs+0
		.byte	tile_bg::sign_text_vs+1
		.byte	tile_bg::sign_text_b+4
		.byte	tile_bg::sign_text_b+5
		.byte	tile_bg::sign_text_b+23
		.byte	SIGN_BLANK
	.endif

	.byte	tile_bg::sign_text_b+4
	.byte	tile_bg::sign_text_b+5
	.byte	tile_bg::sign_text_b+4
	.byte	tile_bg::sign_text_b+9
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+18
	.byte	tile_bg::sign_text_b+4
	.byte	tile_bg::sign_text_b+10
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+16
title_pos_E6_end:

	.dbyt	PPU_VRAM_BG1+$106
	.byte	title_pos_106_end-title_pos_106
title_pos_106:
	.if	.defined(VS_SMB)
		.byte	tile_bg::sign_text_vs+2
		.byte	tile_bg::sign_text_vs+3
		.byte	tile_bg::sign_text_b+6
		.byte	tile_bg::sign_text_b+7
		.byte	tile_bg::sign_text_b+17
		.byte	SIGN_BLANK
	.endif

	.byte	tile_bg::sign_text_b+6
	.byte	tile_bg::sign_text_b+7
	.byte	tile_bg::sign_text_b+6
	.byte	tile_bg::sign_text_b+7
	.byte	tile_bg::sign_text_b+17
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+6
	.byte	tile_bg::sign_text_b+13
	.byte	tile_bg::sign_text_b+17
	.byte	tile_bg::sign_text_b+17
title_pos_106_end:

	.dbyt	PPU_VRAM_BG1+$126
	.byte	title_pos_126_end-title_pos_126
title_pos_126:
	.byte	tile_bg::sign_text_b+0
	.byte	tile_bg::sign_text_b+24
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+0
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+14
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+8
	.byte	tile_bg::sign_text_b+0
	.byte	tile_bg::sign_text_b+1
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+14
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+14
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+0
	.byte	tile_bg::sign_text_b+1
	.byte	tile_bg::sign_text_b+0
	.byte	tile_bg::sign_text_b+1
	.byte	SIGN_BLANK
title_pos_126_end:

	.dbyt	PPU_VRAM_BG1+$146
	.byte	title_pos_146_end-title_pos_146
title_pos_146:
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	SIGN_BLANK
title_pos_146_end:

	.dbyt	PPU_VRAM_BG1+$166
	.byte	NMI_REPEAT|6, tile_bg::sign_text_b+11

	.dbyt	PPU_VRAM_BG1+$16C
	.byte	title_pos_16C_end-title_pos_16C
title_pos_16C:
	.byte	tile_bg::sign_text_b+15
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+15
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+15
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+20
	.byte	tile_bg::sign_text_b+21
	.byte	SIGN_BLANK
title_pos_16C_end:

	.dbyt	PPU_VRAM_BG1+$186
	.byte	title_pos_186_end-title_pos_186
title_pos_186:
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+14
	.byte	tile_bg::sign_letter_edge+1
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+16
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+19
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+16
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+22
	.byte	tile_bg::sign_text_b+19
	.byte	SIGN_BLANK
title_pos_186_end:

	.dbyt	PPU_VRAM_BG1+$1A6
	.byte	title_pos_1A6_end-title_pos_1A6
title_pos_1A6:
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+4
	.byte	tile_bg::sign_text_b+9
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+9
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+4
	.byte	tile_bg::sign_text_b+9
	.byte	tile_bg::sign_text_b+4
	.byte	tile_bg::sign_text_b+9
	.byte	tile_bg::sign_text_b+23
title_pos_1A6_end:

	.dbyt	PPU_VRAM_BG1+$1C5
	.byte	title_pos_1C5_end-title_pos_1C5
title_pos_1C5:
	.byte	tile_bg::sign_sw
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+2
	.byte	tile_bg::sign_text_a+3
	.byte	tile_bg::sign_s
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+1
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_text_a+2
	.byte	tile_bg::sign_text_a+3
	.byte	tile_bg::sign_text_a+2
	.byte	tile_bg::sign_text_a+3
	.byte	tile_bg::sign_text_a+0
	.byte	tile_bg::sign_se
title_pos_1C5_end:

	.dbyt	PPU_VRAM_BG1+$1ED
	.byte	title_pos_1ED_end-title_pos_1ED
title_pos_1ED:
	.byte	"c"
	.if	.defined(SMB)
		.byte	"1985"
	.elseif	.defined(VS_SMB)
		.byte	"1986"
	.endif
	.byte	" NINTENDO"
title_pos_1ED_end:

.if	.defined(CONS)
	.dbyt	PPU_VRAM_BG1+$24B
	.byte	title_pos_24B_end-title_pos_24B
title_pos_24B:
	.byte	"1 PLAYER GAME"
title_pos_24B_end:

	.dbyt	PPU_VRAM_BG1+$28B
	.byte	title_pos_28B_end-title_pos_28B
title_pos_28B:
	.byte	"2 PLAYER GAME"
title_pos_28B_end:
.elseif	.defined(VS)
	.dbyt	PPU_VRAM_BG1+$266
	.byte	title_pos_266_end-title_pos_266
title_pos_266:
	.byte	"I N S E R T  C O I N"
title_pos_266_end:
.endif

	.dbyt	PPU_VRAM_BG1+$2EC
	.byte	title_pos_2EC_end-title_pos_2EC
title_pos_2EC:
	.byte	"TOP-"
title_pos_2EC_end:

	.dbyt	PPU_VRAM_BG1+$2F6
	.byte	title_pos_2F6_end-title_pos_2F6
title_pos_2F6:
	.byte	"0"
title_pos_2F6_end:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$9
	.byte	NMI_REPEAT|22, PPU_BG_COLOR_LINE_1_ALL

.if	.defined(SMB)
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$22
	.byte	title_color_22_end-title_color_22
title_color_22:
	.byte	((PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_1)
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
title_color_22_end:
.elseif	.defined(VS_SMB)
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$20
	.byte	NMI_REPEAT|8, PPU_BG_COLOR_LINE_2_ALL
.endif

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$2A
	.byte	title_color_2A_end-title_color_2A
title_color_2A:
	.byte	((PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_1)
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
title_color_2A_end:

	.byte	NMI_DATA_END
title_map_end:

