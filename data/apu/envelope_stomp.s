.include	"sys/apu.i"

	.export	apu_stomp_envelope
apu_stomp_envelope:
	.byte	channel_vol::duty_500|channel_vol::constant_vol|15
	.byte	channel_vol::duty_500|channel_vol::constant_vol|11
	.byte	channel_vol::duty_500|channel_vol::constant_vol|8
	.byte	channel_vol::duty_500|channel_vol::constant_vol|6
	.byte	channel_vol::duty_500|channel_vol::constant_vol|5
	.byte	channel_vol::duty_500|channel_vol::constant_vol|4
	.byte	channel_vol::duty_500|channel_vol::constant_vol|2
	.byte	channel_vol::duty_500|channel_vol::constant_vol|0
	.byte	channel_vol::duty_500|channel_vol::constant_vol|0
	.byte	channel_vol::duty_500|channel_vol::constant_vol|10
	.byte	channel_vol::duty_500|channel_vol::constant_vol|7
	.byte	channel_vol::duty_500|channel_vol::constant_vol|5
	.byte	channel_vol::duty_500|channel_vol::constant_vol|3
	.byte	channel_vol::duty_500|channel_vol::constant_vol|2
