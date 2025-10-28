.include	"sys/cpu.i"

.include	"mem.i"
.include	"course_flags.i"
.include	"joypad.i"
.include	"sound.i"
.include	"const.i"
.include	"modes.i"
.include	"misc.i"
.include	"macros.i"

.if	.defined(OG_PAD)
.if	.defined(SMB)
	.res	1, $FF
.elseif	.defined(VS_SMB)
	.res	9, $FF
.endif
.endif

; sys_game - game process
	.export	sys_game
	.export	game_mode_tbl
	.export	game_mode_init_0
	.export	game_mode_scr
	.export	game_mode_init_1
	.export	game_mode_proc
sys_game:
	lda	proc_id_game
	jsr	tbljmp
game_mode_tbl:
.if	.defined(VS_SMB)
	.export	game_mode_vs_init
game_mode_vs_init:	.addr	vs_game_init
.elseif	.defined(SMBV2)
	.export	game_mode_init_data2
game_mode_init_data2:	.addr	disk_loader_data2
.endif

game_mode_init_0:	.addr	game_init_0_do

.if	.defined(ANN)
	.export	game_mode_toad_load
game_mode_toad_load:	.addr	ann_toad_load
.endif

game_mode_scr:		.addr	bg_proc
game_mode_init_1:	.addr	game_init_1_do
game_mode_proc:		.addr	game_proc
; ----------------------------------------------------------------------
.if	.defined(VS_SMB)
vs_game_init:
	inc	proc_id_game
	lda	#1
	sta	nmi_disp_disable
	lda	#0
	sta	nmi_sprite_overlap
	rts
.endif
; ----------------------------------------------------------------------
	.export	game_proc, game_proc_scenery_scroll
game_proc:	; game_proc - main gameplay routine
	.if	.defined(SMBV1)
		.if	.defined(VS_SMB)
		lda	player_count
		beq	:+
		.endif ; if (!VS_SMB || player_count > 0) {
			ldx	player_id
			lda	joypad_bits, x
		.if	.defined(VS_SMB)
			jmp	:++
		: ; } else {
			lda	joypad_p1
			ora	joypad_p2
		: ; }
		.endif
		sta	joypad_p1
	.endif

	.if	.defined(VS_SMB)
		and	#joypad_button::right
		beq	:+ ; if (joypad[0].right) {
			lda	joypad_p1
			and	#<~(joypad_button::left)
			sta	joypad_p1
		: ; }

		lda	joypad_p1
		and	#joypad_button::down
		beq	:+ ; if (joypad[0].down) {
			lda	joypad_p1
			and	#<~(joypad_button::up)
			sta	joypad_p1
		: ; }
	.endif

	jsr	player_proc

	lda	proc_id_game
	.if	.defined(CONS)
		cmp	#game_modes::proc
	.elseif	.defined(VS)
		cmp	#game_modes::init_1
	.endif
	bcs	:+
	rts
	: ; if (game.proc_id == proc) {
		jsr	proj_proc

		ldx	#0
		: ; for (actor of actors) {
			stx	actor_index
			jsr	actor_proc

			jsr	bg_score_disp
	
			inx
			cpx	#ENG_ACTOR_MAX
			bne	:-
		; }
	
		jsr	pos_bits_get_player
		jsr	pos_calc_x_rel_player

		jsr	render_player

		jsr	block_flatten
		ldx	#ACTIVE_BLOCK_MAX-1
		stx	actor_index
		jsr	block_proc
		dex
		stx	actor_index
		jsr	block_proc
	
		jsr	misc_proc

		jsr	cannon_proc
		jsr	whirlpool_proc
		jsr	pole_proc

		jsr	stats_time_proc
	
		jsr	meta_color_rotate
	
		.if	.defined(SMB2)
			lda	disk_loader_file_id
			beq	:+ ; if (disk_loader_file_id != main) {
				jsr	scenery_wind_proc
			: ; }
		.endif
	
		lda	pos_y_hi_player
		cmp	#2
		bpl	:+
		lda	timer_player_star
		beq	:+++
		cmp	#4
		bne	:+
		lda	timer_nmi_tick
		bne	:+ ; if (this.timer_star > 0) {
			; if (this.pos_y.hi < 2 && this.timer_star == 4 && !timer_nmi_tick) {
				jsr	game_init_area_music
			: ; }
			ldy	timer_player_star
			lda	frame_count
			cpy	#8
			bcs	:+ ; if (this.timer_star < 8) {
				lsr	a
				lsr	a
			: ; }
			lsr	a
			jsr	player_proc_firefl_do
			jmp	:++
		: ; } else {
			jsr	player_proc_firefl_do_2
		: ; }
	
		lda	joypad_a_b
		sta	joypad_a_b_held
		lda	#joypad_button::none
		sta	joypad_l_r
	
	game_proc_scenery_scroll:	; game_proc_scenery_scroll - update scroll and process scenery, if applicable
		lda	nmi_buffer_ptr
		cmp	#nmi_addr::buffer_11_A
		beq	:++
		lda	bg_scenery_proc_id
		bne	:+
		lda	game_scroll_h
		cmp	#GAME_SCROLL_END
		bmi	:++ ; if (nmi_buffer_ptr != buffer_11_A && (bg_scenery_proc_id == main_c || game.scroll_h > GAME_SCROLL_END)) {
			; if (bg_scenery_proc_id == main_c) {
				lda	game_scroll_h
				sbc	#GAME_SCROLL_END
				sta	game_scroll_h
				lda	#0
				sta	ppu_displist_meta_offset
			: ; }
			jsr	scenery_proc
		: ; }

		rts
	; } else rts;
