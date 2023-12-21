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

	.endif	; MISC_I