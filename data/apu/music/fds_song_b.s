.include	"sound.i"

.segment	"DATA3"

	.export	LD0EF_data
	.export	LD106_data
	.export	LD143_data
	.export	LD0EF_pulse_1
	.export	LD0EF_wave
	.export	LD0EF_triangle
	.export	LD106_pulse_1
	.export	LD106_wave
	.export	LD106_triangle
	.export	LD143_pulse_1
	.export	LD143_wave
	.export	LD143_triangle
	.export	LD0EF_D106_D143_noise
LD0EF_data:
LD0EF_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::C5
		.byte	sound_notes::B4
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::A4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::Ax4
		.byte	sound_notes::B4
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::C5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_notes::A5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::A5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::G5
		.byte	sound_notes::A5
		.byte	sound_notes::Ax5
		.byte	sound_notes::E5
	.byte	SND_TRACK_END

LD106_data:
LD106_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::third_double
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::third
		.byte	sound_notes::F5
	.byte	SND_TRACK_END

LD0EF_pulse_1:
	snd_cmp_byte	length_fds_a::third, sound_notes::E4
	snd_cmp_byte	length_fds_a::third_double, sound_notes::C4
	snd_cmp_byte	length_fds_a::third, sound_notes::D4
	snd_cmp_byte	length_fds_a::third, sound_notes::Dx4
	snd_cmp_byte	length_fds_a::third_double, sound_notes::E4
	snd_cmp_byte	length_fds_a::third, sound_notes::A4
	snd_cmp_byte	length_fds_a::third, sound_notes::C5
	snd_cmp_byte	length_fds_a::third, sound_notes::Ax4
	snd_cmp_byte	length_fds_a::third, sound_notes::C5
	snd_cmp_byte	length_fds_a::third, sound_notes::D5
	snd_cmp_byte	length_fds_a::third, sound_notes::G4

LD106_pulse_1:
	snd_cmp_byte	length_fds_b::third_double, sound_notes::Ax4
	snd_cmp_byte	length_fds_b::third, sound_notes::A4

LD0EF_wave:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	$20
		.byte	$1e
		.byte	$20
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	$1a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	$1c
		.byte	$1e
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	$20
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	$2a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	$32
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	$32
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	$2e
		.byte	$32
		.byte	$34
		.byte	$28

LD106_wave:
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::third_double
		.byte	$2e
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::third
		.byte	$2a

LD0EF_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::E4
		.byte	sound_notes::F4
		.byte	sound_notes::null
		.byte	sound_notes::G4
		.byte	sound_notes::Gx4
		.byte	sound_notes::A4
		.byte	sound_notes::F4
		.byte	sound_notes::D5
		.byte	sound_notes::C5
		.byte	sound_notes::Ax4
		.byte	sound_notes::A4
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4

LD106_triangle:
		.byte	sound_notes::C5
		.byte	sound_notes::C4
		.byte	sound_notes::F4
; --------------
LD143_data:
LD143_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_notes::A5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::A5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::A5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::thirddot
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::F5
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	sound_notes::Ax5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	sound_notes::Ax5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::Ax5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	sound_notes::A5
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::G5
	.byte	SND_TRACK_END

LD143_pulse_1:
	snd_cmp_byte	length_fds_a::ninth_double, sound_notes::C5
	snd_cmp_byte	length_fds_a::ninth, sound_notes::C5
	snd_cmp_byte	length_fds_a::third_double, sound_notes::Cx5
	snd_cmp_byte	length_fds_a::half, sound_notes::G4
	snd_cmp_byte	length_fds_a::ninthdot, sound_notes::Ax4
	snd_cmp_byte	length_fds_a::third, sound_notes::Ax4
	snd_cmp_byte	length_fds_a::ninth, sound_notes::null
	snd_cmp_byte	length_fds_a::ninth, sound_notes::A4
	snd_cmp_byte	length_fds_a::ninth, sound_notes::G4
	snd_cmp_byte	length_fds_a::third, sound_notes::A4
	snd_cmp_byte	length_fds_a::ninth_double, sound_notes::D5
	snd_cmp_byte	length_fds_a::ninth, sound_notes::D5
	snd_cmp_byte	length_fds_a::third_double, sound_notes::D5
	snd_cmp_byte	length_fds_a::half, sound_notes::Ax4
	snd_cmp_byte	length_fds_a::ninthdot, sound_notes::Cx5
	snd_cmp_byte	length_fds_a::third_double, sound_notes::C5
	snd_cmp_byte	length_fds_a::third, sound_notes::Ax4

LD143_wave:
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	$1a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	$1a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	$1a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	$10
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	$16
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::thirddot
		.byte	$16
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	$12
		.byte	$10
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	$12
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth_double
		.byte	$1c
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninth
		.byte	$1c
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	$1c
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::half
		.byte	$12
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::ninthdot
		.byte	$16
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third_double
		.byte	$1a
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	$16

LD143_triangle:	
	.byte	SND_TRACK_NOTE_LEN|length_fds_a::third
		.byte	sound_notes::E4
		.byte	sound_notes::A4
		.byte	sound_notes::B4
		.byte	sound_notes::Cx5
		.byte	sound_notes::E5
		.byte	sound_notes::D5
		.byte	sound_notes::Cx5
		.byte	sound_notes::D5
		.byte	sound_notes::C5
		.byte	sound_notes::Ax4
		.byte	sound_notes::C5
		.byte	sound_notes::Cx5
		.byte	sound_notes::Ax4
		.byte	sound_notes::C5
		.byte	sound_notes::C4
		.byte	sound_notes::Ax4

LD0EF_D106_D143_noise:
        snd_cmp_byte    length_fds_a::third, SND_NOISE_HI_SHORT
        snd_cmp_byte    length_fds_a::third, SND_NOISE_HI_SHORT
        snd_cmp_byte    length_fds_a::ninth, SND_NOISE_HI_SHORT
        snd_cmp_byte    length_fds_a::ninth, SND_NOISE_HI_SHORT
        snd_cmp_byte    length_fds_a::ninth, SND_NOISE_HI_SHORT
        snd_cmp_byte    length_fds_a::third, SND_NOISE_HI_SHORT
	.byte	SND_TRACK_END
