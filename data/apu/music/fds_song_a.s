.include	"sound.i"

.segment	"DATA3"

	.export	LD038_data
	.export	LD04B_data
	.export	LD038_pulse_1
	.export	LD038_wave
	.export	LD038_triangle
LD038_data:
LD038_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::B3
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::G3
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::A3
		.byte	sound_notes::Ax3
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::B3
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::E4
		.byte	sound_notes::G4
		.byte	sound_notes::F4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::D4
		.byte	sound_notes::F4
		.byte	sound_notes::null
		.byte	sound_notes::E4

LD04B_data:
LD04B_pulse_2:
	.byte	SND_TRACK_END

LD038_pulse_1:
	snd_cmp_byte	length_fds_a::ninth, sound_notes::G4
	snd_cmp_byte	length_fds_a::ninth, sound_notes::Fx4
	snd_cmp_byte	length_fds_a::ninth, sound_notes::G4
	snd_cmp_byte	length_fds_a::third_double, sound_notes::E4
	snd_cmp_byte	length_fds_a::third, sound_notes::F4
	snd_cmp_byte	length_fds_a::third, sound_notes::Fx4
	snd_cmp_byte	length_fds_a::third_double, sound_notes::G4
	snd_cmp_byte	length_fds_a::third, sound_notes::C5
	snd_cmp_byte	length_fds_a::ninth_double, sound_notes::E5
	snd_cmp_byte	length_fds_a::ninth, sound_notes::E5
	snd_cmp_byte	length_fds_a::third, sound_notes::D5
	snd_cmp_byte	length_fds_a::third, sound_notes::E5
	snd_cmp_byte	length_fds_a::third, sound_notes::F5
	snd_cmp_byte	length_fds_a::third, sound_notes::B4
	snd_cmp_byte	length_fds_a::third_double, sound_notes::D5
	snd_cmp_byte	length_fds_a::third, sound_notes::C5

LD038_wave:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_fds_notes::note_11
		.byte	sound_fds_notes::note_10
		.byte	sound_fds_notes::note_11
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_fds_notes::note_08
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_fds_notes::note_09
		.byte	sound_fds_notes::note_10
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_fds_notes::note_11
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_fds_notes::note_16
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_fds_notes::note_20
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_fds_notes::note_20
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_fds_notes::note_18
		.byte	sound_fds_notes::note_20
		.byte	sound_fds_notes::note_21
		.byte	sound_fds_notes::note_15
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_fds_notes::note_18
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_fds_notes::note_16

LD038_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::B3
		.byte	sound_notes::C4
		.byte	sound_notes::null
		.byte	sound_notes::D4
		.byte	sound_notes::Dx4
		.byte	sound_notes::E4
		.byte	sound_notes::C4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::F4
		.byte	sound_notes::E4
		.byte	sound_notes::D4
		.byte	sound_notes::F4
		.byte	sound_notes::G4
		.byte	sound_notes::G3
		.byte	sound_notes::C4
; --------------
	.export	LD087_data
	.export	LD087_pulse_1
	.export	LD087_wave
	.export	LD087_triangle
	.export	LD038_D087_noise
LD087_data:
LD087_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::thirddot
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::D4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::E4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	sound_notes::Gx4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::G4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::F4
	.byte	SND_TRACK_END

LD087_pulse_1:
	snd_cmp_byte	length_fds_a::ninth_double, sound_notes::E5
	snd_cmp_byte	length_fds_a::ninth, sound_notes::E5
	snd_cmp_byte	length_fds_a::third_double, sound_notes::E5
	snd_cmp_byte	length_fds_a::half, sound_notes::B4
	snd_cmp_byte	length_fds_a::ninthdot, sound_notes::D5
	snd_cmp_byte	length_fds_a::thirddot, sound_notes::D5
	snd_cmp_byte	length_fds_a::ninth, sound_notes::C5
	snd_cmp_byte	length_fds_a::ninth, sound_notes::B4
	snd_cmp_byte	length_fds_a::third, sound_notes::C5
	snd_cmp_byte	length_fds_a::ninth_double, sound_notes::F5
	snd_cmp_byte	length_fds_a::ninth, sound_notes::F5
	snd_cmp_byte	length_fds_a::third_double, sound_notes::F5
	snd_cmp_byte	length_fds_a::half, sound_notes::C5
	snd_cmp_byte	length_fds_a::ninthdot, sound_notes::D5
	snd_cmp_byte	length_fds_a::third_double, sound_notes::E5
	snd_cmp_byte	length_fds_a::third, sound_notes::D5

LD087_wave:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_fds_notes::note_08
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_fds_notes::note_08
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_fds_notes::note_08
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	sound_fds_notes::note_04
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	sound_fds_notes::note_06
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::thirddot
		.byte	sound_fds_notes::note_06
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_fds_notes::note_05
		.byte	sound_fds_notes::note_04
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_fds_notes::note_05
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_fds_notes::note_09
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_fds_notes::note_09
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_fds_notes::note_09
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	sound_fds_notes::note_05
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	sound_fds_notes::note_06
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_fds_notes::note_08
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_fds_notes::note_06

LD087_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
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

LD038_D087_noise:
	snd_cmp_byte	length_fds_a::third, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_a::third, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_a::ninth, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_a::ninth, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_a::ninth, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_a::third, SND_NOISE_HI_SHORT
	.byte	SND_TRACK_END
