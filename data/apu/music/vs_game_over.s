.include	"sound.i"

	.export	apu_music_game_over_vs_data
	.export	apu_music_game_over_vs_pulse_2
	.export	apu_music_game_over_vs_pulse_1
	.export	apu_music_game_over_vs_triangle
apu_music_game_over_vs_data:
apu_music_game_over_vs_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninth_double
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninth
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_vs::third_double
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_vs::half
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninthdot
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_vs::third
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninth
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninth
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninth
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_vs::third
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninth_double
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninth
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_vs::third_double
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_vs::half
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_vs::ninthdot
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_vs::third_double
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_vs::third
		.byte	sound_notes::F4
	.byte	SND_TRACK_END

apu_music_game_over_vs_pulse_1:
	snd_cmp_byte	length_vs::ninth_double, sound_notes::E5
	snd_cmp_byte	length_vs::ninth,	sound_notes::E5
	snd_cmp_byte	length_vs::third_double, sound_notes::E5
	snd_cmp_byte	length_vs::half,	sound_notes::B4
	snd_cmp_byte	length_vs::ninthdot,	sound_notes::D5
	snd_cmp_byte	length_vs::third,	sound_notes::D5
	snd_cmp_byte	length_vs::ninth,	sound_notes::null
	snd_cmp_byte	length_vs::ninth,	sound_notes::C5
	snd_cmp_byte	length_vs::ninth,	sound_notes::B4
	snd_cmp_byte	length_vs::third,	sound_notes::C5
	snd_cmp_byte	length_vs::ninth_double, sound_notes::F5
	snd_cmp_byte	length_vs::ninth,	sound_notes::F5
	snd_cmp_byte	length_vs::third_double, sound_notes::F5
	snd_cmp_byte	length_vs::half,	sound_notes::C5
	snd_cmp_byte	length_vs::ninthdot,	sound_notes::D5
	snd_cmp_byte	length_vs::third_double, sound_notes::E5
	snd_cmp_byte	length_vs::third,	sound_notes::D5

apu_music_game_over_vs_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_vs::third
		.byte	sound_notes::B3
		.byte	sound_notes::E4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Gx4
		.byte	sound_notes::B4
		.byte	sound_notes::A4
		.byte	sound_notes::Gx4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::F4
		.byte	sound_notes::G4
		.byte	sound_notes::Gx4
		.byte	sound_notes::F4
		.byte	sound_notes::G4
		.byte	sound_notes::G3
		.byte	sound_notes::F4
; ------------------------------------------------------------
	.res	2,	$FF
