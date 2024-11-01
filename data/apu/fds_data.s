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
apu_fds_wave_notes:
	.dbyt	$144
	.dbyt	$158
	.dbyt	$199
	.dbyt	$222
	.dbyt	$242
	.dbyt	$265
	.dbyt	$2B0
	.dbyt	$2D9
	.dbyt	$304
	.dbyt	$332
	.dbyt	$363
	.dbyt	$396
	.dbyt	$3CD
	.dbyt	$407
	.dbyt	$444
	.dbyt	$485
	.dbyt	$4CA
	.dbyt	$513
	.dbyt	$560
	.dbyt	$5B2
	.dbyt	$608
	.dbyt	$664
	.dbyt	$6C6
	.dbyt	$72D
	.dbyt	$79A
	.dbyt	$80E
	.dbyt	$888
	.dbyt	$995
	.dbyt	$A26
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
