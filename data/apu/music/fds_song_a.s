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
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::3
		.byte	$16
		.byte	$14
		.byte	$16
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::6
		.byte	$10
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::4
		.byte	$12
		.byte	$14
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::6
		.byte	$16
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::4
		.byte	$20
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::1
		.byte	$28
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::3
		.byte	$28
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::4
		.byte	$24
		.byte	$28
		.byte	$2a
		.byte	$1e
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::6
		.byte	$24
	.byte	SND_TRACK_NOTE_LEN|lenth_fds_a::4
		.byte	$20

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
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::1
		.byte	$10
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::3
		.byte	$10
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::6
		.byte	$10
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::5
		.byte	$08
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::2
		.byte	$0c
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::0
		.byte	$0c
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::3
		.byte	$0a
		.byte	$08
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::4
		.byte	$0a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::1
		.byte	$12
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::3
		.byte	$12
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::6
		.byte	$12
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::5
		.byte	$0a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::2
		.byte	$0c
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::6
		.byte	$10
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::4
		.byte	$0c

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
