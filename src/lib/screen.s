.include	"../../inc/system/cpu.i"
.include	"../../inc/system/ppu.i"

.include	"../../inc/engine/tunables.i"
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
	.addr	screen_msg_time_reset
	.addr	screen_msg_world_game_over
	.if	.defined(SMB2)
		.addr	sub_C5D0
	.elseif	.defined(ANN)
		.addr	screen_score_disp_end
	.endif
	.addr	screen_msg_time_reset
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
	jsr	sub_8808
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
	lda	#TILE_DASH
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
			jsr	sub_8808
			jsr	sub_88A5
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
				jsr	sub_8808
				jsr	sub_88A5
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
			sta	byte_7A0
		.endif

		lda	#3
		jsr	sub_8808

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

	: ; while (byte_71F) {
		jsr	sub_92B0
		lda	byte_71F
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
