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
	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$A6
		.byte	NMI_REPEAT|20, SIGN_BLANK

		.dbyt	PPU_VRAM_BG1+$C6
		.byte	NMI_REPEAT|20, SIGN_BLANK

		.dbyt	PPU_VRAM_BG1+$E6
		.byte	NMI_REPEAT|20, SIGN_BLANK

		.dbyt	PPU_VRAM_BG1+$106
		.byte	NMI_REPEAT|20, SIGN_BLANK
	.endif

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$85
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$84
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_nw
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$86
	.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+$85
	.endif
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	NMI_REPEAT|20
	.elseif	.defined(SMB2)
		.byte	NMI_REPEAT|23
	.elseif	.defined(ANN)
		.byte	NMI_REPEAT|21
	.endif
	.byte	tile_bg::sign_n

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$9A
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$9C
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+$9B
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_ne
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$A5
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$A4
	.endif
	.byte	NMI_INC_ROW|NMI_REPEAT|9, tile_bg::sign_w

	.if	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$A5
		.byte	NMI_REPEAT|23, SIGN_BLANK
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$BA
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$BC
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+$BB
	.endif
	.byte	NMI_INC_ROW|NMI_REPEAT|9, tile_bg::sign_e

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$A6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$A5
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
		.byte	tile_bg::sign_text_b+8
		.byte	tile_bg::sign_text_b+8
		.byte	tile_bg::sign_text_b+0
		.byte	tile_bg::sign_text_b+1
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_ann_a+0
		.byte	tile_bg::sign_text_ann_a+1
		.byte	tile_bg::sign_text_ann_a+2
		.byte	tile_bg::sign_text_ann_a+3
		.byte	tile_bg::sign_text_ann_b+0
		.byte	tile_bg::sign_text_ann_b+1
		.byte	tile_bg::sign_text_ann_b+2
		.byte	tile_bg::sign_text_ann_b+3
		.byte	tile_bg::sign_text_ann_b+4
		.byte	tile_bg::sign_text_ann_b+5
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
	.if	.defined(ANN)
		.byte	SIGN_BLANK
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$C6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$C5
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
		.byte	tile_bg::sign_text_b+11
		.byte	tile_bg::sign_text_b+11
		.byte	tile_bg::sign_text_b+2
		.byte	tile_bg::sign_text_b+3
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
	.elseif	.defined(ANN)
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
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

	.if	.defined(SMB2)
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
	.elseif	.defined(ANN)
		.byte	SIGN_BLANK
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$E6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$E5
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
		.byte	tile_bg::sign_text_vs+0
		.byte	tile_bg::sign_text_vs+1
		.byte	tile_bg::sign_text_b+4
		.byte	tile_bg::sign_text_b+5
		.byte	tile_bg::sign_text_b+23
		.byte	SIGN_BLANK
	.elseif	.defined(ANN)
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
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

	.if	.defined(SMB2)
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
	.elseif	.defined(ANN)
		.byte	SIGN_BLANK
	.endif
	:

	.if	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$105
		.byte	NMI_REPEAT|23, SIGN_BLANK
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+$106
		.byte	NMI_REPEAT|21, SIGN_BLANK
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$106
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$105
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+$110
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
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
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$126
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$125
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_text_b+0
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
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	tile_bg::sign_text_b+0
		.byte	tile_bg::sign_text_b+1
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$146
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$145
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_letter_edge+0
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	SIGN_BLANK
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	tile_bg::sign_text_b+11
		.byte	tile_bg::sign_letter_edge+0
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$166
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$165
	.endif
	.byte	NMI_REPEAT|6, tile_bg::sign_text_b+11

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$16C
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$16B
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_text_b+15
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
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_text_b+20
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+2
	.endif
	.byte	tile_bg::sign_text_b+21
	.byte	SIGN_BLANK
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	tile_bg::sign_text_smb2+0
		.byte	tile_bg::sign_text_smb2+1
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$186
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$185
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+14
	.byte	tile_bg::sign_letter_edge+1
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_text_b+16
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+11
	.endif
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	SIGN_BLANK
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+19
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_text_b+16
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+19
	.endif
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_text_b+22
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+11
	.endif
	.byte	tile_bg::sign_text_b+19
	.byte	SIGN_BLANK
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	tile_bg::sign_text_smb2+2
		.byte	tile_bg::sign_text_smb2+3
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$1A6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$1A5
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.byte	tile_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+11
	.endif
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
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_bg::sign_text_b+23
	.elseif	.defined(ANN)
		.byte	tile_bg::sign_text_b+10
	.endif
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	tile_bg::sign_text_b+14
		.byte	tile_bg::sign_text_b+10
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$1C5
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$1C4
	.endif
	.byte	(:++)-(:+)
	: .byte	tile_bg::sign_sw
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
	.if	.defined(SMB2M)
		.byte	tile_bg::sign_s
	.endif

	.if	.defined(SMB2)
		.byte	tile_bg::sign_text_a+0
		.byte	tile_bg::sign_text_smb2+4
	.endif

	.byte	tile_bg::sign_se
	:

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$1ED
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$1EF
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+$1EE
	.endif
	.byte	(:++)-(:+)
	: .byte	"c"
	.if	.defined(SMB)
		.byte	"1985"
	.elseif	.defined(VS_SMB)|.defined(SMB2M)
		.byte	"1986"
	.endif
	.byte	" NINTENDO"
	:

