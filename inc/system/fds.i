.ifndef	FDS_I
FDS_I	= 1

.include	"./cpu.i"

FDS_TIMER_DATA_LO = $4020
FDS_TIMER_DATA_HI = $4021
FDS_TIMER_CTLR	= $4022

	.enum	fds_timer_ctlr
		repeat = 1
		irq    = 2
	.endenum

FDS_CTLR	= $4025

	.enum fds_ctlr
		motor_off = 0
		motor_on  = 1

		transfer_reset = 2

		io_mode_w = 0
		io_mode_r = 4

		mirror_v = 0
		mirror_h = 8

		crc_ctl = 16

		mask = 32

		drive_ready = 64

		irq = 128
	.endenum

FDS_MEDIA_SR	= $4030

	.enum	fds_media_sr
		timer_irq	= 1
		tx_complete	= 2
	.endenum

FDS_DISK_SR	= $4032

	.enum	fds_disk_sr
		drive_filled	= 0
		drive_empty	= 1
		drive_ready	= 0
		drive_wait	= 2
		drive_rw	= 0
		drive_ro	= 4
	.endenum

FDS_SND_RAM	= $4040
FDS_SND_RAM_END	= $4080

FDS_SND_VOL	= $4080

	.enum	fds_snd_vol_env
		inc	= 64
		dec	= 0

		off	= 128
		on	= 0
	.endenum

FDS_SND_FREQ	= $4082

FDS_SND_MOD_ENV	= $4084

	.enum	fds_snd_mod_env
		inc	= 64
		dec	= 0

		on	= 128
		off	= 0
	.endenum

FDS_SND_MOD_COUNT = $4085
FDS_SND_MOD_FREQ_LO = $4086
FDS_SND_MOD_FREQ_HI = $4087

FDS_SND_MOD_ENV_4X	= $80

FDS_SND_MOD_WRITE = $4088
FDS_SND_WAVE_VOL = $4089

	.enum	fds_snd_wave_vol
		vol_full	= 0
		vol_two_thirds	= 1
		vol_one_half	= 2
		vol_two_fifths	= 3

		bus_req	= 128
		bus_rel	= 0
	.endenum

fdsbios_sleep_short	= $E149

fdsbios_filetbl_load	= $E1F8
FDSBIOS_FILETBL_LOAD_TRY_COUNT	= 2
FDS_FILEHEADER_ID	= 3

fdsbios_file_write	= $E239

fdsbios_diskset_check	= $E3E7
FDS_DISKSET_2ADDR	= $FF

fdsbios_diskhead_check	= $E445
fdsbios_filecount_get	= $E484
fdsbios_oam_dma	= $E9C8

; joypad_read	= $EA1F
; 	.enum	joypad_button
; 		right	= 1
; 		left	= 2
; 		down	= 4
; 		up	= 8
; 		start	= 16
; 		select	= 32
; 		face_b	= 64
; 		face_a	= 128
; 	.endenum

FDS_STACK_NMIMODE	= STACK_BASE+0

	.enum	fds_nmimode
		none	   = $00
		game_vec_0 = $40
		game_vec_1 = $80
		game_vec_2 = $C0
	.endenum

FDS_STACK_IRQMODE	= STACK_BASE+1

	.enum	fds_irqmode
		skip_bytes = 0
		transfer = $40
		ack_dly	 = $80
		game_vec = $C0
	.endenum

FDS_STACK_RESET_F	= STACK_BASE+2
FDS_RESET_READY	= $35
FDS_RESET_FAIL	= $FF

FDS_STACK_RESET_T	= STACK_BASE+3
FDS_RESET_SOFT	= $53
FDS_RESET_FIRSTBOOT = $AC

FDS_VENDOR_NINTENDO	= $01

fds_ctlr_b	= $FA

	.enum	fds_errnos
		disk_set	= $01
		battery		= $02
		ab_side		= $07
		errno_40	= $40
	.endenum

.endif	; FDS_I
