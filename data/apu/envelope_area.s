.include	"sys/apu.i"

	.export	apu_area_envelope
apu_area_envelope:
	.byte	channel_vol::duty_500|channel_vol::constant_vol|0
	.byte	channel_vol::duty_500|channel_vol::constant_vol|4
	.byte	channel_vol::duty_500|channel_vol::constant_vol|4
	.byte	channel_vol::duty_500|channel_vol::constant_vol|5
	.byte	channel_vol::duty_500|channel_vol::constant_vol|5
	.byte	channel_vol::duty_500|channel_vol::constant_vol|6
	.byte	channel_vol::duty_500|channel_vol::constant_vol|7
	.if	.defined(VS)
		.byte	channel_vol::duty_500|channel_vol::constant_vol|7
	.endif
	.byte	channel_vol::duty_500|channel_vol::constant_vol|8