.if	.defined(CONS)
	.if	.defined(SMB)
		.dbyt	PPU_VRAM_BG1+$24B
	.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+$24D
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(SMB)
		.byte	"1 PLAYER GAME"
	.elseif	.defined(SMB2M)
		.byte	"MARIO GAME"
	.endif
	:

	.if	.defined(SMB)
		.dbyt	PPU_VRAM_BG1+$28B
	.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+$28D
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(SMB)
		.byte	"2 PLAYER GAME"
	.elseif	.defined(SMB2M)
		.byte	"LUIGI GAME"
	.endif
	:
.elseif	.defined(VS)
	.dbyt	PPU_VRAM_BG1+$266
	.byte	(:++)-(:+)
	: .byte	"I N S E R T  C O I N"
	:
.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$2EC
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$2EB
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+$2ED
	.endif
	.byte	(:++)-(:+)
	: .byte	"TOP-"
	:

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$2F6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+$2F5
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+$2F7
	.endif
	.byte	(:++)-(:+)
	: .byte	"0"
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$9
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	NMI_REPEAT|22, PPU_BG_COLOR_LINE_1_ALL
	.elseif	.defined(SMB2)
		.byte	NMI_REPEAT|7, PPU_BG_COLOR_LINE_1_ALL
	.elseif	.defined(ANN)
		.byte	(:++)-(:+)
		:	.byte	((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)
		:
		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$A
		.byte	NMI_REPEAT|6, ((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)
	.endif

	.if	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$11
		.byte	NMI_REPEAT|7, PPU_BG_COLOR_LINE_1_ALL

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$19
		.byte	NMI_REPEAT|7, PPU_BG_COLOR_LINE_1_ALL

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$C
		.byte	NMI_REPEAT|3
		.if	.defined(SMB2)
			.byte	((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)
		.elseif	.defined(ANN)
			.byte	PPU_BG_COLOR_LINE_1_ALL
		.endif

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$16
		.byte	(:++)-(:+)
		: .byte	((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_3<<2)|PPU_BG_COLOR_LINE_1)
		:

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$1E
		.byte	(:++)-(:+)
		: .byte	((PPU_BG_COLOR_LINE_1<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_3<<2)|PPU_BG_COLOR_LINE_1)
		:
	.endif

.if	.defined(SMB)|.defined(SMB2M)
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$22
	.byte	(:++)-(:+)
	:
	.if	.defined(SMB)|.defined(VS_SMB) 
		.byte	((PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_1)
	.elseif	.defined(SMB2M)
		.byte	PPU_BG_COLOR_LINE_1_ALL
	.endif
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
	:
.elseif	.defined(VS_SMB)
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$20
	.byte	NMI_REPEAT|8, PPU_BG_COLOR_LINE_2_ALL
.endif

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$2A
	.byte	(:++)-(:+)
	: .if	.defined(SMB)|.defined(VS_SMB)
		.byte	((PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_1)
	.elseif	.defined(SMB2M)
		.byte	((PPU_BG_COLOR_LINE_2<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)
	.endif
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.byte	PPU_BG_COLOR_LINE_2_ALL
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	PPU_BG_COLOR_LINE_2_ALL
	.endif
	.if	.defined(SMB2M)
		.byte	((PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_2<<4)|(PPU_BG_COLOR_LINE_2<<2)|PPU_BG_COLOR_LINE_2)
	.endif
	:

	.byte	NMI_DATA_END
title_map_end:

.if	.defined(SMB2)
	.res	2, $FF
.endif

