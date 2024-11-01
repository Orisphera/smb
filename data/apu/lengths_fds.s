.include	"sound.i"

.segment	"DATA3"

	.export	apu_fds_note_lengths
apu_fds_note_lengths:

	.export	apu_fds_note_lengths_a
	.export	apu_fds_note_length_a_thirddot
	.export	apu_fds_note_length_a_ninth_double
	.export	apu_fds_note_length_a_ninthdot
	.export	apu_fds_note_length_a_ninth
	.export	apu_fds_note_length_a_third
	.export	apu_fds_note_length_a_half
	.export	apu_fds_note_length_a_third_double
	.export	apu_fds_note_length_a_ninth_double_b
apu_fds_note_lengths_a:
apu_fds_note_length_a_thirddot:
	snd_region_len	36, 24
apu_fds_note_length_a_ninth_double:
	snd_region_len	18, 12
apu_fds_note_length_a_ninthdot:
	snd_region_len	13, 8
apu_fds_note_length_a_ninth:
	snd_region_len	9, 6
apu_fds_note_length_a_third:
	snd_region_len	27, 18
apu_fds_note_length_a_half:
	snd_region_len	40, 26
apu_fds_note_length_a_third_double:
	snd_region_len	54, 36
apu_fds_note_length_a_ninth_double_b:
	snd_region_len	18, 12

	.export	apu_fds_note_lengths_b
	.export	apu_fds_note_length_b_thirddot
	.export	apu_fds_note_length_b_ninth_double
	.export	apu_fds_note_length_b_ninthdot
	.export	apu_fds_note_length_b_ninth
	.export	apu_fds_note_length_b_third
	.export	apu_fds_note_length_b_half
	.export	apu_fds_note_length_b_third_double
	.export	apu_fds_note_length_b_whole_third
apu_fds_note_lengths_b:
apu_fds_note_length_b_thirddot:
	snd_region_len	36, 24
apu_fds_note_length_b_ninth_double:
	snd_region_len	18, 12
apu_fds_note_length_b_ninthdot:
	snd_region_len	13, 8
apu_fds_note_length_b_ninth:
	snd_region_len	9, 6
apu_fds_note_length_b_third:
	snd_region_len	27, 18
apu_fds_note_length_b_half:
	snd_region_len	40, 26
apu_fds_note_length_b_third_double:
	snd_region_len	54, 36
apu_fds_note_length_b_whole_third:
	snd_region_len	108, 72
