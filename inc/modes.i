.ifndef	MODES_I
MODES_I = 1

.include	"system/cpu.i"

	.enum	system_modes
		.if	.defined(SMB)|.defined(VS_SMB)
			title		= <((nmi_system_enter_title-nmi_system_enter_tbl)/WORD_SIZE)
		.elseif	.defined(SMBV2)
			disk_loader	= <((nmi_system_enter_disk_loader-nmi_system_enter_tbl)/WORD_SIZE)
		.endif

		.if	.defined(VS_SMB)
			player_select	= <((nmi_system_enter_player_select-nmi_system_enter_tbl)/WORD_SIZE)
		.endif

		game		= <((nmi_system_enter_game-nmi_system_enter_tbl)/WORD_SIZE)
		castle_victory	= <((nmi_system_enter_castle_victory-nmi_system_enter_tbl)/WORD_SIZE)
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
			vs_init	= <((game_mode_vs_init-game_mode_tbl)/WORD_SIZE)
		.elseif	.defined(SMBV2)
			init_data2	= <((game_mode_init_data2-game_mode_tbl)/WORD_SIZE)
		.endif

		init_0	= <((game_mode_init_0-game_mode_tbl)/WORD_SIZE)

		.if	.defined(ANN)
			toad_load	= <((game_mode_toad_load-game_mode_tbl)/WORD_SIZE)
		.endif

		scr	= <((game_mode_scr-game_mode_tbl)/WORD_SIZE)
		init_1	= <((game_mode_init_1-game_mode_tbl)/WORD_SIZE)
		proc	= <((game_mode_proc-game_mode_tbl)/WORD_SIZE)

		.if	.defined(SMB)
		init	= init_0
		.elseif	.defined(VS_SMB)
		init	= vs_init
		.elseif	.defined(SMBV2)
		init	= init_data2
		.endif
	.endenum

	.enum	castle_victory_modes
		bowser		= <((victory_enter_bowser-victory_enter_tbl)/WORD_SIZE)
		init		= <((victory_enter_init-victory_enter_tbl)/WORD_SIZE)
		proc		= <((victory_enter_proc-victory_enter_tbl)/WORD_SIZE)
		msg		= <((victory_enter_msg-victory_enter_tbl)/WORD_SIZE)

		.if	.defined(SMBV2)|.defined(VS_SMB)
			time_tally		= <((victory_enter_time_tally-victory_enter_tbl)/WORD_SIZE)
		.endif

		finish		= <((victory_enter_finish-victory_enter_tbl)/WORD_SIZE)

		.if	.defined(VS_SMB)
			vs_84CF	= <((victory_enter_84CF-victory_enter_tbl)/WORD_SIZE)
			vs_8526 = <((victory_enter_8526-victory_enter_tbl)/WORD_SIZE)
			vs_85E0 = <((victory_enter_85E0-victory_enter_tbl)/WORD_SIZE)
			vs_864C = <((victory_enter_864C-victory_enter_tbl)/WORD_SIZE)
			vs_865D = <((victory_enter_865D-victory_enter_tbl)/WORD_SIZE)
		.endif
	.endenum

	.if	.defined(SMBV2)
		.enum	castle_victory_modes_course_08
			bowser		= <((victory_course_08_bowser-victory_course_08_tbl)/WORD_SIZE)
			init		= <((victory_course_08_init-victory_course_08_tbl)/WORD_SIZE)
			proc		= <((victory_course_08_proc-victory_course_08_tbl)/WORD_SIZE)
			disk_init	= <((victory_course_08_disk_init-victory_course_08_tbl)/WORD_SIZE)
			disk_check	= <((victory_course_08_disk_check-victory_course_08_tbl)/WORD_SIZE)
			disk_data3	= <((victory_course_08_disk_data3-victory_course_08_tbl)/WORD_SIZE)
			scr		= <((victory_course_08_scr-victory_course_08_tbl)/WORD_SIZE)
			msg		= <((victory_course_08_msg-victory_course_08_tbl)/WORD_SIZE)
			time_tally	= <((victory_course_08_time_tally-victory_course_08_tbl)/WORD_SIZE)
			extra_lives	= <((victory_course_08_extra_lives-victory_course_08_tbl)/WORD_SIZE)
			palcycle	= <((victory_course_08_palcycle-victory_course_08_tbl)/WORD_SIZE)
			lives_draw	= <((victory_course_08_lives_draw-victory_course_08_tbl)/WORD_SIZE)
			toad_proc	= <((victory_course_08_toad_proc-victory_course_08_tbl)/WORD_SIZE)
			disk_save	= <((victory_course_08_disk_save-victory_course_08_tbl)/WORD_SIZE)
		.endenum
	.endif

	.enum	game_over_modes
		init	= <((game_over_mode_init-game_over_mode_tbl)/WORD_SIZE)
		scr	= <((game_over_mode_scr-game_over_mode_tbl)/WORD_SIZE)

		.if	.defined(VS_SMB)
			vs_9902		= <((game_over_mode_9902-game_over_mode_tbl)/WORD_SIZE)
			vs_98DC		= <((game_over_mode_98DC-game_over_mode_tbl)/WORD_SIZE)
			vs_98F2		= <((game_over_mode_98F2-game_over_mode_tbl)/WORD_SIZE)
		.endif

		proc	= <((game_over_mode_proc-game_over_mode_tbl)/WORD_SIZE)
	.endenum

.endif	; MODES_I
