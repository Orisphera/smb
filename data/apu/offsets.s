.include	"sound.i"

	.if	.defined(VS)
		.include	"./envelope_victory_castle.s"
		.include	"./envelope_area.s"
	.endif

	.export	apu_music_offsets, apu_music_overworld_offsets
	.export	apu_music_overworld_loop_offset, apu_music_overworld_loop_end
	.export	apu_music_offsets_base_start
apu_music_offsets:
	.byte	apu_music_death-apu_music_offsets
	.byte	apu_music_game_over-apu_music_offsets
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	apu_music_victory_normal-apu_music_offsets
	.elseif	.defined(SMB2M)
		.byte	apu_music_game_over-apu_music_offsets
	.endif
	.byte	apu_music_victory_castle-apu_music_offsets
	.if	.defined(CONS)
		.byte	apu_music_game_over-apu_music_offsets
	.elseif	.defined(VS)
		.byte	apu_music_game_over_vs_b-apu_music_offsets
	.endif
	.byte	apu_music_level_end-apu_music_offsets
	.byte	apu_music_hurry_up-apu_music_offsets
	.byte	apu_music_none-apu_music_offsets
; --------------
apu_music_offsets_base_start:
	.byte	apu_music_overworld_a-apu_music_offsets
	.byte	apu_music_underwater-apu_music_offsets
	.byte	apu_music_underground-apu_music_offsets
	.byte	apu_music_castle-apu_music_offsets
	.byte	apu_music_super_star-apu_music_offsets
	.byte	apu_music_overworld_intro-apu_music_offsets
	.byte	apu_music_super_star-apu_music_offsets
	.byte	apu_music_none-apu_music_offsets
; --------------
apu_music_overworld_offsets:
	.byte	apu_music_overworld_intro-apu_music_offsets

apu_music_overworld_loop_offset:
	.byte	apu_music_overworld_a-apu_music_offsets
	.byte	apu_music_overworld_a-apu_music_offsets

	.byte	apu_music_overworld_b_a-apu_music_offsets
	.byte	apu_music_overworld_b_b-apu_music_offsets
	.byte	apu_music_overworld_b_a-apu_music_offsets
	.byte	apu_music_overworld_b_c-apu_music_offsets
	.byte	apu_music_overworld_b_a-apu_music_offsets
	.byte	apu_music_overworld_b_b-apu_music_offsets
	.byte	apu_music_overworld_b_a-apu_music_offsets
	.byte	apu_music_overworld_b_c-apu_music_offsets

	.byte	apu_music_overworld_c_a-apu_music_offsets
	.byte	apu_music_overworld_c_b-apu_music_offsets
	.byte	apu_music_overworld_c_a-apu_music_offsets
	.byte	apu_music_overworld_intro-apu_music_offsets

	.byte	apu_music_overworld_a-apu_music_offsets
	.byte	apu_music_overworld_a-apu_music_offsets

	.byte	apu_music_overworld_d_a-apu_music_offsets
	.byte	apu_music_overworld_d_b-apu_music_offsets
	.byte	apu_music_overworld_d_a-apu_music_offsets
	.byte	apu_music_overworld_d_c-apu_music_offsets

	.byte	apu_music_overworld_d_a-apu_music_offsets
	.byte	apu_music_overworld_d_b-apu_music_offsets
	.byte	apu_music_overworld_d_a-apu_music_offsets
	.byte	apu_music_overworld_d_c-apu_music_offsets

	.byte	apu_music_overworld_c_a-apu_music_offsets
	.byte	apu_music_overworld_c_b-apu_music_offsets
	.byte	apu_music_overworld_c_a-apu_music_offsets
	.byte	apu_music_overworld_intro-apu_music_offsets

	.byte	apu_music_overworld_d_a-apu_music_offsets
	.byte	apu_music_overworld_d_b-apu_music_offsets
	.byte	apu_music_overworld_d_a-apu_music_offsets
	.byte	apu_music_overworld_d_c-apu_music_offsets
apu_music_overworld_loop_end:

	.if	.defined(VS)
		.byte	apu_music_victory_normal-apu_music_offsets
		.byte	apu_music_victory_normal-apu_music_offsets
		.byte	apu_music_game_over_vs_b-apu_music_offsets
		.byte	apu_music_victory_normal-apu_music_offsets
		.byte	apu_music_victory_normal-apu_music_offsets

		.export apu_music_super_star_vs_loop, apu_music_super_star_vs_loop_end
	apu_music_super_star_vs_loop:
		.byte	apu_music_super_star_vs_a-apu_music_offsets
		.byte	apu_music_super_star_vs_b-apu_music_offsets
		.byte	apu_music_super_star_vs_d-apu_music_offsets
		.byte	apu_music_super_star_vs_c-apu_music_offsets
	apu_music_super_star_vs_loop_end:
	.endif
