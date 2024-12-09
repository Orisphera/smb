.include	"system/cpu.i"
.include	"system/ppu.i"
.include	"system/palette.i"
.include	"system/fds.i"

.include	"math.i"
.include	"mem.i"
.include	"modes.i"
.include	"misc.i"
.include	"fileids.i"
.include	"sound.i"
.include	"chr.i"

.segment	"DATA3"

.if	.defined(SMB2)
	.export	ending_course_plus_msg
ending_course_plus_msg:
	lda	proc_id_system
	cmp	#system_modes::game_over
	beq	:++ ; if (proc_id_system != game_over) {
		lda	course_plus_msg_flg
		bne	:+ ; if (!course_plus_msg_flg) {
			lda	#nmi_addr::ending_course_plus_txt
			sta	nmi_buffer_ptr

			lda	#16
			sta	timer_screen

			inc	course_plus_msg_flg
		: ; }

		lda	#0
		sta	nmi_disp_disable

		jmp	ending_screen_proc_next
	: ; } else {
		lda	#32
		sta	timer_screen

		lda	#nmi_addr::ending_super_player_txt
		sta	nmi_buffer_ptr

		jmp	ending_state_next
	; }
.endif
; -----------------------------
	.export	ending_screen_proc
ending_screen_proc:
	lda	screen_proc_id
	jsr	tbljmp
	.addr	screen_init_title
	.addr	screen_text_draw_header
	.addr	screen_text_draw_splash
	.addr	ending_throneroom_show
	.addr	screen_color_init_2
	.addr	screen_color_init_3
.if	.defined(ANN)
	.addr	ending_pal_load_ext
.endif
	.addr	ending_princess_show
; -----------------------------
ending_throneroom_show:
	lda	#nmi_addr::ending_throneroom_map
	sta	nmi_buffer_ptr

	sta	nmi_sprite_overlap

ending_screen_proc_next:
	inc	screen_proc_id
	rts
; -----------------------------
.if	.defined(ANN)
ending_pal_load_ext:
	lda	#nmi_addr::ending_pal_ext
	sta	nmi_buffer_ptr
	inc	screen_proc_id
	rts
.endif
; -----------------------------
ending_princess_show:
	lda	#(10<<4)|(stats::time)
	jsr	stats_print_num
	lda	#>apu_fds_cycle
	sta	nmi_apu_call+OP_SIZE+1
	lda	#<apu_fds_cycle
	sta	nmi_apu_call+OP_SIZE
	lda	#music_fds::ending
	sta	apu_music_base_req

	lda	#0
	sta	joypad_l_r
	sta	ppu_ctlr0_bg
	sta	nmi_sprite_overlap
	sta	nmi_disp_disable

ending_state_next:
	inc	proc_id_game
	rts
; ------------------------------------------------------------
	.export	ending_victory_msg
ending_victory_msg:
	lda	timer_victory_msg
	bne	:++
	ldy	victory_msg_id
	cpy	#10
	bcs	:+++ ; if (this.timer != 0 || this.msg_id < 10) {
		; if (this.timer == 0) {
			iny
			iny
			iny
			cpy	#5
			bne	:+ ; if ((victory_msg_id + 3) == 5) {
				lda	#music_event::victory_ending
				sta	apu_music_event_req
			: ; }
		
			tya
			clc
			adc	#nmi_addr::msg_base
			sta	nmi_buffer_ptr
		: ; }

		lda	timer_victory_msg
		clc
		adc	#VICTORY_TICK
		sta	timer_victory_msg
		lda	victory_msg_id
		adc	#0
		sta	victory_msg_id
		rts
	: ; } else {
		lda	#12
		sta	timer_victory

	ending_state_next_init:
		inc	proc_id_game

	ending_vars_init:
		lda	#0
		sta	timer_ending
		sta	ending_palcycle_step
		sta	ending_palcycle_delay
		: rts
	; }
; -----------------------------
	.export	ending_extra_lives
