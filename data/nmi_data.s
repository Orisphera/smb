.include        "../inc/system/ppu.i"
.include        "../inc/system/palettes.i"

.include        "../inc/engine/charmap.i"
.include        "../inc/engine/tunables.i"

	.export palette_underwater
palette_underwater:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_underwater_end-palette_underwater_start
palette_underwater_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ROSE1,   PPU_COLOR_BLUE1,   PPU_COLOR_ROSE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN3,  PPU_COLOR_GREEN1,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_BLUE1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_BLUE1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_BLUE2,  PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY1,   PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_GREY3,   PPU_COLOR_GREY1
palette_underwater_end:
	.byte	NMI_DATA_END

	.export palette_overworld
palette_overworld:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_overworld_end-palette_overworld_start
palette_overworld_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_YGREEN2, PPU_COLOR_GREEN1,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED3,    PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_AZURE2,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN1,  PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
palette_overworld_end:
	.byte	NMI_DATA_END

	.export palette_underground
palette_underground:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_underground_end-palette_underground_start
palette_underground_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_YGREEN2, PPU_COLOR_GREEN1,  PPU_COLOR_YGREEN0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN3,   PPU_COLOR_CYAN1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_AZURE2,  PPU_COLOR_CYAN1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_CYAN1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN1,   PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN0,   PPU_COLOR_CYAN3,   PPU_COLOR_CYAN1
palette_underground_end:
	.byte	NMI_DATA_END

	.export palette_castle
palette_castle:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_castle_end-palette_castle_start
palette_castle_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_RED1,    PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN1,   PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY0,   PPU_COLOR_GREY3,   PPU_COLOR_GREY1
palette_castle_end:
	.byte	NMI_DATA_END

	.export palette_snow_day
palette_snow_day:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_snow_day_end-palette_snow_day_start
palette_snow_day_start:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_GREY3, PPU_COLOR_GREY0, PPU_COLOR_GREY1
palette_snow_day_end:
	.byte	NMI_DATA_END

	.export palette_snow_night
palette_snow_night:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_snow_night_end-palette_snow_night_start
palette_snow_night_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3, PPU_COLOR_GREY0, PPU_COLOR_GREY1
palette_snow_night_end:
	.byte	NMI_DATA_END

	.export palette_mushroom
palette_mushroom:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_mushroom_end-palette_mushroom_start
palette_mushroom_start:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_ORANGE2, PPU_COLOR_RED1, PPU_COLOR_PITCH0
palette_mushroom_end:
	.byte	NMI_DATA_END

	.export palette_koopa
palette_koopa:
	.dbyt	PPU_COLOR_PAGE_OBJ+(PPU_COLOR_LINE_SIZE*1)
	.byte	palette_koopa_end-palette_koopa_start
palette_koopa_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN1, PPU_COLOR_GREY3, PPU_COLOR_ORANGE2
palette_koopa_end:
	.byte	NMI_DATA_END

	.export msg_thankyou_mario
msg_thankyou_mario:
	.dbyt	PPU_VRAM_BG2+$148
	.byte	msg_thankyou_mario_end-msg_thankyou_mario_start
msg_thankyou_mario_start:
	.byte	"THANK YOU MARIO!"
msg_thankyou_mario_end:
	.byte	NMI_DATA_END

	.if	.defined(SMB)|.defined(VS_SMB)
		.export msg_thankyou_luigi
	msg_thankyou_luigi:
		.dbyt	PPU_VRAM_BG2+$148
		.byte	msg_thankyou_luigi_end-msg_thankyou_luigi_start
	msg_thankyou_luigi_start:
		.byte	"THANK YOU LUIGI!"
	msg_thankyou_luigi_end:
		.byte	NMI_DATA_END
	.endif

	.export msg_thankyou_toad
msg_thankyou_toad:
	.dbyt	PPU_VRAM_BG2+$1C5
	.byte	msg_thankyou_toad1_end-msg_thankyou_toad1_start
msg_thankyou_toad1_start:
	.byte	"BUT OUR PRINCESS IS IN"
msg_thankyou_toad1_end:
	.dbyt	PPU_VRAM_BG2+$205
	.byte	msg_thankyou_toad2_end-msg_thankyou_toad2_start
msg_thankyou_toad2_start:
	.byte	"ANOTHER CASTLE!"
