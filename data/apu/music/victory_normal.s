.include	"sound.i"

	.export apu_music_victory_normal_data
	.export	apu_music_victory_normal_pulse_2
	.export	apu_music_victory_normal_pulse_1
	.export apu_music_victory_normal_triangle
apu_music_victory_normal_data:
apu_music_victory_normal_pulse_2:
	.if	.defined(CONS)
		.byte	SND_TRACK_NOTE_LEN|length_c::half
	.elseif	.defined(VS)
		.byte	SND_TRACK_NOTE_LEN|length_vs::third
	.endif
		.byte	sound_notes::null
	.if	.defined(CONS)
		.byte	SND_TRACK_NOTE_LEN|length_c::whole
	.elseif	.defined(VS)
		.byte	SND_TRACK_NOTE_LEN|length_vs::third_double
	.endif
		.byte	sound_notes::G3
	.if	.defined(CONS)
		.byte	SND_TRACK_NOTE_LEN|length_c::half
	.elseif	.defined(VS)
		.byte	SND_TRACK_NOTE_LEN|length_vs::third
	.endif
		.byte	sound_notes::A3
		.byte	sound_notes::Ax3
	.if	.defined(CONS)
		.byte	SND_TRACK_NOTE_LEN|length_c::whole
	.elseif	.defined(VS)
		.byte	SND_TRACK_NOTE_LEN|length_vs::third_double
	.endif
		.byte	sound_notes::B3
	.if	.defined(CONS)
		.byte	SND_TRACK_NOTE_LEN|length_c::half
	.elseif	.defined(VS)
		.byte	SND_TRACK_NOTE_LEN|length_vs::third
	.endif
		.byte	sound_notes::E4
		.byte	sound_notes::G4
		.byte	sound_notes::F4
		.byte	sound_notes::G4
		.byte	sound_notes::A4
		.byte	sound_notes::D4
		.byte	sound_notes::F4
		.byte	sound_notes::null
		.byte	sound_notes::E4
	.byte	SND_TRACK_END

apu_music_victory_normal_pulse_1:
	.if	.defined(CONS)
		snd_cmp_byte	length_c::eighthdot,	sound_notes::G4
		snd_cmp_byte	length_c::eighthdot,	sound_notes::Fx4
		snd_cmp_byte	length_c::eighthdot,	sound_notes::G4
		snd_cmp_byte	length_c::whole,	sound_notes::E4
		snd_cmp_byte	length_c::half,		sound_notes::F4
		snd_cmp_byte	length_c::half,		sound_notes::Fx4
		snd_cmp_byte	length_c::whole,	sound_notes::G4
		snd_cmp_byte	length_c::half,		sound_notes::C5
		snd_cmp_byte	length_c::quarterdot,	sound_notes::E5
		snd_cmp_byte	length_c::eighth,	sound_notes::E5
		snd_cmp_byte	length_c::half,		sound_notes::D5
		snd_cmp_byte	length_c::half,		sound_notes::E5
		snd_cmp_byte	length_c::half,		sound_notes::F5
		snd_cmp_byte	length_c::half,		sound_notes::B4
		snd_cmp_byte	length_c::whole,	sound_notes::D5
		snd_cmp_byte	length_c::whole,	sound_notes::C5
	.elseif	.defined(VS)
		snd_cmp_byte	length_vs::ninth,	sound_notes::G4
		snd_cmp_byte	length_vs::ninth,	sound_notes::Fx4
		snd_cmp_byte	length_vs::ninth,	sound_notes::G4
		snd_cmp_byte	length_vs::third_double, sound_notes::E4
		snd_cmp_byte	length_vs::third,	sound_notes::F4
		snd_cmp_byte	length_vs::third,	sound_notes::Fx4
		snd_cmp_byte	length_vs::third_double, sound_notes::G4
		snd_cmp_byte	length_vs::third,	sound_notes::C5
		snd_cmp_byte	length_vs::ninth_double, sound_notes::E5
		snd_cmp_byte	length_vs::ninth,	sound_notes::E5
		snd_cmp_byte	length_vs::third,	sound_notes::D5
		snd_cmp_byte	length_vs::third,	sound_notes::E5
		snd_cmp_byte	length_vs::third,	sound_notes::F5
		snd_cmp_byte	length_vs::third,	sound_notes::B4
		snd_cmp_byte	length_vs::third_double, sound_notes::D5
		snd_cmp_byte	length_vs::third,	sound_notes::C5
	.endif

apu_music_victory_normal_triangle:
	.if	.defined(CONS)
		.byte	SND_TRACK_NOTE_LEN|length_c::half
	.elseif	.defined(VS)
		.byte	SND_TRACK_NOTE_LEN|length_vs::third
	.endif
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
