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

	DIR_RIGHT	= joypad_button::right
	DIR_LEFT	= joypad_button::left
	DIR_MASK	= (DIR_LEFT|DIR_RIGHT)

	COL_NONE	= joypad_button::none
	COL_RIGHT	= joypad_button::right
	COL_LEFT	= joypad_button::left
	COL_BOTTOM	= joypad_button::down
	COL_TOP		= joypad_button::up

.endif	; JOYPAD_I
