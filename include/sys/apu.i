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
		envelope	= %00000000

		constant_vol	= %00010000
		counter_halt	= %00100000


		duty_bits	= %11000000
		duty_125	= (0<<6)
		duty_250	= (1<<6)
		duty_500	= (2<<6)
		duty_750	= (3<<6)
	.endenum
PULSE1_VOL	.set	$4000

; Sweep Clock Generator [1](11.1.c)(p. 5-6)
PULSE_SWEEP	.set	$4001
	.enum   pulse_sweep
		shift_mask	= %00000111
		shift_0		= 0
		shift_1		= 1
		shift_2		= 2
		shift_3		= 3
		shift_4		= 4
		shift_5		= 5
		shift_6		= 6
		shift_7		= 7

		negate		= %00001000

		period_mask	= %01110000
		period_1hf	= (0<<4)
		period_2hf	= (1<<4)
		period_3hf	= (2<<4)
		period_4hf	= (3<<4)
		period_5hf	= (4<<4)
		period_6hf	= (5<<4)
		period_7hf	= (6<<4)
		period_8hf	= (7<<4)

		enable		= %10000000
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
	.ifndef	PAL_APU
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
	.else
		; NOTE: The PAL timer values are derived from
		; comparison between PAL and NTSC titles
		; As such, only notes discovered in those titles
		; are defined. All others are commented out
		; for now.
		;
		; Note values were adjusted for the same
		; offsets as the NTSC region, therefore
		; fractional changes in tone may be observed
		; when using these values for PAL systems
		.enum	apu_chromatic_scale
			; A1	= $7F2
			; Ax1	= $780
			; B1	= $714
			; C2	= $6AE
			; Cx2	= $64E
			; D2	= $5F4
			; Dx2	= $59E
			; E2	= $54D
			; F2	= $501
			; Fx2	= $4B9
			G2	= $41D
			; Gx2	= $435
			; A2	= $3F9
			; Ax2	= $3C0
			; B2	= $38A
			C3	= $315
			; Cx3	= $327
			D3	= $2BF
			Dx3	= $298
			E3	= $273
			F3	= $250
			Fx3	= $22F
			G3	= $20A
			Gx3	= $1ED
			A3	= $1D5
			Ax3	= $1C7
			B3	= $1A2
			C4	= $18B
			Cx4	= $175
			D4	= $160
			Dx4	= $14C
			E4	= $139
			F4	= $127
			Fx4	= $117
			G4	= $107
			Gx4	= $0F8
			A4	= $0EA
			Ax4	= $0DE
			B4	= $0D1
			C5	= $0C6
			Cx5	= $0BB
			D5	= $0AF
			Dx5	= $0A6
			E5	= $09D
			F5	= $094
			Fx5	= $08B
			G5	= $084
			Gx5	= $07D
			A5	= $075
			Ax5	= $06F
			B5	= $068
			C6	= $063
			Cx6	= $05D
			D6	= $058
			Dx6	= $053
			E6	= $04F
			F6	= $04A
			; Fx6	= $04C
			G6	= $042
			Gx6	= $03E
			; A6	= $040
			Ax6	= $037
			; B6	= $039
			C7	= $031
			; Cx7	= $032
			D7	= $02C
			; Dx7	= $02D
			E7	= $027
			; F7	= $028
			; Fx7	= $026
			G7	= $021
			; Gx7	= $022
			; A7	= $020
			; Ax7	= $01E
			; B7	= $01C
			; C8	= $01B
			; Cx8	= $019
			; D8	= $018
			; Dx8	= $016
			; E8	= $015
			; F8	= $014
			; Fx8	= $013
			; G8	= $012
			; Gx8	= $011
			; A8	= $010
			; Ax8	= $00F
			; B8	= $00E
			; C9	= $00D
			; D9	= $00C
			; Dx9	= $00B
			; F9	= $00A
			; G9	= $009
			; A9	= $008
			; B9	= $007
			; D10	= $006
			; F10	= $005
			; A10	= $004
			; D11	= $003
			; A11	= $002
			; A12	= $001
			none	= $000
		.endenum
	.endif

; Triangle Volume Controls [1](11.2.a)(p. 8)
TRIANGLE_VOL	.set	$4008
	.enum	triangle_vol
		volume_bits	= %01111111
		full		= volume_bits

		counter_halt	= %10000000
	.endenum

; Triangle Frequency Generator [1](11.2.b)(p. 8)
TRIANGLE_TIMER	.set	$400A

; Triangle Counter [1](11.2.c)(p. 8)
TRIANGLE_COUNTER .set	$400B

; Noise Generator [1](11.3.a)(p. 8)
NOISE_PERIOD	.set	$400E
	.enum	noise_period
		mask	= %00001111
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

		loop	= %00010000
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
		pulse_1		= %00000001
		pulse_2		= %00000010
		tri		= %00000100
		noise		= %00001000
		dmc		= %00010000
		none		= 0

		frame_interrupt	= %01000000
		dmc_interrupt	= %10000000
	.endenum
DMCFRAMECOUNT	.set	$4017

.endif	; APU_I
