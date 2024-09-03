.include	"engine/sound.i"

	.export apu_music_overworld_a_data
	.export	apu_music_overworld_a_pulse_2
	.export apu_music_overworld_a_pulse_1
	.export apu_music_overworld_a_triangle
	.export	apu_music_none_data
	.export	apu_music_none_triangle
apu_music_overworld_a_data:
apu_music_overworld_a_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::C5
		.byte	sound_notes::G4
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::A4
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::Ax4
		.byte	sound_notes::A4
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::third
		.byte	sound_notes::G4
		.byte	sound_notes::E5
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::A5
		.byte	sound_notes::null
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::G5
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::B4

apu_music_none_data:
apu_music_none_triangle:
	.byte	SND_TRACK_END

apu_music_overworld_a_pulse_1:
	snd_cmp_byte	length_d::halfdot,	sound_notes::E4
	snd_cmp_byte	length_d::halfdot,	sound_notes::C4
	snd_cmp_byte	length_d::halfdot,	sound_notes::G3
	snd_cmp_byte	length_d::half,		sound_notes::C4
	snd_cmp_byte	length_d::half,		sound_notes::D4
	snd_cmp_byte	length_d::quarter,	sound_notes::Cx4
	snd_cmp_byte	length_d::half,		sound_notes::C4
	snd_cmp_byte	length_d::third,	sound_notes::C4
	snd_cmp_byte	length_d::third,	sound_notes::G4
	snd_cmp_byte	length_d::third,	sound_notes::B4
	snd_cmp_byte	length_d::half,		sound_notes::C5
	snd_cmp_byte	length_d::quarter,	sound_notes::A4
	snd_cmp_byte	length_d::half,		sound_notes::B4
	snd_cmp_byte	length_d::half,		sound_notes::A4
	snd_cmp_byte	length_d::quarter,	sound_notes::E4
	snd_cmp_byte	length_d::quarter,	sound_notes::F4
	snd_cmp_byte	length_d::halfdot,	sound_notes::D4

apu_music_overworld_a_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::G4
		.byte	sound_notes::E4
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::F4
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::Fx4
		.byte	sound_notes::F4
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::third
		.byte	sound_notes::E4
		.byte	sound_notes::C5
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::F5
		.byte	sound_notes::null
		.byte	sound_notes::D5
		.byte	sound_notes::E5
		.byte	sound_notes::null
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::A4
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::G4
; --------------
	.export apu_music_overworld_b_a_data
	.export apu_music_overworld_b_a_pulse_2
	.export apu_music_overworld_b_a_pulse_1
	.export apu_music_overworld_b_a_triangle
apu_music_overworld_b_a_data:
apu_music_overworld_b_a_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::G5
		.byte	sound_notes::Fx5
		.byte	sound_notes::F5
		.byte	sound_notes::Dx5
		.byte	sound_notes::null
		.byte	sound_notes::E5
		.byte	sound_notes::null
		.byte	sound_notes::Gx4
		.byte	sound_notes::A4
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::A4
		.byte	sound_notes::C5
		.byte	sound_notes::D5
	.byte	SND_TRACK_END

apu_music_overworld_b_a_pulse_1:
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::quarter,	sound_notes::E5
	snd_cmp_byte	length_d::quarter,	sound_notes::Dx5
	snd_cmp_byte	length_d::quarter,	sound_notes::D5
	snd_cmp_byte	length_d::half,		sound_notes::B4
	snd_cmp_byte	length_d::quarter,	sound_notes::C5
	snd_cmp_byte	length_d::quarter,	sound_notes::null
	snd_cmp_byte	length_d::quarter,	sound_notes::E4
	snd_cmp_byte	length_d::quarter,	sound_notes::F4
	snd_cmp_byte	length_d::quarter,	sound_notes::G4
	snd_cmp_byte	length_d::quarter,	sound_notes::null
	snd_cmp_byte	length_d::quarter,	sound_notes::C4
	snd_cmp_byte	length_d::quarter,	sound_notes::E4
	snd_cmp_byte	length_d::quarter,	sound_notes::F4

apu_music_overworld_b_a_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::C4
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C5
		.byte	sound_notes::F4
