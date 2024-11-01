.include	"system/fds.i"

.segment	"DATA3"

	.export	apu_fds_wave_offsets, apu_fds_wave_offsets_a, apu_fds_wave_offsets_b
apu_fds_wave_offsets:
apu_fds_wave_offsets_a:
	.byte	apu_fds_wave_a-apu_fds_wave_offsets
apu_fds_wave_offsets_b:
	.byte	apu_fds_wave_b-apu_fds_wave_offsets
; -----------------------------
apu_fds_wave_a:
	.addr	apu_fds_wave_a_data
	.byte	$44
	.addr	apu_fds_wave_a_vols
	.addr	apu_fds_wave_a_mods
	.byte	<((apu_fds_mod_b-apu_fds_mod)*2)

apu_fds_wave_b:
	.addr	apu_fds_wave_b_data
	.byte	$60
	.addr	apu_fds_wave_b_vols
	.addr	apu_fds_wave_b_mods
	.byte	<((apu_fds_mod_a-apu_fds_mod)*2)
; -----------------------------
	.byte	0
;------------------------------
apu_fds_wave_a_data:
	.byte	$01
	.byte	$02
	.byte	$03
	.byte	$04
	.byte	$06
	.byte	$07
	.byte	$09
	.byte	$0B
	.byte	$0E
	.byte	$10
	.byte	$13
	.byte	$18
	.byte	$20
	.byte	$2B
	.byte	$34
	.byte	$3C
	.byte	$3F
	.byte	$3F
	.byte	$3E
	.byte	$3D
	.byte	$3A
	.byte	$36
	.byte	$32
	.byte	$2F
	.byte	$2C
	.byte	$29
	.byte	$26
	.byte	$24
	.byte	$21
	.byte	$1E
	.byte	$18
	.byte	$19
; -----------------------------
apu_fds_wave_a_mods:
	.byte	fds_snd_mod_env::on|fds_snd_mod_env::dec|0
	.byte	27

	.byte	fds_snd_mod_env::on|fds_snd_mod_env::dec|1
	.word	10
	.byte	4

	.byte	fds_snd_mod_env::on|fds_snd_mod_env::dec|2
	.word	16
	.byte	96

apu_fds_wave_b_mods:
	.byte	fds_snd_mod_env::on|fds_snd_mod_env::dec|0
	.byte	2

	.byte	fds_snd_mod_env::on|fds_snd_mod_env::dec|0
	.word	0
	.byte	96
