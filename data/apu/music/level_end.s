.include	"sound.i"

	.export	apu_music_level_end_data
	.export	apu_music_level_end_pulse_2
	.export	apu_music_level_end_pulse_1
	.export	apu_music_level_end_triangle
	.export	apu_music_unk_data
	.export	apu_music_unk_pulse_2
	.export	apu_music_unk_pulse_1
	.export	apu_music_unk_triangle
apu_music_level_end_data:
apu_music_level_end_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_e::third
		.byte	sound_notes::null
		.byte	sound_notes::E3
		.byte	sound_notes::G3
		.byte	sound_notes::C4
		.byte	sound_notes::E4
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::C5
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_e::third
		.byte	sound_notes::null
		.byte	sound_notes::Dx3
		.byte	sound_notes::Gx3
		.byte	sound_notes::C4
		.byte	sound_notes::Dx4
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::C5
		.byte	sound_notes::Gx4

apu_music_unk_data:
apu_music_unk_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_e::third
		.byte	sound_notes::null
		.byte	sound_notes::F3
		.byte	sound_notes::Ax3
		.byte	sound_notes::D4
		.byte	sound_notes::F4
		.byte	sound_notes::Ax4
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::D5
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_e::wholedot
		.byte	sound_notes::C6
	.byte	SND_TRACK_END

apu_music_level_end_pulse_1:
	snd_cmp_byte	length_e::third,	sound_notes::G3
	snd_cmp_byte	length_e::third,	sound_notes::C4
	snd_cmp_byte	length_e::third,	sound_notes::E4
	snd_cmp_byte	length_e::third,	sound_notes::G4
	snd_cmp_byte	length_e::third,	sound_notes::C5
	snd_cmp_byte	length_e::third,	sound_notes::E5
	snd_cmp_byte	length_e::whole,	sound_notes::G5
	snd_cmp_byte	length_e::whole,	sound_notes::E5
	snd_cmp_byte	length_e::third,	sound_notes::Gx3
	snd_cmp_byte	length_e::third,	sound_notes::C4
	snd_cmp_byte	length_e::third,	sound_notes::Dx4
	snd_cmp_byte	length_e::third,	sound_notes::Gx4
	snd_cmp_byte	length_e::third,	sound_notes::C5
	snd_cmp_byte	length_e::third,	sound_notes::Dx5
	snd_cmp_byte	length_e::whole,	sound_notes::Gx5
	snd_cmp_byte	length_e::whole,	sound_notes::Dx5

apu_music_unk_pulse_1:
	snd_cmp_byte	length_e::third,	sound_notes::Ax3
	snd_cmp_byte	length_e::third,	sound_notes::D4
	snd_cmp_byte	length_e::third,	sound_notes::F4
	snd_cmp_byte	length_e::third,	sound_notes::Ax4
	snd_cmp_byte	length_e::third,	sound_notes::D5
	snd_cmp_byte	length_e::third,	sound_notes::F5
	snd_cmp_byte	length_e::whole,	sound_notes::Ax5
	snd_cmp_byte	length_e::third,	sound_notes::Ax5
	snd_cmp_byte	length_e::third,	sound_notes::Ax5
	snd_cmp_byte	length_e::third,	sound_notes::Ax5
	snd_cmp_byte	length_e::wholedot,	sound_notes::E5
	.byte	SND_PULSE_1_SWEEP

apu_music_level_end_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_e::third
		.byte	sound_notes::C4
		.byte	sound_notes::E4
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_e::half
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::null
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_e::third
		.byte	sound_notes::C4
		.byte	sound_notes::Dx4
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::Dx5
	.byte	SND_TRACK_NOTE_LEN|length_e::half
		.byte	sound_notes::C5
		.byte	sound_notes::null

apu_music_unk_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_e::third
		.byte	sound_notes::D4
		.byte	sound_notes::F4
		.byte	sound_notes::Ax4
	.byte	SND_TRACK_NOTE_LEN|length_e::whole
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_e::third
		.byte	sound_notes::D5
		.byte	sound_notes::D5
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_e::wholedot
		.byte	sound_notes::C5
