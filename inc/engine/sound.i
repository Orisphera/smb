.ifndef	SOUND_I
SOUND_I = 1

	.enum	music_event
		game_over	= 2
		victory_normal	= 4
		victory_castle	= 8
		none		= 128
	.endenum

	.enum	music_area
		overworld	= 1
		underwater	= 2
		underground	= 4
		castle		= 8
		clouds		= 16
		pipe_intro	= 32
		super_star	= 64
		none		= 128
	.endenum

.endif
