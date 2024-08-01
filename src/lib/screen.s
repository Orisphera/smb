.include	"system/cpu.i"
.include	"system/ppu.i"
.include	"system/palettes.i"

.include	"engine/mem.i"
.include	"engine/course_flags.i"
.include	"engine/tunables.i"
.include	"engine/charmap.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

.if	.defined(SMB)|.defined(VS_SMB)
	screen_proc_continue = screen_proc_next
.elseif	.defined(SMB2M)
	screen_proc_continue = screen_text_draw_timeup_continue
.endif

	.export screen_proc
screen_proc:
	lda	eng_screen_proc_id
	jsr	eng_farjump
	.addr	screen_init
	.addr	screen_color_init_1
	.addr	screen_text_draw_header
	.addr	screen_text_draw_splash
	.addr	screen_text_draw_timeup
	.addr	screen_timer_clear_check
	.addr	screen_text_draw_intermission
	.if	.defined(SMB2)
		.addr	sub_C5D0
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
	lda	eng_game_mode
	beq	screen_proc_next_b ; if (eng_game_mode != title) {
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
	lda	#COURSE_DATA_BG_COL_OVERWORLD_VAL
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
screen_color_init_2:
	ldy	course_type
	ldx	screen_palette_types, y

screen_proc_next_pal_set:
	stx	nmi_addrs_ctl

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
screen_color_init_3:
	ldy	course_bg_col
	beq	:+ ; if (course_bg_col) {
		lda	screen_color_bg_data-PPU_COLOR_ROW_SIZE, y
		sta	nmi_addrs_ctl
	: ; }

	inc	eng_screen_proc_id

	.export screen_color_player
screen_color_player:
	ldx	ppu_nmi_buffer_0_offset
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
	sta	zp_byte_00
	: ; for (x = ppu_nmi_buffer_0_offset, y = entry_base, i = 3; i >= 0; x++, y++, i--) {
		lda	screen_color_player_data, y
		sta	ppu_nmi_buffer_0_data+3, x

		iny
		inx
		dec	zp_byte_00
		bpl	:-
	; }

	ldx	ppu_nmi_buffer_0_offset
	ldy	course_bg_col
	bne	:+ ; if (!course_bg_col) {
		ldy	course_type
	: ; }
	lda	screen_color_bg_data+PPU_COLOR_ROW_SIZE, y
	sta	ppu_nmi_buffer_0_data+3, x
	lda	#>(PPU_COLOR_PAGE_OBJ)
	sta	ppu_nmi_buffer_0_data+0, x
	lda	#<(PPU_COLOR_PAGE_OBJ)
	sta	ppu_nmi_buffer_0_data+1, x
	lda	#PPU_COLOR_LINE_SIZE
	sta	ppu_nmi_buffer_0_data+2, x
	lda	#NMI_DATA_END
	sta	ppu_nmi_buffer_0_data+7, x
	txa
	clc
	adc	#7

	.export screen_color_player_end
screen_color_player_end:
	sta	ppu_nmi_buffer_0_offset
	rts
; ------------------------------------------------------------
	.export screen_color_init_4_end
screen_color_init_4:
	lda	course_ledge_type
	cmp	#COURSE_AREA_LEDGE_MUSHROOM_VAL
	bne	:+ ; if (ledge_type == MUSHROOM) {
		lda	#nmi_addr::pal_mushroom
	screen_color_init_4_end:
		sta	nmi_addrs_ctl
	: ; }

	jmp	screen_proc_continue
; ------------------------------------------------------------
screen_text_draw_header:
	lda	#screen_text::header
	jsr	screen_text_draw
	jmp	screen_proc_continue
; ------------------------------------------------------------
SCREEN_STAT_BG_1_ADDR	=	PPU_VRAM_BG1+$73
SCREEN_STAT_BG_1_LEN	=	3

screen_text_draw_splash:
	jsr	misc_proc_coin_update_stats
	ldx	ppu_nmi_buffer_0_offset
	lda	#>(SCREEN_STAT_BG_1_ADDR)
	sta	ppu_nmi_buffer_0_data+0, x
	lda	#<(SCREEN_STAT_BG_1_ADDR)
	sta	ppu_nmi_buffer_0_data+1, x
	lda	#SCREEN_STAT_BG_1_LEN
	sta	ppu_nmi_buffer_0_data+2, x
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	course_no
		iny
		tya
	.elseif	.defined(SMB2M)
		jsr	screen_calc_course_no
	.endif
	sta	ppu_nmi_buffer_0_data+3, x
	lda	#'-'
	sta	ppu_nmi_buffer_0_data+4, x
	ldy	eng_goals
	iny
	tya
	sta	ppu_nmi_buffer_0_data+5, x
	lda	#NMI_DATA_END
	sta	ppu_nmi_buffer_0_data+6, x
	txa
	clc
	adc	#SCREEN_STAT_BG_1_LEN+WORD_SIZE+1
	sta	ppu_nmi_buffer_0_offset
	jmp	screen_proc_continue
; ----------------------------
	.if	.defined(SMB2M)
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
	lda	eng_done_timer
	beq	:+ ; if (eng_done_timer) {
		lda	#0
		sta	eng_done_timer
		lda	#screen_text::timeup
		.if	.defined(SMB)|.defined(VS_SMB)
			jmp	sub_86C7
		.elseif	.defined(SMB2M)
		screen_text_draw_timeup_end:
			jsr	screen_text_draw
			jsr	screen_timer_reset
			lda	#0
			sta	eng_disp_disable
			rts
		.endif
	: ; } else {
		inc	eng_screen_proc_id

		.if	.defined(SMB)|.defined(VS_SMB)
			jmp	screen_proc_continue
		.elseif	.defined(SMB2M)	
		screen_text_draw_timeup_continue:
			inc	eng_screen_proc_id
			rts
		.endif
	; }
; ------------------------------------------------------------
screen_text_draw_intermission:
	lda	eng_game_mode
	beq	:+++
	cmp	#game_mode::game_over
	beq	:++ ; if (eng_game_mode.not_in(title, game_over)) {
		lda	eng_start_alt
		bne	:+++
		ldy	course_type
		cpy	#course_types::castle
		beq	:+
		lda	eng_disable_b
		bne	:+++
		: ; if (!eng_start_alt && (course_type == castle || !eng_disable_b)) {
			jsr	sub_EFA4
			lda	#screen_text::splash
			.if	.defined(SMB)|.defined(VS_SMB)
			sub_86C7:
				jsr	screen_text_draw
				jsr	screen_timer_reset
				lda	#0
				sta	eng_disp_disable
				rts
			.elseif	.defined(SMB2M)
				jsr	screen_text_draw_timeup_end
				.if	.defined(SMB2)
					lda	course_no
					cmp	#course::no_09

					bne	screen_proc_continue
					inc	eng_disp_disable
					rts
				.elseif	.defined(ANN)
					jmp	screen_proc_continue
				.endif
			.endif
		; }
	: ; } else if (eng_game_mode == 3) {
		.if	.defined(SMB)|.defined(VS_SMB)
			lda	#$12
			sta	eng_timer_screen
		.endif

		lda	#screen_text::gameover
		jsr	screen_text_draw

		.if	.defined(SMB)|.defined(VS_SMB)
			jmp	screen_title_end
		.elseif	.defined(SMB2M)
			.if	.defined(SMB2)
				lda	course_no
				cmp	#course::no_09
				beq	screen_proc_continue
			.endif
			jmp	screen_title_bg_finish
		.endif
	: ; }

	lda	#screen_proc::bg
	sta	eng_screen_proc_id
	rts
; ------------------------------------------------------------
screen_bg:
	inc	eng_disp_disable

	: ; while (bg_proc_id != main_c) {
		jsr	bg_proc
		lda	bg_proc_id
		bne	:-
	; }

	dec	eng_columnsets
	bpl	:+ ; if (--eng_columnsets >= 0) {
		inc	eng_screen_proc_id
	: ; }

	lda	#nmi_addr::buffer_11_A
	sta	nmi_addrs_ctl
	rts
; ------------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	.include	"../title/scr.s"
.endif
; ------------------------------------------------------------
screen_text_end_val	= $FF
.if	.defined(SMB2)
	screen_text_draw_buffer_page	= PPU_VRAM_BG2
.elseif	.defined(SMBM)|.defined(VS_SMB)
	screen_text_draw_buffer_page	= PPU_VRAM_BG4
.endif

screen_text:
screen_text_header:
	.dbyt	PPU_VRAM_BG1+$43
	.byte	screen_text_player_1_end-screen_text_player_1
screen_text_player_1:
	.byte	"MARIO"
screen_text_player_1_end:

	.dbyt	PPU_VRAM_BG1+$52
	.byte	screen_text_hud_end-screen_text_hud
screen_text_hud:
	.byte	"WORLD  TIME"
screen_text_hud_end:

	.dbyt	PPU_VRAM_BG1+$68
	.byte	screen_text_stats_end-screen_text_stats
screen_text_stats:
	.byte	"0  $x"	; $ explained in charmap.i
screen_text_stats_end:

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+0
	.byte	NMI_REPEAT|63, $AA

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+2
	.byte	screen_text_fill_end-screen_text_fill
screen_text_fill:
	.byte	$EA
screen_text_fill_end:
	.byte	screen_text_end_val

screen_text_splash:
	.dbyt	PPU_VRAM_BG1+$1CD
	.byte	screen_text_lives_end-screen_text_lives
screen_text_lives:
	.byte	"  x    "
screen_text_lives_end:

	.dbyt	PPU_VRAM_BG1+$14B
	.byte	screen_text_world_end-screen_text_world
screen_text_world:
	.byte	"WORLD  - "
screen_text_world_end:

	.dbyt	PPU_VRAM_BG1+$20C
	.byte	NMI_REPEAT|7, " "

	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$1C
	.byte	screen_text_fill_b_end-screen_text_fill_b
screen_text_fill_b:
	.byte	$BA
screen_text_fill_b_end:
	.byte	screen_text_end_val

screen_text_timeup_screen:
.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$1CD
		.byte	screen_text_timeup_player_end-screen_text_timeup_player
	screen_text_timeup_player:
		.byte	"MARIO"
	screen_text_timeup_player_end:
.endif
	.dbyt	PPU_VRAM_BG1+$20C
	.byte	screen_text_timeup_end-screen_text_timeup
screen_text_timeup:
	.byte	"TIME UP"
screen_text_timeup_end:
	.byte	screen_text_end_val

screen_text_gameover_screen:
.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$1CD
		.byte	screen_text_gameover_player_end-screen_text_gameover_player
	screen_text_gameover_player:
		.byte	"MARIO"
	screen_text_gameover_player_end:
.endif

.if	.defined(SMB)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG1+$20B
.elseif	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+$16B
.endif
	.byte	screen_text_gameover_end-screen_text_gameover
screen_text_gameover:
	.byte	"GAME OVER"
screen_text_gameover_end:

.if	.defined(SMB2M)
		.dbyt	PPU_VRAM_BG1+$1EB
		.byte	screen_text_continue_end-screen_text_continue
	screen_text_continue:
		.byte	"CONTINUE"
	screen_text_continue_end:

		.dbyt	PPU_VRAM_BG1+$20C
		.byte	NMI_REPEAT|7, " "

		.dbyt	PPU_VRAM_BG1+$24B
		.byte	screen_text_retry_end-screen_text_retry
	screen_text_retry:
		.byte	"RETRY"
	screen_text_retry_end:
.endif
	.byte	screen_text_end_val

screen_text_warp_screen:
	.dbyt	PPU_VRAM_BG2+$184
	.byte	screen_text_warp_zone_end-screen_text_warp_zone
screen_text_warp_zone:
	.byte	"WELCOME TO WARP ZONE!"
screen_text_warp_zone_end:

.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG2+$225
		.byte	screen_text_warp_pipe_l_end-screen_text_warp_pipe_l
	screen_text_warp_pipe_l:
		.byte	" "
	screen_text_warp_pipe_l_end:
.endif

	.dbyt	PPU_VRAM_BG2+$22D
	.byte	screen_text_warp_pipe_m_end-screen_text_warp_pipe_m
screen_text_warp_pipe_m:
	.byte	" "
screen_text_warp_pipe_m_end:
	
.if	.defined(SMBM)|.defined(VS_SMB)
		.dbyt	PPU_VRAM_BG2+$235
		.byte	screen_text_warp_pipe_r_end-screen_text_warp_pipe_r
	screen_text_warp_pipe_r:
		.byte	" "
	screen_text_warp_pipe_r_end:
.endif

	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$19
	.byte	NMI_REPEAT|6, $AA

	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$21
	.byte	NMI_REPEAT|5, $AA
.if	.defined(SMB)|.defined(VS_SMB)
		.byte	screen_text_end_val
.elseif	.defined(SMB2M)
		.byte	NMI_DATA_END
.endif

.if	.defined(SMB)|.defined(VS_SMB)
	screen_text_player_2:
		.byte	"LUIGI"
	screen_text_player_2_end:
.endif

screen_text_warps:
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	"4", "3", "2", 0
		.byte	" ", "5", " ", 0
		.if	.defined(SMBM)
			.byte	"8", "7", "6", 0
		.elseif	.defined(VS_SMB)
			.byte	" ", "6", " ", 0
		.endif
	.elseif	.defined(SMB2)
		.byte	"2"
		.byte	"3"
		.byte	"4"
		.byte	"1"
		.byte	"6"
		.byte	"7"
		.byte	"8"
		.byte	"5"
		.byte	"B"
		.byte	"C"
		.byte	"D"
	.endif

	.if	.defined(ANN)
		.byte	" ", "B", " ", 0
		.byte	" ", "C", " ", 0
		.byte	" ", "D", " ", 0
	.endif
; -------------
screen_text_idx_off	= $08
screen_text_idx_header		= screen_text_header-screen_text
screen_text_idx_splash		= screen_text_splash-screen_text
screen_text_idx_timeup		= screen_text_timeup_screen-screen_text
screen_text_idx_gameover	= screen_text_gameover_screen-screen_text

.if	.defined(SMB)|.defined(VS_SMB)
	screen_text_idx_warp		= screen_text_warp_screen-screen_text
.endif

screen_text_idx_tbl:
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	screen_text_idx_header, screen_text_idx_header
		.byte	screen_text_idx_splash, screen_text_idx_splash
		.byte	screen_text_idx_timeup, screen_text_idx_timeup+screen_text_idx_off
		.byte	screen_text_idx_gameover, screen_text_idx_gameover+screen_text_idx_off
	.elseif	.defined(SMB2M)
		.byte	screen_text_idx_header
		.byte	screen_text_idx_splash
		.byte	screen_text_idx_timeup
		.byte	screen_text_idx_gameover
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	screen_text_idx_warp, screen_text_idx_warp
	.endif
; ----------------------------
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
			bne	:+ ; if (!player_count) {
				iny
			: ; }
		; }
	.elseif	.defined(SMB2M)
		tay
	.endif

	ldx	screen_text_idx_tbl, y
	ldy	#0
	: ; for (x = screen_text_idx_tbl[y], y = 0; screen_text[x] != screen_text_end_val && y < 0x100; x++, y++) {
		lda	screen_text, x
		cmp	#screen_text_end_val
		beq	:+
		sta	ppu_nmi_buffer_0_data+0, y

		inx
		iny
		bne	:-
	: ; }

	lda	#NMI_DATA_END
	sta	ppu_nmi_buffer_0_data+0, y
	pla

	.if	.defined(SMB2M)
		beq	screen_text_draw_end
	.endif

	tax

	.if	.defined(SMB)|.defined(VS_SMB)
		cmp	#4
		bcs	screen_text_draw_over
	.endif

	dex
	bne	:++ ; if ((a < 4 || !SMB) && a > 1) {
		lda	eng_lives
		clc
		adc	#1
		cmp	#10
		bcc	:+ ; if (++eng_lives >= 10) {
			sbc	#10
			ldy	#$9F
			sty	ppu_nmi_buffer_0_data+7
		: ; }
		sta	ppu_nmi_buffer_0_data+8
	
		.if	.defined(SMB)|.defined(VS_SMB)
			ldy	course_no
			iny
			sty	ppu_nmi_buffer_0_data+19
		.elseif	.defined(SMB2M)
			jsr	screen_calc_course_no
			sta	ppu_nmi_buffer_0_data+19
		.endif

		ldy	eng_goals
		iny
		sty	ppu_nmi_buffer_0_data+21

	.if	.defined(SMB2M)
		: ; }

	screen_text_draw_end:
		rts
	.elseif	.defined(SMB)|.defined(VS_SMB)
		rts
		: ; } else if (a <= 1) {
			lda	player_count
			beq	:+++ ; if (player_count) {
				lda	player_id
				dex
				bne	:+
				ldy	eng_game_mode
				cpy	#game_mode::game_over
				beq	:+ ; if (!game_over && (!VS_SMB || eng_lives_b >= 0)) {
				.if	.defined(VS_SMB)
					ldy	eng_lives_b
					bmi	:+
				.endif
					eor	#1
				: ; }

				lsr	a
				bcc	:++ ; if () {
					ldy	#(screen_text_player_2_end-screen_text_player_2)-1
					: ; for (byte of screen_text_player_2) {
						lda	screen_text_player_2, y
						sta	ppu_nmi_buffer_0_data+3, y

						dey
						bpl	:-
					; }
				; }
			: ; }

			rts
	.endif

	.if	.defined(SMB2M)
			.export screen_text_draw_over
		screen_text_draw_over:
			pha

			ldy	#$FF
			: ; for (byte of screen_text_warp_screen) {
				iny
				lda	screen_text_warp_screen, y
				sta	ppu_nmi_buffer_0_data+0, y

				bne	:-
			; }

			pla
			sec
			sbc	#$80
		.if	.defined(SMB2)
				tax
				lda	screen_text_warps, x
				sta	ppu_nmi_buffer_0_data+27
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
			sta	ppu_nmi_buffer_0_data+27, y

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
	lda	eng_timer_screen
	bne	:+ ; if (!eng_timer_screen) {
		jsr	oam_init
	screen_timer_reset:
		lda	#7
		sta	eng_timer_screen
		inc	eng_screen_proc_id
	: ; }
	rts