ending_extra_lives:
	lda	timer_victory
	bne	:-
	lda	player_lives
	bmi	ending_state_next_init
	lda	timer_select
	bne	:- ; if (timer_victory == 0 && player.lives >= 0 && timer_select == 0) {
		lda	#48
		sta	timer_select
		lda	#sfx_pulse_2::oneup
		sta	apu_sfx_pulse_2_req
		dec	player_lives
		lda	#1
		sta	ending_player_live
	.if	.defined(SMB2)
		jmp	actor_proc_course_end_stats
	.elseif	.defined(ANN)
		jsr	actor_proc_course_end_stats
		lda	apu_fds_music_current
		bne	:+ ; if (music.fds.current == 0) {
			lda	#music_fds::ending
			sta	apu_music_base_req
		: ; }
		rts
	.endif
	; } else rts;
; ------------------------------------------------------------
ending_pal:
	.dbyt	PPU_VRAM_COLOR
	.byte	(:++)-(:+)
	: 
ending_pal_bytes:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3, PPU_COLOR_PITCH0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3, PPU_COLOR_GREY1, PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_AZURE2, PPU_COLOR_BLUE1, PPU_COLOR_AZURE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
ending_pal_bytes_end:
	: .byte	NMI_LIST_END
ending_pal_end:

ending_pal_var:
	.byte	PPU_COLOR_AZURE0, PPU_COLOR_BLUE0, PPU_COLOR_AZURE1, PPU_COLOR_AZURE2
ending_pal_var_end:

ending_lives_disp:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_20+PPU_BG_COL_6
	.byte	NMI_REPEAT|21, chr_bg::blanks+0
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_21+PPU_BG_COL_6
	.byte	NMI_REPEAT|21, chr_bg::blanks+0
	.byte	NMI_LIST_END
ending_lives_disp_end:
; -----------------------------
	.export	ending_palcycle
ending_palcycle:
	inc	timer_ending

	lda	ending_palcycle_delay
	bne	:+
	lda	timer_ending
	and	#$FF
	bne	:+++++
	inc	ending_palcycle_delay
	jmp	:++
	: lda	timer_ending
	and	#MOD_16
	bne	:++++
	: ; if ((!ending_palcycle_delay && timer_ending == 0) || (timer_ending % 16) == 0) {
		ldx	#(ending_pal_end-ending_pal)-1
		: ; for (byte of ending_pal) {
			lda	ending_pal, x
			sta	ppu_displist_0_data, x

			dex
			bpl	:-
		; }
	
		ldx	#(ending_pal_bytes_end-ending_pal_bytes)-(PPU_COLOR_LINE_SIZE)
		ldy	ending_palcycle_step
		: ; for (entry_0 of palette_line) {
			lda	ending_pal_var, y
			sta	ppu_displist_0_data+3, x
	
			dex
			dex
			dex
			dex
			bpl	:-
		; }
	
		inc	ending_palcycle_step
		lda	ending_palcycle_step
		cmp	#ending_pal_var_end-ending_pal_var
		bne	:+ ; if (++ending_palcycle_step == ending_pal_var_end) {
			inc	proc_id_game
		; }
	: ; }

	rts
; -----------------------------
	.export	ending_lives_draw
ending_lives_draw:
	ldx	#(ending_lives_disp_end-ending_lives_disp)-1
	: ; for (byte of ending_lives_disp) {
		lda	ending_lives_disp, x
		sta	ppu_displist_0_data, x

		dex
		bpl	:-
	; }

	inc	proc_id_game

	jsr	ending_vars_init

	lda	#96
	sta	ending_toad_delay

	.if	.defined(ANN)
		lda	#2
		sta	timer_unk_b
	.endif

	rts
; ------------------------------------------------------------
	.export	ending_toad_proc
ending_toad_proc:
	jsr	ending_toad_render
	lda	apu_fds_music_current
	bne	:++

	.if	.defined(ANN)
		lda	timer_unk_b
		beq	:+ ; if (timer_unk_b > 0) {
			lda	#music_fds::ending
			sta	apu_music_base_req
			rts
		; }
	.endif

	: lda	ENG_HARDMODE_VAR
	bne	disk_loader_file_load_save_done ; if (music.fds.current == 0 && !game.hard_mode) {
		inc	proc_id_game
	: ; }

	rts
; ------------------------------------------------------------
	.export	disk_loader_save
