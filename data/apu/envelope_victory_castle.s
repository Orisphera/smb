.include	"sys/apu.i"

	.export	apu_victory_castle_envelope
apu_victory_castle_envelope:
	.byte	channel_vol::duty_500|channel_vol::constant_vol|8
	.byte	channel_vol::duty_500|channel_vol::constant_vol|9
	.byte	channel_vol::duty_500|channel_vol::constant_vol|10
	.byte	channel_vol::duty_500|channel_vol::constant_vol|11
