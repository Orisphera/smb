.segment	"DATA3"

	.export	apu_fds_music_offsets, apu_fds_music_offsets_end
apu_fds_music_offsets:
	.byte	LD005-apu_fds_music_offsets
	.byte	LD005-apu_fds_music_offsets
	.byte	LD00D-apu_fds_music_offsets
	.byte	LD005-apu_fds_music_offsets
	.byte	LD015-apu_fds_music_offsets
	.byte	LD02D-apu_fds_music_offsets
	.byte	LD015-apu_fds_music_offsets
	.byte	LD02D-apu_fds_music_offsets
	.byte	LD01D-apu_fds_music_offsets
	.byte	LD015-apu_fds_music_offsets
	.byte	LD025-apu_fds_music_offsets
apu_fds_music_offsets_end:
; ----------------------------------
LD005:
	.byte	<(apu_fds_note_lengths_a-apu_fds_note_lengths)
	.addr	LD038_data
	.byte	<(LD038_triangle-LD038_data)
	.byte	<(LD038_pulse_1-LD038_data)
	.byte	<(LD038_D087_noise-LD038_data)

	.byte	<(LD038_wave-LD038_data)
	.byte	<((apu_fds_wave_offsets_a)-(apu_fds_wave_offsets-1))

LD00D:
	.byte	<(apu_fds_note_lengths_a-apu_fds_note_lengths)
	.addr	LD087_data
	.byte	<(LD087_triangle-LD087_data)
	.byte	<(LD087_pulse_1-LD087_data)
	.byte	<(LD038_D087_noise-LD087_data)
	
	.byte	<(LD087_wave-LD087_data)
	.byte	<((apu_fds_wave_offsets_b)-(apu_fds_wave_offsets-1))

LD015:
	.byte	<(apu_fds_note_lengths_a-apu_fds_note_lengths)
	.addr	LD0EF_data
	.byte	<(LD0EF_triangle-LD0EF_data)
	.byte	<(LD0EF_pulse_1-LD0EF_data)
	.byte	<(LD0EF_D106_D143_noise-LD0EF_data)
	
	.byte	<(LD0EF_wave-LD0EF_data)
	.byte	<((apu_fds_wave_offsets_a)-(apu_fds_wave_offsets-1))

LD01D:
	.byte	<(apu_fds_note_lengths_a-apu_fds_note_lengths)
	.addr	LD143_data
	.byte	<(LD143_triangle-LD143_data)
	.byte	<(LD143_pulse_1-LD143_data)
	.byte	<(LD0EF_D106_D143_noise-LD143_data)
	
	.byte	<(LD143_wave-LD143_data)
	.byte	<((apu_fds_wave_offsets_b)-(apu_fds_wave_offsets-1))

LD025:
	.byte	<(apu_fds_note_lengths_b-apu_fds_note_lengths)
	.addr	LD1AB_data
	.byte	<(LD1AB_triangle-LD1AB_data)
	.byte	<(LD1AB_pulse_1-LD1AB_data)
	.byte	<(LD1AB_noise-LD1AB_data)
	
	.byte	<(LD1AB_wave-LD1AB_data)
	.byte	<((apu_fds_wave_offsets_a)-(apu_fds_wave_offsets-1))

LD02D:
	.byte	<(apu_fds_note_lengths_b-apu_fds_note_lengths)
	.addr	LD106_data
	.byte	<(LD106_triangle-LD106_data)
	.byte	<(LD106_pulse_1-LD106_data)
	.byte	<(LD0EF_D106_D143_noise-LD106_data)

	.byte	<(LD106_wave-LD106_data)
	.byte	<((apu_fds_wave_offsets_a)-(apu_fds_wave_offsets-1))
; ----------------------------------
LD035:
	.byte	<(apu_fds_note_lengths_a-apu_fds_note_lengths)
	.addr	LD04B_data
