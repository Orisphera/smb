.include	"sys/apu.i"

	.export	apu_notes_skid
apu_notes_skid:
	.byte	apu_chromatic_scale::G6
	.byte	apu_chromatic_scale::G6+2
	.byte	apu_chromatic_scale::Gx6-1
	.byte	apu_chromatic_scale::Fx6-2
	.byte	apu_chromatic_scale::Gx6
	.byte	apu_chromatic_scale::Fx6-1
