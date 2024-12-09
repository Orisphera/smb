.include	"system/ppu.i"

.include	"tunables.i"
.include	"chr.i"
.include	"charmap.i"

.if	.defined(SMB)
.segment	"CHR0DATA"
.elseif	.defined(VS_SMB)
.segment	"CHR1DATA"
.endif

.if	.defined(OG_PAD)
.if	.defined(VS)
	.res	20, $FF
.endif
.endif

SIGN_BLANK	= chr_bg::blanks+2

	.export title_map, title_map_end
title_map:
	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_6
		.byte	NMI_REPEAT|20, SIGN_BLANK

		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_6+PPU_BG_COL_6
		.byte	NMI_REPEAT|20, SIGN_BLANK

		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_7+PPU_BG_COL_6
		.byte	NMI_REPEAT|20, SIGN_BLANK

		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_8+PPU_BG_COL_6
		.byte	NMI_REPEAT|20, SIGN_BLANK
	.endif

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_5
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_4
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_nw
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_6
	.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_5
	.endif
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	NMI_REPEAT|20
	.elseif	.defined(SMB2)
		.byte	NMI_REPEAT|23
	.elseif	.defined(ANN)
		.byte	NMI_REPEAT|21
	.endif
	.byte	chr_bg::sign_n

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_26
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_28
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_27
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_ne
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_5
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_4
	.endif
	.byte	NMI_INC_ROW|NMI_REPEAT|9, chr_bg::sign_w

	.if	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_5
		.byte	NMI_REPEAT|23, SIGN_BLANK
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_26
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_28
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_27
	.endif
	.byte	NMI_INC_ROW|NMI_REPEAT|9, chr_bg::sign_e

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_5
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
		.byte	chr_bg::sign_text_b+8
		.byte	chr_bg::sign_text_b+8
		.byte	chr_bg::sign_text_b+0
		.byte	chr_bg::sign_text_b+1
		.byte	SIGN_BLANK
		.byte	SIGN_BLANK
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_ann_a+0
		.byte	chr_bg::sign_text_ann_a+1
		.byte	chr_bg::sign_text_ann_a+2
		.byte	chr_bg::sign_text_ann_a+3
		.byte	chr_bg::sign_text_ann_b+0
		.byte	chr_bg::sign_text_ann_b+1
		.byte	chr_bg::sign_text_ann_b+2
		.byte	chr_bg::sign_text_ann_b+3
		.byte	chr_bg::sign_text_ann_b+4
		.byte	chr_bg::sign_text_ann_b+5
	.endif

	.byte	chr_bg::sign_text_b+0
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+8
	.byte	chr_bg::sign_text_b+8
	.byte	chr_bg::sign_text_b+14
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+0
	.byte	chr_bg::sign_text_b+10
	.byte	chr_bg::sign_text_b+14
	.byte	chr_bg::sign_text_b+1
	.if	.defined(ANN)
		.byte	SIGN_BLANK
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_6+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_6+PPU_BG_COL_5
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
		.byte	chr_bg::sign_text_b+11
		.byte	chr_bg::sign_text_b+11
		.byte	chr_bg::sign_text_b+2
		.byte	chr_bg::sign_text_b+3
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

	.byte	chr_bg::sign_text_b+2
	.byte	chr_bg::sign_text_b+3
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+9
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+12
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+15

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
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_7+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_7+PPU_BG_COL_5
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
		.byte	chr_bg::sign_text_vs+0
		.byte	chr_bg::sign_text_vs+1
		.byte	chr_bg::sign_text_b+4
		.byte	chr_bg::sign_text_b+5
		.byte	chr_bg::sign_text_b+23
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

	.byte	chr_bg::sign_text_b+4
	.byte	chr_bg::sign_text_b+5
	.byte	chr_bg::sign_text_b+4
	.byte	chr_bg::sign_text_b+9
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+18
	.byte	chr_bg::sign_text_b+4
	.byte	chr_bg::sign_text_b+10
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+16

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
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_8+PPU_BG_COL_5
		.byte	NMI_REPEAT|23, SIGN_BLANK
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_8+PPU_BG_COL_6
		.byte	NMI_REPEAT|21, SIGN_BLANK
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_8+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_8+PPU_BG_COL_5
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_8+PPU_BG_COL_16
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(VS_SMB)
		.byte	chr_bg::sign_text_vs+2
		.byte	chr_bg::sign_text_vs+3
		.byte	chr_bg::sign_text_b+6
		.byte	chr_bg::sign_text_b+7
		.byte	chr_bg::sign_text_b+17
		.byte	SIGN_BLANK
	.endif

	.byte	chr_bg::sign_text_b+6
	.byte	chr_bg::sign_text_b+7
	.byte	chr_bg::sign_text_b+6
	.byte	chr_bg::sign_text_b+7
	.byte	chr_bg::sign_text_b+17
	.byte	SIGN_BLANK
	.byte	chr_bg::sign_text_b+6
	.byte	chr_bg::sign_text_b+13
	.byte	chr_bg::sign_text_b+17
	.byte	chr_bg::sign_text_b+17
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_9+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_9+PPU_BG_COL_5
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_text_b+0
	.byte	chr_bg::sign_text_b+24
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+0
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+14
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+8
	.byte	chr_bg::sign_text_b+0
	.byte	chr_bg::sign_text_b+1
	.byte	SIGN_BLANK
	.byte	chr_bg::sign_text_b+14
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+14
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+0
	.byte	chr_bg::sign_text_b+1
	.byte	chr_bg::sign_text_b+0
	.byte	chr_bg::sign_text_b+1
	.byte	SIGN_BLANK
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	chr_bg::sign_text_b+0
		.byte	chr_bg::sign_text_b+1
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_10+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_10+PPU_BG_COL_5
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_letter_edge+0
	.byte	chr_bg::sign_letter_edge+0
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	SIGN_BLANK
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	SIGN_BLANK
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	chr_bg::sign_text_b+11
		.byte	chr_bg::sign_letter_edge+0
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_5
	.endif
	.byte	NMI_REPEAT|6, chr_bg::sign_text_b+11

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_12
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_11+PPU_BG_COL_11
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_text_b+15
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	SIGN_BLANK
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+15
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+15
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_text_b+20
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+2
	.endif
	.byte	chr_bg::sign_text_b+21
	.byte	SIGN_BLANK
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	chr_bg::sign_text_smb2+0
		.byte	chr_bg::sign_text_smb2+1
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_12+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_12+PPU_BG_COL_5
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+14
	.byte	chr_bg::sign_letter_edge+1
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_text_b+16
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+11
	.endif
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	SIGN_BLANK
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+19
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_text_b+16
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+19
	.endif
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_text_b+22
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+11
	.endif
	.byte	chr_bg::sign_text_b+19
	.byte	SIGN_BLANK
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	chr_bg::sign_text_smb2+2
		.byte	chr_bg::sign_text_smb2+3
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_13+PPU_BG_COL_6
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_13+PPU_BG_COL_5
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_letter_edge+0
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+11
	.endif
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+4
	.byte	chr_bg::sign_text_b+9
	.byte	SIGN_BLANK
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+9
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+11
	.byte	chr_bg::sign_text_b+4
	.byte	chr_bg::sign_text_b+9
	.byte	chr_bg::sign_text_b+4
	.byte	chr_bg::sign_text_b+9
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_bg::sign_text_b+23
	.elseif	.defined(ANN)
		.byte	chr_bg::sign_text_b+10
	.endif
	.if	.defined(SMB2M)
		.byte	SIGN_BLANK
	.endif
	.if	.defined(SMB2)
		.byte	chr_bg::sign_text_b+14
		.byte	chr_bg::sign_text_b+10
	.endif
	:

	.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_5
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_14+PPU_BG_COL_4
	.endif
	.byte	(:++)-(:+)
	: .byte	chr_bg::sign_sw
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+2
	.byte	chr_bg::sign_text_a+3
	.byte	chr_bg::sign_s
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+1
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+0
	.byte	chr_bg::sign_text_a+2
	.byte	chr_bg::sign_text_a+3
	.byte	chr_bg::sign_text_a+2
	.byte	chr_bg::sign_text_a+3
	.byte	chr_bg::sign_text_a+0
	.if	.defined(SMB2M)
		.byte	chr_bg::sign_s
	.endif

	.if	.defined(SMB2)
		.byte	chr_bg::sign_text_a+0
		.byte	chr_bg::sign_text_smb2+4
	.endif

	.byte	chr_bg::sign_se
	:

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_13
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_15
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_14
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
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_18+PPU_BG_COL_11
	.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_18+PPU_BG_COL_13
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(SMB)
		.byte	"1 PLAYER GAME"
	.elseif	.defined(SMB2M)
		.byte	"MARIO GAME"
	.endif
	:

	.if	.defined(SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_20+PPU_BG_COL_11
	.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_20+PPU_BG_COL_13
	.endif
	.byte	(:++)-(:+)
	: .if	.defined(SMB)
		.byte	"2 PLAYER GAME"
	.elseif	.defined(SMB2M)
		.byte	"LUIGI GAME"
	.endif
	:
.elseif	.defined(VS)
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_19+PPU_BG_COL_6
	.byte	(:++)-(:+)
	: .byte	"I N S E R T  C O I N"
	:
.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_12
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_11
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_13
	.endif
	.byte	(:++)-(:+)
	: .byte	"TOP-"
	:

	.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_22
	.elseif	.defined(SMB2)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_21
	.elseif	.defined(ANN)
		.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_23
	.endif
	.byte	(:++)-(:+)
	: .byte	"0"
	:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+9
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	NMI_REPEAT|22, PPU_BG_COLOR_LINE_1_ALL
	.elseif	.defined(SMB2)
		.byte	NMI_REPEAT|7, PPU_BG_COLOR_LINE_1_ALL
	.elseif	.defined(ANN)
		.byte	(:++)-(:+)
		:	.byte	((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)
		:
		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+10
		.byte	NMI_REPEAT|6, ((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)
	.endif

	.if	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+17
		.byte	NMI_REPEAT|7, PPU_BG_COLOR_LINE_1_ALL

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+25
		.byte	NMI_REPEAT|7, PPU_BG_COLOR_LINE_1_ALL

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+12
		.byte	NMI_REPEAT|3
		.if	.defined(SMB2)
			.byte	((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_3<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1)
		.elseif	.defined(ANN)
			.byte	PPU_BG_COLOR_LINE_1_ALL
		.endif

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+22
		.byte	(:++)-(:+)
		: .byte	((PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_3<<2)|PPU_BG_COLOR_LINE_1)
		:

		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+30
		.byte	(:++)-(:+)
		: .byte	((PPU_BG_COLOR_LINE_1<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_3<<2)|PPU_BG_COLOR_LINE_1)
		:
	.endif

.if	.defined(SMB)|.defined(SMB2M)
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+34
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
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+32
	.byte	NMI_REPEAT|8, PPU_BG_COLOR_LINE_2_ALL
.endif

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+42
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

	.byte	NMI_LIST_END
title_map_end:
