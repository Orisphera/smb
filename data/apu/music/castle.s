.include	"sound.i"

	.export	apu_music_castle_data
	.export	apu_music_castle_pulse_2
	.export	apu_music_castle_pulse_1
	.export	apu_music_castle_triangle
apu_music_castle_data:
apu_music_castle_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_a::sixteenth
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::Gx4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::Gx4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Gx4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Gx4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Gx4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::Fx4
		.byte	sound_notes::A4
		.byte	sound_notes::Fx4
		.byte	sound_notes::Gx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::D5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Dx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::D5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Cx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::D5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Cx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::C5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Cx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::D5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Dx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::D5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Cx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::D5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Cx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::C5
		.byte	sound_notes::Ax4
		.byte	sound_notes::Cx5
	.byte	SND_TRACK_END

apu_music_castle_pulse_1:
	snd_cmp_byte	length_a::sixteenth,	sound_notes::null
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::C5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Dx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::C5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Dx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::C5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::C5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::C5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::D5
	snd_cmp_byte	length_a::eighth,	sound_notes::Cx5
	snd_cmp_byte	length_a::eighth,	sound_notes::C5
	snd_cmp_byte	length_a::eighth,	sound_notes::F5
	snd_cmp_byte	length_a::eighth,	sound_notes::Fx5
	snd_cmp_byte	length_a::eighth,	sound_notes::F5
	snd_cmp_byte	length_a::eighth,	sound_notes::E5
	snd_cmp_byte	length_a::eighth,	sound_notes::F5
	snd_cmp_byte	length_a::eighth,	sound_notes::E5
	snd_cmp_byte	length_a::eighth,	sound_notes::Dx5
	snd_cmp_byte	length_a::eighth,	sound_notes::E5
	snd_cmp_byte	length_a::eighth,	sound_notes::F5
	snd_cmp_byte	length_a::eighth,	sound_notes::Fx5
	snd_cmp_byte	length_a::eighth,	sound_notes::F5
	snd_cmp_byte	length_a::eighth,	sound_notes::E5
	snd_cmp_byte	length_a::eighth,	sound_notes::F5
	snd_cmp_byte	length_a::eighth,	sound_notes::E5
	snd_cmp_byte	length_a::eighth,	sound_notes::Dx5
	snd_cmp_byte	length_a::eighth,	sound_notes::E5

apu_music_castle_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_a::whole
		.byte	sound_notes::Dx4
	.byte	SND_TRACK_NOTE_LEN|length_a::half
		.byte	sound_notes::D4
		.byte	sound_notes::Fx4
	.byte	SND_TRACK_NOTE_LEN|length_a::whole
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_a::half
		.byte	sound_notes::E4
		.byte	sound_notes::Ax4
		.byte	sound_notes::A4
		.byte	sound_notes::E4
		.byte	sound_notes::Dx4
		.byte	sound_notes::E4
