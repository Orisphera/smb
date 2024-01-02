.ifndef	FDS_I
FDS_I	= 1

.include	"./cpu.i"

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

		irq_no = 0
		irq_yes = 128
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

FDS_SND_VOL	= $4080
FDS_SND_VOL_80	= $80

fdsbios_filetbl_load	= $E1F8
FDSBIOS_FILETBL_LOAD_TRY_COUNT	= 2
FDS_FILEHEADER_ID	= 3

fdsbios_diskset_check	= $E3E7
FDS_DISKSET_2ADDR	= $FF

fdsbios_diskhead_check	= $E445
fdsbios_filecount_get	= $E484
sub_E4A0	= $E4A0
sub_E4F9	= $E4F9
sub_E68F	= $E68F
sub_E778	= $E778
sub_E97D	= $E97D
fdsbios_oam_dma	= $E9C8

joypad_read	= $EA1F
	.enum	joypad_button
		right	= 1
		left	= 2
		down	= 4
		up	= 8
		start	= 16
		select	= 32
		face_b	= 64
		face_a	= 128
	.endenum

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

.endif	; FDS_I