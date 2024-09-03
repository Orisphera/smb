.include	"engine/sound.i"

	.export	apu_music_super_star_vs_a_data
	.export	apu_music_super_star_vs_a_pulse_2
	.export	apu_music_super_star_vs_a_pulse_1
	.export	apu_music_super_star_vs_a_triangle
	.export	apu_music_super_star_vs_b_data
	.export	apu_music_super_star_vs_b_pulse_2
	.export	apu_music_super_star_vs_b_pulse_1
	.export	apu_music_super_star_vs_b_triangle
	.export	apu_music_super_star_vs_c_data
	.export	apu_music_super_star_vs_c_pulse_2
	.export	apu_music_super_star_vs_c_pulse_1
	.export	apu_music_super_star_vs_c_triangle
	.export	apu_music_super_star_vs_d_data
	.export	apu_music_super_star_vs_d_pulse_2
	.export	apu_music_super_star_vs_d_pulse_1
	.export	apu_music_super_star_vs_d_triangle
apu_music_super_star_vs_a_data:
apu_music_super_star_vs_a_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::E4
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::G3
		.byte	sound_notes::C4
	.byte	SND_TRACK_END

apu_music_super_star_vs_a_pulse_1:
	snd_cmp_byte	length_d::halfdot,	sound_notes::C5
	snd_cmp_byte	length_d::halfdot,	sound_notes::G4
	snd_cmp_byte	length_d::half,		sound_notes::E4
	snd_cmp_byte	length_d::half,		sound_notes::A4

apu_music_super_star_vs_b_data:
apu_music_super_star_vs_c_data:
apu_music_super_star_vs_b_pulse_2:
apu_music_super_star_vs_c_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::null
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::wholedot
		.byte	sound_notes::null
	.byte	SND_TRACK_END

apu_music_super_star_vs_b_pulse_1:
	snd_cmp_byte	length_d::wholedot,	sound_notes::Gx5_b
	snd_cmp_byte	length_d::twelfth,	sound_notes::null
	snd_cmp_byte	length_d::twelfth,	sound_notes::G4
	snd_cmp_byte	length_d::twelfth,	sound_notes::G4
	snd_cmp_byte	length_d::twelfth,	sound_notes::G4
	snd_cmp_byte	length_d::twelfth,	sound_notes::G4
	snd_cmp_byte	length_d::twelfth,	sound_notes::G4
	snd_cmp_byte	length_d::half,		sound_notes::G4
	snd_cmp_byte	length_d::twelfth,	sound_notes::null
	snd_cmp_byte	length_d::twelfth,	sound_notes::C4
	snd_cmp_byte	length_d::twelfth,	sound_notes::C4
	snd_cmp_byte	length_d::twelfth,	sound_notes::C4
	snd_cmp_byte	length_d::twelfth,	sound_notes::C4
	snd_cmp_byte	length_d::twelfth,	sound_notes::C4
	snd_cmp_byte	length_d::halfdot,	sound_notes::C4
	snd_cmp_byte	length_d::quarter,	sound_notes::G3
	snd_cmp_byte	length_d::half,		sound_notes::G3
	snd_cmp_byte	length_d::half,		sound_notes::E3

apu_music_super_star_vs_d_data:
apu_music_super_star_vs_d_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::D4
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::B3
		.byte	sound_notes::G3
	.byte	SND_TRACK_END

apu_music_super_star_vs_d_pulse_1:
	snd_cmp_byte	length_d::halfdot,	sound_notes::B4
	snd_cmp_byte	length_d::halfdot,	sound_notes::A4
	snd_cmp_byte	length_d::half,		sound_notes::G4
	snd_cmp_byte	length_d::half,		sound_notes::E4

apu_music_super_star_vs_c_pulse_1:
	snd_cmp_byte	length_d::wholedot,	sound_notes::Gx5_b
	snd_cmp_byte	length_d::half,		sound_notes::D7
	snd_cmp_byte	length_d::half,		sound_notes::D7
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx5_b
	snd_cmp_byte	length_d::half,		sound_notes::Gx5_b
	snd_cmp_byte	length_d::half,		sound_notes::D7
	snd_cmp_byte	length_d::quarter,	sound_notes::D7
	snd_cmp_byte	length_d::half,		sound_notes::D7
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx5_b
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx5_b

apu_music_super_star_vs_a_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::G4
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C4
		.byte	sound_notes::F4

apu_music_super_star_vs_b_triangle:
apu_music_super_star_vs_c_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::wholedot
		.byte	sound_notes::null
		.byte	sound_notes::null
		.byte	sound_notes::null

apu_music_super_star_vs_d_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::G4
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::E4
		.byte	sound_notes::C4
