.include	"engine/sound.i"

	.export	apu_oneup_data
apu_oneup_data:
	.byte	sound_notes::G7
	.byte	sound_notes::D7
	.byte	sound_notes::C7
	.byte	sound_notes::E7
	.byte	sound_notes::G6
	.byte	sound_notes::E6

	.export	apu_powerup_data, apu_powerup_data_end
apu_powerup_data:
	.byte	sound_notes::F6
	.byte	sound_notes::Ax6
	.byte	sound_notes::F6
	.byte	sound_notes::D6
	.byte	sound_notes::Ax5
	.byte	sound_notes::F5
	.byte	sound_notes::Ax5
	.byte	sound_notes::F5
	.byte	sound_notes::D5
	.byte	sound_notes::Ax4
	.byte	sound_notes::Dx6
	.byte	sound_notes::Gx6
	.byte	sound_notes::Dx6
	.byte	sound_notes::C6
	.byte	sound_notes::Gx5
	.byte	sound_notes::Dx5
	.byte	sound_notes::Gx5
	.byte	sound_notes::Dx5
	.byte	sound_notes::C5
	.byte	sound_notes::Gx4
	.byte	sound_notes::G5
	.byte	sound_notes::C6
	.byte	sound_notes::G5
	.byte	sound_notes::E5
	.byte	sound_notes::C5
	.byte	sound_notes::G4
	.byte	sound_notes::C5
apu_powerup_data_end:

	.byte	sound_notes::G4
	.byte	sound_notes::E4
	.byte	sound_notes::C4

	.export	apu_spawn_data
	.export	apu_spawn_data_powerup_end, apu_spawn_data_vine_end
apu_spawn_data:
	.byte	sound_notes::C4
	.byte	sound_notes::null
	.byte	sound_notes::G4
	.byte	sound_notes::Gx4
	.byte	sound_notes::Cx4
	.byte	sound_notes::null
	.byte	sound_notes::Gx4
	.byte	sound_notes::A4
	.byte	sound_notes::D4
	.byte	sound_notes::null
	.byte	sound_notes::A4
	.byte	sound_notes::Ax4
	.byte	sound_notes::Dx4
	.byte	sound_notes::null
	.byte	sound_notes::Ax4
	.byte	sound_notes::B4
apu_spawn_data_powerup_end:
	.byte	sound_notes::E4
	.byte	sound_notes::null
	.byte	sound_notes::B4
	.byte	sound_notes::C5
	.byte	sound_notes::F4
	.byte	sound_notes::null
	.byte	sound_notes::C5
	.byte	sound_notes::Cx5
	.byte	sound_notes::Fx4
	.byte	sound_notes::null
	.byte	sound_notes::Cx5
	.byte	sound_notes::D5
	.byte	sound_notes::G4
	.byte	sound_notes::null
	.byte	sound_notes::D5
	.byte	sound_notes::Dx5
apu_spawn_data_vine_end:
