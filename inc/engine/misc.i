	.ifndef	MISC_I
	MISC_I = 1

	.enum	game_mode
		normal	= 1
		victory	= 2
	.endenum

	.enum	gameplay_mode
		init	   = 0
		screen	   = 1
		game_setup = 2
		menu       = 3
	.endenum

	.endif	; MISC_I