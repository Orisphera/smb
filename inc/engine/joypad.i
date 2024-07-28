.ifndef JOYPAD_I
JOYPAD_I = 1

	.enum	joypad_button
		right	= 1
		left	= 2
		down	= 4
		up	= 8
		start	= 16
		select	= 32
		face_b	= 64
		face_a	= 128
		none	= 0
	.endenum

	MOTION_DIR_RIGHT	= joypad_button::right
	MOTION_DIR_LEFT		= joypad_button::left

	PLAYER_COL_NONE		= joypad_button::none
	PLAYER_COL_RIGHT	= joypad_button::right
	PLAYER_COL_LEFT		= joypad_button::left
	PLAYER_COL_BOTTOM	= joypad_button::down
	PLAYER_COL_TOP		= joypad_button::up

.endif	; JOYPAD_I
