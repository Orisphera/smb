.include	"system/cpu.i"
.include	"system/ppu.i"
.include	"system/palette.i"

.include	"mem.i"
.include	"course_flags.i"
.include	"tunables.i"
.include	"charmap.i"
.include	"modes.i"
.include	"misc.i"

.if	.defined(SMB)|.defined(VS_SMB)
	screen_proc_continue = screen_proc_next
.elseif	.defined(SMBV2)
	screen_proc_continue = screen_text_draw_timeup_continue
.endif

	.export screen_proc
screen_proc:
	lda	screen_proc_id
	jsr	tbljmp
	.addr	screen_init
	.addr	screen_color_init_1
	.addr	screen_text_draw_header
	.addr	screen_text_draw_splash
	.addr	screen_text_draw_timeup
	.addr	screen_timer_clear_check
	.addr	screen_text_draw_intermission
	.if	.defined(SMB2)
		.addr	ending_course_plus_msg
	.elseif	.defined(ANN)
		.addr	screen_score_disp_end
	.endif
	.addr	screen_timer_clear_check
	.addr	screen_bg
	.addr	screen_color_init_2
	.addr	screen_color_init_3
	.addr	screen_color_init_4
	.addr	screen_title_bg
	.addr	screen_title_cursor
	.addr	screen_title_score
; ------------------------------------------------------------
screen_init:
	jsr	oam_init
	jsr	nt_init
	lda	proc_id_system
	beq	screen_proc_next_b ; if (proc_id_system != title) {
		.export	screen_init_title
	screen_init_title:
		ldx	#3
		jmp	screen_proc_next_pal_set
	; }
; ------------------------------------------------------------
screen_color_init_1:
	lda	course_bg_col
	pha
	lda	player_status
	pha

	lda	#0
	sta	player_status
	lda	#COURSE_SCENERY_BG_COL_OVERWORLD_VAL
	sta	course_bg_col
	jsr	screen_color_player

	pla
	sta	player_status
	pla
	sta	course_bg_col

	jmp	screen_proc_continue
; ------------------------------------------------------------
screen_palette_types:
	.byte	nmi_addr::pal_underwater
	.byte	nmi_addr::pal_overworld
	.byte	nmi_addr::pal_underground
	.byte	nmi_addr::pal_castle
; ----------------------------
	.export	screen_color_init_2
screen_color_init_2:
	ldy	course_type
	ldx	screen_palette_types, y

screen_proc_next_pal_set:
	stx	nmi_buffer_ptr

screen_proc_next_b:
	jmp	screen_proc_continue
; ------------------------------------------------------------
	.export screen_color_bg_data
	.export screen_color_bg_data_water
	.export screen_color_bg_data_overworld
	.export screen_color_bg_data_underground
screen_color_bg_data:
screen_color_bg_data_water:
	.if	.defined(CONS)
	.byte	PPU_COLOR_GREY0, PPU_COLOR_YGREEN0, PPU_COLOR_GREEN0, PPU_COLOR_MAGENTA0
	.elseif	.defined(VS)
	.byte	PPU_COLOR_YELLOW1, PPU_COLOR_YELLOW0, PPU_COLOR_YGREEN3, PPU_COLOR_PITCH1
	.endif

screen_color_bg_data_overworld:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_BLUE2, PPU_COLOR_PITCH0, PPU_COLOR_PITCH0

screen_color_bg_data_underground:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_BLUE2, PPU_COLOR_PITCH0, PPU_COLOR_PITCH0

	.export screen_color_player_data
screen_color_player_data:
screen_color_player_1:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_RED1, PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1

.if	.defined(SMB)|.defined(VS_SMB)
screen_color_player_2:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_GREY3, PPU_COLOR_ORANGE2, PPU_COLOR_YGREEN1
.endif

screen_color_player_power:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_ORANGE3, PPU_COLOR_ORANGE2, PPU_COLOR_RED1
; --------------------------
screen_color_pal_entry	= zp_byte_00

	.export	screen_color_init_3
screen_color_init_3:
	ldy	course_bg_col
	beq	:+ ; if (course_bg_col) {
		lda	screen_color_bg_data-PPU_COLOR_ROW_SIZE, y
		sta	nmi_buffer_ptr
	: ; }

	inc	screen_proc_id

	.export screen_color_player
