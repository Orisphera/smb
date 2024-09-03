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
	.byte	5
apu_note_length_a_eighth:
	.byte	10
apu_note_length_a_quarter:
	.byte	20
apu_note_length_a_half:
	.byte	40
apu_note_length_a_whole:
	.byte	80
apu_note_length_a_quarterdot:
	.byte	30
apu_note_length_a_halfdot:
	.byte	60
apu_note_length_a_fortieth:
	.byte	2

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
	.byte	4
apu_note_length_b_eighth:
	.byte	8
apu_note_length_b_quarter:
	.byte	16
apu_note_length_b_half:
	.byte	32
apu_note_length_b_whole:
	.byte	64
apu_note_length_b_quarterdot:
	.byte	24
apu_note_length_b_halfdot:
	.byte	48
apu_note_length_b_eighthdot:
	.byte	12

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
	.byte	3
apu_note_length_c_eighth:
	.byte	6
apu_note_length_c_quarter:
	.byte	12
apu_note_length_c_half:
	.byte	24
apu_note_length_c_whole:
	.byte	48
apu_note_length_c_quarterdot:
	.byte	18
apu_note_length_c_halfdot:
	.byte	36
apu_note_length_c_eighthdot:
	.byte	8

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
	.byte	81
apu_note_length_vs_ninth_double:
	.byte	18
apu_note_length_vs_ninthdot:
	.byte	13
apu_note_length_vs_ninth:
	.byte	9
apu_note_length_vs_third:
	.byte	27
apu_note_length_vs_half:
	.byte	40
apu_note_length_vs_third_double:
	.byte	54
apu_note_length_vs_ninth_double_b:
	.byte	18
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
	.byte	54
apu_note_length_d_twelfth:
	.byte	3
apu_note_length_d_quarter:
	.byte	9
apu_note_length_d_sixth:
	.byte	6
apu_note_length_d_half:
	.byte	18
apu_note_length_d_halfdot:
	.byte	27
apu_note_length_d_whole:
	.byte	36
apu_note_length_d_third:
	.byte	12

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
	.byte	36
apu_note_length_e_twelfth:
	.byte	2
apu_note_length_e_quarter:
	.byte	6
apu_note_length_e_sixth:
	.byte	4
apu_note_length_e_half:
	.byte	12
apu_note_length_e_halfdot:
	.byte	18
apu_note_length_e_whole:
	.byte	24
apu_note_length_e_third:
	.byte	8

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
	.byte	18
apu_note_length_f_twelfth:
	.byte	1
apu_note_length_f_quarter:
	.byte	3
apu_note_length_f_sixth:
	.byte	2
apu_note_length_f_half:
	.byte	6
apu_note_length_f_halfdot:
	.byte	9
apu_note_length_f_whole:
	.byte	12
apu_note_length_f_third:
	.byte	4