; --------------------------------------------------
.if	.defined(VS)
apu_music_super_star_vs_a:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_super_star_vs_a_data
	.byte	<(apu_music_super_star_vs_a_triangle-apu_music_super_star_vs_a_data)
	.byte	<(apu_music_super_star_vs_a_pulse_1-apu_music_super_star_vs_a_data)
	.byte	<(apu_music_super_star_noise-apu_music_super_star_vs_a_data)

apu_music_super_star_vs_b:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_super_star_vs_b_data
	.byte	<(apu_music_super_star_vs_b_triangle-apu_music_super_star_vs_b_data)
	.byte	<(apu_music_super_star_vs_b_pulse_1-apu_music_super_star_vs_b_data)
	.byte	<(apu_music_super_star_noise-apu_music_super_star_vs_b_data)

apu_music_super_star_vs_c:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_super_star_vs_c_data
	.byte	<(apu_music_super_star_vs_c_triangle-apu_music_super_star_vs_c_data)
	.byte	<(apu_music_super_star_vs_c_pulse_1-apu_music_super_star_vs_c_data)
	.byte	<(apu_music_super_star_noise-apu_music_super_star_vs_c_data)

apu_music_super_star_vs_d:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_super_star_vs_d_data
	.byte	<(apu_music_super_star_vs_d_triangle-apu_music_super_star_vs_d_data)
	.byte	<(apu_music_super_star_vs_d_pulse_1-apu_music_super_star_vs_d_data)
	.byte	<(apu_music_super_star_noise-apu_music_super_star_vs_d_data)
.endif

apu_music_hurry_up:
	.byte	APU_MUSIC_HURRY_UP_LEN
	.addr	apu_music_hurry_up_data
	.byte	<(apu_music_hurry_up_triangle-apu_music_hurry_up_data)
	.byte	<(apu_music_hurry_up_pulse_1-apu_music_hurry_up_data)

apu_music_super_star:
	.byte	<(apu_note_lengths_e-apu_note_lengths)
	.addr	apu_music_super_star_data
	.byte	<(apu_music_super_star_triangle-apu_music_super_star_data)
	.byte	<(apu_music_super_star_pulse_1-apu_music_super_star_data)
	.byte	<(apu_music_super_star_noise-apu_music_super_star_data)

apu_music_level_end:
	.byte	<(apu_note_lengths_e-apu_note_lengths)
	.addr	apu_music_level_end_data
	.byte	<(apu_music_level_end_triangle-apu_music_level_end_data)
	.byte	<(apu_music_level_end_pulse_1-apu_music_level_end_data)

apu_music_unk:
	.byte	<(apu_note_lengths_e-apu_note_lengths)
	.addr	apu_music_unk_data
	.byte	<(apu_music_unk_triangle-apu_music_unk_data)
	.byte	<(apu_music_unk_pulse_1-apu_music_unk_data)

apu_music_underground:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_underground_data
	.byte	<(apu_music_underground_pulse_triangle-apu_music_underground_data)
	.byte	<(apu_music_underground_pulse_triangle-apu_music_underground_data)

apu_music_none:
	.byte	<(apu_note_lengths_b-apu_note_lengths)
	.addr	apu_music_none_data
	.byte	<(apu_music_none_triangle-apu_music_none_data)

apu_music_castle:
	.byte	<(apu_note_lengths_a-apu_note_lengths)
	.addr	apu_music_castle_data
	.byte	<(apu_music_castle_triangle-apu_music_castle_data)
	.byte	<(apu_music_castle_pulse_1-apu_music_castle_data)

.if	.defined(SMB)|.defined(VS_SMB)
apu_music_victory_normal:
	.if	.defined(CONS)
		.byte	<(apu_note_lengths_c-apu_note_lengths)
	.elseif	.defined(VS)
		.byte	<(apu_note_lengths_vs-apu_note_lengths)
	.endif
	.addr	apu_music_victory_normal_data
	.byte	<(apu_music_victory_normal_triangle-apu_music_victory_normal_data)
	.byte	<(apu_music_victory_normal_pulse_1-apu_music_victory_normal_data)
.endif

.if	.defined(VS)
apu_music_game_over_vs_b:
	.byte	<(apu_note_lengths_vs-apu_note_lengths)
	.addr	apu_music_game_over_vs_data
	.byte	<(apu_music_game_over_vs_triangle-apu_music_game_over_vs_data)
	.byte	<(apu_music_game_over_vs_pulse_1-apu_music_game_over_vs_data)
.endif