screen_color_player:
	ldx	ppu_displist_0_offset
	ldy	#(screen_color_player_1-screen_color_player_data)
	.if	.defined(SMB)|.defined(VS_SMB)
		lda	player_id
		beq	:+ ; if (player_id != 0) {
			ldy	#(screen_color_player_2-screen_color_player_data)
		: ; }
	.endif
	lda	player_status
	cmp	#2
	bne	:+ ; if (player_status == 2) {
		ldy	#(screen_color_player_power-screen_color_player_data)
	: ; }
	lda	#PPU_COLOR_LINE_SIZE-1
	sta	screen_color_pal_entry
	: ; for (x = ppu_displist_0_offset, y = entry_base, i = 3; i >= 0; x++, y++, i--) {
		lda	screen_color_player_data, y
		sta	ppu_displist_0_byte, x

		iny
		inx
		dec	screen_color_pal_entry
		bpl	:-
	; }

	ldx	ppu_displist_0_offset
	ldy	course_bg_col
	bne	:+ ; if (!course_bg_col) {
		ldy	course_type
	: ; }
	lda	screen_color_bg_data+PPU_COLOR_ROW_SIZE, y
	sta	ppu_displist_0_byte, x
	lda	#>(PPU_COLOR_PAGE_OBJ)
	sta	ppu_displist_0_addr_dbyt, x
	lda	#<(PPU_COLOR_PAGE_OBJ)
	sta	ppu_displist_0_addr_dbyt+1, x
	lda	#PPU_COLOR_LINE_SIZE
	sta	ppu_displist_0_count, x
	lda	#NMI_LIST_END
	sta	ppu_displist_0_data+(WORD_SIZE+1+PPU_COLOR_ROW_SIZE), x
	txa
	clc
	adc	#(WORD_SIZE+1+PPU_COLOR_ROW_SIZE)

	.export screen_color_player_end
screen_color_player_end:
	sta	ppu_displist_0_offset
	rts
; ------------------------------------------------------------
	.export screen_color_init_4_end
screen_color_init_4:
	lda	course_ledge_type
	cmp	#COURSE_AREA_LEDGE_MUSHROOM_VAL
	bne	:+ ; if (ledge_type == MUSHROOM) {
		lda	#nmi_addr::pal_mushroom
	screen_color_init_4_end:
		sta	nmi_buffer_ptr
	: ; }

	jmp	screen_proc_continue
; ------------------------------------------------------------
	.export screen_text_draw_header
screen_text_draw_header:
	lda	#screen_text::header
	jsr	screen_text_draw
	jmp	screen_proc_continue
; ------------------------------------------------------------
SCREEN_STAT_BG_1_ADDR	=	PPU_VRAM_BG1+PPU_BG_ROW_3+PPU_BG_COL_19
SCREEN_STAT_BG_1_LEN	=	3

	.export	screen_text_draw_splash
screen_text_draw_splash:
	jsr	misc_proc_coin_update_stats
	ldx	ppu_displist_0_offset
	lda	#>(SCREEN_STAT_BG_1_ADDR)
	sta	ppu_displist_0_addr_dbyt, x
	lda	#<(SCREEN_STAT_BG_1_ADDR)
	sta	ppu_displist_0_addr_dbyt+1, x
	lda	#SCREEN_STAT_BG_1_LEN
	sta	ppu_displist_0_count, x
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	course_no
		iny
		tya
	.elseif	.defined(SMBV2)
		jsr	screen_calc_course_no
	.endif
	sta	ppu_displist_0_tile+0, x
	lda	#'-'
	sta	ppu_displist_0_tile+1, x
	ldy	player_goals
	iny
	tya
	sta	ppu_displist_0_tile+2, x

	lda	#NMI_LIST_END
	sta	ppu_displist_0_tile+SCREEN_STAT_BG_1_LEN, x

	txa
	clc
	adc	#SCREEN_STAT_BG_1_LEN+WORD_SIZE+1
	sta	ppu_displist_0_offset
	jmp	screen_proc_continue
