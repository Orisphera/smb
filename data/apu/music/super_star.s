.include	"sound.i"

	.export	apu_music_super_star_data
	.export	apu_music_super_star_pulse_2
	.export	apu_music_super_star_pulse_1
	.export	apu_music_super_star_triangle
	.export	apu_music_super_star_noise
apu_music_super_star_data:
apu_music_super_star_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_f::half
		.byte	sound_notes::C5
		.byte	sound_notes::C5
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_f::quarter
		.byte	sound_notes::null
		.byte	sound_notes::C5
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_f::halfdot
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_f::half
		.byte	sound_notes::C5
		.byte	sound_notes::C5
		.byte	sound_notes::B4
		.byte	sound_notes::B4
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_f::quarter
		.byte	sound_notes::null
		.byte	sound_notes::B4
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_f::halfdot
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_f::half
		.byte	sound_notes::B4
		.byte	sound_notes::B4
	.byte	SND_TRACK_END

apu_music_super_star_pulse_1:
	snd_cmp_byte	length_f::half,		sound_notes::F4
	snd_cmp_byte	length_f::half,		sound_notes::F4
	snd_cmp_byte	length_f::half,		sound_notes::F4
	snd_cmp_byte	length_f::quarter,	sound_notes::D4
	snd_cmp_byte	length_f::half,		sound_notes::F4
	snd_cmp_byte	length_f::half,		sound_notes::F4
	snd_cmp_byte	length_f::quarter,	sound_notes::D4
	snd_cmp_byte	length_f::quarter,	sound_notes::F4
	snd_cmp_byte	length_f::quarter,	sound_notes::D4
	snd_cmp_byte	length_f::half,		sound_notes::F4
	snd_cmp_byte	length_f::half,		sound_notes::E4
	snd_cmp_byte	length_f::half,		sound_notes::E4
	snd_cmp_byte	length_f::half,		sound_notes::E4
	snd_cmp_byte	length_f::quarter,	sound_notes::C4
	snd_cmp_byte	length_f::half,		sound_notes::E4
	snd_cmp_byte	length_f::half,		sound_notes::E4
	snd_cmp_byte	length_f::quarter,	sound_notes::C4
	snd_cmp_byte	length_f::quarter,	sound_notes::E4
	snd_cmp_byte	length_f::quarter,	sound_notes::C4
	snd_cmp_byte	length_f::half,		sound_notes::E4

apu_music_super_star_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_f::whole
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_f::halfdot
		.byte	sound_notes::A4
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_f::half
		.byte	sound_notes::null
		.byte	sound_notes::A4
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_f::whole
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_f::halfdot
		.byte	sound_notes::G4
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_f::half
		.byte	sound_notes::null
		.byte	sound_notes::G4
		.byte	sound_notes::C5
      
apu_music_super_star_noise:
	snd_cmp_byte	length_f::half,		SND_NOISE_LO_SHORT
	snd_cmp_byte	length_f::sixth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_f::sixth,	SND_NOISE_NONE
	snd_cmp_byte	length_f::sixth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_f::half,		SND_NOISE_HI_LONG
	snd_cmp_byte	length_f::sixth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_f::sixth,	SND_NOISE_NONE
	snd_cmp_byte	length_f::sixth,	SND_NOISE_HI_SHORT
	.byte	SND_TRACK_END
