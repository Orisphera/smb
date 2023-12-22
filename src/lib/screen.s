.include	"../../inc/engine/unk.i"

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

	jmp	screen_proc_next
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
	jmp	screen_proc_next
; ------------------------------------------------------------