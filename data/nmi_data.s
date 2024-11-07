.include	"system/ppu.i"
.include	"system/palettes.i"

.include	"charmap.i"
.include	"tunables.i"

	.export palette_underwater
palette_underwater:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_ROSE1,   PPU_COLOR_BLUE1,   PPU_COLOR_ROSE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN3,  PPU_COLOR_GREEN1,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_BLUE1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_BLUE1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_BLUE2,  PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY1,   PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_GREY3,   PPU_COLOR_GREY1
	: .byte	NMI_LIST_END

	.export palette_overworld
palette_overworld:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_YGREEN2, PPU_COLOR_GREEN1,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED3,    PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_AZURE2,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN1,  PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
	: .byte	NMI_LIST_END

	.export palette_underground
palette_underground:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_YGREEN2, PPU_COLOR_GREEN1,  PPU_COLOR_YGREEN0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN3,   PPU_COLOR_CYAN1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_AZURE2,  PPU_COLOR_CYAN1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_CYAN1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN1,   PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN0,   PPU_COLOR_CYAN3,   PPU_COLOR_CYAN1
	: .byte	NMI_LIST_END

	.export palette_castle
palette_castle:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_RED1,    PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN1,   PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY0,   PPU_COLOR_GREY3,   PPU_COLOR_GREY1
	: .byte	NMI_LIST_END

	.export palette_snow_day
palette_snow_day:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_BLUE2, PPU_COLOR_GREY3, PPU_COLOR_GREY0, PPU_COLOR_GREY1
	: .byte	NMI_LIST_END

	.export palette_snow_night
palette_snow_night:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3, PPU_COLOR_GREY0, PPU_COLOR_GREY1
	: .byte	NMI_LIST_END

	.export palette_mushroom
palette_mushroom:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_BLUE2, PPU_COLOR_ORANGE2, PPU_COLOR_RED1, PPU_COLOR_PITCH0
	: .byte	NMI_LIST_END

	.export palette_bowser
palette_bowser:
	.dbyt	PPU_COLOR_PAGE_OBJ+(PPU_COLOR_LINE_SIZE*1)
	.byte	(:++)-(:+)
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN1, PPU_COLOR_GREY3, PPU_COLOR_ORANGE2
	: .byte	NMI_LIST_END

	.export msg_thankyou_mario
	.export msg_thankyou_player_name
msg_thankyou_mario:
	.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_10+PPU_BG_COL_8
	.byte	(:++)-(:+)
	: .byte	"THANK YOU "
msg_thankyou_player_name:
	.byte	"MARIO"
	.byte	"!"
	: .byte	NMI_LIST_END

	.if	.defined(SMB)|.defined(VS_SMB)
		.export msg_thankyou_luigi
	msg_thankyou_luigi:
		.dbyt	PPU_VRAM_BG2++PPU_BG_ROW_10+PPU_BG_COL_8
		.byte	(:++)-(:+)
		: .byte	"THANK YOU LUIGI!"
		: .byte	NMI_LIST_END
	.endif

	.export msg_thankyou_toad
msg_thankyou_toad:
	.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_14+PPU_BG_COL_5
	.byte	(:++)-(:+)
	: .byte	"BUT OUR PRINCESS IS IN"
	: .dbyt	PPU_VRAM_BG2+PPU_BG_ROW_16+PPU_BG_COL_5
	.byte	(:++)-(:+)
	: .byte	"ANOTHER CASTLE!"
	: .byte	NMI_LIST_END

	.if	.defined(SMB)
		.export msg_thankyou_princess1
	msg_thankyou_princess1:
		.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_13+PPU_BG_COL_7
		.byte	(:++)-(:+)
		: .byte	"YOUR QUEST IS OVER."
		: .byte	NMI_LIST_END

		.export msg_thankyou_princess2
	msg_thankyou_princess2:
		.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_15+PPU_BG_COL_3
		.byte	(:++)-(:+)
		: .byte	"WE PRESENT YOU A NEW QUEST."
		: .byte	NMI_LIST_END

		.export msg_worldsel_1
	msg_worldsel_1:
		.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_18+PPU_BG_COL_10
		.byte	(:++)-(:+)
		: .byte	"PUSH BUTTON B"
		: .byte	NMI_LIST_END

		.export msg_worldsel_2
	msg_worldsel_2:
		.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_20+PPU_BG_COL_8
		.byte	(:++)-(:+)
		: .byte	"TO SELECT A WORLD"
		: .byte	NMI_LIST_END

	.elseif	.defined(VS_SMB)
		.include	"./ending_data.s"
	.endif
