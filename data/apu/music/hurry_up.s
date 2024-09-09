.include	"sound.i"

	.export	apu_music_hurry_up_data
	.export	apu_music_hurry_up_pulse_2
	.export	apu_music_hurry_up_pulse_1
	.export	apu_music_hurry_up_triangle
apu_music_hurry_up_data:
apu_music_hurry_up_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::E4
		.byte	sound_notes::D5
		.byte	sound_notes::null
		.byte	sound_notes::D5
		.byte	sound_notes::D5
		.byte	sound_notes::null
		.byte	sound_notes::F4
		.byte	sound_notes::Dx5
		.byte	sound_notes::null
		.byte	sound_notes::Dx5
		.byte	sound_notes::Dx5
		.byte	sound_notes::null
		.byte	sound_notes::Fx4
		.byte	sound_notes::E5
		.byte	sound_notes::null
		.byte	sound_notes::E5
		.byte	sound_notes::E5
		.byte	sound_notes::null
		.byte	sound_notes::F5
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::whole
		.byte	sound_notes::F5
	.byte	SND_TRACK_END

apu_music_hurry_up_pulse_1:
	snd_cmp_byte	length_b::eighth,	sound_notes::E3
	snd_cmp_byte	length_b::quarter,	sound_notes::Gx4
	snd_cmp_byte	length_b::eighth,	sound_notes::Gx4
	snd_cmp_byte	length_b::quarter,	sound_notes::Gx4
	snd_cmp_byte	length_b::eighth,	sound_notes::F3
	snd_cmp_byte	length_b::quarter,	sound_notes::A4
	snd_cmp_byte	length_b::eighth,	sound_notes::A4
	snd_cmp_byte	length_b::quarter,	sound_notes::A4
	snd_cmp_byte	length_b::eighth,	sound_notes::Fx3
	snd_cmp_byte	length_b::quarter,	sound_notes::Ax4
	snd_cmp_byte	length_b::eighth,	sound_notes::Ax4
	snd_cmp_byte	length_b::quarter,	sound_notes::Ax4
	snd_cmp_byte	length_b::eighth,	sound_notes::B4
	snd_cmp_byte	length_b::eighth,	sound_notes::null
	snd_cmp_byte	length_b::whole,	sound_notes::B4

apu_music_hurry_up_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::B4
		.byte	sound_notes::B5
		.byte	sound_notes::null
		.byte	sound_notes::B5
		.byte	sound_notes::B5
		.byte	sound_notes::null
		.byte	sound_notes::C5
		.byte	sound_notes::C6
		.byte	sound_notes::null
		.byte	sound_notes::C6
		.byte	sound_notes::C6
		.byte	sound_notes::null
		.byte	sound_notes::Cx5
		.byte	sound_notes::Cx6
		.byte	sound_notes::null
		.byte	sound_notes::Cx6
		.byte	sound_notes::Cx6
		.byte	sound_notes::null
		.byte	sound_notes::G4
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::whole
		.byte	sound_notes::G4
