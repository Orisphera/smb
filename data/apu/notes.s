.include	"sys/apu.i"

	.if	.defined(OG_PAD)
	.if	.defined(SMB)
		.ifndef	PAL
			.res	3, $FF
		.else
			.res	2, $FF
		.endif
	.elseif	.defined(VS_SMB)
		.res	5, $FF
	.elseif	.defined(SMB2)
		.res	1, $FF
	.endif
	.endif

	.export	apu_notes
apu_notes:
	.export	apu_note_Gx5_b
apu_note_Gx5_b:
	.ifndef	PAL
		.dbyt	apu_chromatic_scale::Gx5+1
	.else
		.dbyt	apu_chromatic_scale::Fx5-3
	.endif

	.export	apu_note_D7
apu_note_D7:
	.dbyt	apu_chromatic_scale::D7-1

	.export	apu_note_null
apu_note_null:
	.dbyt	apu_chromatic_scale::none

	.export	apu_note_E3
apu_note_E3:
	.dbyt	apu_chromatic_scale::E3-1

	.export	apu_note_F3
apu_note_F3:
	.dbyt	apu_chromatic_scale::F3-1

	.export	apu_note_Fx3
apu_note_Fx3:
	.dbyt	apu_chromatic_scale::Fx3-1

	.export	apu_note_G3
apu_note_G3:
	.dbyt	apu_chromatic_scale::G3+4

	.export	apu_note_Gx3
apu_note_Gx3:
	.dbyt	apu_chromatic_scale::Gx3+4

	.export	apu_note_Ax3
apu_note_Ax3:
	.dbyt	apu_chromatic_scale::Ax3-13

	.export	apu_note_B3
apu_note_B3:
	.dbyt	apu_chromatic_scale::B3-1

	.export	apu_note_C4
apu_note_C4:
	.dbyt	apu_chromatic_scale::C4-1

	.export	apu_note_Cx4
apu_note_Cx4:
	.dbyt	apu_chromatic_scale::Cx4-1

	.export	apu_note_D4
apu_note_D4:
	.dbyt	apu_chromatic_scale::D4-1

	.export	apu_note_Dx4
apu_note_Dx4:
	.dbyt	apu_chromatic_scale::Dx4-1

	.export	apu_note_E4
apu_note_E4:
	.dbyt	apu_chromatic_scale::E4

	.export	apu_note_F4
apu_note_F4:
	.dbyt	apu_chromatic_scale::F4

	.export	apu_note_Fx4
apu_note_Fx4:
	.dbyt	apu_chromatic_scale::Fx4

	.export	apu_note_G4
apu_note_G4:
	.dbyt	apu_chromatic_scale::G4

	.export	apu_note_Gx4
apu_note_Gx4:
	.dbyt	apu_chromatic_scale::Gx4

	.export	apu_note_A4
apu_note_A4:
	.dbyt	apu_chromatic_scale::A4

	.export	apu_note_Ax4
apu_note_Ax4:
	.dbyt	apu_chromatic_scale::Ax4-1

	.export	apu_note_B4
apu_note_B4:
	.dbyt	apu_chromatic_scale::B4

	.export	apu_note_C5
apu_note_C5:
	.dbyt	apu_chromatic_scale::C5-1

	.export	apu_note_Cx5
apu_note_Cx5:
	.dbyt	apu_chromatic_scale::Cx5-1

	.export	apu_note_D5
apu_note_D5:
	.dbyt	apu_chromatic_scale::D5

	.export	apu_note_Dx5
apu_note_Dx5:
	.dbyt	apu_chromatic_scale::Dx5-1

	.export	apu_note_E5
apu_note_E5:
	.dbyt	apu_chromatic_scale::E5-1

	.export	apu_note_F5
apu_note_F5:
	.dbyt	apu_chromatic_scale::F5

	.export	apu_note_Fx5
apu_note_Fx5:
	.dbyt	apu_chromatic_scale::Fx5

	.export	apu_note_G5
apu_note_G5:
	.dbyt	apu_chromatic_scale::G5-1

	.export	apu_note_Gx5
apu_note_Gx5:
	.dbyt	apu_chromatic_scale::Gx5-1

	.export	apu_note_Ax5
apu_note_Ax5:
	.dbyt	apu_chromatic_scale::Ax5-1

	.export	apu_note_A5
apu_note_A5:
	.dbyt	apu_chromatic_scale::A5-1

	.export	apu_note_B5
apu_note_B5:
	.dbyt	apu_chromatic_scale::B5

	.export	apu_note_E6
apu_note_E6:
	.dbyt	apu_chromatic_scale::E6-1

	.export	apu_note_Cx6
apu_note_Cx6:
	.dbyt	apu_chromatic_scale::Cx6-1

	.export	apu_note_D6
apu_note_D6:
	.dbyt	apu_chromatic_scale::D6

	.export	apu_note_Dx6
apu_note_Dx6:
	.dbyt	apu_chromatic_scale::Dx6-1

	.export	apu_note_F6
apu_note_F6:
	.dbyt	apu_chromatic_scale::F6

	.export	apu_note_G6
apu_note_G6:
	.dbyt	apu_chromatic_scale::G6

	.export	apu_note_Gx6
apu_note_Gx6:
	.dbyt	apu_chromatic_scale::Gx6

	.export	apu_note_Ax6
apu_note_Ax6:
	.dbyt	apu_chromatic_scale::Ax6-1

	.export	apu_note_C7
apu_note_C7:
	.dbyt	apu_chromatic_scale::C7

	.export	apu_note_E7
apu_note_E7:
	.dbyt	apu_chromatic_scale::E7

	.export	apu_note_G7
apu_note_G7:
	.dbyt	apu_chromatic_scale::G7-1

	.export	apu_note_G2
apu_note_G2:
	.dbyt	apu_chromatic_scale::G2

	.export	apu_note_C3
apu_note_C3:
	.dbyt	apu_chromatic_scale::C3

	.export	apu_note_D3
apu_note_D3:
	.dbyt	apu_chromatic_scale::D3-1

	.export	apu_note_Dx3
apu_note_Dx3:
	.dbyt	apu_chromatic_scale::Dx3

	.export	apu_note_A3
apu_note_A3:
	.dbyt	apu_chromatic_scale::A3

	.export	apu_note_C6
apu_note_C6:
	.dbyt	apu_chromatic_scale::C6-1
