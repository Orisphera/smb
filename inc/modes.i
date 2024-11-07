.ifndef	MODES_I
MODES_I = 1

.include	"system/cpu.i"

	.enum	system_modes
		.if	.defined(SMB)|.defined(VS_SMB)
			title		= <((nmi_system_enter_title-nmi_system_enter_tbl)/WORD_SIZE)
		.elseif	.defined(SMB2M)
			disk_loader	= <((nmi_system_enter_disk_loader-nmi_system_enter_tbl)/WORD_SIZE)
		.endif

		.if	.defined(VS_SMB)
			player_select	= <((nmi_system_enter_player_select-nmi_system_enter_tbl)/WORD_SIZE)
		.endif

		game		= <((nmi_system_enter_game-nmi_system_enter_tbl)/WORD_SIZE)
		victory		= <((nmi_system_enter_victory-nmi_system_enter_tbl)/WORD_SIZE)
		game_over 	= <((nmi_system_enter_game_over-nmi_system_enter_tbl)/WORD_SIZE)
	.endenum

	.if	.defined(SMB)|.defined(VS_SMB)
		.enum	title_modes
			.if	.defined(VS)
				vs_init		= <((title_mode_vs_init-title_mode_tbl)/WORD_SIZE)
			.endif

			init_0	= <((title_mode_init_0-title_mode_tbl)/WORD_SIZE)
			scr	= <((title_mode_scr-title_mode_tbl)/WORD_SIZE)
			init_1	= <((title_mode_init_1-title_mode_tbl)/WORD_SIZE)
			proc	= <((title_mode_proc-title_mode_tbl)/WORD_SIZE)

			.if	.defined(VS)
				init_player_select = <((title_mode_init_player_select-title_mode_tbl)/WORD_SIZE)
				init_ppu	= <((title_mode_init_ppu-title_mode_tbl)/WORD_SIZE)
				super_players	= <((title_mode_super_players-title_mode_tbl)/WORD_SIZE)
				tick		= <((title_mode_tick-title_mode_tbl)/WORD_SIZE)
			.endif
		.endenum
	.endif

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
