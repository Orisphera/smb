.include	"../../inc/system/cpu.i"
.include	"../../inc/system/ppu.i"

.include	"../../inc/engine/tunables.i"
.include	"../../inc/engine/charmap.i"
.include	"../../inc/engine/misc.i"

.include	"../../inc/engine/unk.i"

.if	.defined(SMB)
	screen_proc_continue = screen_proc_next
.elseif	.defined(SMB2M)
	screen_proc_continue = screen_msg_time_up_continue
.endif

	.export screen_proc
screen_proc:
	lda	eng_screen_proc_id
	jsr	eng_farjump
	.addr	screen_init
	.addr	screen_color_init_1
	.addr	screen_stat_bg_0
	.addr	screen_stat_bg_1
	.addr	screen_msg_time_up
	.addr	screen_timer_clear_check
	.addr	screen_msg_world_game_over
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
	lda	eng_bg_col
	pha
	lda	eng_player_status
	pha

	lda	#0
	sta	eng_player_status
	lda	#2
	sta	eng_bg_col
	jsr	screen_color_player

	pla
	sta	eng_player_status
	pla
	sta	eng_bg_col

	jmp	screen_proc_continue
; ------------------------------------------------------------
screen_palette_types:
	.byte	1, 2, 3, 4
; ----------------------------
screen_color_init_2:
	ldy	eng_area_type
	ldx	screen_palette_types, y

screen_proc_next_pal_set:
	stx	nmi_addrs_ctl

screen_proc_next_b:
	jmp	screen_proc_continue
; ------------------------------------------------------------
data_85D7_entry_size	= 4

data_85CB:
	.byte	$00, $09, $0A, $04

data_85CF:
	.byte	$22, $22, $0F, $0F
	.byte	$0F, $22, $0F, $0F

tbl_85D7:
data_85D7_0:
	.byte	$22, $16, $27, $18
	.if	.defined(SMB)
	data_85D7_1:
		.byte	$22, $30, $27, $19
	.endif
data_85D7_2:
	.byte	$22, $37, $27, $16
; --------------------------
screen_color_init_3:
	ldy	eng_bg_col
	beq	:+ ; if (eng_bg_col) {
		lda	data_85CB-4, y
		sta	nmi_addrs_ctl
	: ; }

	inc	eng_screen_proc_id

screen_color_player:
	ldx	ppu_nmi_buffer+0
	ldy	#(data_85D7_0-tbl_85D7)
	.if	.defined(SMB)
		lda	eng_player_id
		beq	:+ ; if (eng_player_id != 0) {
			ldy	#(data_85D7_1-tbl_85D7)
		: ; }
	.endif
	lda	eng_player_status
	cmp	#2
	bne	:+ ; if (eng_player_status == 2) {
		ldy	#(data_85D7_2-tbl_85D7)
	: ; }
	lda	#data_85D7_entry_size-1
	sta	zp_byte_00
	: ; for (x = ppu_nmi_buffer[0], y = entry_base, i = 3; i >= 0; x++, y++, i--) {
		lda	tbl_85D7, y
		sta	ppu_nmi_buffer+4, x

		iny
		inx
		dec	zp_byte_00
		bpl	:-
	; }

	ldx	ppu_nmi_buffer+0
	ldy	eng_bg_col
	bne	:+ ; if (!eng_bg_col) {
		ldy	eng_area_type
	: ; }
	lda	data_85CF, y
	sta	ppu_nmi_buffer+4, x
	lda	#$3F
	sta	ppu_nmi_buffer+1, x
	lda	#$10
	sta	ppu_nmi_buffer+2, x
	lda	#4
	sta	ppu_nmi_buffer+3, x
	lda	#0
	sta	ppu_nmi_buffer+8, x
	txa
	clc
	adc	#7

screen_color_player_end:
	sta	ppu_nmi_buffer+0
	rts
; ------------------------------------------------------------
	.export screen_color_init_4_end
screen_color_init_4:
	lda	eng_area_var
	cmp	#1
	bne	:+ ; if () {
		lda	#$0B
	screen_color_init_4_end:
		sta	nmi_addrs_ctl
	: ; }

	jmp	screen_proc_continue
; ------------------------------------------------------------
screen_stat_bg_0:
	lda	#0
	jsr	screen_text_draw
	jmp	screen_proc_continue
; ------------------------------------------------------------
SCREEN_STAT_BG_1_ADDR	=	PPU_VRAM_BG1+$73
SCREEN_STAT_BG_1_LEN	=	3

