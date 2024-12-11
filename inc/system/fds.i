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
FDS_DISK_ACK_BATTERY	= %10000000

FDS_MEDIA_SR		= $4030
	.enum	fds_media_sr
		timer_irq	= %00000001

		tx_complete	= %00000010

		crc_bit		= %00010000
		crc_error	= crc_bit
		crc_ok		= 0

		end_media	= %01000000

		rw_enable	= %10000000
		rw_disable	= 0
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

; fdsbios_sleep_short - wait 137 cycles
fdsbios_sleep_short	= $E149

; fdsbios_sleep_ms - wait around 1787*y cycles or 1ms
; input:
;	y - milliseconds
; clobbers:
;	x - zero
;	y - zero
fdsbios_sleep_ms	= $E150

; fdsbios_ppuctlr1_blk - set PPU blanking
; clobbers:
;	a
fdsbios_ppuctlr1_blk_on		= $E161
fdsbios_ppuctlr1_blk_off	= $E16B
fdsbios_ppuctlr1_objblk_on	= $E171
fdsbios_ppuctlr1_objblk_off	= $E178
fdsbios_ppuctlr1_bgblk_on	= $E17E
fdsbios_ppuctlr1_bgblk_off	= $E185

; fdsbios_nmi_wait - sync with nmi
fdsbios_nmi_wait	= $E1B2

; fdsbios_filetbl_load - load a series of FDS files
; input:
;	(following jsr)
;	.addr - pointer to FDS disk header reference
;	.addr - pointer to disk table
; output:
;	y - file load count
;	x - error code
;	a - x
fdsbios_filetbl_load	= $E1F8
FDSBIOS_FILETBL_LOAD_TRY_COUNT	= 2
FDSBIOS_FILETBL_ENTRY_MAX	= $14
FDSBIOS_FILETBL_END		= $FF

FDS_DISKHEADER_ID		= 1
FDS_DISKHEADER_STR_IDX		= 2
FDS_DISKHEADER_STR_LAST		= 14
FDS_DISKHEADER_VENDOR_IDX	= 15
FDS_DISKHEADER_STR_END_IDX	= FDS_DISKHEADER_STR_LAST+1
FDS_DISKHEADER_NAME_IDX		= 16
FDS_DISKHEADER_TYPE_IDX		= 19
FDS_DISKHEADER_DISK_ID_IDX	= 20
FDS_DISKHEADER_VER_IDX		= 20
FDS_DISKHEADER_SIDE_IDX		= 21
FDS_DISKHEADER_NUM_IDX		= 22
FDS_DISKHEADER_DISK_TYPE_IDX	= 23
FDS_DISKHEADER_UNK_IDX		= 24
FDS_DISKHEADER_CHECK_END	= 24
FDS_DISKHEADER_FILE_MAX		= 25
FDS_DISKHEADER_DATA_END		= FDS_DISKHEADER_FILE_MAX
FDS_DISKHEADER_SIZE		= 55

FDS_FILECOUNT_ID	= 2
FDS_FILEHEADER_ID	= 3
FDS_FILEHEADER_FILENO_IDX = 1
FDS_FILEHEADER_FILEID_IDX = 2
FDS_FILEHEADER_NAME_IDX	= 3
FDS_FILEHEADER_ADDR_IDX	= 11
FDS_FILEHEADER_NAME_SIZE = (FDS_FILEHEADER_ADDR_IDX-FDS_FILEHEADER_NAME_IDX)
FDS_FILEBLOB_ID		= 4

FDS_VENDOR_NINTENDO	= 1

; fdsbios_file_write - write a file to disk
; input:
;	a - file number
;	(following jsr)
;	.addr - pointer to FDS disk header reference
;	.addr - pointer to FDS file header reference
; output:
;	x - error code
;	a - x
; clobbers:
;	y
fdsbios_file_write	= $E239
FDS_DISKSET_1ADDR	= 0
FDS_DISKSET_2ADDR	= $FF
	fdsbios_disk_ptr_nocheck = $E3E7
	fdsbios_diskhead_check	= $E445
	fdsbios_filecount_get	= $E484
	fdsbios_file_match	= $E4A0
	fdsbios_data_load	= $E4F9
	fdsbios_blocktype_check	= $E68F
	fdsbios_load_done	= $E778

; fdsbios_ppu_displist_write -
; input:
;	(following jsr)
;	.addr	
; output:
; clobbers:
fdsbios_ppu_displist_write	= $E7BB

fdsbios_ppu_inc_load	= $E86A

fdsbios_ppu_buffer_load	= $E8D2
fdsbios_ppu_buffer_tbl_load = $E8E1

; fdsbios_ppu_px_to_nt - convert pixel coordinates to nt address
; input:
;	byte (RAM_BASE+2) - y coordinate
;	byte (RAM_BASE+3) - x coordinate
; output:
;	word (RAM_BASE+0) - nametable 1 address
; clobbers:
;	a
fdsbios_ppu_px_to_nt	= $E97D

; fdsbios_ppu_nt_to_px - convert nt address to pixels
; input:
;	word (RAM_BASE+0) - nametable 1 address
; output:
;	byte (RAM_BASE+2) - y coordinate
;	byte (RAM_BASE+3) - x coordinate
; clobbers:
;	a
fdsbios_ppu_nt_to_px	= $E997
fdsbios_ppu_ntaddr	= RAM_BASE+0       
fdsbios_ppu_y_px	= RAM_BASE+2       
fdsbios_ppu_x_px	= RAM_BASE+3 

; fdsbios_rand - entropy
; input:
;	x - shift register base
;	y - shift register width
; output:
;	entropy in shift register
fdsbios_rand		= $E9B1

; fdsbios_set_obj_dma - trigger OBJ DMA on buffer $200
; input:
;	none
; output:
;	none
; clobbers:
;	a
fdsbios_set_obj_dma	= $E9C8

fdsbios_timers_tick	= $E9D3

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

fdsbios_ppu_fill	= $EA84
fdsbios_ppu_restore	= $EAEA
fdsbios_tbljmp		= $EAFD

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
		read_only	= $03
		headererrs	= $04
		vendor		= headererrs+0
		name		= headererrs+1
		disk_id		= headererrs+2
		ver		= disk_id+0
		ab_side		= disk_id+1
		disk_no		= disk_id+2
		disk_color	= disk_id+3
		errno_10	= $10
		blockerrs	= $21
		blockerr_header	= blockerrs+0
		blockerr_count	= blockerrs+1
		blockerr_fileh	= blockerrs+2
		blockerr_filed	= blockerrs+3
		savefail	= $26
		crcfail		= $27
		crcoverflow	= $28
		txoverflow	= $29
		txwait		= $30
		update_count_fail = $31
		errno_40	= $40
	.endenum

FDS_STACK_WORKING	= FDS_STACK_RESET_T+1

.endif	; FDS_I
