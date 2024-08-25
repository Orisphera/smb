.include	"system/ppu.i"

.include	"engine/charmap.i"
.include	"engine/tunables.i"

	.export screen_text
screen_text:
screen_text_header:
	.dbyt	PPU_VRAM_BG1+$43
	.byte	(:++)-(:+)
	: .byte	"MARIO"
	:

	.dbyt	PPU_VRAM_BG1+$52
	.byte	(:++)-(:+)
	: .byte	"WORLD  TIME"
	:

	.dbyt	PPU_VRAM_BG1+$68
	.byte	(:++)-(:+)
	: .byte	"0  $x"	; $ explained in charmap.i
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+0
	.byte	NMI_REPEAT|63, PPU_BG_COLOR_LINE_2_ALL

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+2
	.byte	(:++)-(:+)
	: .byte	(PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_2<<4)|(PPU_BG_COLOR_LINE_2<<2)|(PPU_BG_COLOR_LINE_2)
	:

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_splash:
	.dbyt	PPU_VRAM_BG1+$1CD
	.byte	(:++)-(:+)
	: .byte	"  x    "
	:

	.dbyt	PPU_VRAM_BG1+$14B
	.byte	(:++)-(:+)
	: .byte	"WORLD  - "
	:

	.dbyt	PPU_VRAM_BG1+$20C
	.byte	NMI_REPEAT|7, " "

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$1C
	.byte	(:++)-(:+)
	: .byte	(PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_2<<2)|(PPU_BG_COLOR_LINE_2)
	:

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_timeup_screen:
.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$1CD
		.byte	(:++)-(:+)
		: .byte	"MARIO"
		:
.endif

	.dbyt	PPU_VRAM_BG1+$20C
	.byte	(:++)-(:+)
	: .byte	"TIME UP"
	:

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_gameover_screen:
.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$1CD
		.byte	(:++)-(:+)
		: .byte	"MARIO"
		:
.endif

.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$20B
.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+$16B
.endif
	.byte	(:++)-(:+)
	: .byte	"GAME OVER"
	:

.if	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+$1EB
		.byte	(:++)-(:+)
		: .byte	"CONTINUE"
		:

		.dbyt	PPU_VRAM_BG1+$20C
		.byte	NMI_REPEAT|7, " "

		.dbyt	PPU_VRAM_BG1+$24B
		.byte	(:++)-(:+)
		: .byte	"RETRY"
		:
.endif

	.byte	SCREEN_TEXT_END_VAL
; ----------------------------
screen_text_warp_screen:
	.dbyt	PPU_VRAM_BG2+$184
	.byte	(:++)-(:+)
	: .byte	"WELCOME TO WARP ZONE!"
	:

.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG2+$225
		.byte	(:++)-(:+)
		: .byte	" "
		:
.endif

	.dbyt	PPU_VRAM_BG2+$22D
	.byte	(:++)-(:+)
	: .byte	" "
	:
	
.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG2+$235
		.byte	(:++)-(:+)
		: .byte	" "
		:
.endif

	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$19
	.byte	NMI_REPEAT|6, PPU_BG_COLOR_LINE_2_ALL

	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$21
	.byte	NMI_REPEAT|5, PPU_BG_COLOR_LINE_2_ALL

.if	.defined(SMB)|.defined(VS_SMB)
		.byte	SCREEN_TEXT_END_VAL
.elseif	.defined(SMB2M)
		.byte	NMI_DATA_END
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
