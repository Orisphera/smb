.include	"engine/sound.i"

	.export	apu_note_lengths
apu_note_lengths:

	.export	apu_note_lengths_a
	.export	apu_note_length_a_sixteenth
	.export	apu_note_length_a_eighth
	.export	apu_note_length_a_quarter
	.export	apu_note_length_a_half
	.export	apu_note_length_a_whole
	.export	apu_note_length_a_quarterdot
	.export	apu_note_length_a_halfdot
	.export	apu_note_length_a_fortieth
apu_note_lengths_a:
apu_note_length_a_sixteenth:
	snd_region_len	5, 4
apu_note_length_a_eighth:
	snd_region_len	10, 8
apu_note_length_a_quarter:
	snd_region_len	20, 16
apu_note_length_a_half:
	snd_region_len	40, 32
apu_note_length_a_whole:
	snd_region_len	80, 64
apu_note_length_a_quarterdot:
	snd_region_len	30, 24
apu_note_length_a_halfdot:
	snd_region_len	60, 48
apu_note_length_a_fortieth:
	snd_region_len	2, 12

	.export	apu_note_lengths_b
	.export	apu_note_length_b_sixteenth
	.export	apu_note_length_b_eighth
	.export	apu_note_length_b_quarter
	.export	apu_note_length_b_half
	.export	apu_note_length_b_whole
	.export	apu_note_length_b_quarterdot
	.export	apu_note_length_b_halfdot
	.export	apu_note_length_b_eighthdot
apu_note_lengths_b:
apu_note_length_b_sixteenth:
	snd_region_len	4, 3
apu_note_length_b_eighth:
	snd_region_len	8, 6
apu_note_length_b_quarter:
	snd_region_len	16, 12
apu_note_length_b_half:
	snd_region_len	32, 24
apu_note_length_b_whole:
	snd_region_len	64, 48
apu_note_length_b_quarterdot:
	snd_region_len	24, 18
apu_note_length_b_halfdot:
	snd_region_len	48, 36
apu_note_length_b_eighthdot:
	snd_region_len	12, 8

	.export	apu_note_lengths_c
	.export	apu_note_length_c_sixteenth
	.export	apu_note_length_c_eighth
	.export	apu_note_length_c_quarter
	.export	apu_note_length_c_half
	.export	apu_note_length_c_whole
	.export	apu_note_length_c_quarterdot
	.export	apu_note_length_c_halfdot
	.export	apu_note_length_c_eighthdot
apu_note_lengths_c:
apu_note_length_c_sixteenth:
	snd_region_len	3, 3
apu_note_length_c_eighth:
	snd_region_len	6, 6
apu_note_length_c_quarter:
	snd_region_len	12, 12
apu_note_length_c_half:
	snd_region_len	24, 24
apu_note_length_c_whole:
	snd_region_len	48, 48
apu_note_length_c_quarterdot:
	snd_region_len	18, 18
apu_note_length_c_halfdot:
	snd_region_len	36, 36
apu_note_length_c_eighthdot:
	snd_region_len	8, 8

	.if	.defined(VS)
	.export	apu_note_lengths_vs
	.export	apu_note_length_vs_whole
	.export	apu_note_length_vs_ninth_double
	.export	apu_note_length_vs_ninthdot
	.export	apu_note_length_vs_third
	.export	apu_note_length_vs_ninth
	.export	apu_note_length_vs_half
	.export	apu_note_length_vs_third_double
	.export	apu_note_length_vs_ninth_double_b
apu_note_lengths_vs:
apu_note_length_vs_whole:
	snd_region_len	81, 81
apu_note_length_vs_ninth_double:
	snd_region_len	18, 18
apu_note_length_vs_ninthdot:
	snd_region_len	13, 13
apu_note_length_vs_ninth:
	snd_region_len	9, 9
apu_note_length_vs_third:
	snd_region_len	27, 27
apu_note_length_vs_half:
	snd_region_len	40, 40
apu_note_length_vs_third_double:
	snd_region_len	54, 54
apu_note_length_vs_ninth_double_b:
	snd_region_len	18, 18
	.endif

	.export	apu_note_lengths_d
	.export	apu_note_length_d_wholedot
	.export	apu_note_length_d_twelfth
	.export	apu_note_length_d_quarter
	.export	apu_note_length_d_sixth
	.export	apu_note_length_d_half
	.export	apu_note_length_d_halfdot
	.export	apu_note_length_d_whole
	.export	apu_note_length_d_third
apu_note_lengths_d:
apu_note_length_d_wholedot:
	snd_region_len	54, 36
apu_note_length_d_twelfth:
	snd_region_len	3, 2
apu_note_length_d_quarter:
	snd_region_len	9, 6
apu_note_length_d_sixth:
	snd_region_len	6, 4
apu_note_length_d_half:
	snd_region_len	18, 12
apu_note_length_d_halfdot:
	snd_region_len	27, 18
apu_note_length_d_whole:
	snd_region_len	36, 24
apu_note_length_d_third:
	snd_region_len	12, 8

	.export	apu_note_lengths_e
	.export	apu_note_length_e_wholedot
	.export	apu_note_length_e_twelfth
	.export	apu_note_length_e_quarter
	.export	apu_note_length_e_sixth
	.export	apu_note_length_e_half
	.export	apu_note_length_e_halfdot
	.export	apu_note_length_e_whole
	.export	apu_note_length_e_third
apu_note_lengths_e:
apu_note_length_e_wholedot:
	snd_region_len	36, 27
apu_note_length_e_twelfth:
	snd_region_len	2, 1
apu_note_length_e_quarter:
	snd_region_len	6, 5
apu_note_length_e_sixth:
	snd_region_len	4, 3
apu_note_length_e_half:
	snd_region_len	12, 9
apu_note_length_e_halfdot:
	snd_region_len	18, 13
apu_note_length_e_whole:
	snd_region_len	24, 18
apu_note_length_e_third:
	snd_region_len	8, 6

	.export	apu_note_lengths_f
	.export	apu_note_length_f_wholedot
	.export	apu_note_length_f_twelfth
	.export	apu_note_length_f_quarter
	.export	apu_note_length_f_sixth
	.export	apu_note_length_f_half
	.export	apu_note_length_f_halfdot
	.export	apu_note_length_f_whole
	.export	apu_note_length_f_third
apu_note_lengths_f:
apu_note_length_f_wholedot:
	snd_region_len	18, 18
apu_note_length_f_twelfth:
	snd_region_len	1, 1
apu_note_length_f_quarter:
	snd_region_len	3, 3
apu_note_length_f_sixth:
	snd_region_len	2, 2
apu_note_length_f_half:
	snd_region_len	6, 6
apu_note_length_f_halfdot:
	snd_region_len	9, 9
apu_note_length_f_whole:
	snd_region_len	12, 12
apu_note_length_f_third:
	snd_region_len	4, 4
