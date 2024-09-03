.include	"engine/sound.i"

	.export	apu_music_victory_castle_data
	.export	apu_music_victory_castle_pulse_2
	.export	apu_music_victory_castle_pulse_1
	.export	apu_music_victory_castle_triangle
apu_music_victory_castle_data:
apu_music_victory_castle_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::C5
		.byte	sound_notes::G4
		.byte	sound_notes::E4
		.byte	sound_notes::C5
		.byte	sound_notes::G4
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_b::quarterdot
		.byte	sound_notes::C5
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::Cx5
		.byte	sound_notes::Gx4
		.byte	sound_notes::F4
		.byte	sound_notes::Cx5
		.byte	sound_notes::Gx4
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_b::quarterdot
		.byte	sound_notes::Cx5
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::Dx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::Dx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_b::quarterdot
		.byte	sound_notes::Dx5
	.byte	SND_TRACK_NOTE_LEN|length_b::eighthdot
		.byte	sound_notes::F5
		.byte	sound_notes::F5
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_b::whole
		.byte	sound_notes::G5
	.byte	SND_TRACK_END

apu_music_victory_castle_pulse_1:
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::C4
	snd_cmp_byte	length_b::eighth,	sound_notes::G3
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::C4
	snd_cmp_byte	length_b::eighth,	sound_notes::G3
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::sixteenth,	sound_notes::E4
	snd_cmp_byte	length_b::sixteenth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::E4
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::eighth,	sound_notes::Cx4
	snd_cmp_byte	length_b::eighth,	sound_notes::Gx3
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::eighth,	sound_notes::Cx4
	snd_cmp_byte	length_b::eighth,	sound_notes::Gx3
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::sixteenth,	sound_notes::F4
	snd_cmp_byte	length_b::sixteenth,	sound_notes::F4
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::eighth,	sound_notes::F4
	snd_cmp_byte	length_b::eighth,	sound_notes::G4
	snd_cmp_byte	length_b::eighth,	sound_notes::Dx4
	snd_cmp_byte	length_b::eighth,	sound_notes::Ax3
	snd_cmp_byte	length_b::eighth,	sound_notes::G4
	snd_cmp_byte	length_b::eighth,	sound_notes::Dx4
	snd_cmp_byte	length_b::eighth,	sound_notes::Ax3
	snd_cmp_byte	length_b::eighth,	sound_notes::G4
	snd_cmp_byte	length_b::sixteenth,	sound_notes::G4
	snd_cmp_byte	length_b::sixteenth,	sound_notes::G4
	snd_cmp_byte	length_b::eighth,	sound_notes::G4
	snd_cmp_byte	length_b::eighthdot,	sound_notes::A4
	snd_cmp_byte	length_b::eighthdot,	sound_notes::A4
	snd_cmp_byte	length_b::eighthdot,	sound_notes::A4
	snd_cmp_byte	length_b::whole,	sound_notes::B4

apu_music_victory_castle_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_b::sixteenth
		.byte	sound_notes::C4
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::C4
		.byte	sound_notes::C4
		.byte	sound_notes::C4
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_b::halfdot
		.byte	sound_notes::Cx4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::Cx4
	.byte	SND_TRACK_NOTE_LEN|length_b::sixteenth
		.byte	sound_notes::Cx4
		.byte	sound_notes::Cx4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::Cx4
		.byte	sound_notes::Cx4
		.byte	sound_notes::Cx4
		.byte	sound_notes::Cx4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::Dx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::Dx4
		.byte	sound_notes::Ax4
	.byte	SND_TRACK_NOTE_LEN|length_b::sixteenth
		.byte	sound_notes::Ax4
		.byte	sound_notes::Ax4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighth
		.byte	sound_notes::Ax4
	.byte	SND_TRACK_NOTE_LEN|length_b::eighthdot
		.byte	sound_notes::C5
		.byte	sound_notes::C5
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_b::whole
		.byte	sound_notes::D5
