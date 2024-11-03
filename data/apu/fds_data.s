.include	"system/fds.i"

.include	"sound.i"

.segment	"DATA3"

	.export	apu_fds_wave_b_data
apu_fds_wave_b_data:
	.byte	$10
	.byte	$2C
	.byte	$2E
	.byte	$27
	.byte	$29
	.byte	$2B
	.byte	$2A
	.byte	$28
	.byte	$25
	.byte	$29
	.byte	$2F
	.byte	$2D
	.byte	$2C
	.byte	$2A
	.byte	$22
	.byte	$24
	.byte	$34
	.byte	$3F
	.byte	$31
	.byte	$2D
	.byte	$3A
	.byte	$3B
	.byte	$27
	.byte	$12
	.byte	$0A
	.byte	$1F
	.byte	$2C
	.byte	$27
	.byte	$23
	.byte	$28
	.byte	$22
	.byte	$1E
; ------------------------------------------------------------
	.export	apu_fds_wave_a_vols
	.export	apu_fds_wave_b_vols
apu_fds_wave_b_vols:
	.byte	fds_snd_vol_env::off|fds_snd_vol_env::dec|32
	.byte	4

	.byte	fds_snd_vol_env::on|fds_snd_vol_env::dec|24
	.byte	96

apu_fds_wave_a_vols:
	.byte	fds_snd_vol_env::off|fds_snd_vol_env::dec|20
	.byte	2

	.byte	fds_snd_vol_env::on|fds_snd_vol_env::inc|4
	.byte	48

	.byte	fds_snd_vol_env::on|fds_snd_vol_env::dec|10
	.byte	80

	.byte	fds_snd_vol_env::off|fds_snd_vol_env::dec|32
	.byte	fds_snd_vol_env::on|fds_snd_vol_env::dec|2
	.byte	54

	.byte	fds_snd_vol_env::on|fds_snd_vol_env::dec|53
	.byte	128

	.byte	fds_snd_vol_env::on|fds_snd_vol_env::dec|52
; ------------------------------------------------------------
	.export	apu_fds_wave_notes
	.export	apu_fds_wave_note_00
	.export	apu_fds_wave_note_01
	.export	apu_fds_wave_note_02
	.export	apu_fds_wave_note_03
	.export	apu_fds_wave_note_04
	.export	apu_fds_wave_note_05
	.export	apu_fds_wave_note_06
	.export	apu_fds_wave_note_07
	.export	apu_fds_wave_note_08
	.export	apu_fds_wave_note_09
	.export	apu_fds_wave_note_10
	.export	apu_fds_wave_note_11
	.export	apu_fds_wave_note_12
	.export	apu_fds_wave_note_13
	.export	apu_fds_wave_note_14
	.export	apu_fds_wave_note_15
	.export	apu_fds_wave_note_16
	.export	apu_fds_wave_note_17
	.export	apu_fds_wave_note_18
	.export	apu_fds_wave_note_19
	.export	apu_fds_wave_note_20
	.export	apu_fds_wave_note_21
	.export	apu_fds_wave_note_22
	.export	apu_fds_wave_note_23
	.export	apu_fds_wave_note_24
	.export	apu_fds_wave_note_25
	.export	apu_fds_wave_note_26
	.export	apu_fds_wave_note_27
	.export	apu_fds_wave_note_28
	.export	apu_fds_wave_note_29
apu_fds_wave_notes:
apu_fds_wave_note_00:
	.dbyt	$144
apu_fds_wave_note_01:
	.dbyt	$158
apu_fds_wave_note_02:
	.dbyt	$199
apu_fds_wave_note_03:
	.dbyt	$222
apu_fds_wave_note_04:
	.dbyt	$242
apu_fds_wave_note_05:
	.dbyt	$265
apu_fds_wave_note_06:
	.dbyt	$2B0
apu_fds_wave_note_07:
	.dbyt	$2D9
apu_fds_wave_note_08:
	.dbyt	$304
apu_fds_wave_note_09:
	.dbyt	$332
apu_fds_wave_note_10:
	.dbyt	$363
apu_fds_wave_note_11:
	.dbyt	$396
apu_fds_wave_note_12:
	.dbyt	$3CD
apu_fds_wave_note_13:
	.dbyt	$407
apu_fds_wave_note_14:
	.dbyt	$444
apu_fds_wave_note_15:
	.dbyt	$485
apu_fds_wave_note_16:
	.dbyt	$4CA
apu_fds_wave_note_17:
	.dbyt	$513
apu_fds_wave_note_18:
	.dbyt	$560
apu_fds_wave_note_19:
	.dbyt	$5B2
apu_fds_wave_note_20:
	.dbyt	$608
apu_fds_wave_note_21:
	.dbyt	$664
apu_fds_wave_note_22:
	.dbyt	$6C6
apu_fds_wave_note_23:
	.dbyt	$72D
apu_fds_wave_note_24:
	.dbyt	$79A
apu_fds_wave_note_25:
	.dbyt	$80E
apu_fds_wave_note_26:
	.dbyt	$888
apu_fds_wave_note_27:
	.dbyt	$995
apu_fds_wave_note_28:
	.dbyt	$A26
apu_fds_wave_note_29:
	.dbyt	$000
; ------------------------------------------------------------
	.export	apu_fds_envelope
apu_fds_envelope:
	.byte	channel_vol::duty_500|channel_vol::constant_vol|7
	.byte	channel_vol::duty_500|channel_vol::constant_vol|8
	.byte	channel_vol::duty_500|channel_vol::constant_vol|10
	.byte	channel_vol::duty_500|channel_vol::constant_vol|11
	.byte	channel_vol::duty_500|channel_vol::constant_vol|11
	.byte	channel_vol::duty_500|channel_vol::constant_vol|10
	.byte	channel_vol::duty_500|channel_vol::constant_vol|10
	.byte	channel_vol::duty_500|channel_vol::constant_vol|9
	.byte	channel_vol::duty_500|channel_vol::constant_vol|9
	.byte	channel_vol::duty_500|channel_vol::constant_vol|8
	.byte	channel_vol::duty_500|channel_vol::constant_vol|8
	.byte	channel_vol::duty_500|channel_vol::constant_vol|7
	.byte	channel_vol::duty_500|channel_vol::constant_vol|7
	.byte	channel_vol::duty_500|channel_vol::constant_vol|6
	.byte	channel_vol::duty_500|channel_vol::constant_vol|6
	.byte	channel_vol::duty_500|channel_vol::constant_vol|5
