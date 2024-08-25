.include        "system/ppu.i"
.include        "system/palettes.i"

.include        "engine/tunables.i"
.include        "engine/chr.i"
.include	"engine/charmap.i"

.segment        "CHR1DATA"

	.export vs_player_select_bg
vs_player_select_bg:
	.dbyt	PPU_VRAM_COLOR+0
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,  PPU_COLOR_BLUE1,  PPU_COLOR_CYAN0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0, PPU_COLOR_PITCH0, PPU_COLOR_PITCH0
	:

	.dbyt	PPU_VRAM_COLOR+$10
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,  PPU_COLOR_PITCH0, PPU_COLOR_PITCH0
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$19
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_1_ALL

	.dbyt	PPU_VRAM_BG1+$EA
	.byte	(:++)-(:+)
	: .byte	"PUSH BUTTON"
	:

	.dbyt	PPU_VRAM_BG1+$148
	.byte	(:++)-(:+)
	: .byte	tile_bg::window_button+0
	.byte	tile_bg::window_button+2
	:

	.dbyt	PPU_VRAM_BG1+$168
	.byte	(:++)-(:+)
	: .byte	tile_bg::window_button+1
	.byte	tile_bg::window_button+3
	:

	.dbyt	PPU_VRAM_BG1+$16B
	.byte	(:++)-(:+)
	: .byte	"FOR 1-PLAYER"
	:

	.dbyt	PPU_VRAM_BG1+$1C8
	.byte	(:++)-(:+)
	: .byte	tile_bg::window_button+0
	.byte	tile_bg::window_button+2
	:

	.dbyt	PPU_VRAM_BG1+$1E8
	.byte	(:++)-(:+)
	: .byte	tile_bg::window_button+1
	.byte	tile_bg::window_button+3
	:

	.dbyt	PPU_VRAM_BG1+$1EB
	.byte	(:++)-(:+)
	: .byte	"FOR 2-PLAYERS"
	:

	.byte	NMI_DATA_END

        .res    8, $FF
; ------------------------------------------------------------
	.export vs_name_register_bg
vs_name_register_bg:
	.dbyt	PPU_VRAM_BG1+$A8
	.byte	(:++)-(:+)
	: .byte	"NAME REGISTRATION"
	:

	.dbyt	PPU_VRAM_BG1+$106
	.byte	(:++)-(:+)
	: .byte	"A B C D E F G H I J K"
	:

	.dbyt	PPU_VRAM_BG1+$186
	.byte	(:++)-(:+)
	: .byte	"L M N O P Q R S T U V"
	:

	.dbyt	PPU_VRAM_BG1+$206
	.byte	(:++)-(:+)
	: .byte	"W X Y Z ! - . ' "
	.byte	tile_bg::window_rub+0, tile_bg::window_rub+1
	.byte	" "
	.byte	tile_bg::window_end+0, tile_bg::window_end+1
	:

	.byte	NMI_DATA_END

        .res    3, $FF
; ------------------------------------------------------------
	.export vs_stats_bg
vs_stats_bg:
	.dbyt	PPU_VRAM_BG1+$2D4
	.byte	NMI_INC_ROW|((:++)-(:+))
	: .byte	$F4, $F8, $F5
	:

	.dbyt	PPU_VRAM_BG1+$2DA
	.byte	NMI_INC_ROW|((:++)-(:+))
	: .byte	$F7, $F8, $F9
	:

	.dbyt	PPU_VRAM_BG1+$2D5
	.byte	NMI_REPEAT|5, $F6

	.dbyt	PPU_VRAM_BG1+$2E4
	.byte	(:++)-(:+)
	: .byte	$F4, $F6, $F6, $F7
	.byte	"NAME"
	:

	.dbyt	PPU_VRAM_BG1+$315
	.byte	NMI_REPEAT|5, $F6

	.dbyt	PPU_VRAM_BG1+$2EC
	.byte	NMI_REPEAT|8, "."

	.dbyt	PPU_VRAM_BG1+$304
	.byte	(:++)-(:+)
	: .byte	$F8
	.byte	"20"
	.byte	$F8
	:

	.dbyt	PPU_VRAM_BG1+$324
	.byte	(:++)-(:+)
	: .byte	$F5, $F6, $F6, $F9
	.byte	"SCORE..0W-0."
	:

	.byte	NMI_DATA_END

        .res    18, $FF
; ------------------------------------------------------------
	.export vs_box_bg
vs_box_bg:
	.dbyt	PPU_VRAM_BG1+$0
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$20
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$40
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$60
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$280
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$2A0
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$360
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$380
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$3A0
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$80
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+$81
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+$82
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+$83
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+$9C
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+$9D
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+$9E
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+$9F
	.byte	NMI_INC_ROW|NMI_REPEAT|$17, $47

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$0
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$9
	.byte	NMI_REPEAT|6, $0a

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$F
	.byte	NMI_REPEAT|22, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$25
	.byte	(:++)-(:+)
	: .byte	$04
	.byte	$05
	.byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	PPU_BG_COLOR_LINE_0_ALL
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$29
	.byte	NMI_REPEAT|6, $A0

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$2F
	.byte	(:++)-(:+)
	: .byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	$0A
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$32
	.byte	NMI_REPEAT|5, $05

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$37
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_0_ALL

	.byte	NMI_DATA_END

        .res    6, $FF
