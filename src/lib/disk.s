.include	"system/ppu.i"
.include	"system/palettes.i"
.include	"system/fds.i"

.include	"mem.i"
.include	"modes.i"
.include	"misc.i"
.include	"fileids.i"

.include	"unk.i"

	.export sys_disk_loader
sys_disk_loader:
	lda	mode_game
	jsr	tbljmp
	.addr	disk_loader_main
	.addr	title_init_0
	
	.if	.defined(ANN)
		.addr	disk_loader_inc_mode_game
	.endif

	.addr	screen_proc
	.addr	title_init_1
	.addr	title_proc
	.addr	disk_loader_data4
; ------------------------------------------------------------
disk_loader_data4:
	lda	disk_loader_proc
	jsr	tbljmp
	.addr	disk_loader_prompt
	.addr	disk_loader_file_load_data4
	.addr	disk_loader_wait_eject
	.addr	disk_loader_wait_insert
	.addr	disk_loader_bootstrap
; -----------------------------
disk_loader_file_load_data4:
	lda	ENG_HARDMODE_VAR
	beq	:+ ; if (ENG_HARDMODE_VAR) {
		lda	#fds_file_ids::data4
		sta	disk_loader_file_id

		jsr	disk_load_files
		bne	disk_loader_file_load_err

		jsr	disk_loader_file_count_check
		bne	disk_loader_file_count_err
	: ; }

	jsr	course_descriptor_load
	lda	ENG_HARDMODE_VAR
	beq	:+ ; if (ENG_HARDMODE_VAR) {
		jsr	sub_C3D6
	: ; }

	inc	bg_hidden_one_up_req
	inc	eng_req_timer
	inc	mode_system
	lda	#fds_loader_procs::prompt_00|game_modes::init_data2
	sta	disk_loader_proc
	sta	mode_game
	sta	timer_demo
	rts
; ------------------------------------------------------------
disk_loader_main:
	lda	disk_loader_proc
	jsr	tbljmp
	.addr	disk_loader_prompt
	.addr	disk_loader_file_load_main
	.addr	disk_loader_wait_eject
	.addr	disk_loader_wait_insert
	.addr	disk_loader_bootstrap
; -----------------------------
disk_loader_file_load_main:
	lda	disk_loader_main_req
	beq	:++++
	lda	ENG_HARDMODE_VAR
	bne	:+
	lda	course_no
	cmp	#course::no_05
	bcc	:++++
	: ; if (disk_loader_main_req && (ENG_HARDMODE_VAR || course.no >= no_05)) {
		lda	#fds_file_ids::main
		sta	disk_loader_file_id
		jsr	disk_load_files
		bne	:+
		jsr	disk_loader_file_count_check
		beq	:++ ; if (disk_loader.file_load_do(main)) {
			; if (disk_loader_file_count_check()) {
			disk_loader_file_count_err: 
				lda	#fds_errnos::errno_40
			: ; }
	
		disk_loader_file_load_err:
			inc	disk_loader_proc
			jmp	disk_perror
		: ; }
	: ; }

	lda	#1
	sta	disk_loader_main_req
	lsr	a
	sta	course_no
	sta	ENG_HARDMODE_VAR
	jmp	disk_loader_next
; ------------------------------------------------------------
	.export disk_loader_data2
disk_loader_data2:
	lda	disk_loader_proc
	jsr	tbljmp
	.addr	disk_loader_prompt
	.addr	disk_loader_file_load_data2
	.addr	disk_loader_wait_eject
	.addr	disk_loader_wait_insert
	.addr	disk_loader_bootstrap
; -----------------------------
disk_loader_file_load_data2:
	lda	course_no
	cmp	#course::no_05
	bcc	disk_loader_next
	lda	disk_loader_file_id
	bne	disk_loader_next ; if (course.no >= no_05 && disk_loader.file_id == main) {
		lda	#fds_file_ids::data2
		sta	disk_loader_file_id

		jsr	disk_load_files
		bne	disk_loader_file_load_err
		jsr	disk_loader_file_count_check
		bne	disk_loader_file_count_err
	; }

	; if (disk_load_files(data2) == 0 && disk_loader_file_count_chec() == 0) {
	disk_loader_next:
		lda	#fds_loader_procs::prompt_00
		sta	disk_loader_proc
	
	disk_loader_inc_mode_game:
		inc	mode_game
		rts
	; }