; --------------
	.export	apu_music_overworld_b_b_data
	.export	apu_music_overworld_b_b_pulse_2
	.export apu_music_overworld_b_b_pulse_1
	.export apu_music_overworld_b_b_triangle
apu_music_overworld_b_b_data:
apu_music_overworld_b_b_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::G5
		.byte	sound_notes::Fx5
		.byte	sound_notes::F5
		.byte	sound_notes::Dx5
		.byte	sound_notes::null
		.byte	sound_notes::E5
		.byte	sound_notes::null
		.byte	sound_notes::C6
		.byte	sound_notes::null
		.byte	sound_notes::C6
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::C6
	.byte	SND_TRACK_END

apu_music_overworld_b_b_pulse_1:
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::quarter,	sound_notes::E5
	snd_cmp_byte	length_d::quarter,	sound_notes::Dx5
	snd_cmp_byte	length_d::quarter,	sound_notes::D5
	snd_cmp_byte	length_d::half,		sound_notes::B4
	snd_cmp_byte	length_d::quarter,	sound_notes::C5
	snd_cmp_byte	length_d::quarter,	sound_notes::null
	snd_cmp_byte	length_d::half,		sound_notes::F5
	snd_cmp_byte	length_d::quarter,	sound_notes::F5
	snd_cmp_byte	length_d::quarter,	sound_notes::F5
	snd_cmp_byte	length_d::halfdot,	sound_notes::null

apu_music_overworld_b_b_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::C4
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C5
		.byte	sound_notes::G6
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::G6
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::G6
		.byte	sound_notes::G4
; --------------
	.export	apu_music_overworld_b_c_data
	.export	apu_music_overworld_b_c_pulse_2
	.export	apu_music_overworld_b_c_pulse_1
	.export	apu_music_overworld_b_c_triangle
	.export apu_music_overworld_b_noise
apu_music_overworld_b_c_data:
apu_music_overworld_b_c_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::Dx5
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::C5
		.byte	sound_notes::null
	.byte	SND_TRACK_END

	.export	apu_music_overworld_b_c_pulse_1
apu_music_overworld_b_c_pulse_1:
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx4
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::quarter,	sound_notes::F4
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::whole,	sound_notes::E4
	snd_cmp_byte	length_d::whole,	sound_notes::null

apu_music_overworld_b_c_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::Gx4
		.byte	sound_notes::Ax4
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::G4
		.byte	sound_notes::C4

apu_music_overworld_b_noise:
	snd_cmp_byte	length_d::half,		SND_NOISE_LO_SHORT
	snd_cmp_byte	length_d::sixth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::sixth,	SND_NOISE_NONE
	snd_cmp_byte	length_d::sixth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::half,		SND_NOISE_HI_LONG
	snd_cmp_byte	length_d::sixth,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::sixth,	SND_NOISE_NONE
	snd_cmp_byte	length_d::sixth,	SND_NOISE_HI_SHORT
	.byte	SND_TRACK_END
; --------------
	.export apu_music_overworld_c_a_data
	.export apu_music_overworld_c_a_pulse_2
	.export	apu_music_overworld_c_a_pulse_1
apu_music_overworld_c_a_data:
apu_music_overworld_c_a_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C5
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
		.byte	sound_notes::D5
		.byte	sound_notes::null
		.byte	sound_notes::E5
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::G4
	.byte	SND_TRACK_END

apu_music_overworld_c_a_pulse_1:
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx4
	snd_cmp_byte	length_d::half,		sound_notes::Gx4
	snd_cmp_byte	length_d::half,		sound_notes::Gx4
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx4
	snd_cmp_byte	length_d::half,		sound_notes::Ax4
	snd_cmp_byte	length_d::quarter,	sound_notes::G4
	snd_cmp_byte	length_d::half,		sound_notes::E4
	snd_cmp_byte	length_d::quarter,	sound_notes::E4
	snd_cmp_byte	length_d::whole,	sound_notes::C4
; --------------
	.export	apu_music_overworld_c_b_data
	.export	apu_music_overworld_c_b_pulse_2
	.export	apu_music_overworld_c_b_pulse_1
	.export	apu_music_overworld_c_triangle