; ----------------------------
	.if	.defined(SMBV2)
	screen_calc_course_no:
		ldy	course_no
		lda	ENG_HARDMODE_VAR
		beq	:+ ; if (ENG_HARDMODE_VAR) {
			tya
			and	#$03
			clc
			adc	#9
			tay
		: ; }
		iny
		tya
		rts
	.endif
; ------------------------------------------------------------
screen_text_draw_timeup:
	lda	game_time_up
	beq	:+ ; if (game_time_up) {
		lda	#0
		sta	game_time_up
		lda	#screen_text::timeup
		.if	.defined(SMB)|.defined(VS_SMB)
			jmp	screen_text_draw_timeup_end
		.elseif	.defined(SMBV2)
		screen_text_draw_timeup_end:
			jsr	screen_text_draw
			jsr	screen_timer_reset
			lda	#0
			sta	nmi_disp_disable
			rts
		.endif
	: ; } else {
		inc	screen_proc_id

		.if	.defined(SMB)|.defined(VS_SMB)
			jmp	screen_proc_continue
		.elseif	.defined(SMBV2)	
		screen_text_draw_timeup_continue:
			inc	screen_proc_id
			rts
		.endif
	; }
; ------------------------------------------------------------
screen_text_draw_intermission:
	lda	proc_id_system
	beq	:+++
	cmp	#system_modes::game_over
	beq	:++ ; if (proc_id_system.not_in(title, game_over)) {
		lda	game_start_type
		bne	:+++
		ldy	course_type
		cpy	#course_types::castle
		beq	:+
		lda	screen_msg_disable
		bne	:+++
		: ; if (game.start_type != 0 && (course.type == castle || !screen_msg_disable)) {
			jsr	render_player_course_card
			lda	#screen_text::splash
			.if	.defined(SMB)|.defined(VS_SMB)
			screen_text_draw_timeup_end:
				jsr	screen_text_draw
				jsr	screen_timer_reset
				lda	#0
				sta	nmi_disp_disable
				rts
			.elseif	.defined(SMBV2)
				jsr	screen_text_draw_timeup_end
				.if	.defined(SMB2)
					lda	course_no
					cmp	#course::no_09

					bne	screen_proc_continue
					inc	nmi_disp_disable
					rts
				.elseif	.defined(ANN)
					jmp	screen_proc_continue
				.endif
			.endif
		; }
	: ; } else if (game.mode == game_over) {
		.if	.defined(SMB)|.defined(VS_SMB)
			lda	#$12
			sta	timer_screen
		.endif

		lda	#screen_text::gameover
		jsr	screen_text_draw

		.if	.defined(SMB)|.defined(VS_SMB)
			jmp	screen_title_proc_id_inc
		.elseif	.defined(SMBV2)
			.if	.defined(SMB2)
				lda	course_no
				cmp	#course::no_09
				beq	screen_proc_continue
			.endif
			jmp	screen_title_bg_finish
		.endif
	: ; }

	lda	#screen_procs::bg
	sta	screen_proc_id
	rts
; ------------------------------------------------------------
screen_bg:
	inc	nmi_disp_disable

	: ; while (bg_proc_id != main_c) {
		jsr	bg_proc
		lda	bg_proc_id
		bne	:-
	; }

	dec	screen_bg_counter
	bpl	:+ ; if (--screen_bg_counter >= 0) {
		inc	screen_proc_id
	: ; }

	lda	#nmi_addr::buffer_11_A
	sta	nmi_buffer_ptr
	rts
; ------------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	.include	"../title/scr.s"
.endif
; ------------------------------------------------------------
.include	"../../data/screen_text.s"
; ----------------------------
.if	.defined(SMB2)
	screen_text_draw_buffer_page	= PPU_VRAM_BG2
.elseif	.defined(SMBM)|.defined(VS_SMB)
	screen_text_draw_buffer_page	= PPU_VRAM_BG4
.endif

	.export	screen_text_draw
