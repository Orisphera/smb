.ifndef	SOUND_I
SOUND_I = 1

	.enum	sfx_noise
		block_break_01	= 1
		flame		= 2
	.endenum

	.enum	sfx_pulse1
		jump_big	= 1
		bump		= 2
		stomp		= 4
		smack		= 8
		pipe_entry_16	= 16
		proj		= 32
		pole		= 64
		jump_small	= 128
	.endenum

	.enum	sfx_pulse2
		coin_01		= 1
		spawn_powerup	= 2
		spawn_vine	= 4
		blast		= 8
		tick		= 16
		powerup		= 32
		oneup		= 64
		bowser_fall	= 128
	.endenum

	.enum	music_event
		death		= 1
		game_over	= 2
		victory_normal	= 4
		victory_castle	= 8
		game_over_alt	= 16
		level_end	= 32
		hurry_up	= 64
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
