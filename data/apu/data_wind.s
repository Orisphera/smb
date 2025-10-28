.include	"sys/apu.i"

		.export	apu_wind_data
	apu_wind_data:
		.byte	(3<<4)|noise_period::C9
		.byte	(4<<4)|noise_period::B8
		.byte	(5<<4)|noise_period::A8
		.byte	(6<<4)|noise_period::G8
		.byte	(7<<4)|noise_period::G8
		.byte	(8<<4)|noise_period::F8
		.byte	(9<<4)|noise_period::F8
		.byte	(10<<4)|noise_period::E8
		.byte	(11<<4)|noise_period::D8
		.byte	(12<<4)|noise_period::C8
		.byte	(13<<4)|noise_period::C8
		.byte	(14<<4)|noise_period::C8
		.byte	(15<<4)|noise_period::D8
		.byte	(15<<4)|noise_period::D8
		.byte	(15<<4)|noise_period::E8
		.byte	(14<<4)|noise_period::E8
		.byte	(14<<4)|noise_period::E8
		.byte	(12<<4)|noise_period::F8
		.byte	(10<<4)|noise_period::F8
		.byte	(8<<4)|noise_period::G8
		.byte	(6<<4)|noise_period::G8
		.byte	(4<<4)|noise_period::G8
		.byte	(3<<4)|noise_period::A8
		.byte	(2<<4)|noise_period::A8