screen_text_draw:
	pha

	.if	.defined(SMB)|.defined(VS_SMB)
		asl	a
		tay
		cpy	#4
		bcc	:++ ; if (y >= 4) {
			cpy	#8
			bcc	:+ ; if (y >= 8) {
				ldy	#8
			: ; }

			lda	player_count
			bne	:+ ; if (player_count == 0) {
				iny
			: ; }
		; }
	.elseif	.defined(SMBV2)
		tay
	.endif

	ldx	screen_text_idx_tbl, y
	ldy	#0
	: ; for (x = screen_text_idx_tbl[y], y = 0; screen_text[x] != SCREEN_TEXT_END_VAL && y < 0x100; x++, y++) {
		lda	screen_text, x
		cmp	#SCREEN_TEXT_END_VAL
		beq	:+
		sta	ppu_displist_0_data, y

		inx
		iny
		bne	:-
	: ; }

	lda	#NMI_LIST_END
	sta	ppu_displist_0_data, y
	pla

	.if	.defined(SMBV2)
		beq	screen_text_draw_end
	.endif

	tax

	.if	.defined(SMB)|.defined(VS_SMB)
		cmp	#4
		bcs	screen_text_draw_over
	.endif

	dex
	bne	:++ ; if ((a < 4 || !SMB) && a > 1) {
		lda	player_lives
		clc
		adc	#1
		cmp	#10
		bcc	:+ ; if (++player_lives >= 10) {
			sbc	#10
			ldy	#$9F
			sty	ppu_displist_0_data+7
		: ; }
		sta	ppu_displist_0_data+8
	
		.if	.defined(SMB)|.defined(VS_SMB)
			ldy	course_no
			iny
			sty	ppu_displist_0_data+19
		.elseif	.defined(SMBV2)
			jsr	screen_calc_course_no
			sta	ppu_displist_0_data+19
		.endif

		ldy	player_goals
		iny
		sty	ppu_displist_0_data+21

	.if	.defined(SMBV2)
		: ; }

	screen_text_draw_end:
		rts
	.elseif	.defined(SMB)|.defined(VS_SMB)
		rts
		: ; } else if (a <= 1) {
			lda	player_count
			beq	:+++ ; if (player_count > 0) {
				lda	player_id
				dex
				bne	:+
				ldy	proc_id_system
				cpy	#system_modes::game_over
				beq	:+ ; if (proc_id_system != game_over && (!VS_SMB || player_lives_b >= 0)) {
				.if	.defined(VS_SMB)
					ldy	player_lives_b
					bmi	:+
				.endif
					eor	#1
				: ; }

				lsr	a
				bcc	:++ ; if () {
					ldy	#(screen_text_player_2_end-screen_text_player_2)-1
					: ; for (byte of screen_text_player_2) {
						lda	screen_text_player_2, y
						sta	ppu_displist_0_tile, y

						dey
						bpl	:-
					; }
				; }
			: ; }

			rts
	.endif

	.if	.defined(SMBV2)
			.export screen_text_draw_over
		screen_text_draw_over:
			pha

			ldy	#$FF
			: ; for (byte of screen_text_warp_screen) {
				iny
				lda	screen_text_warp_screen, y
				sta	ppu_displist_0_data, y

				bne	:-
			; }

			pla
			sec
			sbc	#$80
		.if	.defined(SMB2)
				tax
				lda	screen_text_warps, x
				sta	ppu_displist_0_data+27
		.endif
	.elseif	.defined(SMB)|.defined(VS_SMB)
		screen_text_draw_over: ; } else {
			sbc	#4
	.endif

	.if	.defined(SMBM)|.defined(VS_SMB)
		asl	a
		asl	a
		tax
		ldy	#0
		: ; for (y = 0; y < 12; y += 4) {
			lda	screen_text_warps, x
			sta	ppu_displist_0_data+27, y

			inx
			iny
			iny
			iny
			iny
			cpy	#12
			bcc	:-
		; }
	.endif

	lda	#>screen_text_draw_buffer_page
	jmp	screen_color_player_end
; }
; -----------------------------------------------------------
screen_timer_clear_check:
	lda	timer_screen
	bne	:+ ; if (!timer_screen) {
		jsr	oam_init
	screen_timer_reset:
		lda	#7
		sta	timer_screen
		inc	screen_proc_id
	: ; }
	rts
