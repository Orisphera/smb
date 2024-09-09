.include	"sound.i"

	.export	apu_music_game_over_data
	.export	apu_music_game_over_pulse_2
	.export	apu_music_game_over_pulse_1
	.export	apu_music_game_over_triangle
apu_music_game_over_data:
apu_music_game_over_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::null
		.byte	sound_notes::G4
		.byte	sound_notes::null
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_d::third
		.byte	sound_notes::A4
		.byte	sound_notes::B4
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::Gx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_d::wholedot
		.byte	sound_notes::G4
	.byte	SND_TRACK_END

apu_music_game_over_pulse_1:
	snd_cmp_byte	length_d::quarter,	sound_notes::E4
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::quarter,	sound_notes::C4
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::half,		sound_notes::G3
	snd_cmp_byte	length_d::whole,	sound_notes::F4
	snd_cmp_byte	length_d::wholedot,	sound_notes::F4
	snd_cmp_byte	length_d::quarter,	sound_notes::E4
	snd_cmp_byte	length_d::quarter,	sound_notes::D4
	snd_cmp_byte	length_d::whole,	sound_notes::E4

apu_music_game_over_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::G4
		.byte	sound_notes::null
		.byte	sound_notes::null
		.byte	sound_notes::E4
		.byte	sound_notes::null
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_d::wholedot
		.byte	sound_notes::Cx4
	.byte	SND_TRACK_NOTE_LEN|length_d::wholedot
		.byte	sound_notes::C4