apu_music_overworld_c_b_data:
apu_music_overworld_c_b_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::C5
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::E5
		.byte	sound_notes::null
		.byte	sound_notes::null
	.byte	SND_TRACK_END

apu_music_overworld_c_b_pulse_1:
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx4
	snd_cmp_byte	length_d::half,		sound_notes::Gx4
	snd_cmp_byte	length_d::half,		sound_notes::Gx4
	snd_cmp_byte	length_d::quarter,	sound_notes::Gx4
	snd_cmp_byte	length_d::quarter,	sound_notes::Ax4
	snd_cmp_byte	length_d::halfdot,	sound_notes::G4
	snd_cmp_byte	length_d::wholedot,	sound_notes::null

apu_music_overworld_c_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::Gx3
		.byte	sound_notes::Dx4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::G4
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::G3
; --------------
	.export	apu_music_overworld_intro_data
	.export	apu_music_overworld_intro_pulse_2
	.export	apu_music_overworld_intro_pulse_1
	.export	apu_music_overworld_intro_triangle
	.export	apu_music_overworld_c_noise
apu_music_overworld_intro_data:
apu_music_overworld_intro_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::E5
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::G5
		.byte	sound_notes::null
	.byte	SND_TRACK_END

apu_music_overworld_intro_pulse_1:
	snd_cmp_byte	length_d::quarter,	sound_notes::Fx4
	snd_cmp_byte	length_d::half,		sound_notes::Fx4
	snd_cmp_byte	length_d::half,		sound_notes::Fx4
	snd_cmp_byte	length_d::quarter,	sound_notes::Fx4
	snd_cmp_byte	length_d::half,		sound_notes::Fx4
	snd_cmp_byte	length_d::half,		sound_notes::B4
	snd_cmp_byte	length_d::half,		sound_notes::null
	snd_cmp_byte	length_d::whole,	sound_notes::G4

apu_music_overworld_intro_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::D4
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::D4
		.byte	sound_notes::D4
		.byte	sound_notes::null
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::G5
		.byte	sound_notes::G4

apu_music_overworld_c_noise:
	snd_cmp_byte	length_d::half,		SND_NOISE_HI_LONG
	snd_cmp_byte	length_d::quarter,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::half,		SND_NOISE_HI_LONG
	snd_cmp_byte	length_d::quarter,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::half,		SND_NOISE_HI_LONG
	snd_cmp_byte	length_d::halfdot,	SND_NOISE_HI_LONG
	snd_cmp_byte	length_d::half,		SND_NOISE_HI_LONG
	snd_cmp_byte	length_d::quarter,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::quarter,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::quarter,	SND_NOISE_HI_SHORT
	.byte	SND_TRACK_END
; --------------
	.export	apu_music_overworld_d_a_data
	.export	apu_music_overworld_d_a_pulse_2
	.export	apu_music_overworld_d_a_pulse_1
	.export	apu_music_overworld_d_a_triangle
apu_music_overworld_d_a_data:
apu_music_overworld_d_a_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::A4
		.byte	sound_notes::F5
		.byte	sound_notes::null
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::A4
	.byte	SND_TRACK_END

apu_music_overworld_d_a_pulse_1:
	snd_cmp_byte	length_d::quarter,	sound_notes::C5
	snd_cmp_byte	length_d::half,		sound_notes::A4
	snd_cmp_byte	length_d::halfdot,	sound_notes::E4
	snd_cmp_byte	length_d::half,		sound_notes::E4
	snd_cmp_byte	length_d::quarter,	sound_notes::F4
	snd_cmp_byte	length_d::half,		sound_notes::C5
	snd_cmp_byte	length_d::quarter,	sound_notes::C5
	snd_cmp_byte	length_d::whole,	sound_notes::F4

apu_music_overworld_d_a_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::C4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::Fx4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::G4
		.byte	sound_notes::C5
		.byte	sound_notes::F4
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
		.byte	sound_notes::C5
		.byte	sound_notes::F4
		.byte	sound_notes::null
