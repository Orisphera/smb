.include	"system/ppu.i"

.include	"engine/charmap.i"
.include	"engine/tunables.i"

	.export screen_text
	.export screen_text_header_player_name
screen_text:
screen_text_header:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_2+PPU_BG_COL_3
	.byte	(:++)-(:+)
screen_text_header_player_name:
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

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_splash:
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

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_timeup_screen:
.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_13
		.byte	(:++)-(:+)
		: .byte	"MARIO"
		:
.endif

	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_16+PPU_BG_COL_12
	.byte	(:++)-(:+)
	: .byte	"TIME UP"
	:

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_gameover_screen:
.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_13
		.byte	(:++)-(:+)
		: .byte	"MARIO"
		:
.endif

.if	.defined(SMB)|.defined(VS_SMB)
	SCREEN_TEXT_GAME_OVER_ROW	= PPU_BG_ROW_16
.elseif	.defined(SMB2M)
	SCREEN_TEXT_GAME_OVER_ROW	= PPU_BG_ROW_11
.endif
	.dbyt	PPU_VRAM_BG1+SCREEN_TEXT_GAME_OVER_ROW+PPU_BG_COL_11
	.byte	(:++)-(:+)
	: .byte	"GAME OVER"
	:

.if	.defined(SMB2M)
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

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_warp_screen:
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

.if	.defined(SMB)|.defined(VS_SMB)
		.byte	SCREEN_TEXT_END_VAL
.elseif	.defined(SMB2M)
		.byte	NMI_LIST_END
.endif
; ----------------------------
.if	.defined(SMB)|.defined(VS_SMB)
		.export screen_text_player_2
	screen_text_player_2:
		.byte	"LUIGI"
	screen_text_player_2_end:
.endif
; ----------------------------
	.export screen_text_warps
screen_text_warps:
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
screen_text_idx_off	= $08
screen_text_idx_header		= screen_text_header-screen_text
screen_text_idx_splash		= screen_text_splash-screen_text
screen_text_idx_timeup		= screen_text_timeup_screen-screen_text
screen_text_idx_gameover	= screen_text_gameover_screen-screen_text

.if	.defined(SMB)|.defined(VS_SMB)
	screen_text_idx_warp		= screen_text_warp_screen-screen_text
.endif

	.export screen_text_idx_tbl
screen_text_idx_tbl:
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	screen_text_idx_header, screen_text_idx_header
		.byte	screen_text_idx_splash, screen_text_idx_splash
		.byte	screen_text_idx_timeup, screen_text_idx_timeup+screen_text_idx_off
		.byte	screen_text_idx_gameover, screen_text_idx_gameover+screen_text_idx_off
	.elseif	.defined(SMB2M)
		.byte	screen_text_idx_header
		.byte	screen_text_idx_splash
		.byte	screen_text_idx_timeup
		.byte	screen_text_idx_gameover
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	screen_text_idx_warp, screen_text_idx_warp
	.endif
