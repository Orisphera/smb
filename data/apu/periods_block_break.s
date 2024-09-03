.include	"system/apu.i"

	.export	apu_block_break_periods
apu_block_break_periods:
	.byte	noise_period::D8
	.byte	noise_period::C10
	.byte	noise_period::C10
	.byte	noise_period::B9
	.byte	noise_period::G9
	.byte	noise_period::B8
	.byte	noise_period::A9
	.byte	noise_period::D10
	.byte	noise_period::F9
	.byte	noise_period::E9
	.byte	noise_period::F8
	.byte	noise_period::B9
	.byte	noise_period::D9
	.byte	noise_period::B9
	.byte	noise_period::B8
	.byte	noise_period::A9
