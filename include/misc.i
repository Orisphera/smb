.ifndef	MISC_I
MISC_I = 1

.include	"sys/cpu.i"

.include	"const.i"
.include	"mem.i"
.include	"sound.i"

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

		exploded	= 128
	.endenum

STAR_TIMER	= 35

.if	.defined(SMB)|.defined(SMBV2)
	STAR_MUSIC	= music_base::super_star
.elseif	.defined(VS_SMB)
	STAR_MUSIC	= music_base::clouds
.endif

MISC_MODE_HIGH_BIT		= %10000000

ACTOR_MODE_CHILD_BIT	= %10000000
ACTOR_MODE_PARENT_MASK	= %00001111

	.enum	actor_states
		init
		descending
		acting
		stopped
		timing
		thrown
		state_end
		state_mask = 7

		bit_3	= 8
		bit_4	= 16
		dying	= 32

		falling	= 64
		spawned	= 128
	.endenum

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

	.enum	flag_victory_proc
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
		.if	.defined(SMBV2)
			mushroom_poison
			type_05
		.endif
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

PLAYER_DEATH_VELOC_Y	= <-4

	.enum	scores
		value_100	= <(bg_score_value_100-bg_score_disp_incs)
		value_200	= <(bg_score_value_200-bg_score_disp_incs)
		value_400	= <(bg_score_value_400-bg_score_disp_incs)
		value_500	= <(bg_score_value_500-bg_score_disp_incs)
		value_800	= <(bg_score_value_800-bg_score_disp_incs)
		value_1000	= <(bg_score_value_1000-bg_score_disp_incs)
		value_2000	= <(bg_score_value_2000-bg_score_disp_incs)
		value_4000	= <(bg_score_value_4000-bg_score_disp_incs)
		value_5000	= <(bg_score_value_5000-bg_score_disp_incs)
		value_8000	= <(bg_score_value_8000-bg_score_disp_incs)
		value_oneup	= <(bg_score_value_oneup-bg_score_disp_incs)
	.endenum

