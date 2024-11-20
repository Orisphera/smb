.ifndef	MISC_I
MISC_I = 1

.include	"system/cpu.i"

METATILE_SIZE	= 4

	.enum	proc_id_actors
		free
		active
	.endenum

	.enum	block_states
		inactive
		punch_bump	= $11
		punch_break	= $12
	.endenum

BLOCK_STATE_PROC_MASK	= %00001111

	.enum	misc_states
		inactive
		init
		throw
		bit_4	= 16
		bit_5	= 32
		hammer	= 128

		coin_01	= init
		score	= throw
	.endenum

	.enum	proj_states
		inactive
		state_1
		state_2
		state_3
		state_mask	= 7

		bit_7	= 128
	.endenum

MISC_MODE_HIGH_BIT		= %10000000

ACTOR_MODE_CHILD_BIT	= %10000000
ACTOR_MODE_PARENT_MASK	= %00001111

	.enum	actor_states
		init
		state_1
		state_2
		state_3
		state_4
		state_5
		state_6
		state_mask = 7

		bit_3	= 8
		bit_4	= 16
		bit_5	= 32

		falling	= 64
		spawned	= 128
	.endenum

COL_BOX_SIZE	= 4

	.enum	col_boxes
		box_0		= <((col_box_0-col_box_tbl)/COL_BOX_SIZE)
		box_1		= <((col_box_1-col_box_tbl)/COL_BOX_SIZE)
		box_2		= <((col_box_2-col_box_tbl)/COL_BOX_SIZE)
		box_3		= <((col_box_3-col_box_tbl)/COL_BOX_SIZE)
		box_4		= <((col_box_4-col_box_tbl)/COL_BOX_SIZE)
		box_5		= <((col_box_5-col_box_tbl)/COL_BOX_SIZE)
		box_6		= <((col_box_6-col_box_tbl)/COL_BOX_SIZE)
		box_7		= <((col_box_7-col_box_tbl)/COL_BOX_SIZE)
		box_8		= <((col_box_8-col_box_tbl)/COL_BOX_SIZE)
		box_9		= <((col_box_9-col_box_tbl)/COL_BOX_SIZE)
		box_10		= <((col_box_10-col_box_tbl)/COL_BOX_SIZE)
		box_11		= <((col_box_11-col_box_tbl)/COL_BOX_SIZE)
	.endenum

	.enum	victory_flag_proc
		null		= (actor_proc_flag_victory_tbl_null-actor_proc_flag_victory_tbl)/WORD_SIZE
		fireworks	= (actor_proc_flag_victory_tbl_fireworks-actor_proc_flag_victory_tbl)/WORD_SIZE
		score		= (actor_proc_flag_victory_tbl_timer_score-actor_proc_flag_victory_tbl)/WORD_SIZE
		raise		= (actor_proc_flag_victory_tbl_raise-actor_proc_flag_victory_tbl)/WORD_SIZE
		delay		= (actor_proc_flag_victory_tbl_delay-actor_proc_flag_victory_tbl)/WORD_SIZE
		done		= (actor_proc_flag_victory_tbl_done-actor_proc_flag_victory_tbl)/WORD_SIZE
	.endenum

	.enum	powerup_type
		mushroom_reg
		firefl
		star
		mushroom_oneup
		.if	.defined(SMB2M)
			mushroom_poison
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

	.enum	player_procs
		init
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

	.enum	scores
		value_100	= <(screen_score_value_100-screen_score_disp_incs)
		value_200	= <(screen_score_value_200-screen_score_disp_incs)
		value_400	= <(screen_score_value_400-screen_score_disp_incs)
		value_500	= <(screen_score_value_500-screen_score_disp_incs)
		value_800	= <(screen_score_value_800-screen_score_disp_incs)
		value_1000	= <(screen_score_value_1000-screen_score_disp_incs)
		value_2000	= <(screen_score_value_2000-screen_score_disp_incs)
		value_4000	= <(screen_score_value_4000-screen_score_disp_incs)
		value_5000	= <(screen_score_value_5000-screen_score_disp_incs)
		value_8000	= <(screen_score_value_8000-screen_score_disp_incs)
		value_oneup	= <(screen_score_value_oneup-screen_score_disp_incs)
	.endenum

	.enum	screen_procs
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

	.enum	player_statuses
		power_none
		power_mushroom
		power_firefl
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
		.elseif	.defined(VS_SMB)|.defined(SMB2M)
			addr_0F
			addr_10
			msg_ty_mario_2
			.if	.defined(VS_SMB)
				msg_ty_luigi_2
			.endif
			vsend_1
			vsend_2
			vsend_3_mario
			.if	.defined(VS_SMB)
				vsend_3_luigi
			.endif
			vsend_4
			vsend_5
			vsend_6
			vsend_7
			vsend_8
		.endif

		.if	.defined(VS_SMB)
			vs_nmi_list
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
		.endif

		.if	.defined(SMB2M)
			disk_text_error_buffer
			disk_perror_pal
			ending_throneroom_map
			title_cursor_data
		.endif

		.if	.defined(SMB2)
			ending_course_plus_txt
			ending_super_player_txt
		.elseif	.defined(ANN)
			ann_toad_pal_common
			ending_pal_ext
		.endif
	.endenum

	.enum	actor
		koopa_green	= $00

		koopa_mask	= $01

		buzzy_beetle	= $02
		koopa_red	= $03

		koopa_cutoff	= $04

		.if		.defined(SMB)|.defined(VS_SMB)
		actor_04	= $04
		.elseif	.defined(SMB2M)
		piranha_plant_b	= $04
		.endif

		hammer_bro	= $05
		goomba		= $06

		blooper		= $07
		bullet_swarm	= $08

		div_height	= $09

		cheep		= $0A
		cheep_grey	= $0A
		cheep_red	= $0B

		podoboo		= $0C
		piranha_plant	= $0D
		koopa_para_jump_green = $0E
		koopa_para_fly_red = $0F
		koopa_para_fly_green = $10
		lakitu		= $11

		swarm_start	= $12
		spiny		= $12

		cheep_fly	= $14

		actors_page_b	= $15
		bowser_flame	= $15
		fireworks	= $16
		bullet_cheep_swarm = $17
		swarm_stop	= $18

		spring_ani_a	= $18
		spring_ani_b	= $19
		spring_ani_c	= $1A

		firebar_start	= $1B
		firebar_clock_slow = $1B
		firebar_clock_fast = $1C
		firebar_counter_slow = $1D
		firebar_counter_fast = $1E
		firebar_long	= $1F
		firebar_end	= $20

		plat_start	= $24
		plat_bal	= $24
		plat_std_v	= $25
		plat_l_up	= $26
		plat_l_down	= $27
		plat_std_h	= $28
		plat_drop	= $29
		plat_std_h_b	= $2A

		plat_s_up	= $2B
		plat_s_down	= $2C

		bowser		= $2D
		power_up	= $2E
		vine		= $2F
		flag_enemy	= $30
		flag_victory	= $31
		spring	= $32
		bullet		= $33
		warp		= $34
		toad		= $35

		group_start	= $37
		goomba_trio_lo	= $37
		goomba_duo_lo	= $38
		goomba_trio_hi	= $39
		goomba_duo_hi	= $3A
		koopa_trio_lo	= $3B
		koopa_duo_lo	= $3C
		koopa_trio_hi	= $3D
		koopa_duo_hi	= $3E
		group_end	= $3F
	.endenum

	.enum	actor_bowser_ani
		right_step	= 0
		left_step	= 1
		step_bit	= 1

		mouth_open	= 0
		mouth_closed	= 128
		mouth_bit	= 128
	.endenum

	.enum	firebar_rot_dir
		cw = 0
		ccw = 16
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

	.enum	player_size
		large
		small
	.endenum

	.enum	col_box_type
		large
		small
		crouch
	.endenum

	.enum	clear_blocks
		brick_a		= <((gfx_clear_blocks_brick_a-gfx_clear_blocks)/METATILE_SIZE)
		brick_b		= <((gfx_clear_blocks_brick_b-gfx_clear_blocks)/METATILE_SIZE)
		block_empty	= <((gfx_clear_blocks_block_empty-gfx_clear_blocks)/METATILE_SIZE)
		blank_a		= <((gfx_clear_blocks_blank_a-gfx_clear_blocks)/METATILE_SIZE)
		blank_b		= <((gfx_clear_blocks_blank_b-gfx_clear_blocks)/METATILE_SIZE)
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

	.enum	fds_loader_procs
		prompt_00
		load_file
		wait_eject
		wait_insert
		bootstrap
	.endenum

	.enum	fds_file_ids
		main
		data2
		data3
		data4
	.endenum

	.enum	vschar1_bg_data
		map_title
		player_select
		name_register
		stats
		box
		insert_coin
		continue
		super_players
	.endenum

	.enum	stats
		score_player_a

		.if	.defined(SMB)|.defined(VS_SMB)
		score_player_b
		.endif

		coin_player_a

		.if	.defined(SMB)|.defined(VS_SMB)
		coin_player_b
		.endif

		time
	.endenum

.endif	; MISC_I
