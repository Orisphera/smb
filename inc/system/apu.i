.ifndef APU_I
APU_I = 1

CHANNEL_VOL	.set	$4000
	.enum	channel_vol
		envelope	= 0
		constant_vol	= 16
		counter_halt	= 32
		duty_125	= 0
		duty_250	= $40
		duty_500	= $80
		duty_250n	= $C0
	.endenum
PULSE1_VOL	.set	$4000

PULSE_SWEEP	.set	$4001
	.enum   pulse_sweep
		negate		= 8
		period_1hf	= 0
		period_2hf	= (1<<4)
		period_3hf	= (2<<4)
		period_4hf	= (3<<4)
		period_5hf	= (4<<4)
		period_6hf	= (5<<4)
		period_7hf	= (6<<4)
		period_8hf	= (7<<4)
		enable		= 128
	.endenum
PULSE1_SWEEP	.set	$4001

CHANNEL_TIMER	.set	$4002
	.enum	apu_notes
		C2	= $00
		Cx2	= $01
		D2	= $02
		Dx2	= $03
		E2	= $04
		F2	= $05
		Fx2	= $06
		G2	= $07
		Ab2	= $08
		A2	= $09
		Ax2	= $0A
		B2	= $0B
		C3	= $0C
		Cx3	= $0D
		D3	= $0E
		Dx3	= $0F
		E3	= $10
		F3	= $11
		Fx3	= $12
		G3	= $13
		Ab3	= $14
		A3	= $15
		Ax3	= $16
		B3	= $17
		C4	= $18
		Cx4	= $19
		D4	= $1A
		Dx4	= $1B
		E4	= $1C
		F4	= $1D
		Fx4	= $1E
		G4	= $1F
		Ab4	= $20
		A4	= $21
		Ax4	= $22
		B4	= $23
		C5	= $24
		Cx5	= $25
		D5	= $26
		Dx5	= $27
		E5	= $28
		F5	= $29
		Fx5	= $2A
		G5	= $2B
		Ab5	= $2C
		A5	= $2D
		Ax5	= $2E
		B5	= $2F
		C6	= $30
		Cx6	= $31
		D6	= $32
		Dx6	= $33
		E6	= $34
		F6	= $35
		Fx6	= $36
		G6	= $37
		Ab6	= $38
		A6	= $39
		Ax6	= $3A
		B6	= $3B
		C7	= $3C
		Cx7	= $3D
		D7	= $3E
		Dx7	= $3F
		E7	= $40
		F7	= $41
		Fx7	= $42
		G7	= $43
		Ab7	= $44
		A7	= $45
		Ax7	= $46
		B7	= $47
		C8	= $48
	.endenum
PULSE1_TIMER	.set	$4002

CHANNEL_COUNTER	.set	$4003
	.enum	channel_counter
		length_254	= 1<<3
		length_2	= 3<<3
		length_4	= 5<<3
		length_6	= 7<<3
		length_8	= 9<<3
		length_10	= 11<<3
		length_12	= 13<<3
		length_14	= 15<<3
		length_16	= 17<<3
		length_18	= 19<<3
		length_20	= 21<<3
		length_22	= 23<<3
		length_24	= 25<<3
		length_26	= 27<<3
		length_28	= 29<<3
		length_30	= 31<<3

		sixteenth_10	= 0
		eighth_10	= 2<<3
		quarter_10	= 4<<3
		half_10		= 6<<3
		whole_10	= 8<<3
		quarterdot_10	= 10<<3
		eighthtrip_10	= 12<<3
		quartertrip_10	= 14<<3

		sixteenth_12	= 16<<3
		eighth_12	= 18<<3
		quarter_12	= 20<<3
		half_12		= 22<<3
		whole_12	= 24<<3
		quarterdot_12	= 26<<3
		eighthtrip_12	= 28<<3
		quartertrip_12	= 30<<3
	.endenum
PULSE1_COUNTER	.set	$4003

PULSE2_VOL	.set	$4004
PULSE2_SWEEP	.set	$4005
PULSE2_TIMER	.set	$4006
PULSE2_COUNTER	.set	$4007

NOISE_VOL	.set	$400C
NOISE_PERIOD	.set	$400E
NOISE_PERIOD_MASK	.set	%00001111
	.enum	noise_period
		np_4		= 0
		np_8		= 1
		np_16n_14p	= 2
		np_32n_30p	= 3
		np_64n_60p	= 4
		np_96n_88p	= 5
		np_128n_118p	= 6
		np_160n_148p	= 7
		np_202n_188p	= 8
		np_254n_236p	= 9
		np_380n_354p	= 10
		np_508n_472p	= 11
		np_762n_708p	= 12
		np_1016n_944p	= 13
		np_2034n_1890p	= 14
		np_4068n_3778p	= 15
	.endenum
NOISE_COUNTER	.set	$400F

DMCFLAG		.set	$4010
DMCDATA		.set	$4011
DMCSTATUS	.set	$4015
	.enum	dmcstatus
		pulse_1		= 1
		pulse_2		= 2
		tri		= 4
		noise		= 8
		dmc		= 16
		frame_interrupt	= 64
		dmc_interrupt	= 128
	.endenum
DMCFRAMECOUNT	.set	$4017

.endif	; APU_I
