.ifndef	SOUND_I
SOUND_I = 1

.include	"sys/apu.i"

	SND_TRACK_NOTE_LEN      = %10000000
	SND_CMP_LEN_MASK	= %11000001
	SND_CMP_NOTE_MASK	= %00111110
	SND_NOTE_LEN_MASK	= %00000111

	.macro	snd_cmp_byte	len, note
		.byte	<(note|(len<<6)|(len>>2))
	.endmacro

	.macro	snd_region_len	ntsc, pal
		.ifndef	PAL
			.byte	ntsc
		.else
			.byte	pal
		.endif
	.endmacro

	APU_COUNTER_OFFSET	= 0
	APU_TIMER_OFFSET	= 1

	APU_MUSIC_HURRY_UP_LEN	= <(apu_note_lengths_b-apu_note_lengths)

	SND_TRACK_END		= 0
	SND_PULSE_1_SWEEP	= 0

	SND_NOISE_NONE		= $04
	SND_NOISE_HI_SHORT	= $10
	SND_NOISE_LO_SHORT	= $20
	SND_NOISE_HI_LONG	= $30

	SND_NOISE_VOL		= 12
	SND_NOISE_HIGH		= (noise_period::F8)
	SND_NOISE_LOW		= (noise_period::A9)
	SND_NOISE_SHORT_COUNT	= 24
	SND_NOISE_LONG_COUNT	= 88

	SND_FDS_VOL_FULL	= %01000000

	SND_FDS_ENV_CTL_COUNTER	= 16

	SND_WAVE_SAMPLES_LEN	= 32

	.enum	sound_notes
		Gx5_b	=	<(apu_note_Gx5_b-apu_notes)
		D7	=	<(apu_note_D7-apu_notes)
		null	=	<(apu_note_null-apu_notes)
		E3	=	<(apu_note_E3-apu_notes)
		F3	=	<(apu_note_F3-apu_notes)
		Fx3	=	<(apu_note_Fx3-apu_notes)
		G3	=	<(apu_note_G3-apu_notes)
		Gx3	=	<(apu_note_Gx3-apu_notes)

		Ax3	=	<(apu_note_Ax3-apu_notes)
		B3	=	<(apu_note_B3-apu_notes)
		C4	=	<(apu_note_C4-apu_notes)
		Cx4	=	<(apu_note_Cx4-apu_notes)
		D4	=	<(apu_note_D4-apu_notes)
		Dx4	=	<(apu_note_Dx4-apu_notes)
		E4	=	<(apu_note_E4-apu_notes)
		F4	=	<(apu_note_F4-apu_notes)

		Fx4	=	<(apu_note_Fx4-apu_notes)
		G4	=	<(apu_note_G4-apu_notes)
		Gx4	=	<(apu_note_Gx4-apu_notes)
		A4	=	<(apu_note_A4-apu_notes)
		Ax4	=	<(apu_note_Ax4-apu_notes)
		B4	=	<(apu_note_B4-apu_notes)
		C5	=	<(apu_note_C5-apu_notes)
		Cx5	=	<(apu_note_Cx5-apu_notes)

		D5	=	<(apu_note_D5-apu_notes)
		Dx5	=	<(apu_note_Dx5-apu_notes)
		E5	=	<(apu_note_E5-apu_notes)
		F5	=	<(apu_note_F5-apu_notes)
		Fx5	=	<(apu_note_Fx5-apu_notes)
		G5	=	<(apu_note_G5-apu_notes)
		Gx5	=	<(apu_note_Gx5-apu_notes)
		Ax5	=	<(apu_note_Ax5-apu_notes)

		A5	=	<(apu_note_A5-apu_notes)
		B5	=	<(apu_note_B5-apu_notes)
		E6	=	<(apu_note_E6-apu_notes)
		Cx6	=	<(apu_note_Cx6-apu_notes)
		D6	=	<(apu_note_D6-apu_notes)
		Dx6	=	<(apu_note_Dx6-apu_notes)
		F6	=	<(apu_note_F6-apu_notes)
		G6	=	<(apu_note_G6-apu_notes)

		Gx6	=	<(apu_note_Gx6-apu_notes)
		Ax6	=	<(apu_note_Ax6-apu_notes)
		C7	=	<(apu_note_C7-apu_notes)
		E7	=	<(apu_note_E7-apu_notes)
		G7	=	<(apu_note_G7-apu_notes)
		G2	=	<(apu_note_G2-apu_notes)
		C3	=	<(apu_note_C3-apu_notes)
		D3	=	<(apu_note_D3-apu_notes)

		Dx3	=	<(apu_note_Dx3-apu_notes)
		A3	=	<(apu_note_A3-apu_notes)
		C6	=	<(apu_note_C6-apu_notes)
	.endenum

	.if	.defined(SMBV2)
		.enum	sound_fds_notes
			note_00	= <(apu_fds_wave_note_00-apu_fds_wave_notes)
			note_01	= <(apu_fds_wave_note_01-apu_fds_wave_notes)
			note_02	= <(apu_fds_wave_note_02-apu_fds_wave_notes)
			note_03	= <(apu_fds_wave_note_03-apu_fds_wave_notes)
			note_04	= <(apu_fds_wave_note_04-apu_fds_wave_notes)
			note_05	= <(apu_fds_wave_note_05-apu_fds_wave_notes)
			note_06	= <(apu_fds_wave_note_06-apu_fds_wave_notes)
			note_07	= <(apu_fds_wave_note_07-apu_fds_wave_notes)

			note_08	= <(apu_fds_wave_note_08-apu_fds_wave_notes)
			note_09	= <(apu_fds_wave_note_09-apu_fds_wave_notes)
			note_10	= <(apu_fds_wave_note_10-apu_fds_wave_notes)
			note_11	= <(apu_fds_wave_note_11-apu_fds_wave_notes)
			note_12	= <(apu_fds_wave_note_12-apu_fds_wave_notes)
			note_13	= <(apu_fds_wave_note_13-apu_fds_wave_notes)
			note_14	= <(apu_fds_wave_note_14-apu_fds_wave_notes)
			note_15	= <(apu_fds_wave_note_15-apu_fds_wave_notes)

			note_16	= <(apu_fds_wave_note_16-apu_fds_wave_notes)
			note_17	= <(apu_fds_wave_note_17-apu_fds_wave_notes)
			note_18	= <(apu_fds_wave_note_18-apu_fds_wave_notes)
			note_19	= <(apu_fds_wave_note_19-apu_fds_wave_notes)
			note_20	= <(apu_fds_wave_note_20-apu_fds_wave_notes)
			note_21	= <(apu_fds_wave_note_21-apu_fds_wave_notes)
			note_22	= <(apu_fds_wave_note_22-apu_fds_wave_notes)
			note_23	= <(apu_fds_wave_note_23-apu_fds_wave_notes)

			note_24	= <(apu_fds_wave_note_24-apu_fds_wave_notes)
			note_25	= <(apu_fds_wave_note_25-apu_fds_wave_notes)
			note_26	= <(apu_fds_wave_note_26-apu_fds_wave_notes)
			note_27	= <(apu_fds_wave_note_27-apu_fds_wave_notes)
			note_28	= <(apu_fds_wave_note_28-apu_fds_wave_notes)
			note_29	= <(apu_fds_wave_note_29-apu_fds_wave_notes)
		.endenum
	.endif

	.enum	length_a
		sixteenth	= <(apu_note_length_a_sixteenth-apu_note_lengths_a)
		eighth		= <(apu_note_length_a_eighth-apu_note_lengths_a)
		quarter		= <(apu_note_length_a_quarter-apu_note_lengths_a)
		half		= <(apu_note_length_a_half-apu_note_lengths_a)
		whole		= <(apu_note_length_a_whole-apu_note_lengths_a)
		quarterdot	= <(apu_note_length_a_quarterdot-apu_note_lengths_a)
		halfdot		= <(apu_note_length_a_halfdot-apu_note_lengths_a)
		fortieth	= <(apu_note_length_a_fortieth-apu_note_lengths_a)
	.endenum

	.enum	length_b
		sixteenth	= <(apu_note_length_b_sixteenth-apu_note_lengths_b)
		eighth		= <(apu_note_length_b_eighth-apu_note_lengths_b)
		quarter		= <(apu_note_length_b_quarter-apu_note_lengths_b)
		half		= <(apu_note_length_b_half-apu_note_lengths_b)
		whole		= <(apu_note_length_b_whole-apu_note_lengths_b)
		quarterdot	= <(apu_note_length_b_quarterdot-apu_note_lengths_b)
		halfdot		= <(apu_note_length_b_halfdot-apu_note_lengths_b)
		eighthdot	= <(apu_note_length_b_eighthdot-apu_note_lengths_b)
	.endenum

	.enum	length_c
		sixteenth	= <(apu_note_length_c_sixteenth-apu_note_lengths_c)
		eighth		= <(apu_note_length_c_eighth-apu_note_lengths_c)
		quarter		= <(apu_note_length_c_quarter-apu_note_lengths_c)
		half		= <(apu_note_length_c_half-apu_note_lengths_c)
		whole		= <(apu_note_length_c_whole-apu_note_lengths_c)
		quarterdot	= <(apu_note_length_c_quarterdot-apu_note_lengths_c)
		halfdot		= <(apu_note_length_c_halfdot-apu_note_lengths_c)
		eighthdot	= <(apu_note_length_c_eighthdot-apu_note_lengths_c)
	.endenum

	.if	.defined(VS)
		.enum	length_vs
			whole		= <(apu_note_length_vs_whole-apu_note_lengths_vs)
			ninth_double	= <(apu_note_length_vs_ninth_double-apu_note_lengths_vs)
			ninthdot	= <(apu_note_length_vs_ninthdot-apu_note_lengths_vs)
			ninth		= <(apu_note_length_vs_ninth-apu_note_lengths_vs)
			third		= <(apu_note_length_vs_third-apu_note_lengths_vs)
			half		= <(apu_note_length_vs_half-apu_note_lengths_vs)
			third_double	= <(apu_note_length_vs_third_double-apu_note_lengths_vs)
			ninth_double_b	= <(apu_note_length_vs_ninth_double_b-apu_note_lengths_vs)
		.endenum
	.endif

	.enum	length_d
		wholedot	= <(apu_note_length_d_wholedot-apu_note_lengths_d)
		twelfth		= <(apu_note_length_d_twelfth-apu_note_lengths_d)
		quarter		= <(apu_note_length_d_quarter-apu_note_lengths_d)
		sixth		= <(apu_note_length_d_sixth-apu_note_lengths_d)
		half		= <(apu_note_length_d_half-apu_note_lengths_d)
		halfdot		= <(apu_note_length_d_halfdot-apu_note_lengths_d)
		whole		= <(apu_note_length_d_whole-apu_note_lengths_d)
		third		= <(apu_note_length_d_third-apu_note_lengths_d)
	.endenum

	.enum	length_e
		wholedot	= <(apu_note_length_e_wholedot-apu_note_lengths_e)
		twelfth		= <(apu_note_length_e_twelfth-apu_note_lengths_e)
		quarter		= <(apu_note_length_e_quarter-apu_note_lengths_e)
		sixth		= <(apu_note_length_e_sixth-apu_note_lengths_e)
		half		= <(apu_note_length_e_half-apu_note_lengths_e)
		halfdot		= <(apu_note_length_e_halfdot-apu_note_lengths_e)
		whole		= <(apu_note_length_e_whole-apu_note_lengths_e)
		third		= <(apu_note_length_e_third-apu_note_lengths_e)
	.endenum

	.enum	length_f
		wholedot	= <(apu_note_length_f_wholedot-apu_note_lengths_f)
		twelfth		= <(apu_note_length_f_twelfth-apu_note_lengths_f)
		quarter		= <(apu_note_length_f_quarter-apu_note_lengths_f)
		sixth		= <(apu_note_length_f_sixth-apu_note_lengths_f)
		half		= <(apu_note_length_f_half-apu_note_lengths_f)
		halfdot		= <(apu_note_length_f_halfdot-apu_note_lengths_f)
		whole		= <(apu_note_length_f_whole-apu_note_lengths_f)
		third		= <(apu_note_length_f_third-apu_note_lengths_f)
	.endenum

	.if	.defined(SMBV2)
		.enum	length_fds_a
			thirddot	= <(apu_fds_note_length_a_thirddot-apu_fds_note_lengths_a)
			ninth_double	= <(apu_fds_note_length_a_ninth_double-apu_fds_note_lengths_a)
			ninthdot	= <(apu_fds_note_length_a_ninthdot-apu_fds_note_lengths_a)
			ninth		= <(apu_fds_note_length_a_ninth-apu_fds_note_lengths_a)
			third		= <(apu_fds_note_length_a_third-apu_fds_note_lengths_a)
			half		= <(apu_fds_note_length_a_half-apu_fds_note_lengths_a)
			third_double	= <(apu_fds_note_length_a_third_double-apu_fds_note_lengths_a)
			ninth_double_b	= <(apu_fds_note_length_a_ninth_double_b-apu_fds_note_lengths_a)
		.endenum

		.enum	length_fds_b
			thirddot	= <(apu_fds_note_length_b_thirddot-apu_fds_note_lengths_b)
			ninth_double	= <(apu_fds_note_length_b_ninth_double-apu_fds_note_lengths_b)
			ninthdot	= <(apu_fds_note_length_b_ninthdot-apu_fds_note_lengths_b)
			ninth		= <(apu_fds_note_length_b_ninth-apu_fds_note_lengths_b)
			third		= <(apu_fds_note_length_b_third-apu_fds_note_lengths_b)
			half		= <(apu_fds_note_length_b_half-apu_fds_note_lengths_b)
			third_double	= <(apu_fds_note_length_b_third_double-apu_fds_note_lengths_b)
			whole_third	= <(apu_fds_note_length_b_whole_third-apu_fds_note_lengths_b)
		.endenum
	.endif

	.enum	sfx_noise
		null		= 0
		block_break_01	= 1
		flame		= 2

		.if	.defined(SMB2)
		wind		= 4
		.endif

		.if	.defined(SMBV2)
		skid		= 128
		.endif
	.endenum

	.enum	sfx_pulse_1
		none		= 0
		jump_big	= 1
		bump		= 2
		stomp		= 4
		smack		= 8
		pipe_entry_16	= 16
		proj		= 32
		pole		= 64
		jump_small	= 128
	.endenum

	.enum	sfx_pulse_2
		none		= 0
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
		null		= 0
		death		= 1
		game_over	= 2
		victory_ending	= 4
		victory_castle	= 8
		game_over_alt	= 16
		level_end	= 32
		hurry_up	= 64
		none		= 128
	.endenum

	.enum	music_base
		null		= 0
		overworld	= 1
		underwater	= 2
		underground	= 4
		castle		= 8
		clouds		= 16
		pipe_intro	= 32
		super_star	= 64
		none		= 128
	.endenum

	.if	.defined(SMBV2)
		.enum	music_fds
			null		= 0
			ending		= 1
		.endenum
	.endif

.endif
