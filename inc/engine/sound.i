.ifndef	SOUND_I
SOUND_I = 1

	.enum	noise_event
		bowser_die	= 1
		flame		= 2
	.endenum

	.enum	pulse_queue
		pulse_1		= 1
		pulse_2		= 2
		pulse_4		= 4
		pulse_8		= 8
		pulse_16	= 16
		pulse_32	= 32
		pulse_64	= 64
		pulse_128	= 128
	.endenum

	.enum	music_event
		game_over	= 2
		victory_normal	= 4
		victory_castle	= 8
		event_20	= 32
		event_40	= 64
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