; ------------------------------------------------------------
	.export disk_loader_victory_init, disk_loader_victory_check
disk_loader_victory_init:
	lda	#16
	sta	timer_victory
	bne	disk_loader_inc_mode_game

disk_loader_victory_check:
	lda	timer_victory
	beq	disk_loader_inc_mode_game
	rts
; ------------------------------------------------------------
.if	.defined(SMB2)
	VICTORY_CUTOFF	= 24
.elseif	.defined(ANN)
	VICTORY_CUTOFF	= 20
.endif

	.export disk_loader_data3
disk_loader_data3:
	lda	disk_loader_proc
	jsr	tbljmp
	.addr	disk_loader_prompt
	.addr	disk_loader_file_load_data3
	.addr	disk_loader_wait_eject
	.addr	disk_loader_wait_insert
	.addr	disk_loader_bootstrap
; -----------------------------
disk_loader_file_load_data3:
	lda	#fds_file_ids::data3
	sta	disk_loader_file_id
	jsr	disk_load_files
	bne	disk_loader_file_load_err ; if (!disk_load_files(data3)) {
		jsr	disk_loader_file_count_check
		beq	:+ ; if (disk_loader_file_count_check(data3)) {
			lda	#0
			sta	save
		: ; }

		lda	save
		clc
		adc	#1
		cmp	#VICTORY_CUTOFF+1
		bcc	:+ ; if (save++ >= VICTORY_CUTOFF) {
			lda	#VICTORY_CUTOFF
		: ; }
		sta	save

		.if	.defined(ANN)
			lda	#1
			sta	byte_77D
		.endif

		jsr	nt_init
		jsr	disk_loader_next
		jmp	ending_text_player_set
	; } else disk_loader_file_load_err();
; ------------------------------------------------------------
disk_loader_file_count_check:
	tya
	ldy	disk_loader_file_id
	cmp	filetbl_lens, y
	rts
; -----------------------------
	.export	disk_header_id
disk_header_id:
	.byte	FDS_VENDOR_NINTENDO
.if	.defined(SMB2)
	.byte	"SMB "
.elseif	.defined(ANN)
	.byte	"NSM "
.endif

	.byte	0

disk_sideb_current:	.byte	0

	.byte	0, 0, 0

filelist_files_lo:
	.byte	<filetbl_main
	.byte	<filetbl_data2
	.byte	<filetbl_data3
	.byte	<filetbl_data4

filelist_files_hi:
	.byte	>filetbl_main
	.byte	>filetbl_data2
	.byte	>filetbl_data3
	.byte	>filetbl_data4

filetbl_main:
	.byte	FILE_ID_CHAR1
	.byte	FILE_ID_MAIN
	.byte	FILE_ID_SAVE
filetbl_main_end:
	.byte	FILE_ID_NULL

filetbl_data2:
	.byte	FILE_ID_DATA2
filetbl_data2_end:
	.byte	FILE_ID_NULL

filetbl_data3:
	.byte	FILE_ID_CHAR2
	.byte	FILE_ID_DATA3
	.byte	FILE_ID_SAVE
filetbl_data3_end:
	.byte	FILE_ID_NULL

filetbl_data4:
	.byte	FILE_ID_DATA4
filetbl_data4_end:
	.byte	FILE_ID_NULL

filetbl_lens:
	.byte	filetbl_main_end-filetbl_main
	.byte	filetbl_data2_end-filetbl_data2
	.byte	filetbl_data3_end-filetbl_data3
	.byte	filetbl_data4_end-filetbl_data4
; -----------------------------
disk_load_files:
	ldx	disk_loader_file_id
	lda	filelist_files_lo, x
	sta	fileptr_filetbl
	lda	filelist_files_hi, x
	sta	fileptr_filetbl+1
	jsr	fdsbios_filetbl_load
	.addr	disk_header_id
fileptr_filetbl:
	.addr	filetbl_main

	rts
; ------------------------------------------------------------
	.export	disk_perror_pal
