.ifndef	MODES_I
MODES_I = 1

	.enum	system_modes
		.if	.defined(SMB)|.defined(VS_SMB)
			title
		.elseif	.defined(SMB2M)
			disk_loader
		.endif

		.if	.defined(VS_SMB)
			player_select
		.endif

		game
		victory
		game_over
	.endenum

	.enum	title_modes
		.if	.defined(VS)
			vs_init
		.endif

		init_0
		scr
		init_1
		proc

		.if	.defined(VS)
			init_player_select
			init_ppu
			super_players
			tick
		.endif
	.endenum

	.enum	game_modes
		.if	.defined(VS_SMB)
			vs_init
		.elseif	.defined(SMB2M)
			init_data2
		.endif

		init_0

		.if	.defined(ANN)
			mode_unk_1
		.endif

		scr
		init_1
		proc

		.if	.defined(SMB)
		init	= init_0
		.elseif	.defined(VS_SMB)
		init	= vs_init
		.elseif	.defined(SMB2M)
		init	= init_data2
		.endif
	.endenum

	.enum	victory_modes
		bowser
		init
		proc
		msg

		.if	.defined(SMB2M)|.defined(VS_SMB)
			time_tally
		.endif

		finish

		.if	.defined(VS_SMB)
			vs_84CF
			vs_8526
			vs_85E0
			vs_864C
			vs_865D
		.endif
	.endenum

	.if	.defined(SMB2M)
	.enum	victory_modes_ending
		bowser
		init
		proc
		disk_init
		disk_check
		disk_data3
		scr
		msg
		time_tally
		extra_lives
		palcycle
		lives_draw
		toad_proc
		disk_save
	.endenum
	.endif

	.enum	game_over_modes
		init
		scr

		.if	.defined(VS_SMB)
			vs_9902
			vs_98DC
			vs_98F2
		.endif

		proc
	.endenum

.endif	; MODES_I
