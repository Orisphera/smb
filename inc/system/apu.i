.ifndef APU_I
APU_I = 1

; References
; 1 - Ricoh RP2A03 Custom CPU - December 3rd, 1982

CHANNEL_PULSE1	.set	0
CHANNEL_PULSE2	.set	1
CHANNEL_TRIANGLE .set	2
CHANNEL_NOISE	.set	3

CHANNEL_SIZE	.set	4

; Volume Controls [1](11.1.a,11.1.b)(p. 5)
CHANNEL_VOL	.set	$4000
	.enum	channel_vol
		envelope	= 0
		constant_vol	= 16
		counter_halt	= 32
		duty_125	= $00
		duty_250	= $40
		duty_500	= $80
		duty_750	= $C0
	.endenum
PULSE1_VOL	.set	$4000

; Sweep Clock Generator [1](11.1.c)(p. 5-6)
PULSE_SWEEP	.set	$4001
	.enum   pulse_sweep
		shift_0		= 0
		shift_1		= 1
		shift_2		= 2
		shift_3		= 3
		shift_4		= 4
		shift_5		= 5
		shift_6		= 6
		shift_7		= 7
		shift_mask	= 7
		negate		= 8
		period_1hf	= (0<<4)
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

; Frequency Generator [1](11.1.d)(p. 6)
CHANNEL_TIMER	.set	$4002
PULSE1_TIMER	.set	$4002

; Channel Counter [1](11.1.e)(p. 6)
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

; Chromatic Scale [1](11.1.f)(p. 7)
	.enum	apu_chromatic_scale
		A1	= $7F2
		Ax1	= $780
		B1	= $714
		C2	= $6AE
		Cx2	= $64E
		D2	= $5F4
		Dx2	= $59E
		E2	= $54D
		F2	= $501
		Fx2	= $4B9
		G2	= $475
		Gx2	= $435
		A2	= $3F9
		Ax2	= $3C0
		B2	= $38A
		C3	= $357
		Cx3	= $327
		D3	= $2FA
		Dx3	= $2CF
		E3	= $2A7
		F3	= $281
		Fx3	= $25D
		G3	= $236
		Gx3	= $216
		A3	= $1FC
		Ax3	= $1EC
		B3	= $1C5
		C4	= $1AC
		Cx4	= $194
		D4	= $17D
		Dx4	= $168
		E4	= $153
		F4	= $140
		Fx4	= $12E
		G4	= $11D
		Gx4	= $10D
		A4	= $0FE
		Ax4	= $0F0
		B4	= $0E2
		C5	= $0D6
		Cx5	= $0CA
		D5	= $0BE
		Dx5	= $0B4
		E5	= $0AA
		F5	= $0A0
		Fx5	= $097
		G5	= $08F
		Gx5	= $087
		A5	= $07F
		Ax5	= $078
		B5	= $071
		C6	= $06B
		Cx6	= $065
		D6	= $05F
		Dx6	= $05A
		E6	= $055
		F6	= $050
		Fx6	= $04C
		G6	= $047
		Gx6	= $043
		A6	= $040
		Ax6	= $03C
		B6	= $039
		C7	= $035
		Cx7	= $032
		D7	= $030
		Dx7	= $02D
		E7	= $02A
		F7	= $028
		Fx7	= $026
		G7	= $024
		Gx7	= $022
		A7	= $020
		Ax7	= $01E
		B7	= $01C
		C8	= $01B
		Cx8	= $019
		D8	= $018
		Dx8	= $016
		E8	= $015
		F8	= $014
		Fx8	= $013
		G8	= $012
		Gx8	= $011
		A8	= $010
		Ax8	= $00F
		B8	= $00E
		C9	= $00D
		D9	= $00C
		Dx9	= $00B
		F9	= $00A
		G9	= $009
		A9	= $008
		B9	= $007
		D10	= $006
		F10	= $005
		A10	= $004
		D11	= $003
		A11	= $002
		A12	= $001
		none	= $000
	.endenum

; Triangle Volume Controls [1](11.2.a)(p. 8)
TRIANGLE_VOL	.set	$4008
	.enum	triangle_vol
		counter_halt	= 128	
	.endenum

; Triangle Frequency Generator [1](11.2.b)(p. 8)
TRIANGLE_TIMER	.set	$400A

; Triangle Counter [1](11.2.c)(p. 8)
TRIANGLE_COUNTER .set	$400B

; Noise Generator [1](11.3.a)(p. 8)
NOISE_PERIOD	.set	$400E
NOISE_PERIOD_MASK	.set	%00001111
	.enum	noise_period
		C8	= 0
		D8	= 1
		E8	= 2
		F8	= 3
		G8	= 4
		A8	= 5
		B8	= 6
		C9	= 7
		D9	= 8
		E9	= 9
		F9	= 10
		G9	= 11
		A9	= 12
		B9	= 13
		C10	= 14
		D10	= 15
		loop	= 16
	.endenum

; Noise Volume Controls [1](11.3.b)(p. 8)
NOISE_VOL	.set	$400C
NOISE_VOL_HI_BITS .set	%11000000

; Noise Generator Counter [1](11.3.c)(p. 8)
NOISE_COUNTER	.set	$400F

; Delta Modulation [1](11.4)(p. 9)
DMCFLAG		.set	$4010

; Delta Modulation I/O [1](11.4.c)(p. 9)
DMCDATA		.set	$4011
DMCSTATUS	.set	$4015
	.enum	dmcstatus
		none		= 0
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