; ------------------------------------------------------------
	.export vs_insert_coin_bg
vs_insert_coin_bg:
	.dbyt	PPU_VRAM_BG1+$12A
	.byte	(:++)-(:+)
	: .byte	"INSERT COIN"
	:

	.dbyt	PPU_VRAM_BG1+$16A
	.byte	(:++)-(:+)
	: .byte	"TO CONTINUE"
	:

	.dbyt	PPU_VRAM_BG1+$250
	.byte	(:++)-(:+)
	: .byte	$F4, $F6, $F6, $F7
	:

	.dbyt	PPU_VRAM_BG1+$26B
	.byte	(:++)-(:+)
	: .byte	"TIME "
	.byte	$F8
	.byte	"10"
	.byte	$F8
	:

	.dbyt	PPU_VRAM_BG1+$290
	.byte	(:++)-(:+)
	: .byte	$F5, $F6, $F6, $F9
	:

	.dbyt	PPU_VRAM_BG1+$208
	.byte	NMI_REPEAT|16, " "

	.byte	NMI_DATA_END

        .res    69, $FF
; ------------------------------------------------------------
	.export vs_continue_bg
vs_continue_bg:
	.dbyt	PPU_VRAM_BG1+$12A
	.byte	NMI_REPEAT|11, " "

	.dbyt	PPU_VRAM_BG1+$EA
	.byte	(:++)-(:+)
	: .byte	"PUSH BUTTON"
	:

	.dbyt	PPU_VRAM_BG1+$148
	.byte	(:++)-(:+)
	: .byte	$F0, $F2
	:

	.dbyt	PPU_VRAM_BG1+$168
	.byte	(:++)-(:+)
	: .byte	$F1, $F3
	:

	.dbyt	PPU_VRAM_BG1+$16A
	.byte	(:++)-(:+)
	: .byte	" TO CONTINUE"
	:

	.dbyt	PPU_VRAM_BG1+$208
	.byte	NMI_REPEAT|16, " "

	.byte	NMI_DATA_END

        .res    80, $FF
; ------------------------------------------------------------
	.export vs_super_players_bg
vs_super_players_bg:
	.dbyt	PPU_VRAM_BG1+$0
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$20
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$380
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$3A0
	.byte	NMI_REPEAT|32, $47

	.dbyt	PPU_VRAM_BG1+$40
	.byte	NMI_INC_ROW|NMI_REPEAT|26, $47

	.dbyt	PPU_VRAM_BG1+$41
	.byte	NMI_INC_ROW|NMI_REPEAT|26, $47

	.dbyt	PPU_VRAM_BG1+$42
	.byte	NMI_INC_ROW|NMI_REPEAT|26, $47

	.dbyt	PPU_VRAM_BG1+$5D
	.byte	NMI_INC_ROW|NMI_REPEAT|26, $47

	.dbyt	PPU_VRAM_BG1+$5E
	.byte	NMI_INC_ROW|NMI_REPEAT|26, $47

	.dbyt	PPU_VRAM_BG1+$5F
	.byte	NMI_INC_ROW|NMI_REPEAT|26, $47

	.dbyt	PPU_VRAM_BG1+$43
	.byte	NMI_REPEAT|26, $5E

	.dbyt	PPU_VRAM_BG1+$363
	.byte	NMI_REPEAT|26, $5E

	.dbyt	PPU_VRAM_BG1+$63
	.byte	NMI_INC_ROW|NMI_REPEAT|24, $5E

	.dbyt	PPU_VRAM_BG1+$7C
	.byte	NMI_INC_ROW|NMI_REPEAT|24, $5E

	.dbyt	PPU_VRAM_BG1+$89
	.byte	(:++)-(:+)
	: .byte	"SUPER PLAYER'S"
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$0
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$9
	.byte	(:++)-(:+)
	: .byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	$A0
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$B
	.byte	NMI_REPEAT|4, $50

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$F
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$11
	.byte	(:++)-(:+)
	: .byte	PPU_BG_COLOR_LINE_0_ALL
	.byte	$AA
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$13
	.byte	NMI_REPEAT|4, PPU_BG_COLOR_LINE_1_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$17
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$19
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$1F
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$21
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$27
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$29
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_0_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$2F
	.byte	NMI_REPEAT|2, PPU_BG_COLOR_LINE_3_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$31
	.byte	NMI_REPEAT|6, $F0

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$37
	.byte	NMI_REPEAT|9, PPU_BG_COLOR_LINE_3_ALL

	.byte	NMI_DATA_END

        .res    248, $FF
