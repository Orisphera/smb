.ifndef JOYPAD_I
JOYPAD_I = 1

	.enum	joypad_button
		right	= %00000001
		left	= %00000010
		down	= %00000100
		up	= %00001000
		start	= %00010000
		select	= %00100000
		face_b	= %01000000
		face_a	= %10000000
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
