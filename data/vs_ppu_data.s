.include        "system/ppu.i"
.include        "system/palette.i"

.include        "tunables.i"
.include        "chr.i"
.include	"charmap.i"

.segment        "CHR1DATA"

.if	.defined(OG_PAD)
	.res	836, $FF
.endif

	.export vs_player_select_bg
vs_player_select_bg:
	.dbyt	PPU_VRAM_COLOR+(PPU_COLOR_PAGE_SIZE*0)
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,  PPU_COLOR_BLUE1,  PPU_COLOR_CYAN0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0, PPU_COLOR_PITCH0, PPU_COLOR_PITCH0
	:

	.dbyt	PPU_VRAM_COLOR+(PPU_COLOR_PAGE_SIZE*1)
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,  PPU_COLOR_PITCH0, PPU_COLOR_PITCH0
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+25
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_1_ALL

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_7+PPU_BG_COL_10
	.byte	(:++)-(:+)
	: .byte	"PUSH BUTTON"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_10+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_button+0
	.byte	chr_bg::window_button+2
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_button+1
	.byte	chr_bg::window_button+3
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_11
	.byte	(:++)-(:+)
	: .byte	"FOR 1-PLAYER"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_button+0
	.byte	chr_bg::window_button+2
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_button+1
	.byte	chr_bg::window_button+3
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_11
	.byte	(:++)-(:+)
	: .byte	"FOR 2-PLAYERS"
	:

	.byte	NMI_LIST_END
; ------------------------------------------------------------
        .res    8, $FF
; ------------------------------------------------------------
	.export vs_name_register_bg
vs_name_register_bg:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	"NAME REGISTRATION"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_8+PPU_BG_COL_6
	.byte	(:++)-(:+)
	: .byte	"A B C D E F G H I J K"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_12+PPU_BG_COL_6
	.byte	(:++)-(:+)
	: .byte	"L M N O P Q R S T U V"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_6
	.byte	(:++)-(:+)
	: .byte	"W X Y Z ! - . ' "
	.byte	chr_bg::window_rub+0, chr_bg::window_rub+1
	.byte	" "
	.byte	chr_bg::window_end+0, chr_bg::window_end+1
	:

	.byte	NMI_LIST_END
; ------------------------------------------------------------
        .res    3, $FF
; ------------------------------------------------------------
	.export vs_stats_bg
vs_stats_bg:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_22+PPU_BG_COL_20
	.byte	NMI_INC_ROW|((:++)-(:+))
	: .byte	chr_bg::window_box_nw
	.byte	chr_bg::window_box_w_e
	.byte	chr_bg::window_box_sw
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_22+PPU_BG_COL_26
	.byte	NMI_INC_ROW|((:++)-(:+))
	: .byte	chr_bg::window_box_ne
	.byte	chr_bg::window_box_w_e
	.byte	chr_bg::window_box_se
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_22+PPU_BG_COL_21
	.byte	NMI_REPEAT|5, chr_bg::window_box_n_s

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_4
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_box_nw, chr_bg::window_box_n_s, chr_bg::window_box_n_s, chr_bg::window_box_ne
	.byte	"NAME"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_24+PPU_BG_COL_21
	.byte	NMI_REPEAT|5, chr_bg::window_box_n_s

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_12
	.byte	NMI_REPEAT|8, "."

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_24+PPU_BG_COL_4
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_box_w_e, "20", chr_bg::window_box_w_e
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_25+PPU_BG_COL_4
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_box_sw, chr_bg::window_box_n_s, chr_bg::window_box_n_s, chr_bg::window_box_se
	.byte	"SCORE..0W-0."
	:

	.byte	NMI_LIST_END
; ------------------------------------------------------------
        .res    18, $FF
; ------------------------------------------------------------
VS_BOX_BG_TILE	= chr_bg::brick_b

	.export vs_box_bg