; ----------------------------------------------------------------------
	.export	game_scroll, game_scroll_calc
game_scroll:	; game_scroll - apply scroll operations based on player motion
	lda	scroll_x_player
	clc
	adc	actor_plat_scroll_x
	sta	scroll_x_player
	lda	game_scroll_lock
	bne	:++++
	lda	scroll_x_player_b
	cmp	#80
	bcc	:++++
	lda	timer_col_x
	bne	:++++
	ldy	scroll_x_player
	dey
	bmi	:++++ ; if (!scroll_lock && this.scroll_x_b >= 80 && !timer_col_x && --this.scroll_x >= 0) {
		iny
		cpy	#2
		bcc	:+ ; if (++this.scroll_x >= 2) {
			dey
		: ; }
	
		lda	scroll_x_player_b
		cmp	#112
		bcc	:+ ; if (this.scroll_x_b >= 112) {
			ldy	scroll_x_player
		: ; }
	
	game_scroll_calc:	; game_scroll_calc - apply scroll operations generally
		.if	.defined(SMBV2)
		: ; while (SMBV2 && fds_sprite_overlap_hit) {
			lda	fds_sprite_overlap_hit
			bne	:-
		; }
		.else
		:
		.endif

		tya
		sta	game_scroll_amount
		clc
		adc	game_scroll_h
		sta	game_scroll_h

		tya
		clc
		adc	pos_x_lo_screen_left
		sta	pos_x_lo_screen_left
		sta	ppu_scc_h_b
		lda	pos_x_hi_screen_left
		adc	#0
		sta	pos_x_hi_screen_left
	
		and	#ppu_ctlr0::bg_parity
		.if	.defined(SMBV1)
			sta	zp_byte_00
	
			lda	ppu_ctlr0_b
			and	#<~ppu_ctlr0::bg_parity
			ora	zp_byte_00
			sta	ppu_ctlr0_b
		.elseif	.defined(SMBV2)
			sta	ppu_ctlr0_bg
		.endif

		jsr	game_screen_pos_x_calc

		lda	#8
		sta	timer_scroll
		jmp	:++
	: ; } else {
		lda	#0
		sta	game_scroll_amount
	: ; }

	ldx	#0
	jsr	pos_bits_get_do_x
	sta	zp_byte_00
	ldy	#0
	asl	a
	bcs	:+
	iny
	lda	zp_byte_00
	and	#%00100000
	beq	:++
	: ; if (zp_byte_00 & 0xC0) {
		lda	pos_x_lo_screen_left, y
		sec
		sbc	game_scroll_off, y
		sta	pos_x_lo_player
		lda	pos_x_hi_screen_left, y
		sbc	#0
		sta	pos_x_hi_player
		lda	joypad_l_r
		cmp	game_scroll_btn_mask, y
		beq	:+ ; if (joypad_l_r != game_scroll_btn_mask[y]) {
			lda	#0
			sta	veloc_x_player
		: ; }
	; }

	lda	#0
	sta	actor_plat_scroll_x
	rts
; ----------------------------------
game_scroll_off:
	.byte	0, 16

game_scroll_btn_mask:
	.byte	joypad_button::right
	.byte	joypad_button::left
; ----------------------------------------------------------------------
; game_screen_pos_x_calc - calculate screen boundaries
	.export	game_screen_pos_x_calc
game_screen_pos_x_calc:
	lda	pos_x_lo_screen_left
	clc
	adc	#<255
	sta	pos_x_lo_screen_right
	lda	pos_x_hi_screen_left
	adc	#>255
	sta	pos_x_hi_screen_right
	rts
