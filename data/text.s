.include	"sys/ppu.i"

.include	"charmap.i"
.include	"tunables.i"

	.export bg_text
	.export bg_text_header_player_name
bg_text:
bg_text_header:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_3
	.byte	(:++)-(:+)
bg_text_header_player_name:
	: .byte	"MARIO"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_18
	.byte	(:++)-(:+)
	: .byte	"WORLD  TIME"
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_3+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	"0  $x"	; $ explained in charmap.i
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+0
	.byte	NMI_REPEAT|63, PPU_BG_COLOR_LINE_2_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+2
	.byte	(:++)-(:+)
	: .byte	(PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_2<<4)|(PPU_BG_COLOR_LINE_2<<2)|(PPU_BG_COLOR_LINE_2)
	:

	.byte	BG_TEXT_END_VAL
; ----------------------------
bg_text_splash:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_13
	.byte	(:++)-(:+)
	: .byte	"  x    "
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_10+PPU_BG_COL_11
	.byte	(:++)-(:+)
	: .byte	"WORLD  - "
	:

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_12
	.byte	NMI_REPEAT|7, " "

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+28
	.byte	(:++)-(:+)
	: .byte	(PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_2<<2)|(PPU_BG_COLOR_LINE_2)
	:

	.byte	BG_TEXT_END_VAL
; ----------------------------
bg_text_timeup_screen:
.if	.defined(SMBV1)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_13
		.byte	(:++)-(:+)
		: .byte	"MARIO"
		:
.endif

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_12
	.byte	(:++)-(:+)
	: .byte	"TIME UP"
	:

	.byte	BG_TEXT_END_VAL
; ----------------------------
bg_text_gameover_screen:
.if	.defined(SMBV1)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_13
		.byte	(:++)-(:+)
		: .byte	"MARIO"
		:
.endif

.if	.defined(SMBV1)
	BG_TEXT_GAME_OVER_ROW	= PPU_BG_ROW_16
.elseif	.defined(SMBV2)
	BG_TEXT_GAME_OVER_ROW	= PPU_BG_ROW_11
.endif
	.dbyt	PPU_VRAM_BG1+BG_TEXT_GAME_OVER_ROW+PPU_BG_COL_11
	.byte	(:++)-(:+)
	: .byte	"GAME OVER"
	:

.if	.defined(SMBV2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_11
		.byte	(:++)-(:+)
		: .byte	"CONTINUE"
		:

		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_12
		.byte	NMI_REPEAT|7, " "

		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_18+PPU_BG_COL_11
		.byte	(:++)-(:+)
		: .byte	"RETRY"
		:
.endif

	.byte	BG_TEXT_END_VAL
; ----------------------------
bg_text_warp_screen:
	.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_12+PPU_BG_COL_4
	.byte	(:++)-(:+)
	: .byte	"WELCOME TO WARP ZONE!"
	:

.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_17+PPU_BG_COL_5
		.byte	(:++)-(:+)
		: .byte	" "
		:
.endif

	.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_17+PPU_BG_COL_13
	.byte	(:++)-(:+)
	: .byte	" "
	:
	
.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_17+PPU_BG_COL_21
		.byte	(:++)-(:+)
		: .byte	" "
		:
.endif

	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_ATTR+25
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_2_ALL

	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_ATTR+33
	.byte	NMI_REPEAT|5, PPU_BG_COLOR_LINE_2_ALL

.if	.defined(SMBV1)
		.byte	BG_TEXT_END_VAL
.elseif	.defined(SMBV2)
		.byte	NMI_LIST_END
.endif
; ----------------------------
.if	.defined(SMBV1)
		.export bg_text_player_2
	bg_text_player_2:
		.byte	"LUIGI"
	bg_text_player_2_end:
.endif
; ----------------------------
	.export bg_text_warps
bg_text_warps:
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	"4", "3", "2", 0
		.byte	" ", "5", " ", 0
		.if	.defined(SMBM)
			.byte	"8", "7", "6", 0
		.elseif	.defined(VS_SMB)
			.byte	" ", "6", " ", 0
		.endif
	.elseif	.defined(SMB2)
		.byte	"2"
		.byte	"3"
		.byte	"4"
		.byte	"1"
		.byte	"6"
		.byte	"7"
		.byte	"8"
		.byte	"5"
		.byte	"B"
		.byte	"C"
		.byte	"D"
	.endif

	.if	.defined(ANN)
		.byte	" ", "B", " ", 0
		.byte	" ", "C", " ", 0
		.byte	" ", "D", " ", 0
	.endif
; -------------
bg_text_idx_off	= $08
bg_text_idx_header		= bg_text_header-bg_text
bg_text_idx_splash		= bg_text_splash-bg_text
bg_text_idx_timeup		= bg_text_timeup_screen-bg_text
bg_text_idx_gameover	= bg_text_gameover_screen-bg_text

.if	.defined(SMBV1)
	bg_text_idx_warp		= bg_text_warp_screen-bg_text
.endif

	.export bg_text_idx_tbl
bg_text_idx_tbl:
	.if	.defined(SMBV1)
		.byte	bg_text_idx_header, bg_text_idx_header
		.byte	bg_text_idx_splash, bg_text_idx_splash
		.byte	bg_text_idx_timeup, bg_text_idx_timeup+bg_text_idx_off
		.byte	bg_text_idx_gameover, bg_text_idx_gameover+bg_text_idx_off
	.elseif	.defined(SMBV2)
		.byte	bg_text_idx_header
		.byte	bg_text_idx_splash
		.byte	bg_text_idx_timeup
		.byte	bg_text_idx_gameover
	.endif

	.if	.defined(SMBV1)
		.byte	bg_text_idx_warp, bg_text_idx_warp
	.endif
