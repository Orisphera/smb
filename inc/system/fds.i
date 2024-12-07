.ifndef	FDS_I
FDS_I	= 1

.include	"./cpu.i"

FDS_TIMER_DATA_LO	= $4020
FDS_TIMER_DATA_HI	= $4021
FDS_TIMER_CTLR		= $4022
	.enum	fds_timer_ctlr
		repeat	= %00000001
		irq	= %00000010
	.endenum

FDS_IO_ENABLE   	= $4023
	.enum	fds_io 
		disk	= %00000001
		sound	= %00000010
		mask	= %10000000
	.endenum

FDS_DATA_WRITE		= $4024

FDS_CTLR		= $4025
	.enum fds_ctlr
		motor		= %00000001
		motor_on	= motor
		motor_off	= 0

		transfer_reset	= %00000010

		io_mode		= %00000100
		io_mode_r	= io_mode
		io_mode_w	= 0

		mirror		= %00001000
		mirror_h	= mirror
		mirror_v	= 0

		crc_ctl		= %00010000

		mask		= %00100000

		drive_ready	= %01000000

		irq		= %10000000
		irq_yes		= irq
		irq_no		= 0
	.endenum

FDS_DISK_ACK		= $4026

FDS_MEDIA_SR		= $4030
	.enum	fds_media_sr
		timer_irq	= %00000001
		tx_complete	= %00000010
	.endenum

FDS_DATA_READ		= $4031

FDS_DISK_SR		= $4032
	.enum	fds_disk_sr
		drive_filled_state	= %00000001
		drive_empty		= drive_filled_state
		drive_filled		= 0

		drive_wait_state	= %00000010
		drive_wait		= drive_wait_state
		drive_ready		= 0

		drive_ro_state		= %00000100
		drive_ro		= drive_ro_state
		drive_rw		= 0
	.endenum

FDS_EXT_READ		= $4033

FDS_SND_RAM		= $4040
FDS_SND_RAM_END		= $4080

FDS_SND_VOL		= $4080
	.enum	fds_snd_vol_env
		inc_bit	= %01000000
		inc	= inc_bit
		dec	= 0

		off_bit	= %10000000
		off	= off_bit
		on	= 0
	.endenum

FDS_SND_FREQ		= $4082

FDS_SND_MOD_ENV		= $4084
	.enum	fds_snd_mod_env
		inc_bit	= %01000000
		inc	= inc_bit
		dec	= 0

		on_bit	= %10000000
		on	= on_bit
		off	= 0
	.endenum

FDS_SND_MOD_COUNT	= $4085
FDS_SND_MOD_FREQ_LO	= $4086
FDS_SND_MOD_FREQ_HI	= $4087

FDS_SND_MOD_ENV_4X	= $80

FDS_SND_MOD_WRITE	= $4088
FDS_SND_WAVE_VOL	= $4089
	.enum	fds_snd_wave_vol
		vol_full	= 0
		vol_two_thirds	= 1
		vol_one_half	= 2
		vol_two_fifths	= 3

		bus_req_bit	= %10000000
		bus_req		= bus_req_bit
		bus_rel		= 0
	.endenum

FDS_SND_ENV_SPD		= $408A

fdsbios_sleep_short	= $E149

fdsbios_filetbl_load	= $E1F8
FDSBIOS_FILETBL_LOAD_TRY_COUNT = 2

FDS_DISKHEADER_ID	= 1
FDS_FILECOUNT_ID	= 2
FDS_FILEHEADER_ID	= 3
FDS_FILEBLOB_ID		= 4

FDS_VENDOR_NINTENDO	= 1

fdsbios_file_write	= $E239
FDS_FILE_WRITE_DO_LAST	= $FF

fdsbios_diskset_check	= $E3E7
FDS_DISKSET_2ADDR	= $FF

fdsbios_diskhead_check	= $E445
fdsbios_filecount_get	= $E484

fdsbios_E4A0		= $E4A0
fdsbios_E4F9		= $E4F9
fdsbios_E68F		= $E68F
fdsbios_E778		= $E778
fdsbios_E7BB		= $E7BB
fdsbios_E818		= $E818
fdsbios_E97D		= $E97D
fdsbios_E9B1		= $E9B1

fdsbios_set_obj_dma	= $E9C8

fdsbios_E9D3		= $E9D3

fdsbios_joypad_read	= $EA1F
	.enum	fds_joypad_button
 		right	= %00000001
 		left	= %00000010
 		down	= %00000100
 		up	= %00001000
 		start	= %00010000
 		select	= %00100000
 		face_b	= %01000000
 		face_a	= %10000000
 	.endenum

fdsbios_EA29		= $EA29
fdsbios_EA84		= $EA84
fdsbios_EAEA		= $EAEA
fdsbios_EF29		= $EF29

FDS_PPU_CTLR0_B		= $FF
FDS_PPU_CTLR1_B		= FDS_PPU_CTLR0_B-1
FDS_PPU_SCC_H_B		= FDS_PPU_CTLR1_B-1
FDS_PPU_SCC_V_B		= FDS_PPU_SCC_H_B-1
FDS_CTRL0_B		= FDS_PPU_SCC_V_B-1
FDS_CTLR_B		= FDS_CTRL0_B-1
FDS_DISK_ACK_B		= FDS_CTLR_B-1

FDS_STACK_INTMASK	= %11000000
FDS_STACK_INTBIT	= 6

FDS_STACK_NMIMODE	= STACK_BASE+0
	.enum	fds_nmimode
		mask		= FDS_STACK_INTMASK
		none		= (0<<FDS_STACK_INTBIT)
		game_vec_0	= (1<<FDS_STACK_INTBIT)
		game_vec_1	= (2<<FDS_STACK_INTBIT)
		game_vec_2	= (3<<FDS_STACK_INTBIT)
	.endenum

FDS_STACK_IRQMODE	= FDS_STACK_NMIMODE+1
	.enum	fds_irqmode
		mask		= FDS_STACK_INTMASK
		skip_bytes	= (0<<FDS_STACK_INTBIT)
		transfer 	= (1<<FDS_STACK_INTBIT)
		ack_dly	 	= (2<<FDS_STACK_INTBIT)
		game_vec 	= (3<<FDS_STACK_INTBIT)
	.endenum

FDS_STACK_RESET_F	= FDS_STACK_IRQMODE+1
FDS_RESET_HOLD		= $00
FDS_RESET_READY		= $35
FDS_RESET_FAIL		= $FF

FDS_STACK_RESET_T	= FDS_STACK_RESET_F+1
FDS_RESET_SOFT		= $53
FDS_RESET_FIRSTBOOT	= $AC

	.enum	fds_errnos
		disk_set	= $01
		battery		= $02
		ab_side		= $07
		errno_40	= $40
	.endenum

.endif	; FDS_I
