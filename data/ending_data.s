.include	"system/ppu.i"
.include	"system/palettes.i"

.include	"chr.i"
.include	"charmap.i"
.include	"tunables.i"

.if	.defined(SMB2M)
.segment	"DATA3"
.endif

.if	.defined(VS_SMB)
MSG_BG	= PPU_VRAM_BG2
.elseif	.defined(SMB2M)
MSG_BG	= PPU_VRAM_BG1
.endif

	.export nmi_addr_0F
nmi_addr_0F:
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR
	.byte	NMI_REPEAT|8, PPU_BG_COLOR_LINE_1_ALL
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+2
	.byte	(:++)-(:+)
	: .byte	(PPU_BG_COLOR_LINE_3<<6)|(PPU_BG_COLOR_LINE_1<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1
	: .byte	NMI_LIST_END

	.export	nmi_addr_10
nmi_addr_10:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_AZURE2,  PPU_COLOR_BLUE1,   PPU_COLOR_BLUE0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
	: .byte	NMI_LIST_END

	.export msg_thankyou_mario_2, msg_thankyou_mario_2_name
msg_thankyou_mario_2:
	.dbyt	MSG_BG+PPU_BG_ROW_7+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	"THANK YOU "
msg_thankyou_mario_2_name:
	.byte	"MARIO"
	.byte	"!"
	: .dbyt	MSG_BG+PPU_VRAM_BG_ATTR+8
	.byte	NMI_REPEAT|8, (PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1
	.byte	NMI_LIST_END

.if	.defined(VS_SMB)
	.export msg_thankyou_luigi_2
msg_thankyou_luigi_2:
	.dbyt	MSG_BG+PPU_BG_ROW_7+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	"THANK YOU LUIGI!"
	: .dbyt	MSG_BG+PPU_VRAM_BG_ATTR+8
	.byte	NMI_REPEAT|8, (PPU_BG_COLOR_LINE_0<<6)|(PPU_BG_COLOR_LINE_0<<4)|(PPU_BG_COLOR_LINE_1<<2)|PPU_BG_COLOR_LINE_1
	.byte	NMI_LIST_END
.endif

	.export msg_vsend_1
msg_vsend_1:
	.dbyt	MSG_BG+PPU_BG_ROW_8+PPU_BG_COL_9
	.byte	(:++)-(:+)
	: .byte	"PEACE IS PAVED"
	: .dbyt	MSG_BG+PPU_VRAM_BG_ATTR+16
	.byte	NMI_REPEAT|24, PPU_BG_COLOR_LINE_2_ALL
	.byte	NMI_LIST_END

	.export msg_vsend_2
msg_vsend_2:
	.dbyt	MSG_BG+PPU_BG_ROW_10+PPU_BG_COL_7
	.byte	(:++)-(:+)
	: .byte	"WITH KINGDOM SAVED"
	: .byte	NMI_LIST_END

	.export	msg_vsend_3_mario, msg_vsend_3_mario_name
msg_vsend_3_mario:
	.dbyt	MSG_BG+PPU_BG_ROW_12+PPU_BG_COL_9
	.byte	(:++)-(:+)
	: .byte	"HURRAH TO  "
msg_vsend_3_mario_name:
	.byte	"MARIO"
	: .byte	NMI_LIST_END

.if	.defined(VS_SMB)
	.export msg_vsend_3_luigi
msg_vsend_3_luigi:
	.dbyt	MSG_BG+PPU_BG_ROW_12+PPU_BG_COL_9
	.byte	(:++)-(:+)
	: .byte	"HURRAH TO  LUIGI"
	: .byte	NMI_LIST_END
.endif

	.export msg_vsend_4
msg_vsend_4:
	.dbyt	MSG_BG+PPU_BG_ROW_14+PPU_BG_COL_10
	.byte	(:++)-(:+)
	: .byte	"OUR ONLY HERO"
	: .byte	NMI_LIST_END

	.export msg_vsend_5
msg_vsend_5:
	.dbyt	MSG_BG+PPU_BG_ROW_16+PPU_BG_COL_7
	.byte	(:++)-(:+)
	: .byte	"THIS ENDS YOUR TRIP"
	: .byte	NMI_LIST_END

	.export msg_vsend_6
msg_vsend_6:
	.dbyt	MSG_BG+PPU_BG_ROW_18+PPU_BG_COL_6
	.byte	(:++)-(:+)
	: .byte	"OF A LONG FRIENDSHIP"
	: .byte	NMI_LIST_END

	.export msg_vsend_7
msg_vsend_7:
	.dbyt	MSG_BG+PPU_BG_ROW_20+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	"100000 PTS.ADDED"
	: .dbyt	MSG_BG+PPU_VRAM_BG_ATTR+40
	.byte	NMI_REPEAT|8, PPU_BG_COLOR_LINE_3_ALL
	.byte	NMI_LIST_END

	.export msg_vsend_8
msg_vsend_8:
	.dbyt	MSG_BG+PPU_BG_ROW_21+PPU_BG_COL_6
	.byte	(:++)-(:+)
	: .byte	"FOR EACH PLAYER LEFT."
	: .byte	NMI_LIST_END

.if	.defined(ANN)
	.export	ending_pal_ext
ending_pal_ext:
	.dbyt	PPU_COLOR_PAGE_OBJ+(PPU_COLOR_LINE_SIZE*1)
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_BLUE1, PPU_COLOR_GREY3, PPU_COLOR_RED3
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED3, PPU_COLOR_GREY3, PPU_COLOR_RED1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED3, PPU_COLOR_GREY3, PPU_COLOR_GREEN1
	: .byte	NMI_LIST_END
.endif

.if	.defined(SMB2M)
	.export	ending_throneroom_map
ending_throneroom_map:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_4+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, chr_bg::floor_castle+1
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_5+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, chr_bg::floor_castle+0
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_26+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, chr_bg::floor_castle+1
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_27+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, chr_bg::floor_castle+0
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_28+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, chr_bg::floor_castle+1
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_29+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, chr_bg::floor_castle+0
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+0
	.byte	NMI_REPEAT|16, PPU_BG_COLOR_LINE_1_ALL
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_ATTR+48
	.byte	NMI_REPEAT|16, PPU_BG_COLOR_LINE_1_ALL
	.byte	NMI_LIST_END
.endif

.if	.defined(SMB2)
	.export	ending_course_plus_txt
ending_course_plus_txt:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_17+PPU_BG_COL_4
	.byte	(:++)-(:+)
	: .byte	"WE PRESENT FANTASY WORLD"
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_19+PPU_BG_COL_6
	.byte	(:++)-(:+)
	: .byte	"LET'S TRY ", chr_bg::quotes+1, "9 WORLD", chr_bg::quotes+0
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_21+PPU_BG_COL_9
	.byte	(:++)-(:+)
	: .byte	"WITH ONE GAME."
	: .byte	NMI_LIST_END

	.export	ending_super_player_txt
ending_super_player_txt:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, " "
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_18+PPU_BG_COL_0
	.byte	NMI_REPEAT|32, " "
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_17+PPU_BG_COL_5
	.byte	(:++)-(:+)
	: .byte	"YOU'RE A SUPER PLAYER!"
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_19+PPU_BG_COL_9
	.byte	(:++)-(:+)
	: .byte	"WE HOPE WE'LL"
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_21+PPU_BG_COL_9
	.byte	(:++)-(:+)
	: .byte	"SEE YOU AGAIN."
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_23+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	"MARIO AND STAFF."
	: .byte	NMI_LIST_END
.endif