apu_music_game_over:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_game_over_data
	.byte	<(apu_music_game_over_triangle-apu_music_game_over_data)
	.byte	<(apu_music_game_over_pulse_1-apu_music_game_over_data)

apu_music_underwater:
	.byte	<(apu_note_lengths_b-apu_note_lengths)
	.addr	apu_music_underwater_data
	.byte	<(apu_music_underwater_triangle-apu_music_underwater_data)
	.byte	<(apu_music_underwater_pulse_1-apu_music_underwater_data)
	.byte	<(apu_music_underwater_noise-apu_music_underwater_data)

apu_music_victory_castle:
	.byte	<(apu_note_lengths_b-apu_note_lengths)
	.addr	apu_music_victory_castle_data
	.byte	<(apu_music_victory_castle_triangle-apu_music_victory_castle_data)
	.byte	<(apu_music_victory_castle_pulse_1-apu_music_victory_castle_data)

apu_music_overworld_a:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_a_data
	.byte	<(apu_music_overworld_a_triangle-apu_music_overworld_a_data)
	.byte	<(apu_music_overworld_a_pulse_1-apu_music_overworld_a_data)
	.byte	<(apu_music_overworld_b_noise-apu_music_overworld_a_data)

apu_music_overworld_b_a:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_b_a_data
	.byte	<(apu_music_overworld_b_a_triangle-apu_music_overworld_b_a_data)
	.byte	<(apu_music_overworld_b_a_pulse_1-apu_music_overworld_b_a_data)
	.byte	<(apu_music_overworld_b_noise-apu_music_overworld_b_a_data)

apu_music_overworld_b_b:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_b_b_data
	.byte	<(apu_music_overworld_b_b_triangle-apu_music_overworld_b_b_data)
	.byte	<(apu_music_overworld_b_b_pulse_1-apu_music_overworld_b_b_data)
	.byte	<(apu_music_overworld_b_noise-apu_music_overworld_b_b_data)

apu_music_overworld_b_c:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_b_c_data
	.byte	<(apu_music_overworld_b_c_triangle-apu_music_overworld_b_c_data)
	.byte	<(apu_music_overworld_b_c_pulse_1-apu_music_overworld_b_c_data)
	.byte	<(apu_music_overworld_b_noise-apu_music_overworld_b_c_data)

apu_music_overworld_c_a:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_c_a_data
	.byte	<(apu_music_overworld_c_triangle-apu_music_overworld_c_a_data)
	.byte	<(apu_music_overworld_c_a_pulse_1-apu_music_overworld_c_a_data)
	.byte	<(apu_music_overworld_c_noise-apu_music_overworld_c_a_data)

apu_music_overworld_c_b:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_c_b_data
	.byte	<(apu_music_overworld_c_triangle-apu_music_overworld_c_b_data)
	.byte	<(apu_music_overworld_c_b_pulse_1-apu_music_overworld_c_b_data)
	.byte	<(apu_music_overworld_c_noise-apu_music_overworld_c_b_data)

apu_music_overworld_intro:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_intro_data
	.byte	<(apu_music_overworld_intro_triangle-apu_music_overworld_intro_data)
	.byte	<(apu_music_overworld_intro_pulse_1-apu_music_overworld_intro_data)
	.byte	<(apu_music_overworld_c_noise-apu_music_overworld_intro_data)

apu_music_overworld_d_a:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_d_a_data
	.byte	<(apu_music_overworld_d_a_triangle-apu_music_overworld_d_a_data)
	.byte	<(apu_music_overworld_d_a_pulse_1-apu_music_overworld_d_a_data)
	.byte	<(apu_music_overworld_d_noise-apu_music_overworld_d_a_data)

apu_music_overworld_d_b:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_d_b_data
	.byte	<(apu_music_overworld_d_b_triangle-apu_music_overworld_d_b_data)
	.byte	<(apu_music_overworld_d_b_pulse_1-apu_music_overworld_d_b_data)
	.byte	<(apu_music_overworld_d_noise-apu_music_overworld_d_b_data)

apu_music_overworld_d_c:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_overworld_d_c_data
	.byte	<(apu_music_overworld_d_c_triangle-apu_music_overworld_d_c_data)
	.byte	<(apu_music_overworld_d_c_pulse_1-apu_music_overworld_d_c_data)
	.byte	<(apu_music_overworld_d_noise-apu_music_overworld_d_c_data)

apu_music_death:
	.byte	<(apu_note_lengths_d-apu_note_lengths)
	.addr	apu_music_death_data
	.byte	<(apu_music_death_triangle-apu_music_death_data)
	.byte	<(apu_music_death_pulse_1-apu_music_death_data)
	.byte	<(apu_music_overworld_d_noise-apu_music_death_data)