disk_perror_pal:
	.dbyt	PPU_VRAM_COLOR
	.byte	((:++)-(:+))
	: .byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3, PPU_COLOR_GREY3, PPU_COLOR_PITCH0
	: .byte	NMI_LIST_END
; ------------------------------------------------------------
	.export	disk_loader_prompt
disk_loader_prompt:
	lda	#ppu_ctlr1::objblk_on|ppu_ctlr1::bgblk_on|ppu_ctlr1::objlblk_on|ppu_ctlr1::bglblk_on|ppu_ctlr1::color
	sta	ppu_ctlr1_b
	sta	PPU_CTLR1
	inc	nmi_disp_disable
	lda	#nmi_addr::disk_perror_pal
	sta	nmi_addrs_ctl
	jmp	:+
; -----------------------------
	.export	disk_loader_wait_eject
disk_loader_wait_eject:
	lda	#ppu_ctlr0::bg1
	sta	ppu_ctlr0_bg
	sta	nmi_disp_disable
	lda	FDS_DISK_SR
	lsr	a
	bcc	:++
	: ; if (
	;	proc == prompt
	;	|| (proc == wait_eject && (FDS_DISK_SR & drive_empty))
	;	|| (proc == wait_insert && !(FDS_DISK_SR & drive_empty))
	; ) {
		inc	disk_loader_proc
	: ; }

	rts
; -----------------------------
	.export	disk_loader_wait_insert
disk_loader_wait_insert:
	lda	FDS_DISK_SR
	lsr	a
	bcc	:--
	bcs	:-
; ------------------------------------------------------------
	.export	disk_loader_bootstrap
disk_loader_bootstrap:
	lda	#fds_loader_procs::prompt_00
	sta	disk_loader_proc
	sta	disk_loader_file_id
	rts
; ------------------------------------------------------------
.include	"charmap.i"

	.export disk_text_error_buffer
disk_text_error_buffer:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_6
	.byte	disk_text_error_buffer_end-disk_text_error_buffer_start
disk_text_error_buffer_start:
	.byte	"        "
disk_text_error_buffer_end:

disk_text_errorbase:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_15+PPU_BG_COL_20
	.byte	disk_text_errorbase_end-disk_text_errorbase_start
disk_text_errorbase_start:
	.byte	"ERR 01"
disk_text_errorbase_end:
	.byte	NMI_LIST_END

disk_text_error_entries:
	.byte	(disk_text_error_gen_end-disk_text_errors)-1
	.byte	(disk_text_error_disk_set_end-disk_text_errors)-1
	.byte	(disk_text_error_battery_end-disk_text_errors)-1
disk_text_error_entries_ab_side:
	.byte	(disk_text_error_ab_side_end-disk_text_errors)-1

disk_text_errors:
disk_text_error_gen:
	.byte	"        "
disk_text_error_gen_end:

disk_text_error_disk_set:
	.byte	"DISK SET"
disk_text_error_disk_set_end:

disk_text_error_battery:
	.byte	"BATTERY "
disk_text_error_battery_end:

disk_text_error_ab_side:
	.byte	"A B SIDE"
disk_text_error_ab_side_end:
; -----------------------------
	.export	disk_perror
disk_perror:
	pha

	and	#%00001111
	sta	disk_text_errorbase_start+5

	pla
	pha

	lsr	a
	lsr	a
	lsr	a
	lsr	a
	sta	disk_text_errorbase_start+4

	ldy	#disk_text_error_entries_ab_side-disk_text_error_entries

	pla
	cmp	#fds_errnos::ab_side
	beq	:+ ; if (errno != ab_side) {
		dey
		cmp	#fds_errnos::battery
		beq	:+ ; if (errno != battery) {
			dey
			cmp	#fds_errnos::disk_set
			beq	:+ ; if (errno != disk_set) {
				dey
			; }
		; }
	: ; }

	ldx	disk_text_error_entries, y
	ldy	#ENG_ERR_MSG_SIZE_MAX-1
	: ; for (character of error) {
		lda	disk_text_errors, x
		sta	disk_text_error_buffer_start, y

		dex
		dey
		bpl	:-
	; }

	lda	#nmi_addr::disk_text_error_buffer
	sta	nmi_addrs_ctl
	jsr	oam_init
	jmp	nt_init