SCORE_PROJ_GOOMBA	= scores::value_100
SCORE_PROJ_ENEMY_OTHER	= scores::value_200
SCORE_PROJ_HAMMER_BRO	= scores::value_1000
SCORE_PROJ_BOWSER	= scores::value_5000
SCORE_POWERUP		= scores::value_1000

	.enum	bg_procs
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

	.enum	bg_text
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
		.if	.defined(SMBV1)
			msg_ty_luigi
		.endif
		msg_ty_toad
		.if	.defined(SMB)
			msg_ty_princess1
			msg_ty_princess2
			msg_addr_worldsel_1
			msg_addr_worldsel_2
		.elseif	.defined(VS_SMB)|.defined(SMBV2)
			ending_attr
			ending_pal
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
			vs_ppu_displist
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

		.if	.defined(SMBV2)
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

		msg_base	= msg_ty_mario
	.endenum

	.enum	actor
		koopa_green	= <((actor_init_A_tbl_00-actor_init_tbl)/WORD_SIZE)

		koopa_mask	= <((actor_init_A_tbl_01-actor_init_tbl)/WORD_SIZE)

		buzzy_beetle	= <((actor_init_A_tbl_02-actor_init_tbl)/WORD_SIZE)
		koopa_red	= <((actor_init_A_tbl_03-actor_init_tbl)/WORD_SIZE)

		koopa_cutoff	= <((actor_init_A_tbl_04-actor_init_tbl)/WORD_SIZE)

		.if	.defined(SMBV2)
			piranha_plant_b	= koopa_cutoff
		.endif

		hammer_bro	= <((actor_init_A_tbl_05-actor_init_tbl)/WORD_SIZE)
		goomba		= <((actor_init_A_tbl_06-actor_init_tbl)/WORD_SIZE)

		blooper		= <((actor_init_A_tbl_07-actor_init_tbl)/WORD_SIZE)
		bullet_swarm	= <((actor_init_A_tbl_08-actor_init_tbl)/WORD_SIZE)

		div_height	= <((actor_init_A_tbl_09-actor_init_tbl)/WORD_SIZE)

		cheep_grey	= <((actor_init_A_tbl_0A-actor_init_tbl)/WORD_SIZE)
		cheep_red	= <((actor_init_A_tbl_0B-actor_init_tbl)/WORD_SIZE)
		cheep		= cheep_grey
		podoboo		= <((actor_init_A_tbl_0C-actor_init_tbl)/WORD_SIZE)
		
		piranha_plant	= <((actor_init_A_tbl_0D-actor_init_tbl)/WORD_SIZE)
		koopa_para_jump_green = <((actor_init_A_tbl_0E-actor_init_tbl)/WORD_SIZE)
		koopa_para_fly_red = <((actor_init_A_tbl_0F-actor_init_tbl)/WORD_SIZE)
		koopa_para_fly_green = <((actor_init_A_tbl_10-actor_init_tbl)/WORD_SIZE)

		lakitu		= <((actor_init_A_tbl_11-actor_init_tbl)/WORD_SIZE)

		spiny		= <((actor_init_A_tbl_12-actor_init_tbl)/WORD_SIZE)

		cheep_fly	= <((actor_init_A_tbl_14-actor_init_tbl)/WORD_SIZE)
		swarm_start	= spiny

		bowser_flame	= <((actor_init_B_tbl_00-actor_init_tbl)/WORD_SIZE)
		actors_page_b	= bowser_flame
		fireworks	= <((actor_init_B_tbl_01-actor_init_tbl)/WORD_SIZE)
		bullet_cheep_swarm = <((actor_init_B_tbl_02-actor_init_tbl)/WORD_SIZE)

		spring_ani_a	= <((actor_init_B_tbl_03-actor_init_tbl)/WORD_SIZE)
		swarm_stop	= spring_ani_a
		spring_ani_b	= <((actor_init_B_tbl_04-actor_init_tbl)/WORD_SIZE)
		spring_ani_c	= <((actor_init_B_tbl_05-actor_init_tbl)/WORD_SIZE)

		firebar_clock_slow = <((actor_init_B_tbl_06-actor_init_tbl)/WORD_SIZE)
		firebar_start	= firebar_clock_slow
		firebar_clock_fast = <((actor_init_B_tbl_07-actor_init_tbl)/WORD_SIZE)
		firebar_counter_slow = <((actor_init_B_tbl_08-actor_init_tbl)/WORD_SIZE)
		firebar_counter_fast = <((actor_init_B_tbl_09-actor_init_tbl)/WORD_SIZE)
		firebar_long	= <((actor_init_B_tbl_0A-actor_init_tbl)/WORD_SIZE)
		firebar_end	= firebar_long+1

		plat_bal	= <((actor_init_B_tbl_0F-actor_init_tbl)/WORD_SIZE)
		plat_start	= plat_bal
		plat_std_v	= <((actor_init_B_tbl_10-actor_init_tbl)/WORD_SIZE)
		plat_l_up	= <((actor_init_B_tbl_11-actor_init_tbl)/WORD_SIZE)
		plat_l_down	= <((actor_init_B_tbl_12-actor_init_tbl)/WORD_SIZE)
		plat_std_h	= <((actor_init_B_tbl_13-actor_init_tbl)/WORD_SIZE)
		plat_drop	= <((actor_init_B_tbl_14-actor_init_tbl)/WORD_SIZE)
		plat_std_h_b	= <((actor_init_B_tbl_15-actor_init_tbl)/WORD_SIZE)
	
		plat_s_up	= <((actor_init_B_tbl_16-actor_init_tbl)/WORD_SIZE)
		plat_s_down	= <((actor_init_B_tbl_17-actor_init_tbl)/WORD_SIZE)

		bowser		= <((actor_init_B_tbl_18-actor_init_tbl)/WORD_SIZE)
		power_up	= <((actor_init_B_tbl_19-actor_init_tbl)/WORD_SIZE)
		vine		= <((actor_init_B_tbl_1A-actor_init_tbl)/WORD_SIZE)
		flag_enemy	= <((actor_init_B_tbl_1B-actor_init_tbl)/WORD_SIZE)
		flag_victory	= <((actor_init_B_tbl_1C-actor_init_tbl)/WORD_SIZE)
		spring		= <((actor_init_B_tbl_1D-actor_init_tbl)/WORD_SIZE)
		bullet		= <((actor_init_B_tbl_1E-actor_init_tbl)/WORD_SIZE)
		warp		= <((actor_init_B_tbl_1F-actor_init_tbl)/WORD_SIZE)
		toad		= <((actor_init_B_tbl_20-actor_init_tbl)/WORD_SIZE)

		group_start	= toad+2
		goomba_duo_lo	= group_start+0
		goomba_trio_lo	= goomba_duo_lo+1
		goomba_duo_hi	= goomba_trio_lo+1
		goomba_trio_hi	= goomba_duo_hi+1
		koopa_group_start = goomba_trio_hi+1
		koopa_duo_lo	= koopa_group_start+0
		koopa_trio_lo	= koopa_duo_lo+1
		koopa_duo_hi	= koopa_trio_lo+1
		koopa_trio_hi	= koopa_duo_hi+1
		group_end	= koopa_trio_hi+1
		actor_end	= group_end
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

	.if	.defined(SMB2)
		no_09
	.endif	; SMB2

		count
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
		brick_a		= <((meta_clear_blocks_brick_a-meta_clear_blocks)/METATILE_SIZE)
		brick_b		= <((meta_clear_blocks_brick_b-meta_clear_blocks)/METATILE_SIZE)
		block_empty	= <((meta_clear_blocks_block_empty-meta_clear_blocks)/METATILE_SIZE)
		blank_a		= <((meta_clear_blocks_blank_a-meta_clear_blocks)/METATILE_SIZE)
		blank_b		= <((meta_clear_blocks_blank_b-meta_clear_blocks)/METATILE_SIZE)
	.endenum

	.enum	scenery_procs
		main_c			= 0
		inc_seam_a		= (((scenery_proc_inc_seam_a-scenery_proc_tbl)/WORD_SIZE)+1)
		render_area_a		= (((scenery_proc_render_area_a-scenery_proc_tbl)/WORD_SIZE)+1)
		render_area_b		= (((scenery_proc_render_area_b-scenery_proc_tbl)/WORD_SIZE)+1)
		main_a			= (((scenery_proc_main_a-scenery_proc_tbl)/WORD_SIZE)+1)
		inc_seam_b		= (((scenery_proc_inc_seam_b-scenery_proc_tbl)/WORD_SIZE)+1)
		render_area_c		= (((scenery_proc_render_area_c-scenery_proc_tbl)/WORD_SIZE)+1)
		render_area_d		= (((scenery_proc_render_area_d-scenery_proc_tbl)/WORD_SIZE)+1)
		main_b			= (((scenery_proc_main_b-scenery_proc_tbl)/WORD_SIZE)+1)
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

		.if	.defined(SMBV1)
		score_player_b
		.endif

		coin_player_a

		.if	.defined(SMBV1)
		coin_player_b
		.endif

		time
	.endenum

