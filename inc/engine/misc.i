	.ifndef	MISC_I
	MISC_I = 1

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
		init_0	 = 0
		scr_proc = 1
		init_1	 = 2
		proc	 = 3
		mode_4   = 4
		mode_5   = 5
		mode_D   = $D
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

	.enum	screen_text
		header
		splash
		timeup
		gameover
		.if	.defined(SMB)
		warp
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
		bowser_flame	= $15
		fireworks	= $16
		bullet_cheep_swarm = $17
		swarm_stop	= $18
		bowser		= $2D
		power_up	= $2E
		vine		= $2F
		flag_enemy	= $30
		flag_victory	= $31
		jump_spring	= $32
		bullet		= $33
		toad		= $35
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

	.enum	area_type
		water
		overworld	
		underground
	.endenum

	.endif	; MISC_I