disk_loader_save:
	lda	disk_loader_proc
	jsr	tbljmp
	.addr	disk_loader_prompt
	.addr	disk_loader_file_load_save
	.addr	disk_loader_wait_eject
	.addr	disk_loader_wait_insert
	.addr	disk_loader_bootstrap
; -----------------------------
disk_header_save:
	.byte	FILE_ID_SAVE, "SM2SAVE "
	.addr	save
	.byte	1, 0
	.byte	0
	.addr	save
	.byte	0
; -----------------------------
disk_loader_file_load_save:
	lda	#FILE_NO_SAVE
	jsr	fdsbios_file_write
	.addr	disk_header_id
	.addr	disk_header_save
	beq	disk_loader_file_load_save_done
	inc	disk_loader_proc
	jmp	disk_perror
; ------------------------------------------------------------
disk_loader_file_load_save_done:
	lda	#>apu_cycle
	sta	nmi_apu_call+OP_SIZE+1
	lda	#<apu_cycle
	sta	nmi_apu_call+OP_SIZE
	lda	#fds_loader_procs::prompt_00
	sta	disk_loader_proc
	sta	proc_id_game

.if	.defined(SMB2)
	lda	ENG_HARDMODE_VAR
	bne	:+
	lda	game_courses_cleared
	cmp	#$FF
	beq	:++
	: ; if () {
.endif
		lda	#0

		.if	.defined(SMB2)
			sta	game_courses_cleared
		.endif

		sta	proc_id_system
		jmp	sys_disk_loader
	: ; } else {
.if	.defined(SMB2)
		lda	#0
		sta	game_courses_cleared

		sta	player_lives
		sta	course_plus_msg_flg
		jmp	victory_finish_do
	; }
.endif
; ------------------------------------------------------------
ending_toad_render_data_offset:
	.byte	$50, $B0, $E0, $68, $98, $C8

ending_toad_render_data_offset_next:
	.byte	$80, $50, $68, $80, $98, $B0, $C8

ending_toad_render_pos_y:
	.byte	224, 184, 144, 112, 104, 112, 144

ending_toad_render_pos_x:
	.byte	184, 56, 72, 96, 128, 160, 184, 200

.if	.defined(ANN)
ending_toad_render_chr_base:
	.byte	chr_obj::toads_nsm_a
	.byte	chr_obj::toads_nsm_b
	.byte	chr_obj::toads_nsm_c
	.byte	chr_obj::toads_nsm_d
	.byte	chr_obj::toads_nsm_e
	.byte	chr_obj::toads_nsm_f
	.byte	chr_obj::toads_nsm_g

ending_toad_render_attrs:
	.byte	obj_attr::color2
	.byte	obj_attr::color3
	.byte	obj_attr::color1
	.byte	obj_attr::color2
	.byte	obj_attr::color3
	.byte	obj_attr::color1
	.byte	obj_attr::color3
.endif
; -----------------------------
ending_toad_render_CHR_NO	= zp_byte_00
ending_toad_render_ATTR		= zp_byte_01

