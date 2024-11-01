.include	"sound.i"

.segment	"DATA3"

	.export	LD1AB_data
	.export	LD1AB_pulse_1
	.export	LD1AB_wave
	.export	LD1AB_triangle
	.export	LD1AB_noise
LD1AB_data:
LD1AB_pulse_2:
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::whole_third
		.byte	sound_notes::G5
		.byte	sound_notes::F5
	.byte	SND_TRACK_END

LD1AB_pulse_1:
	snd_cmp_byte	length_fds_b::whole_third, sound_notes::Ax4
	snd_cmp_byte	length_fds_b::whole_third, sound_notes::A4

LD1AB_wave:
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::7
		.byte	$2E
		.byte	$2A

LD1AB_triangle:
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::ninth
		.byte	sound_notes::Cx4
		.byte	sound_notes::E4
		.byte	sound_notes::G4
		.byte	sound_notes::Ax4
		.byte	sound_notes::Cx5
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::third
		.byte	sound_notes::G5
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::ninth
		.byte	sound_notes::E5
		.byte	sound_notes::G4
		.byte	sound_notes::E5
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::third
		.byte	sound_notes::F5
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::ninth
		.byte	sound_notes::F4
		.byte	sound_notes::F4
		.byte	sound_notes::F4
	.byte	SND_TRACK_NOTE_LEN|length_fds_b::third_double
		.byte	sound_notes::F4

LD1AB_noise:
	snd_cmp_byte	length_fds_b::third, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_b::third, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_b::ninth, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_b::ninth, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_b::ninth, SND_NOISE_HI_SHORT
	snd_cmp_byte	length_fds_b::third, SND_NOISE_HI_SHORT
	.byte	SND_TRACK_END