; --------------
	.export	apu_music_overworld_d_b_data
	.export	apu_music_overworld_d_b_pulse_2
	.export	apu_music_overworld_d_b_pulse_1
	.export	apu_music_overworld_d_b_triangle
apu_music_overworld_d_b_data:
apu_music_overworld_d_b_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::third
		.byte	sound_notes::B4
		.byte	sound_notes::A5
		.byte	sound_notes::A5
		.byte	sound_notes::A5
		.byte	sound_notes::G5
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::E5
		.byte	sound_notes::C5
		.byte	sound_notes::null
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::G4
	.byte	SND_TRACK_END

apu_music_overworld_d_b_pulse_1:
	snd_cmp_byte	length_d::third,	sound_notes::G4
	snd_cmp_byte	length_d::third,	sound_notes::F5
	snd_cmp_byte	length_d::third,	sound_notes::F5
	snd_cmp_byte	length_d::third,	sound_notes::F5
	snd_cmp_byte	length_d::third,	sound_notes::E5
	snd_cmp_byte	length_d::third,	sound_notes::D5
	snd_cmp_byte	length_d::quarter,	sound_notes::C5
	snd_cmp_byte	length_d::half,		sound_notes::A4
	snd_cmp_byte	length_d::quarter,	sound_notes::F4
	snd_cmp_byte	length_d::whole,	sound_notes::E4

apu_music_overworld_d_b_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::G4
		.byte	sound_notes::B4
		.byte	sound_notes::G4
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::C5
		.byte	sound_notes::C5
		.byte	sound_notes::G4
		.byte	sound_notes::null
; --------------
	.export	apu_music_overworld_d_c_data
	.export	apu_music_overworld_d_c_pulse_2
	.export	apu_music_overworld_d_c_pulse_1
	.export	apu_music_overworld_d_c_triangle
	.export	apu_music_overworld_d_noise
	.export	apu_music_death_data
	.export	apu_music_death_pulse_2
	.export	apu_music_death_pulse_1
	.export	apu_music_death_triangle
apu_music_death_data:
apu_music_death_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::null

apu_music_overworld_d_c_data:
apu_music_overworld_d_c_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::B4
		.byte	sound_notes::F5
		.byte	sound_notes::null
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_d::third
		.byte	sound_notes::F5
		.byte	sound_notes::E5
		.byte	sound_notes::D5
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::C5
		.byte	sound_notes::null
	.byte	SND_TRACK_END

apu_music_death_pulse_1:
	snd_cmp_byte	length_d::wholedot,	sound_notes::Gx5_b
	snd_cmp_byte	length_d::twelfth,	sound_notes::Ax4
	snd_cmp_byte	length_d::twelfth,	sound_notes::B4
	snd_cmp_byte	length_d::twelfth,	sound_notes::C5
	snd_cmp_byte	length_d::halfdot,	sound_notes::null

apu_music_overworld_d_c_pulse_1:
	snd_cmp_byte	length_d::quarter,	sound_notes::G4
	snd_cmp_byte	length_d::half,		sound_notes::D5
	snd_cmp_byte	length_d::quarter,	sound_notes::D5
	snd_cmp_byte	length_d::third,	sound_notes::D5
	snd_cmp_byte	length_d::third,	sound_notes::C5
	snd_cmp_byte	length_d::third,	sound_notes::B4
	snd_cmp_byte	length_d::quarter,	sound_notes::G4
	snd_cmp_byte	length_d::half,		sound_notes::E4
	snd_cmp_byte	length_d::quarter,	sound_notes::E4
	snd_cmp_byte	length_d::whole,	sound_notes::C4

apu_music_death_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::null

apu_music_overworld_d_c_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_d::halfdot
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::quarter
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::third
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_d::half
		.byte	sound_notes::C5
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_d::whole
		.byte	sound_notes::C4

apu_music_overworld_d_noise:
	snd_cmp_byte	length_d::halfdot,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::quarter,	SND_NOISE_HI_SHORT
	snd_cmp_byte	length_d::half,		SND_NOISE_HI_LONG
	snd_cmp_byte	length_d::half,		SND_NOISE_HI_SHORT
	.byte	SND_TRACK_END