screen_stat_bg_1:
	jsr	sub_BC30
	ldx	ppu_nmi_buffer+$00
	lda	#>(SCREEN_STAT_BG_1_ADDR)
	sta	ppu_nmi_buffer+$01, x
	lda	#<(SCREEN_STAT_BG_1_ADDR)
	sta	ppu_nmi_buffer+$02, x
	lda	#SCREEN_STAT_BG_1_LEN
	sta	ppu_nmi_buffer+$03, x
	.if	.defined(SMB)
		ldy	eng_course_no
		iny
		tya
	.elseif	.defined(SMB2M)
		jsr	screen_calc_course_no
	.endif
	sta	ppu_nmi_buffer+$04, x
	lda	#'-'
	sta	ppu_nmi_buffer+$05, x
	ldy	eng_goals
	iny
	tya
	sta	ppu_nmi_buffer+$06, x
	lda	#0
	sta	ppu_nmi_buffer+$07, x
	txa
	clc
	adc	#SCREEN_STAT_BG_1_LEN+WORD_SIZE+1
	sta	ppu_nmi_buffer+$00
	jmp	screen_proc_continue
; ----------------------------
	.if	.defined(SMB2M)
	screen_calc_course_no:
		ldy	eng_course_no
		lda	byte_7FB
		beq	:+ ; if (byte_7FB) {
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
screen_msg_time_up:
	lda	eng_done_timer
	beq	:+ ; if (eng_done_timer) {
		lda	#0
		sta	eng_done_timer
		lda	#2
		.if	.defined(SMB)
			jmp	sub_86C7
		.elseif	.defined(SMB2M)
		screen_msg_time_up_end:
			jsr	screen_text_draw
			jsr	screen_timer_reset
			lda	#0
			sta	eng_disp_disable
			rts
		.endif
	: ; } else {
		inc	eng_screen_proc_id

		.if	.defined(SMB)
			jmp	screen_proc_continue
		.elseif	.defined(SMB2M)	
		screen_msg_time_up_continue:
			inc	eng_screen_proc_id
			rts
		.endif
	; }
; ------------------------------------------------------------
screen_msg_world_game_over:
	lda	eng_game_mode
	beq	:+++
	cmp	#3
	beq	:++ ; if (eng_game_mode.not_in(0, 3)) {
		lda	byte_752
		bne	:+++
		ldy	eng_area_type
		cpy	#3
		beq	:+
		lda	byte_769
		bne	:+++
		: ; if (!byte_752 && (eng_area_type == 3 || !byte_769)) {
			jsr	sub_EFA4
			lda	#1
			.if	.defined(SMB)
			sub_86C7:
				jsr	screen_text_draw
				jsr	screen_timer_reset
				lda	#0
				sta	eng_disp_disable
				rts
			.elseif	.defined(SMB2M)
				jsr	screen_msg_time_up_end
				.if	.defined(SMB2)
					lda	eng_course_no
					cmp	#course::no_09

					bne	screen_proc_continue
					inc	eng_disp_disable
					rts
				.elseif	.defined(ANN)
					jmp	$669A
				.endif
			.endif
		; }
	: ; } else if (eng_game_mode == 3) {
		.if	.defined(SMB)
			lda	#$12
			sta	eng_timer_screen
		.endif

		lda	#3
		jsr	screen_text_draw

		.if	.defined(SMB)
			jmp	screen_title_end
		.elseif	.defined(SMB2M)
			.if	.defined(SMB2)
				lda	eng_course_no
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

	: ; while (bg_proc_id) {
		jsr	bg_proc
		lda	bg_proc_id
		bne	:-
	; }

	dec	byte_71E
	bpl	:+ ; if (--byte_71E >= 0) {
		inc	eng_screen_proc_id
	: ; }

	lda	#6
	sta	nmi_addrs_ctl
	rts
; ------------------------------------------------------------
.if	.defined(SMB)
	.include	"../title/scr.s"
.endif
; ------------------------------------------------------------
screen_text_end_val	= $FF
.if	.defined(SMB2)
	screen_text_draw_buffer_page	= PPU_VRAM_BG2
.elseif	.defined(SMBM)
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
	.byte	$7F, $AA
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+2
	.byte	$01, $EA
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
	.byte	$47, " "
	.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS+$1C
	.byte	$01, $BA
	.byte	screen_text_end_val

screen_text_timeup_screen:
.if	.defined(SMB)
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
.if	.defined(SMB)
		.dbyt	PPU_VRAM_BG1+$1CD
		.byte	screen_text_gameover_player_end-screen_text_gameover_player
	screen_text_gameover_player:
		.byte	"MARIO"
	screen_text_gameover_player_end:
.endif

.if	.defined(SMB)
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
		.byte	$47, " "

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

.if	.defined(SMBM)
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
	
.if	.defined(SMBM)
		.dbyt	PPU_VRAM_BG2+$235
		.byte	screen_text_warp_pipe_r_end-screen_text_warp_pipe_r
	screen_text_warp_pipe_r:
		.byte	" "
	screen_text_warp_pipe_r_end:
.endif

	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$19
	.byte	$46, $AA
	.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$21
	.byte	$45, $AA
.if	.defined(SMB)
		.byte	screen_text_end_val
.elseif	.defined(SMB2M)
		.byte	0
.endif

.if	.defined(SMB)
	screen_text_player_2:
		.byte	"LUIGI"
	screen_text_player_2_end:
.endif

screen_text_warps:
	.if	.defined(SMBM)
		.byte	"4", "3", "2", 0
		.byte	" ", "5", " ", 0
		.byte	"8", "7", "6", 0
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

.if	.defined(SMB)
	screen_text_idx_warp		= screen_text_warp_screen-screen_text
.endif

screen_text_idx_tbl:
	.if	.defined(SMB)
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

	.if	.defined(SMB)
		.byte	screen_text_idx_warp, screen_text_idx_warp
	.endif
; ----------------------------
screen_text_draw:
	pha

	.if	.defined(SMB)
		asl	a
		tay
		cpy	#4
		bcc	:++ ; if (y >= 4) {
			cpy	#8
			bcc	:+ ; if (y >= 8) {
				ldy	#8
			: ; }

			lda	eng_player_count
			bne	:+ ; if (!eng_player_count) {
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
		sta	ppu_nmi_buffer+$01, y

		inx
		iny
		bne	:-
	: ; }

	lda	#0
	sta	ppu_nmi_buffer+$01, y
	pla

	.if	.defined(SMB2M)
		beq	screen_text_draw_end
	.endif

	tax

	.if	.defined(SMB)
		cmp	#4
		bcs	screen_text_draw_over
	.endif

	dex
	bne	:++ ; if ((a < 4 || !SMB) && a > 1) {
		lda	eng_lives
		clc
		adc	#1
		cmp	#$0A
		bcc	:+ ; if (++eng_lives >= 0x0A) {
			sbc	#$0A
			ldy	#$9F
			sty	ppu_nmi_buffer+$08
		: ; }
		sta	ppu_nmi_buffer+$09
	
		.if	.defined(SMB)
			ldy	eng_course_no
			iny
			sty	ppu_nmi_buffer+$14
		.elseif	.defined(SMB2M)
			jsr	screen_calc_course_no
			sta	ppu_nmi_buffer+$14
		.endif

		ldy	eng_goals
		iny
		sty	ppu_nmi_buffer+$16

	.if	.defined(SMB2M)
		: ; }

	screen_text_draw_end:
		rts
	.elseif	.defined(SMB)
		rts
		: ; } else if (a <= 1) {
			lda	eng_player_count
			beq	:+++ ; if (eng_player_count) {
				lda	eng_player_id
				dex
				bne	:+
				ldy	eng_game_mode
				cpy	#game_mode::game_over
				beq	:+ ; if (!game_over) {
					eor	#1
				: ; }

				lsr	a
				bcc	:++ ; if () {
					ldy	#(screen_text_player_2_end-screen_text_player_2)-1
					: ; for (byte of screen_text_player_2) {
						lda	screen_text_player_2, y
						sta	ppu_nmi_buffer+$04, y

						dey
						bpl	:-
					; }
				; }
			: ; }

			rts
	.endif

	.if	.defined(SMB2M)
		screen_text_draw_over:
			pha

			ldy	#$FF
			: ; for (byte of screen_text_warp_screen) {
				iny
				lda	screen_text_warp_screen, y
				sta	ppu_nmi_buffer+$01, y

				bne	:-
			; }

			pla
			sec
			sbc	#$80
		.if	.defined(SMB2)
				tax
				lda	screen_text_warps, x
				sta	ppu_nmi_buffer+$1C
		.endif
	.elseif	.defined(SMB)
		screen_text_draw_over: ; } else {
			sbc	#4
	.endif

	.if	.defined(SMBM)
		asl	a
		asl	a
		tax
		ldy	#0
		: ; for (y = 0; y < 0xC; y += 4) {
			lda	screen_text_warps, x
			sta	ppu_nmi_buffer+$1C, y

			inx
			iny
			iny
			iny
			iny
			cpy	#$0C
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