ending_toad_render:
	lda	ending_toad_delay
	beq	:+ ; if (ending_toad_delay > 0) {
		dec	ending_toad_delay
		rts
	: ; } else {
		jsr	oam_init_all

		ldx	ending_toad_offset
		cpx	#7
		beq	:+
		lda	timer_ending
		and	#MOD_32
		bne	:++ ; if (ending_toad_offset = 7 || (timer_ending % 32) == 0) {
			; if () {
				inc	ending_toad_offset
				lda	#sfx_pulse_2::coin_01
				sta	apu_sfx_pulse_2_req
				jmp	:++
			: ; } else {
				lda	timer_ending
				and	#MOD_32
				bne	:+ ; if ((timer_ending % 32) == 0) {
					inc	ending_toad_cycling
					lda	ending_toad_cycling
					cmp	#11
					bcc	:+ ; if (++ending_toad_cycling >= 11) {
						lda	#4
						sta	ending_toad_cycling
					; }
				; }
			; }
		: ; }

		inc	timer_ending

		.if	.defined(SMB2)
			lda	course_no
			pha
		.endif

		lda	ending_toad_offset
		pha

		tax
		: ; for () {
			lda	ending_toad_cycling
			cmp	#4
			bcc	:+
			sbc	#4
			tay
			lda	ending_toad_render_data_offset, y
			cmp	ending_toad_render_data_offset_next, x
			beq	:+++
			: ; if () {
				ldy	ending_toad_render_data_offset_next, x

				.if	.defined(SMB2)
					sty	obj_data_offset_actor
					lda	#actor::toad
					sta	obj_id_actor
				.endif

				lda	ending_toad_render_pos_y, x
				.if	.defined(SMB2)
					sta	pos_y_lo_actor
					lda	ending_toad_render_pos_x, x
					sta	pos_x_rel_actor
					ldx	#0
					stx	course_no
					stx	actor_index
					jsr	render_actor
					:
				.elseif	.defined(ANN)
					sta	oam_buffer+OBJ_POS_V+(OBJ_SIZE*0), y
					sta	oam_buffer+OBJ_POS_V+(OBJ_SIZE*3), y
					clc
					adc	#PPU_CHR_HEIGHT_PX
					sta	oam_buffer+OBJ_POS_V+(OBJ_SIZE*1), y
					sta	oam_buffer+OBJ_POS_V+(OBJ_SIZE*4), y
					clc
					adc	#PPU_CHR_HEIGHT_PX
					sta	oam_buffer+OBJ_POS_V+(OBJ_SIZE*2), y
					sta	oam_buffer+OBJ_POS_V+(OBJ_SIZE*5), y
					lda	ending_toad_render_pos_x, x
					sta	oam_buffer+OBJ_POS_H+(OBJ_SIZE*0), y
					sta	oam_buffer+OBJ_POS_H+(OBJ_SIZE*1), y
					sta	oam_buffer+OBJ_POS_H+(OBJ_SIZE*2), y
					clc
					adc	#PPU_CHR_WIDTH_PX
					sta	oam_buffer+OBJ_POS_H+(OBJ_SIZE*3), y
					sta	oam_buffer+OBJ_POS_H+(OBJ_SIZE*4), y
					sta	oam_buffer+OBJ_POS_H+(OBJ_SIZE*5), y
					lda	ending_toad_render_chr_base-1, x
					sta	ending_toad_render_CHR_NO
					lda	ending_toad_render_attrs-1, x
					sta	ending_toad_render_ATTR
					ldx	#0
					: ; for () {
						lda	ending_toad_render_CHR_NO
						sta	oam_buffer+OBJ_CHR_NO, y
						lda	ending_toad_render_ATTR
						sta	oam_buffer+OBJ_ATTR, y

						iny
						iny
						iny
						iny
						inc	ending_toad_render_CHR_NO
						inx
						cpx	#6
						bne	:-
					; }
				.endif
			: ; }

			dec	ending_toad_offset
			ldx	ending_toad_offset
			bne	:----
		; }
	
		pla
		sta	ending_toad_offset

		.if	.defined(SMB2)
			pla
			sta	course_no
		.endif

		lda	#$30
		sta	obj_data_offset_actor
		lda	#184
		sta	pos_y_lo_actor
		rts
	; }
; ------------------------------------------------------------
	.include        "charmap.i"
ENDING_TEXT_NAME_LEN	= 5

ending_text_player_names:
	.byte	"MARIO"
ending_text_player_mario_end:
	.byte	"LUIGI"
ending_text_player_luigi_end:
; -----------------------------
	.export	ending_text_player_set
ending_text_player_set:
	lda	#screen_procs::init
	sta	screen_proc_id

	ldx	#(ending_text_player_mario_end-ending_text_player_names)-1
	lda	player_id
	beq	:+ ; if (player_id != mario) {
		ldx	#(ending_text_player_luigi_end-ending_text_player_names)-1
	: ; }
	ldy	#(ENDING_TEXT_NAME_LEN)-1
	: ; for (character of name) {
		lda	ending_text_player_names, x
		sta	msg_thankyou_mario_2_name, y
		sta	msg_vsend_3_mario_name, y

		dex
		dey
		bpl	:-
	; }

	rts
; ------------------------------------------------------------
	.include        "../../data/ending_data.s"