vs_box_bg:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_0+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_1+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_3+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_20+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_21+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_27+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_28+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_29+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_0
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_1
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_2
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_3
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_28
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_29
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_30
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_31
	.byte	NMI_INC_ROW|NMI_REPEAT|23, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+0
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+9
	.byte	NMI_REPEAT|6, (PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_2

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+15
	.byte	NMI_REPEAT|22, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+37
	.byte	(:++)-(:+)
	: .byte	(PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_0
	.byte	(PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1
	.byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	PPU_BG_COLOR_LINE_0_ALL
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+41
	.byte	NMI_REPEAT|6, (PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_2<<4)|(PPU_BG_COLOR_LINE_0<<2)|PPU_BG_COLOR_LINE_0

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+47
	.byte	(:++)-(:+)
	: .byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	(PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_2
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+50
	.byte	NMI_REPEAT|5, (PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+55
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_0_ALL

	.byte	NMI_LIST_END
; ------------------------------------------------------------
        .res    6, $FF
; ------------------------------------------------------------
	.export vs_insert_coin_bg
vs_insert_coin_bg:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_9+PPU_BG_COL_10
	.byte	(:++)-(:+)
	: .byte	"INSERT COIN"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_10
	.byte	(:++)-(:+)
	: .byte	"TO CONTINUE"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_18+PPU_BG_COL_16
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_box_nw, chr_bg::window_box_n_s, chr_bg::window_box_n_s, chr_bg::window_box_ne
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_19+PPU_BG_COL_11
	.byte	(:++)-(:+)
	: .byte	"TIME "
	.byte	chr_bg::window_box_w_e, "10", chr_bg::window_box_w_e
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_20+PPU_BG_COL_16
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_box_sw, chr_bg::window_box_n_s, chr_bg::window_box_n_s, chr_bg::window_box_se
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_8
	.byte	NMI_REPEAT|16, " "

	.byte	NMI_LIST_END
; ------------------------------------------------------------
        .res    69, $FF
; ------------------------------------------------------------
	.export vs_continue_bg
vs_continue_bg:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_9+PPU_BG_COL_10
	.byte	NMI_REPEAT|11, " "

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_7+PPU_BG_COL_10
	.byte	(:++)-(:+)
	: .byte	"PUSH BUTTON"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_10+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_button+0, chr_bg::window_button+2
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	chr_bg::window_button+1, chr_bg::window_button+3
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_10
	.byte	(:++)-(:+)
	: .byte	" TO CONTINUE"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_8
	.byte	NMI_REPEAT|16, " "

	.byte	NMI_LIST_END
; ------------------------------------------------------------
        .res    80, $FF
; ------------------------------------------------------------
	.export vs_super_players_bg
vs_super_players_bg:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_0+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_1+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_28+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_29+PPU_BG_COL_0
	.byte	NMI_REPEAT|PPU_VRAM_COLUMN_COUNT, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_0
	.byte	NMI_INC_ROW|NMI_REPEAT|26, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_1
	.byte	NMI_INC_ROW|NMI_REPEAT|26, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_2
	.byte	NMI_INC_ROW|NMI_REPEAT|26, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_29
	.byte	NMI_INC_ROW|NMI_REPEAT|26, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_30
	.byte	NMI_INC_ROW|NMI_REPEAT|26, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_31
	.byte	NMI_INC_ROW|NMI_REPEAT|26, VS_BOX_BG_TILE

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_3
	.byte	NMI_REPEAT|26, chr_bg::floor_castle+1

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_27+PPU_BG_COL_3
	.byte	NMI_REPEAT|26, chr_bg::floor_castle+1

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_3+PPU_BG_COL_3
	.byte	NMI_INC_ROW|NMI_REPEAT|24, chr_bg::floor_castle+1

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_3+PPU_BG_COL_28
	.byte	NMI_INC_ROW|NMI_REPEAT|24, chr_bg::floor_castle+1

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_9
	.byte	(:++)-(:+)
	: .byte	"SUPER PLAYER'S"
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+0
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+9
	.byte	(:++)-(:+)
	: .byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	(PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_2<<4)|(PPU_BG_COLOR_LINE_0<<2)|PPU_BG_COLOR_LINE_0
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+11
	.byte	NMI_REPEAT|4, (PPU_BG_COLOR_LINE_1<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_0<<2)|PPU_BG_COLOR_LINE_0

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+15
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+17
	.byte	(:++)-(:+)
	: .byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+19
	.byte	NMI_REPEAT|4, PPU_BG_COLOR_LINE_1_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+23
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+25
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+31
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+33
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+39
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+41
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+47
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+49
	.byte	NMI_REPEAT|6, (PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_0<<2)|PPU_BG_COLOR_LINE_0

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+55
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_3_ALL

	.byte	NMI_LIST_END
