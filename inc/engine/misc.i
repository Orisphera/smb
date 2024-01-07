	.ifndef	MISC_I
	MISC_I = 1

	.enum	game_mode
		title     = 0
		normal	  = 1
		victory	  = 2
		game_over = 3
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
		bridge   = 0
		init	 = 1
		proc     = 2
		msg      = 3
		end      = 4
	.endenum

	.enum	game_proc
		start	= 0
		vine	= 1
		pipe_h	= 2
		pipe_v	= 3
		pole	= 4
		victory	= 5
		lifedown = 6
		enter	= 7
		ctrl	= 8
		size_chg = 9
		hurt	= 10
		death	= 11
		firefl	= 12
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
		no_01	= 0
		no_02	= 1
		no_03	= 2
		no_04	= 3
		no_05	= 4
		no_06	= 5
		no_07	= 6
		no_08	= 7
		no_09	= 8
	.endenum

	.endif	; MISC_I