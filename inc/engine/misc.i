.ifndef	MISC_I
MISC_I = 1

.include	"../system/cpu.i"

	.enum	actor_modes
		free
		active
	.endenum

ACTOR_MODE_CHILD_BIT	= %10000000
ACTOR_MODE_PARENT_MASK	= %00001111

	.enum	actor_states
		state_0
		state_1
		state_2
		state_3
		state_4
		state_5
	.endenum

	.enum	game_mode
		title
		.if	.defined(VS_SMB)
			mode_vs_1
		.endif
		normal
		victory
		game_over
	.endenum

	.enum	gameplay_mode
		.if	.defined(VS_SMB)
			vs_init
		.elseif	.defined(SMB2M)
			mode_unk_0
		.endif

		init_0_do

		.if	.defined(ANN)
			mode_unk_1
		.endif

		scr_proc
		init_1
		proc

		init_0	= 0
		.if	.defined(SMB2M)
			mode_5	= $5
			mode_D	= $D
		.endif
	.endenum

	.enum	powerup_type
		mushroom_a
		firefl
		star
		mushroom_b
		.if	.defined(SMB2M)
			type_04
			type_05
		.endif
	.endenum

	.enum	victory_mode
		bridge
		init
		proc
		msg
		end
	.endenum

	.enum	game_proc
		start
		vine
		pipe_h
		pipe_v
		pole
		victory
		lifedown
		enter
		ctrl
		size_chg
		hurt
		death
		firefl
	.endenum

	.enum	screen_proc
		init
		color_init_1
		stat_bg_0
		stat_bg_1
		msg_time_up
		msg_time_reset
		msg_world_game_over
		.if	.defined(SMB2)
			proc_C5D0
		.elseif	.defined(ANN)
			score_disp_end
		.endif
		msg_time_reset_b
		bg
		color_init_2
		color_init_3
		color_init_4
		title_bg
		title_cursor
		title_score
	.endenum

	.enum	player_state
		ground
		jump_swim
		fall
		climb
	.endenum

	.enum	screen_text
		header
		splash
		timeup
		gameover
		.if	.defined(SMB)
		warp
		.endif
	.endenum

	.enum	nmi_addr
		buffer_01_A
		pal_underwater
		pal_overworld
		pal_underground
		pal_castle
		buffer_00_A
		buffer_11_A
		buffer_11_B
		pal_bowser
		pal_day_snow
		pal_night_snow
		pal_mushroom
		msg_ty_mario
		.if	.defined(SMB)|.defined(VS_SMB)
			msg_ty_luigi
		.endif
		msg_ty_toad
		.if	.defined(SMB)
			msg_ty_princess1
			msg_ty_princess2
			msg_addr_worldsel_1
			msg_addr_worldsel_2
		.elseif	.defined(VS_SMB)
			addr_0F
			addr_10
			msg_ty_mario_2
			msg_ty_luigi_2
			vsend_1
			vsend_2
			vsend_3_mario
			vsend_3_luigi
			vsend_4
			vsend_5
			vsend_6
			vsend_7
			vsend_8
			addr_1C
			addr_1D_A
			addr_1D_B
			addr_1E_A
			addr_1E_B
			addr_1E_C
			addr_1E_D
			addr_1E_E
			addr_1E_F
			addr_1E_G
			addr_1F
		.elseif	.defined(SMB2M)
			addr_C876
			addr_C87F
			addr_C893
			addr_C8AB
			addr_C8C1
			addr_C8D7
			addr_C8EB
			addr_C8FC
			addr_C913
			addr_C92B
			addr_C943
			addr_C149
			addr_C10B
			addr_C95C
			addr_C511
			addr_C97D
			addr_C9C0
		.endif
	.endenum

	.enum	actor
		koopa_green	= $00

		buzzy_beetle	= $02
		koopa_red	= $03

		hammer_bro	= $05
		goomba		= $06
		bloober		= $07
		bullet_swarm	= $08

		div_height	= $09

		cheep_grey	= $0A
		cheep_red	= $0B
		podoboo		= $0C
		piranha_plant	= $0D
		koopa_para_jump_green = $0E
		koopa_para_fly_red = $0F
		koopa_para_fly_green = $10
		lakitu		= $11
		spiny		= $12

		cheep_fly	= $14

		actors_page_b	= $15

		bowser_flame	= $15
		fireworks	= $16
		bullet_cheep_swarm = $17
		swarm_stop	= $18

		actor_1B	= $1B
		actor_1D	= $1D
		actor_28	= $28
		unk_00		= $29
		bowser		= $2D
		power_up	= $2E
		vine		= $2F
		flag_enemy	= $30
		flag_victory	= $31
		jump_spring	= $32
		bullet		= $33
		toad		= $35

		goomba_trio	= $37
		actor_3F	= $3F
	.endenum

	.enum	course
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		no_07
		no_08
		no_09
		no_0A
	.endenum

	.enum	course_types
		water
		overworld	
		underground
		castle
		MAX = castle
		cloud
	.endenum

	.enum	course_water
		no_01
		no_02
		no_03
		.if	.defined(VS_SMB)
			no_04
		.endif
	.endenum

	.enum	course_overworld
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		no_07
		no_08
		no_09
		no_10
		no_11
		no_12
		no_13
		no_14
		no_15
		no_16
		no_17
		no_18
		no_19
		no_20
		no_21
		no_22
		.if	.defined(VS_SMB)
			no_23
			no_24
		.endif
	.endenum

	.enum	course_underground
		no_01
		no_02
		no_03
	.endenum

	.enum	course_castle
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		.if	.defined(VS_SMB)
			no_07
			no_08
		.endif
	.endenum

	.enum	player_size
		large
		small
	.endenum

	.enum	col_box_type
		large
		small
		crouch
	.endenum

	.enum	bg_procs
		main_c			= 0
		inc_col_a		= (((bg_proc_inc_col_a-bg_proc_tbl)/WORD_SIZE)+1)
		gfx_render_area_a	= (((bg_proc_gfx_render_area_a-bg_proc_tbl)/WORD_SIZE)+1)
		gfx_render_area_b	= (((bg_proc_gfx_render_area_b-bg_proc_tbl)/WORD_SIZE)+1)
		main_a			= (((bg_proc_main_a-bg_proc_tbl)/WORD_SIZE)+1)
		inc_col_b		= (((bg_proc_inc_col_b-bg_proc_tbl)/WORD_SIZE)+1)
		gfx_render_area_c	= (((bg_proc_gfx_render_area_c-bg_proc_tbl)/WORD_SIZE)+1)
		gfx_render_area_d	= (((bg_proc_gfx_render_area_d-bg_proc_tbl)/WORD_SIZE)+1)
		main_b			= (((bg_proc_main_b-bg_proc_tbl)/WORD_SIZE)+1)
		mask			= $07
	.endenum

	.endif	; MISC_I