ACTOR_SWAPPABLE_EASY	= actor::goomba
ACTOR_SWAPPABLE_HARD	= actor::buzzy_beetle

ACTOR_COL_BOX_LARGE	= col_boxes::box_3
ACTOR_COL_BOX_SMALL	= col_boxes::box_9

.if	.defined(SMB)
	ENG_HARDMODE_B_COURSE	= course::no_05
	ENG_HARDMODE_B_GOAL	= 2
.elseif	.defined(VS_SMB)
	ENG_HARDMODE_B_COURSE	= course::no_04
	ENG_HARDMODE_B_GOAL	= 1
.elseif	.defined(SMBV2)
	ENG_HARDMODE_B_COURSE	= course::no_04
	ENG_HARDMODE_B_GOAL	= 3
.endif

.if	.defined(VS_SMB)
CLIMB_POS_X	= pos_x_lo_actor+(ACTOR_COUNT_MAX-1)
CLIMB_DIR_BOUND	= 10
.else
CLIMB_POS_X	= pos_x_lo_player
CLIMB_DIR_BOUND	= 16
.endif

.if	.defined(SMB2)
	PIPE_POS_MASK	= %00001111
.elseif	.defined(ANN)
	PIPE_POS_MASK	= %00000111
.else
	PIPE_POS_MASK	= %00000011
.endif

SPRING_ACCEL_Y_INIT	= 112
SPRING_ACCEL_TIMER	= 3

.endif	; MISC_I
