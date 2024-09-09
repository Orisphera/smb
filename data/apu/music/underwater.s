.include	"sound.i"

	.export	apu_music_underwater_data
	.export	apu_music_underwater_pulse_2
	.export	apu_music_underwater_pulse_1
	.export	apu_music_underwater_triangle
	.export	apu_music_underwater_noise
apu_music_underwater_data:
apu_music_underwater_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::D4
		.byte	sound_notes::E4
		.byte	sound_notes::Fx4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::Ax4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::B4
		.byte	sound_notes::B4
		.byte	sound_notes::B4
		.byte	sound_notes::null
		.byte	sound_notes::B4
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::half
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::E5
		.byte	sound_notes::Dx5
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::null
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::B4
		.byte	sound_notes::C5
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_b::half
		.byte	sound_notes::Dx5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_b::whole
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarterdot
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::D5
		.byte	sound_notes::Cx5
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::null
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::B4
		.byte	sound_notes::C5
		.byte	sound_notes::Cx5
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_b::half
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_b::whole
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarterdot
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::G5
		.byte	sound_notes::G5
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::A5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::G5
	.byte 	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::F5
		.byte	sound_notes::F5
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::A4
		.byte	sound_notes::B4
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::E5
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_b::quarterdot
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::C5
	.byte	SND_TRACK_END

apu_music_underwater_noise:
	snd_cmp_byte	length_b::quarter,	SND_NOISE_NONE
	snd_cmp_byte	length_b::quarter,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_b::quarter,	SND_NOISE_HI_LONG
	snd_cmp_byte	length_b::quarter,	SND_NOISE_NONE
	snd_cmp_byte	length_b::eighth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_b::eighth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_b::quarter,	SND_NOISE_HI_LONG
	.byte	SND_TRACK_END

apu_music_underwater_pulse_1:
	snd_cmp_byte	length_b::quarter,	sound_notes::D4
	snd_cmp_byte	length_b::quarter,	sound_notes::Cx4
	snd_cmp_byte	length_b::quarter,	sound_notes::C4
	snd_cmp_byte	length_b::quarter,	sound_notes::B3
	snd_cmp_byte	length_b::quarter,	sound_notes::C4
	snd_cmp_byte	length_b::quarter,	sound_notes::Cx4
	snd_cmp_byte	length_b::eighth,	sound_notes::D4
	snd_cmp_byte	length_b::eighth,	sound_notes::D4
	snd_cmp_byte	length_b::eighth,	sound_notes::D4
	snd_cmp_byte	length_b::eighth,	sound_notes::null
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::null
	snd_cmp_byte	length_b::halfdot,	sound_notes::F4
	snd_cmp_byte	length_b::halfdot,	sound_notes::G4
	snd_cmp_byte	length_b::halfdot,	sound_notes::Fx4
	snd_cmp_byte	length_b::halfdot,	sound_notes::G4
	snd_cmp_byte	length_b::halfdot,	sound_notes::null
	snd_cmp_byte	length_b::halfdot,	sound_notes::G4
	snd_cmp_byte	length_b::half,		sound_notes::Fx4
	snd_cmp_byte	length_b::quarter,	sound_notes::A4
	snd_cmp_byte	length_b::whole,	sound_notes::G4
	snd_cmp_byte	length_b::half,		sound_notes::null
	snd_cmp_byte	length_b::halfdot,	sound_notes::F4
	snd_cmp_byte	length_b::halfdot,	sound_notes::E4
	snd_cmp_byte	length_b::halfdot,	sound_notes::F4
	snd_cmp_byte	length_b::halfdot,	sound_notes::null
	snd_cmp_byte	length_b::halfdot,	sound_notes::F4
	snd_cmp_byte	length_b::half,		sound_notes::B3
	snd_cmp_byte	length_b::quarter,	sound_notes::A4
	snd_cmp_byte	length_b::whole,	sound_notes::G4
	snd_cmp_byte	length_b::half,		sound_notes::null
	snd_cmp_byte	length_b::halfdot,	sound_notes::E5
	snd_cmp_byte	length_b::halfdot,	sound_notes::D5
	snd_cmp_byte	length_b::halfdot,	sound_notes::Cx5
	snd_cmp_byte	length_b::halfdot,	sound_notes::null
	snd_cmp_byte	length_b::halfdot,	sound_notes::D5
	snd_cmp_byte	length_b::halfdot,	sound_notes::Cx5
	snd_cmp_byte	length_b::halfdot,	sound_notes::C5
	snd_cmp_byte	length_b::halfdot,	sound_notes::null
	snd_cmp_byte	length_b::halfdot,	sound_notes::C4
	snd_cmp_byte	length_b::quarter,	sound_notes::F4
	snd_cmp_byte	length_b::quarter,	sound_notes::G4
	snd_cmp_byte	length_b::quarter,	sound_notes::B4
	snd_cmp_byte	length_b::eighth,	sound_notes::B4
	snd_cmp_byte	length_b::eighth,	sound_notes::B4
	snd_cmp_byte	length_b::quarterdot,	sound_notes::B4
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::halfdot,	sound_notes::E4

apu_music_underwater_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_b::whole
		.byte	sound_notes::null
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::quarter
		.byte	sound_notes::C4
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::B3
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::C4
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::E4
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::C4
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::B3
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::C4
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::E4
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::D4
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::Cx4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::D4
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::B3
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::D4
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::B3
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::C4
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::G3
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::C4
		.byte	sound_notes::G4
		.byte	sound_notes::E5
		.byte	sound_notes::B3
		.byte	sound_notes::G4
		.byte	sound_notes::D5
		.byte	sound_notes::Ax3
		.byte	sound_notes::G4
		.byte	sound_notes::Cx5
		.byte	sound_notes::Cx4
		.byte	sound_notes::G4
		.byte	sound_notes::E5
		.byte	sound_notes::D4
		.byte	sound_notes::A4
		.byte	sound_notes::F5
		.byte	sound_notes::Cx4
		.byte	sound_notes::A4
		.byte	sound_notes::F5
		.byte	sound_notes::C4
		.byte	sound_notes::A4
		.byte	sound_notes::F5
		.byte	sound_notes::B3
		.byte	sound_notes::G4
		.byte	sound_notes::F5
		.byte	sound_notes::C3
		.byte	sound_notes::G4
		.byte	sound_notes::E5
		.byte	sound_notes::G3
		.byte	sound_notes::G4
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::F4
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_b::quarterdot
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::B3
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::C4