msg_thankyou_toad2_end:
	.byte	NMI_DATA_END

	.if	.defined(SMB)
		.export msg_thankyou_princess1
	msg_thankyou_princess1:
		.dbyt	PPU_VRAM_BG2+$1A7
		.byte	msg_thankyou_princess1_end-msg_thankyou_princess1_start
	msg_thankyou_princess1_start:
		.byte	"YOUR QUEST IS OVER."
	msg_thankyou_princess1_end:
		.byte	NMI_DATA_END

		.export msg_thankyou_princess2
	msg_thankyou_princess2:
		.dbyt	PPU_VRAM_BG2+$1E3
		.byte	msg_thankyou_princess2_end-msg_thankyou_princess2_start
	msg_thankyou_princess2_start:
		.byte	"WE PRESENT YOU A NEW QUEST."
	msg_thankyou_princess2_end:
		.byte	NMI_DATA_END

		.export msg_worldsel_1
	msg_worldsel_1:
		.dbyt	PPU_VRAM_BG2+$24A
		.byte	msg_worldsel_1_end-msg_worldsel_1_start
	msg_worldsel_1_start:
		.byte	"PUSH BUTTON B"
	msg_worldsel_1_end:
		.byte	NMI_DATA_END

		.export msg_worldsel_2
	msg_worldsel_2:
		.dbyt	PPU_VRAM_BG2+$288
		.byte	msg_worldsel_2_end-msg_worldsel_2_start
	msg_worldsel_2_start:
		.byte	"TO SELECT A WORLD"
	msg_worldsel_2_end:
		.byte	NMI_DATA_END
	.elseif	.defined(VS_SMB)
		.export nmi_addr_0F
	nmi_addr_0F:
		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS
		.byte	$48, $55, $23, $C2, $01, $D5
		.byte	NMI_DATA_END

		.export	nmi_addr_10
	nmi_addr_10:
		.dbyt	PPU_COLOR_PAGE_BG
		.byte	nmi_addr_10_end-nmi_addr_10_start
	nmi_addr_10_start:
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_AZURE2,  PPU_COLOR_BLUE1,   PPU_COLOR_BLUE0
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
	nmi_addr_10_end:
		.byte	NMI_DATA_END

		.export msg_thankyou_mario_2
	msg_thankyou_mario_2:
		.dbyt	PPU_VRAM_BG2+$E8
		.byte	msg_thankyou_mario_2_end-msg_thankyou_mario_2_start
	msg_thankyou_mario_2_start:
		.byte	"THANK YOU MARIO!"
	msg_thankyou_mario_2_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$8
		.byte	$48, $05
		.byte	NMI_DATA_END

		.export msg_thankyou_luigi_2
	msg_thankyou_luigi_2:
		.dbyt	PPU_VRAM_BG2+$E8
		.byte	msg_thankyou_luigi_2_end-msg_thankyou_luigi_2_start
	msg_thankyou_luigi_2_start:
		.byte	"THANK YOU LUIGI!"
	msg_thankyou_luigi_2_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$8
		.byte	$48, $05
		.byte	NMI_DATA_END

		.export msg_vsend_1
	msg_vsend_1:
		.dbyt	PPU_VRAM_BG2+$109
		.byte	msg_vsend_1_end-msg_vsend_1_start
	msg_vsend_1_start:
		.byte	"PEACE IS PAVED"
	msg_vsend_1_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$10
		.byte	$58, $AA
		.byte	NMI_DATA_END

		.export msg_vsend_2
	msg_vsend_2:
		.dbyt	PPU_VRAM_BG2+$147
		.byte	msg_vsend_2_end-msg_vsend_2_start
	msg_vsend_2_start:
		.byte	"WITH KINGDOM SAVED"
	msg_vsend_2_end:
		.byte	NMI_DATA_END

		.export	msg_vsend_3_mario
	msg_vsend_3_mario:
		.dbyt	PPU_VRAM_BG2+$189
		.byte	msg_vsend_3_mario_end-msg_vsend_3_mario_start
	msg_vsend_3_mario_start:
		.byte	"HURRAH TO  MARIO"
	msg_vsend_3_mario_end:
		.byte	NMI_DATA_END

		.export msg_vsend_3_luigi
	msg_vsend_3_luigi:
		.dbyt	PPU_VRAM_BG2+$189
		.byte	msg_vsend_3_luigi_end-msg_vsend_3_luigi_start
	msg_vsend_3_luigi_start:
		.byte	"HURRAH TO  LUIGI"
	msg_vsend_3_luigi_end:
		.byte	NMI_DATA_END

		.export msg_vsend_4
	msg_vsend_4:
		.dbyt	PPU_VRAM_BG2+$1CA
		.byte	msg_vsend_4_end-msg_vsend_4_start
	msg_vsend_4_start:
		.byte	"OUR ONLY HERO"
	msg_vsend_4_end:
		.byte	NMI_DATA_END

		.export msg_vsend_5
	msg_vsend_5:
		.dbyt	PPU_VRAM_BG2+$207
		.byte	msg_vsend_5_end-msg_vsend_5_start
	msg_vsend_5_start:
		.byte	"THIS ENDS YOUR TRIP"
	msg_vsend_5_end:
		.byte	NMI_DATA_END

		.export msg_vsend_6
	msg_vsend_6:
		.dbyt	PPU_VRAM_BG2+$246
		.byte	msg_vsend_6_end-msg_vsend_6_start
	msg_vsend_6_start:
		.byte	"OF A LONG FRIENDSHIP"
	msg_vsend_6_end:
		.byte	NMI_DATA_END

		.export msg_vsend_7
	msg_vsend_7:
		.dbyt	PPU_VRAM_BG2+$288
		.byte	msg_vsend_7_end-msg_vsend_7_start
	msg_vsend_7_start:
		.byte	"100000 PTS.ADDED"
	msg_vsend_7_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$28
		.byte	$48, $FF
		.byte	NMI_DATA_END

		.export msg_vsend_8
	msg_vsend_8:
		.dbyt	PPU_VRAM_BG2+$2A6
		.byte	msg_vsend_8_end-msg_vsend_8_start
	msg_vsend_8_start:
		.byte	"FOR EACH PLAYER LEFT."
	msg_vsend_8_end:
		.byte	NMI_DATA_END
	.endif
