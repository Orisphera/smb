.include	"system/cpu.i"

.include	"engine/mem.i"
.include	"engine/course_flags.i"
.include	"engine/joypad.i"
.include	"engine/sound.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

.include	"macros.i"

	.export	eng_game
eng_game:
	lda	eng_gameplay_mode
	jsr	eng_farjump

	.if	.defined(VS_SMB)
		.addr	game_vs_init
	.elseif	.defined(SMB2M)
		.addr	disk_loader_data2
	.endif

	.addr	eng_init_0_do

	.if	.defined(ANN)
		.addr	ann_toad_load
	.endif

	.addr	screen_proc
	.addr	eng_init_1_do
	.addr	game_proc
; -----------------------------------------------------------
.if	.defined(VS_SMB)
game_vs_init:
	inc	eng_gameplay_mode
	lda	#1
	sta	eng_disp_disable
	lda	#0
	sta	eng_sprite_overlap
	rts
.endif
; -----------------------------------------------------------
	.export	game_proc, game_proc_scroll_save
game_proc:
	.if	.defined(VS_SMB)
		lda	player_count
		beq	:+ ; if (player_count > 0) {
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
				ldx	player_id
				lda	joypad_p1, x
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
		beq	:+ ; if (joypad_button == right) {
			lda	joypad_p1
			and	#<~(joypad_button::left)
			sta	joypad_p1
		: ; }

		lda	joypad_p1
		and	#joypad_button::down
		beq	:+ ; if (joypad_button == down) {
			lda	joypad_p1
			and	#<~(joypad_button::up)
			sta	joypad_p1
		: ; }
	.endif

	jsr	game_proc_do
	lda	eng_gameplay_mode
	.if	.defined(CONS)
		cmp	#gameplay_mode::proc
	.elseif	.defined(VS)
		cmp	#gameplay_mode::init_1
	.endif
	bcs	:+ ; if (eng_gameplay_mode < proc) {
		rts
	: ; }

	jsr	game_proc_proj
	ldx	#0
	: ; for (actor_index = 0; actor_index < ENG_ACTOR_MAX; actor_index++) {
		stx	actor_index
		jsr	actor_proc
		jsr	screen_score_disp

		inx
		cpx	#ENG_ACTOR_MAX
		bne	:-
	; }

	jsr	lib_player_bits_get
	jsr	lib_calc_player_pos
	jsr	render_player
	jsr	block_flatten
	ldx	#ACTIVE_BLOCK_MAX-1
	stx	actor_index
	jsr	block_proc
	dex
	stx	actor_index
	jsr	block_proc

	jsr	misc_proc

	jsr	game_proc_cannon
	jsr	game_proc_whirlpool
	jsr	game_proc_pole_b
	jsr	game_proc_timer

	jsr	gfx_color_rotate

	.if	.defined(SMB2)
		lda	disk_loader_file_id
		beq	:+ ; if (disk_loader_file_id != main) {
			jsr	sub_C550
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
	bne	:+ ; if (player.timer_star) {
		; if (player.pos_y.hi < 2 && player.timer_star == 4 && !timer_nmi_tick) {
			jsr	sub_load_area_music
		: ; }
		ldy	timer_player_star
		lda	frame_count
		cpy	#8
		bcs	:+ ; if (player.timer_star < 8) {
			lsr	a
			lsr	a
		: ; }
		lsr	a
		jsr	game_proc_firefl_do
		jmp	:++
	: ; } else {
		jsr	game_proc_firefl_do_2
	: ; }

	lda	joypad_a_b
	sta	joypad_a_b_held
	lda	#joypad_button::none
	sta	joypad_l_r

GAME_SCROLL_END	= $20

game_proc_scroll_save:
	lda	nmi_addrs_ctl
	cmp	#nmi_addr::buffer_11_A
	beq	:++
	lda	bg_proc_id
	bne	:+
	lda	eng_scroll_h
	cmp	#GAME_SCROLL_END
	bmi	:++ ; if (nmi_addrs_ctl != buffer_11_A && (bg_proc_id == main_c || eng_scroll_h > GAME_SCROLL_END)) {
		; if (bg_proc_id == main_c) {
			lda	eng_scroll_h
			sbc	#GAME_SCROLL_END
			sta	eng_scroll_h
			lda	#0
			sta	ppu_nmi_buffer_1_offset
		: ; }
		jsr	bg_proc
	: ; }
	rts
; -----------------------------------------------------------
	.export	game_proc_scroll_do
game_proc_scroll:
	lda	player_scroll_x
	clc
	adc	actor_plat_scroll_x
	sta	player_scroll_x
	lda	eng_scroll_lock
	bne	:+++
	lda	player_scroll_x_b
	cmp	#$50
	bcc	:+++
	lda	timer_col_x
	bne	:+++
	ldy	player_scroll_x
	dey
	bmi	:+++ ; if (!eng_scroll_lock && player_scroll_x_b >= 0x50 && !timer_col_x && --player_scroll_x >= 0) {
		iny
		cpy	#2
		bcc	:+ ; if (++player_scroll_x >= 2) {
			dey
		: ; }
	
		lda	player_scroll_x_b
		cmp	#$70
		bcc	:+ ; if (player_scroll_x_b >= 0x70) {
			ldy	player_scroll_x
		: ; }
	
	game_proc_scroll_do:
		.if	.defined(SMB2M)
			; while (byte_77B) {
				lda	byte_77B
				bne	game_proc_scroll_do
			; }
		.endif

		tya
		sta	eng_scroll_amount
		clc
		adc	eng_scroll_h
		sta	eng_scroll_h
		tya
		clc
		adc	pos_x_lo_screen_left
		sta	pos_x_lo_screen_left
		sta	eng_scc_h_b
		lda	pos_x_hi_screen_left
		adc	#0
		sta	pos_x_hi_screen_left
		and	#ppu_ctlr0::bg_parity
		.if	.defined(SMB)|.defined(VS_SMB)
			sta	zp_byte_00
	
			lda	ppu_ctlr0_b
			and	#<~ppu_ctlr0::bg_parity
			ora	zp_byte_00
			sta	ppu_ctlr0_b
		.elseif	.defined(SMB2M)
			sta	ppu_ctlr0_bg
		.endif

		jsr	game_proc_disp_pos

		lda	#8
		sta	timer_scroll
		jmp	:++
	: ; } else {
		lda	#0
		sta	eng_scroll_amount
	: ; }

	ldx	#0
	jsr	lib_bits_get_do_x
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
		sbc	game_proc_scroll_off, y
		sta	pos_x_lo_player
		lda	pos_x_hi_screen_left, y
		sbc	#0
		sta	pos_x_hi_player
		lda	joypad_l_r
		cmp	game_proc_scroll_btn_mask, y
		beq	:+ ; if (joypad_l_r != game_proc_scroll_btn_mask[y]) {
			lda	#0
			sta	veloc_x_player
		: ; }
	; }

	lda	#0
	sta	actor_plat_scroll_x
	rts
; ----------------------------
game_proc_scroll_off:
	.byte	0, 16

game_proc_scroll_btn_mask:
	.byte	joypad_button::right
	.byte	joypad_button::left
; -----------------------------------------------------------
	.export	game_proc_disp_pos
game_proc_disp_pos:
	lda	pos_x_lo_screen_left
	clc
	adc	#$FF
	sta	pos_x_lo_screen_right
	lda	pos_x_hi_screen_left
	adc	#0
	sta	pos_x_hi_screen_right
	rts
; -----------------------------------------------------------
game_proc_do:
	lda	game_proc_id
	jsr	eng_farjump
	.addr	game_proc_start
	.addr	game_proc_vine
	.addr	game_proc_pipe_h
	.addr	game_proc_pipe_v
	.addr	game_proc_pole
	.addr	game_proc_victory
	.addr	game_proc_lifedown
	.addr	game_proc_enter
	.addr	game_proc_ctrl
	.addr	game_proc_size_chg
	.addr	game_proc_hurt
	.addr	game_proc_death
	.addr	game_proc_firefl
; -----------------------------------------------------------
game_proc_enter:
	lda	eng_start_alt
	cmp	#2
	beq	:+++ ; if () {
		lda	#joypad_button::none
		ldy	pos_y_lo_player
		cpy	#48
		bcc	game_proc_auto
		lda	course_enter_pos
		cmp	#COURSE_SCENERY_ENTER_POS_B0_B_VAL
		beq	:+
		cmp	#COURSE_SCENERY_ENTER_POS_B0_C_VAL
		bne	:++++++
		: lda	attr_player
		bne	:+ ; if (course.enter_pos == 0xB0 && player.priority == high && player.flip == none) {
			lda	#joypad_button::right
			jmp	game_proc_auto
		: ; } else {
			jsr	game_proc_pipe_h_enter
			dec	eng_timer_scene_trans
			bne	game_proc_enter_rts ; if (--eng_timer_scene_trans == 0) {
				inc	eng_disable_b
				jmp	game_proc_victory_do
			; } else rts;
		; }
	: lda	eng_joypad_override
	bne	:+ ; } else if (!eng_joypad_override) {
		lda	#$FF
		jsr	game_pos_y_lo_player_add
		lda	pos_y_lo_player
		cmp	#145
		bcc	:+++ ; if (pos_y_lo_player >= 145) {
			rts
		; }
	: ; } else {
		lda	height_vine
		cmp	#$60
		bne	game_proc_enter_rts
		lda	pos_y_lo_player
		cmp	#153
		ldy	#0
		lda	#joypad_button::right
		bcc	:+ ; if (pos_y_lo_player >= 153) {
			lda	#player_state::climb
			sta	state_player
			iny
			lda	#joypad_button::up
			sta	bg_buffer_0+$B4
		: ; }
		sty	eng_col_off
		jsr	game_proc_auto
		lda	pos_x_lo_player
		cmp	#72
		bcc	game_proc_enter_rts
	: ; } if ((!eng_joypad_override && pos_y_lo_player < 0x91) || (pos_x_lo_player >= 72)) {
		lda	#game_proc::ctrl
		sta	game_proc_id
		lda	#DIR_RIGHT
		sta	disp_dir_player
		lsr	a
		sta	eng_start_alt
		sta	eng_col_off
		sta	eng_joypad_override
	game_proc_enter_rts: ; }

	rts
; -----------------------------------------------------------
game_proc_ctrl_fall_y_hi_cutoff	= zp_byte_07

	.export	game_proc_auto
game_proc_auto:
	sta	joypad_p1
; ---------------------------
game_proc_ctrl:
	lda	game_proc_id
	cmp	#game_proc::death
	beq	:+++ ; if (game.proc_id != death) {
		lda	course_type
		bne	:++
		ldy	pos_y_hi_player
		dey
		bne	:+
		lda	pos_y_lo_player
		cmp	#$D0
		bcc	:++
		: ; if (course.type == water && player.pos_y >= 0x1D0) {
			lda	#joypad_button::none
			sta	joypad_p1
		: ; }
	
		lda	joypad_p1
		and	#(joypad_button::face_a|joypad_button::face_b)
		sta	joypad_a_b
		lda	joypad_p1
		and	#(joypad_button::left|joypad_button::right)
		sta	joypad_l_r
		lda	joypad_p1
		and	#(joypad_button::up|joypad_button::down)
		sta	joypad_u_d
		and	#joypad_button::down
		beq	:+
		lda	state_player
		bne	:+
		ldy	joypad_l_r
		beq	:+ ; if ((joypad_u_d & down) && player.state == ground && joypad_l_r) {
			lda	#joypad_button::none
			sta	joypad_l_r
			sta	joypad_u_d
		; }
	: ; }

	jsr	game_proc_player_move

	ldy	#col_box_type::small
	lda	player_size
	bne	:+ ; if (player.size == large) {
		ldy	#col_box_type::large

		lda	player_crouch
		beq	:+ ; if (player.crouch) {
			ldy	#col_box_type::crouch
		; }
	: ; }
	sty	col_box_player

	lda	#DIR_RIGHT
	ldy	veloc_x_player
	beq	:++
	bpl	:+ ; if (player.veloc_x != 0) {
		; if (player.veloc_x < 0) {
			asl	a
		: ; }
		sta	motion_dir_player
	: ; }

	jsr	game_proc_scroll

	jsr	lib_player_bits_get
	jsr	lib_calc_player_pos
	ldx	#0
	jsr	col_box_proc
	jsr	col_bg_proc

	lda	pos_y_lo_player
	cmp	#64
	bcc	:+
	lda	game_proc_id
	cmp	#game_proc::victory
	beq	:+
	cmp	#game_proc::enter
	beq	:+
	cmp	#game_proc::pole
	bcc	:+ ; if (player.pos_y.lo >= 64 && game.proc_id >= pole && game.proc_id.not_in(victory, enter)) {
		lda	attr_player
		and	#<~obj_attr::priority_bit
		sta	attr_player
	: ; }

	lda	pos_y_hi_player
	cmp	#2
	bmi	game_proc_ctrl_rts ; if (player.pos_y.hi >= 2) {
		ldx	#1
		stx	eng_scroll_lock

		ldy	#4
		sty	game_proc_ctrl_fall_y_hi_cutoff
		ldx	#0

		ldy	eng_done_timer
		bne	:+
		ldy	course_type_cloud
		bne	:+++
		: ; if (eng_done_timer != 0 || course.type != cloud) {
			inx

			ldy	game_proc_id
			cpy	#game_proc::death
			beq	:++ ; if (game.proc_id != death) {
				ldy	eng_music_event_death
				bne	:+ ; if (!eng_music_event_death) {
					iny
					sty	apu_music_event
					sty	eng_music_event_death
				: ; }
			
				ldy	#6
				sty	game_proc_ctrl_fall_y_hi_cutoff
			; }
		: ; }

		cmp	game_proc_ctrl_fall_y_hi_cutoff
		bmi	game_proc_ctrl_rts ; if (player.pos_y.hi >= fall_y_hi_cutoff) {
			dex
			bmi	:++ ; if (x) {
				ldy	snd_ram+1
				bne	:+ ; if (snd_ram[1] == 0) {
					lda	#game_proc::lifedown
					sta	game_proc_id
				: ; }
	
			game_proc_ctrl_rts:
				rts
			: ; } else {
				lda	#joypad_button::none
				sta	eng_joypad_override
				jsr	game_proc_vine_b
				inc	eng_start_alt
				rts
			; }
		; }
	; }
; -----------------------------------------------------------
game_proc_vine:
	lda	pos_y_hi_player
	bne	:+
	lda	pos_y_lo_player
	cmp	#$E4
	bcc	:++
	: ; if (player.pos_y >= 0xE4) {
		lda	#joypad_button::up
		sta	eng_joypad_override
		ldy	#player_state::climb
		sty	state_player
		jmp	game_proc_auto
	: ; } else {
	game_proc_vine_b:
		lda	#2
		sta	eng_start_alt
		jmp	game_proc_pipe_h_do_2
	; }
; -----------------------------------------------------------
game_proc_pipe_v:
	lda	#1
	jsr	game_pos_y_lo_player_add

	jsr	game_proc_scroll

	ldy	#0
	lda	eng_warp_ctrl
	bne	game_proc_pipe_h_do ; if (!eng_warp_ctrl) {
		iny
		lda	course_type
		cmp	#course_types::castle
		bne	game_proc_pipe_h_do ; if (course_type == castle) {
			iny
			jmp	game_proc_pipe_h_do
		; }
	; }
; -----------------------------
game_pos_y_lo_player_add:
	clc
	adc	pos_y_lo_player
	sta	pos_y_lo_player
	rts
; -----------------------------------------------------------
game_proc_pipe_h:
	jsr	game_proc_pipe_h_enter
	ldy	#2

game_proc_pipe_h_do:
	dec	eng_timer_scene_trans
	bne	:+ ; if (--eng_timer_scene_trans == 0) {
		sty	eng_start_alt
	
	game_proc_pipe_h_do_2:
		inc	eng_disp_disable
		lda	#gameplay_mode::init_0
		sta	eng_gameplay_mode
		sta	eng_sprite_overlap
	: ; }

	rts
; ------------------------------
game_proc_pipe_h_enter:
	lda	#8
	sta	veloc_x_player
	ldy	#joypad_button::right
	lda	pos_x_lo_player
	and	#(joypad_button::right|joypad_button::left|joypad_button::down|joypad_button::up)
	bne	:+ ; if (!(player.pos_x & 0x0F)) {
		sta	veloc_x_player
		tay
	: ; }
	tya
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		jsr	game_proc_auto
		rts
	.elseif	.defined(ANN)
		jmp	game_proc_auto
	.endif
; -----------------------------------------------------------
game_proc_size_chg:
	lda	eng_timer_ctl
	cmp	#$F8
	bne	:+ ; if (eng_timer_ctl == 0xF8) {
		jmp	game_proc_hurt_do
	: cmp	#$C4
	bne	:+ ; } else if (eng_timer_ctl == 0xC4) {
		jsr	game_proc_player_done
	: ; }

	rts
; -----------------------------------------------------------
game_proc_hurt:
	lda	eng_timer_ctl
	cmp	#$F0
	bcs	:+ ; if (eng_timer_ctl < 0xF0) {
		cmp	#$C8 ; if (eng_timer_ctl == 0xC8) {
			beq	game_proc_player_done
		; } else {
			jmp	game_proc_ctrl
		; }
	: ; }
	bne	:+ ; } else if (eng_timer_ctl >= 0xF0) {
	game_proc_hurt_do:
		ldy	player_resizing
		bne	:+ ; if (!player_resizing) {
			sty	player_ani_frame
			inc	player_resizing
			lda	player_size
			eor	#1
			sta	player_size
		: ; }
	; }

	rts
; -----------------------------------------------------------
game_proc_death:
	lda	eng_timer_ctl
	cmp	#$F0
	.if	.defined(SMB)|.defined(VS_SMB)
		bcs	game_proc_player_rts
	.elseif	.defined(SMB2M)
		bcs	game_proc_firefl_rts
	.endif
	jmp	game_proc_ctrl
; -----------------------------------------------------------
game_proc_player_done:
	lda	#0
	sta	eng_timer_ctl
	lda	#game_proc::ctrl
	sta	game_proc_id
	rts
; -----------------------------------------------------------
game_proc_firefl:
	lda	eng_timer_ctl
	cmp	#$C0
	beq	:+ ; if (eng_timer_ctl != 0xC0) {
		lda	frame_count
		lsr	a
		lsr	a

	game_proc_firefl_do:
		and	#obj_attr::color_bits
		sta	zp_byte_00
		lda	attr_player
		and	#<~obj_attr::color_bits
		ora	zp_byte_00
		sta	attr_player
		rts
	: ; } else {
		jsr	game_proc_player_done

	game_proc_firefl_do_2:
		lda	attr_player
		and	#<~obj_attr::color_bits|obj_attr::color0
		sta	attr_player
	game_proc_firefl_rts:
		rts
	; }
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
game_proc_player_rts:
	rts
.endif
; -----------------------------------------------------------
game_proc_pole:
	lda	actor_id+(ENG_ACTOR_MAX-1)
	cmp	#actor::flag_enemy
	bne	:++ ; if (this.actor_id == flag_enemy) {
		lda	eng_music_event_flag
		sta	apu_pulse1_queue

		lda	#joypad_button::none
		sta	eng_music_event_flag
		ldy	pos_y_lo_player
		cpy	#$9E
		bcs	:+ ; if (player.pos_y < 0x9E) {
			lda	#joypad_button::down
		: ; }
		jmp	game_proc_auto
	: ; } else {
		inc	game_proc_id
		rts
	; }
; -----------------------------------------------------------
game_proc_victory_oneup_tallies:
.if	.defined(SMB)|.defined(VS_SMB)
	.byte	$15, $23, $16, $1B
	.byte	$17, $18, $23, $63
.elseif	.defined(ANN)
	.byte	$14, $1E, $14, $1B
	.byte	$13, $18, $13, $63
.endif
; ----------------------------
game_proc_victory:
	lda	#joypad_button::right
	jsr	game_proc_auto

	lda	pos_y_lo_player
	cmp	#$AE
	bcc	:+
	.if	.defined(SMB)|.defined(VS_SMB)
	lda	eng_scroll_lock
	beq	:+ ; if (player.pos_y >= 0xAE && eng_scroll_lock || !(SMB|VS_SMB)) {
	.endif
		.if	.defined(SMB2M)
			lda	#0
			sta	eng_scroll_lock
		.endif

		.if	.defined(SMB2M)
		lda	byte_7F6
		bne	:+ ; if (!byte_7F6) {
		.endif
			lda	#music_event::level_end
			sta	apu_music_event
			.if	.defined(SMB)|.defined(VS_SMB)
				lda	#0
				sta	eng_scroll_lock
			.endif

		.if	.defined(SMB2M)
			inc	byte_7F6
		; }
		.endif
	: ; }

	lda	collision_player
	lsr	a
	bcs	:++ ; if (!(player.collision & right)) {
		lda	actor_proc_flag_victory_id
		bne	:+ ; if (actor_proc_flag_victory_id == null) {
			inc	actor_proc_flag_victory_id
		: ; }

		lda	#obj_attr::priority_low|obj_attr::color0
		sta	attr_player
	: ; }

	lda	actor_proc_flag_victory_id
	cmp	#<victory_flag_proc::done
	bne	:+++ ; if (actor_proc_flag_victory_id == done) {
		inc	eng_goals
		lda	eng_goals
		cmp	#3
		bne	:+
		ldy	course_no
		lda	eng_bonus_oneup_tally
		.if	.defined(SMB)|.defined(VS_SMB)|.defined(ANN)
		cmp	game_proc_victory_oneup_tallies, y
		.elseif	.defined(SMB2)
		cmp	#$0A
		.endif
		bcc	:+ ; if (++eng_goals == 3 && (eng_bonus_oneup_tally >= game_proc_victory_oneup_tallies[eng_course_no] || (SMB2M && eng_bonus_oneup_tally >= 0xA)) {
			inc	eng_hidden_one_up
		: ; }

	game_proc_victory_do:
		inc	course_sub

		.if	.defined(SMB2)
			lda	course_no
			cmp	#course::no_09
			bne	:+
			lda	eng_goals
			cmp	#4
			bne	:+ ; if (course_no == no_09 && eng_goals == 4) {
				lda	#0
				sta	eng_goals
				sta	course_sub
			; }
		.endif
		:

		jsr	course_descriptor_load
		inc	eng_req_timer
		jsr	game_proc_pipe_h_do_2
		sta	eng_startpage_alt
		lda	#music_event::none
		sta	apu_music_event
	: ; }

	rts
; -----------------------------------------------------------
game_proc_player_move:
	lda	#0
	ldy	player_size
	bne	:+
	lda	state_player
	bne	:++ ; if (player.size == small || player.state == ground) {
		; if (player.size == large) {
			lda	joypad_u_d
			and	#joypad_button::down
		: ; }
		sta	player_crouch
	: ; }

	jsr	game_proc_player_physics

	lda	player_resizing
	bne	:++ ; if (!player.resizing) {
		lda	state_player
		cmp	#player_state::climb
		beq	:+ ; if (player.state != climb) {
			ldy	#$18
			sty	timer_player_climb
		: ; }

		jsr	eng_farjump
		.addr	game_proc_player_ground
		.addr	game_proc_player_jump_swim
		.addr	game_proc_player_fall
		.addr	game_proc_player_climb
	: ; }

	rts
; -----------------------------------------------------------
game_proc_player_ground:
	jsr	game_proc_player_ani_speed

	lda	joypad_l_r
	beq	:+ ; if (joypad_l_r) {
		sta	disp_dir_player
	: ; }

	jsr	game_proc_player_friction

game_proc_player_ground_b:
	jsr	motion_x_check_spring
	sta	player_scroll_x

	.if	.defined(SMB2)
		lda	disk_loader_file_id
		beq	:+ ; if (disk_loader_file_id != main) {
			jsr	sub_C4FE
		: ; }
	.endif

	rts
; -----------------------------------------------------------
game_proc_player_fall:
	lda	player_gravity
	sta	accel_y_player
	jmp	game_proc_player_jump_swim_do
; -----------------------------------------------------------
game_proc_player_jump_swim:
	ldy	veloc_y_player
	bpl	:+
	lda	joypad_a_b
	and	#joypad_button::face_a
	and	joypad_a_b_held
	bne	:++
	lda	player_jump_org_y_lo
	sec
	sbc	pos_y_lo_player
	cmp	player_jump_diff
	bcc	:++
	: ; if (
	;	!(veloc_y_player & 0x80)
	;	|| (
	;		!((joypad_a_b & joypad_a_b_held) & face_a)
	;		&& ((player_jump_org_y_lo - pos_y_lo_player) >= player_mid_jump_y)
	;	)
	; ) {
		lda	player_gravity
		sta	accel_y_player
	: ; }

	lda	player_swimming
	beq	:++ ; if (player_swimming) {
		jsr	game_proc_player_ani_speed
		lda	pos_y_lo_player
		cmp	#$14
		bcs	:+ ; if (player_pos_y < 0x14) {
			lda	#$18
			sta	accel_y_player
		: ; }
	
		lda	joypad_l_r
		beq	:+ ; if (joypad_l_r) {
			sta	disp_dir_player
		; }
	: ; }

game_proc_player_jump_swim_do:
	lda	joypad_l_r
	beq	:+ ; if (joypad_l_r) {
		jsr	game_proc_player_friction
	: ; }

	.if	.defined(SMB)|.defined(VS_SMB)
		jsr	motion_x_check_spring
		sta	player_scroll_x
	.elseif	.defined(SMB2M)
		jsr	game_proc_player_ground_b
	.endif

	lda	game_proc_id
	cmp	#game_proc::death
	bne	:+ ; if (game_proc_id == death) {
		lda	#$28
		sta	accel_y_player
	: ; }

	jmp	motion_y_check_spring
; -----------------------------------------------------------
CLIMB_OFFSET_SMALL	= 4
CLIMB_OFFSET_LARGE	= 14

game_proc_player_climb_offset_x_lo:
	.byte	<CLIMB_OFFSET_LARGE, <CLIMB_OFFSET_SMALL, <-CLIMB_OFFSET_SMALL, <-CLIMB_OFFSET_LARGE

game_proc_player_climb_offset_x_hi:
	.byte	>CLIMB_OFFSET_LARGE, >CLIMB_OFFSET_SMALL, >-CLIMB_OFFSET_SMALL, >-CLIMB_OFFSET_LARGE
; -----------------------------
game_proc_player_climb:
	lda	accel_y_actor_b
	clc
	adc	accel_y_actor
	sta	accel_y_actor_b

	ldy	#0
	lda	veloc_y_player
	bpl	:+ ; if (veloc_y_player & 0x80) {
		dey
	: ; }
	sty	zp_byte_00
	adc	pos_y_lo_player
	sta	pos_y_lo_player
	lda	pos_y_hi_player
	adc	zp_byte_00
	sta	pos_y_hi_player

	lda	joypad_l_r
	and	collision_player
	beq	:++++ ; if ((joypad.l_r & player.collision) != none) {
		ldy	timer_player_climb
		bne	:+++ ; if (player.timer_climb == 0) {
			ldy	#24
			sty	timer_player_climb
			ldx	#0
			ldy	disp_dir_player
			lsr	a
			bcs	:+ ; if ((joypad.l_r & player.collision) & right) {
				inx
				inx
			: ; }
			dey
			beq	:+ ; if (player.disp_dir == right) {
				inx
			: ; }
		
			lda	pos_x_lo_player
			clc
			adc	game_proc_player_climb_offset_x_lo, x
			sta	pos_x_lo_player
			lda	pos_x_hi_player
			adc	game_proc_player_climb_offset_x_hi, x
			sta	pos_x_hi_player
			lda	joypad_l_r
			eor	#joypad_button::left|joypad_button::right
			sta	disp_dir_player
		: ; }
	
		rts
	: ; } else {
		sta	timer_player_climb
		rts
	; }
; -----------------------------------------------------------
STATS_BASE_INCLUDE	= 1

	.export	game_proc_player_stats
game_proc_player_stats:
	.include	"../../data/player_a_accel.s"

.if	.defined(SMB2M)
	.include	"../../data/player_a_friction.s"
.endif

game_proc_veloc_y_player:
	.byte	<-4, <-4, <-4, <-5, <-5

	.byte	<-2, <-1

game_proc_player_init_accel_y:
	.byte	0, 0, 0, 0, 0

	.byte	$80, $00

game_proc_player_max_veloc_left:
	.byte	<-$28, <-$18, <-$10

game_proc_player_max_veloc_right:
	.byte	$28, $18, $10

game_proc_player_max_veloc_right_enter:
	.byte	$0C

.if	.defined(SMB)|.defined(VS_SMB)
	.include	"../../data/player_a_friction.s"
.endif

game_proc_player_climb_veloc_y:
	.byte	0, <-1, 1

game_proc_player_climb_accel_y:
	.byte	0, 32, <-1
; ------------------------
game_proc_player_physics:
	lda	state_player
	cmp	#player_state::climb
	bne	:+++ ; if (player.state == climb) {
		ldy	#0
		lda	joypad_u_d
		and	collision_player
		beq	:+ ; if ((player.collision & joypad.u_d) != none) {
			iny
			and	#COL_TOP
			bne	:+ ; if ((player.collision & joypad.u_d) != top) {
				iny
			; }
		: ; }
		ldx	game_proc_player_climb_accel_y, y
		stx	accel_y_actor
	
		lda	#8
		ldx	game_proc_player_climb_veloc_y, y
		stx	veloc_y_player
		bmi	:+ ; (player.veloc_y >= 0) { 
			lsr	a
		: ; }
		sta	timer_player_ani
	
		rts
	: lda	eng_spring_ani
	bne	:+
	lda	joypad_a_b
	and	#joypad_button::face_a
	beq	:+
	and	joypad_a_b_held
	beq	:++
	: ; } else if (eng_spring_ani || pressed_a || held_a || (player.state != ground && !player.swimming)) {
		jmp	:+++++++
	:
	lda	state_player
	beq	:+
	lda	player_swimming
	beq	:--
	lda	timer_player_jump_swim
	bne	:+
	lda	veloc_y_player
	bpl	:+ ; } else if (player.state != ground && player.swimming && !player.timer_jump_swim && player.veloc_y < 0) {
		jmp	:++++++
	: ; } else {
		lda	#$20
		sta	timer_player_jump_swim
		ldy	#0
		sty	accel_y_actor_b
		sty	accel_y_actor
		lda	pos_y_hi_player
		sta	player_jump_org_y_hi
		lda	pos_y_lo_player
		sta	player_jump_org_y_lo
		lda	#player_state::jump_swim
		sta	state_player
		lda	veloc_x_player_abs
		cmp	#$09
		bcc	:+ ; if (abs(player.veloc_x) >= 0x9) {
			iny
			cmp	#$10
			bcc	:+ ; if (abs(player.veloc_x) >= 0x10) {
				iny
				cmp	#$19
				bcc	:+ ; if (abs(player.veloc_x) >= 0x19) {
					iny
					cmp	#$1C
					bcc	:+ ; if (abs(player.veloc_x) >= 0x1C) {
						iny
					; }
				; }
			; }
		: ; }
		lda	#1
		sta	player_jump_diff

		lda	player_swimming
		beq	:+ ; if (player.swimming) {
			ldy	#$05
			lda	eng_whirlpool_flag
			beq	:+ ; if (eng_whirlpool_flag) {
				iny
			; }
		: ; }

		lda	game_proc_player_jump_accel_y, y
		sta	accel_y_player
		lda	game_proc_player_grav_accel_y, y
		sta	player_gravity
		lda	game_proc_player_init_accel_y, y
		sta	accel_y_actor
		lda	game_proc_veloc_y_player, y
		sta	veloc_y_player

		lda	player_swimming
		beq	:+ ; if (player.swimming) {
			lda	#sfx_pulse1::stomp
			sta	apu_pulse1_queue
	
			lda	pos_y_lo_player
			cmp	#$14
			bcs	:+++ ; if (player.pos_y < 0x14) {
				lda	#0
				sta	veloc_y_player
				jmp	:+++
			; }
		: ; } else {
			lda	#sfx_pulse1::jump_big
			ldy	player_size
			beq	:+ ; if (player.size == small) {
				lda	#sfx_pulse1::jump_small
			: ; }
			sta	apu_pulse1_queue
		; }
	: ; }

	ldy	#0
	sty	zp_byte_00
	lda	state_player
	beq	:+ ; if (player.state != ground) {
		lda	veloc_x_player_abs
		cmp	#$19
		bcs	:+++++
		bcc	:++
	: ; } else {
		iny
		lda	course_type
		beq	:+ ; if (course_type != water) {
			dey
			lda	joypad_l_r
			cmp	motion_dir_player
			bne	:+ ; if (player_button == motion_dir) {
				lda	joypad_a_b
				and	#joypad_button::face_b
				bne	:+++
				lda	timer_player_run
				bne	:++++
			; }
		: ; }
	; }

	; if (
	;	(player.state != ground && abs(player.veloc_x) >= 0x19)
	;	|| (player.state == ground && course_type == water)
	; ) {
		iny
		inc	zp_byte_00
		lda	player_veloc_run
		bne	:+
		lda	veloc_x_player_abs
		cmp	#$21
		bcc	:+++
		: inc	zp_byte_00
		jmp	:++
	: ; } if (pressed_b || player.veloc_run) {
		lda	#$0A
		sta	timer_player_run
	: ; }

	lda	game_proc_player_max_veloc_left, y
	sta	player_max_veloc_left
	lda	game_proc_id
	cmp	#game_proc::enter
	bne	:+ ; if (game_proc_id == enter) {
		ldy	#game_proc_player_max_veloc_right_enter-game_proc_player_max_veloc_right
	: ; }
	lda	game_proc_player_max_veloc_right, y
	sta	player_max_veloc_right
	ldy	zp_byte_00
	lda	game_proc_player_data_friction, y
	sta	eng_friction_add_lo
	lda	#0
	sta	eng_friction_add_hi
	lda	disp_dir_player
	cmp	motion_dir_player
	beq	:+ ; if (player.dir != player.motion_dir) {
		.export game_proc_player_physics_friction_shift
	game_proc_player_physics_friction_shift:
		asl	eng_friction_add_lo
		rol	eng_friction_add_hi
	: ; }

	rts
; -----------------------------------------------------------
game_proc_player_ani_timers:
	.byte	$02, $04, $07
; ---------------------------
game_proc_player_ani_speed:
	ldy	#0
	lda	veloc_x_player_abs
	cmp	#$1C
	bcs	:++ ; if (veloc_x_player_abs < 0x1C) {
		iny
		cmp	#$0E
		bcs	:+ ; if (veloc_x_player_abs < 0x0E) {
			iny
		: ; }

		lda	joypad_p1
		and	#<~(joypad_button::face_a)
		beq	:+++
		and	#(joypad_button::left|joypad_button::right)
		cmp	motion_dir_player
		bne	:++ ; if (no_motion) {
			lda	#0
		; }
	: ; } if (run_motion) {
		sta	player_veloc_run
		jmp	:++
	: ; } else {
		lda	veloc_x_player_abs
		cmp	#$0B
		bcs	:+ ; if (veloc_x_player_abs < 0x0B) {
			lda	disp_dir_player
			sta	motion_dir_player
			lda	#0
			sta	veloc_x_player
			sta	accel_x_player
		; }
	: ; }

	lda	game_proc_player_ani_timers, y
	sta	timer_player_ani
	rts
; -----------------------------------------------------------
game_proc_player_friction:
	and	collision_player
	cmp	#COL_NONE
	bne	:+
	lda	veloc_x_player
	beq	:+++++
	bpl	:+++
	bmi	:++
	: lsr	a
	bcc	:++
	: ; if (player.collision == none && player.veloc_x < 0) {
		lda	accel_x_player
		clc
		adc	eng_friction_add_lo
		sta	accel_x_player
		lda	veloc_x_player
		adc	eng_friction_add_hi
		sta	veloc_x_player
		cmp	player_max_veloc_right
		bmi	:++ ; if (player.veloc_x > player_max_veloc_right) {
			lda	player_max_veloc_right
			sta	veloc_x_player
			jmp	:+++
		; }
	: ; } else {
		lda	accel_x_player
		sec
		sbc	eng_friction_add_lo
		sta	accel_x_player
		lda	veloc_x_player
		sbc	eng_friction_add_hi
		sta	veloc_x_player
		cmp	player_max_veloc_left
		bpl	:+ ; if (player.veloc_x < player_max_veloc_left) {
			lda	player_max_veloc_left
			sta	veloc_x_player
		; }
	: ; } if () {
		cmp	#0
		bpl	:+ ; if (player.veloc_x < 0) {
			neg_m
		; }
	: ; }

	sta	veloc_x_player_abs
	rts
; -----------------------------------------------------------
game_proc_proj:
	lda	player_status
	cmp	#2
	bcc	:++ ; if (player_status >= 2) {
		lda	joypad_a_b
		and	#joypad_button::face_b
		beq	:+
		and	joypad_a_b_held
		bne	:+
		lda	eng_fireball_counter
		and	#1
		tax
		lda	state_proj, x
		bne	:+
		ldy	pos_y_hi_player
		dey
		bne	:+
		lda	player_crouch
		bne	:+
		lda	state_player
		cmp	#player_state::climb
		beq	:+ ; if (
			;	(pressed_b)
			;	&& !(held_b)
			;	&& proj.state[eng_fireball_counter&1] == inactive
			;	&& !(--player.pos_y.hi)
			;	&& !player_crouch
			;	&& player.state != climb
			; ) {
			lda	#sfx_pulse1::proj
			sta	apu_pulse1_queue
			lda	#proj_states::state_2
			sta	state_proj, x
			ldy	timer_player_ani
			sty	eng_timer_fireball_throw
			dey
			sty	timer_ani_proj
			inc	eng_fireball_counter
		: ; }
	
		ldx	#0
		jsr	game_proc_proj_do
		ldx	#1
		jsr	game_proc_proj_do
	: ; }

	lda	course_type
	bne	:++ ; if (course_type == water) {
		ldx	#3-1
		: ; for (x = 3-1; x >= 0; x--) {
			stx	actor_index
			jsr	game_proc_bubble_do

			jsr	lib_calc_bubble_pos
			jsr	lib_bubble_bits_get
			jsr	render_bubble

			dex
			bpl	:-
		; }
	: ; }
	rts
; -----------------------------------------------------------
PROJ_VELOC_X_ABS	= 64

game_proc_veloc_x_proj:
	.byte	PROJ_VELOC_X_ABS, <-PROJ_VELOC_X_ABS
; -----------------------------
game_proc_proj_do:
	stx	actor_index
	lda	state_proj, x
	asl	a
	bcs	:+++ ; if (proj.bit_7) {
		ldy	state_proj, x
		beq	game_proc_proj_do_rts
		dey
		beq	:+ ; if (proj.state == state_1) {
			lda	pos_x_lo_player
			adc	#4
			sta	pos_x_lo_proj, x
			lda	pos_x_hi_player
			adc	#0
			sta	pos_x_hi_proj, x
			lda	pos_y_lo_player
			sta	pos_y_lo_proj, x
			lda	#1
			sta	pos_y_hi_proj, x
			ldy	disp_dir_player
			dey
			lda	game_proc_veloc_x_proj, y
			sta	veloc_x_proj, x
			lda	#4
			sta	veloc_y_proj, x
			lda	#7
			sta	col_box_proj, x
			dec	state_proj, x
		: ; }
		txa
		clc
		adc	#ENG_PROJ_OFF
		tax

		lda	#$50
		sta	motion_gravity_accel_y_inc
		lda	#3
		sta	motion_gravity_veloc_y_max_abs
		lda	#0
		jsr	motion_gravity
		jsr	motion_x_do

		ldx	actor_index
		jsr	lib_calc_proj_pos
		jsr	lib_proj_bits_get
		jsr	col_proj_box
		jsr	col_proj_proc

		lda	bits_offscr_proj
		and	#%11001100
		bne	:+ ; if () {
			jsr	col_proj_actor_proc
			jmp	render_proj
		: ; } else {
			lda	#proj_states::inactive
			sta	state_proj, x
		game_proc_proj_do_rts:
			rts
		; }
	: ; } else {
		jsr	lib_calc_proj_pos
		jmp	render_proj_hit
	; }
; -----------------------------------------------------------
	.export	game_proc_bubble_init
game_proc_bubble_do:
	lda	eng_rand_seed+1, x
	and	#1
	sta	zp_byte_07
	lda	pos_y_lo_bubble, x
	cmp	#ENG_OAM_CLEAR_SCANLINE
	bne	:++
	lda	timer_bubble
	bne	:++++ ; if () {
		; if () {
		game_proc_bubble_init:
			ldy	#0
			lda	disp_dir_player
			lsr	a
			bcc	:+ ; if (disp_dir_player == right) {
				ldy	#8
			: ; }
			tya
			adc	pos_x_lo_player
			sta	pos_x_lo_bubble, x
			lda	pos_x_hi_player
			adc	#0
			sta	pos_x_hi_bubble, x
			lda	pos_y_lo_player
			clc
			adc	#8
			sta	pos_y_lo_bubble, x
			lda	#1
			sta	pos_y_hi_bubble, x
			ldy	zp_byte_07
			lda	game_proc_bubble_timers, y
			sta	timer_bubble
		: ; }

		ldy	zp_byte_07
		lda	accel_y_bubble, x
		sec
		sbc	game_proc_bubble_accel_y, y
		sta	accel_y_bubble, x
		lda	pos_y_lo_bubble, x
		sbc	#0
		cmp	#$20
		bcs	:+ ; if () {
			lda	#ENG_OAM_CLEAR_SCANLINE
		: ; }
		sta	pos_y_lo_bubble, x
	: ; }

	rts
; -----------------------------
game_proc_bubble_accel_y:
	.byte	<-1, 80

game_proc_bubble_timers:
	.byte	64, 32
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	ENG_TIMER_DISP	= eng_timer_disp
.elseif	.defined(SMB2M)
	ENG_TIMER_DISP	= eng_timer_disp_b
.endif
game_proc_timer:
	lda	eng_game_mode
	beq	:++++
	lda	game_proc_id
	cmp	#game_proc::ctrl
	bcc	:++++
	cmp	#game_proc::death
	beq	:++++
	lda	pos_y_hi_player
	cmp	#2
	.if	.defined(SMB)|.defined(VS_SMB)
	bcs	:++++
	.elseif	.defined(SMB2M)
	bpl	:++++
	.endif
	lda	timer_game_ctrl
	bne	:++++ ; if (eng_game_mode != 0 && game_proc_id >= ctrl && game_proc_id != death && pos_y_hi_player < 2 && !timer_game_ctrl) {
		lda	ENG_TIMER_DISP
		ora	ENG_TIMER_DISP+1
		ora	ENG_TIMER_DISP+2
		beq	:+++ ; if (eng_timer_disp) {
			ldy	ENG_TIMER_DISP
			dey
			bne	:+
			lda	ENG_TIMER_DISP+1
			ora	ENG_TIMER_DISP+2
			bne	:+ ; if (--eng_timer_disp == 0) {
				lda	#music_event::hurry_up
				sta	apu_music_event
			: ; }

			.if	.defined(CONS)
				lda	#$18
				:
			.elseif	.defined(VS)
				lda	#$11
				ldy	VS_RAM_ARENA0+3
				bne	:+ ; if (!vs_ram_arena0[3]) {
					lda	#$14
				: ; }
			.endif

			sta	timer_game_ctrl
			.if	.defined(SMB)|.defined(VS_SMB)
				ldy	#$23
			.elseif	.defined(SMB2M)
				ldy	#$17
			.endif
			lda	#$FF
			sta	score_digit_mod+6
			jsr	eng_stats_math
			.if	.defined(SMB)|.defined(VS_SMB)
				lda	#$A4
			.elseif	.defined(SMB2M)
				lda	#$A2
			.endif
			jmp	eng_stats_print_num
		: ; } else {
			sta	player_status
			jsr	col_player_harm_proc_do
			inc	eng_done_timer
		; }
	: ; }

game_proc_timer_rts:
	rts
; -----------------------------------------------------------
	.export game_proc_warp
game_proc_warp:
	lda	eng_scroll_lock
	beq	game_proc_timer_rts
	lda	pos_y_lo_player
	and	pos_y_hi_player
	bne	game_proc_timer_rts ; if (eng_scroll_lock && player.pos_y == 0) {
		sta	eng_scroll_lock

		.if	.defined(SMB)|.defined(VS_SMB)
			inc	eng_warp_ctrl
		.endif

		jmp	actor_erase
	; } else rts;
; -----------------------------------------------------------
game_proc_whirlpool:
	lda	course_type
	bne	:+++ ; if (course_type == water) {
		sta	eng_whirlpool_flag

		lda	eng_timer_ctl
		bne	:+++ ; if (!eng_timer_ctl) {
			ldy	#5-1
			: ; for (y = 5-1; y >= 0; y--) {
				lda	pos_x_lo_cannon, y
				clc
				adc	pos_y_lo_cannon, y
				sta	zp_byte_02

				lda	pos_y_hi_cannon, y
				beq	:+ ; if (this.pos_y.hi > 0) {
					adc	#0
					sta	zp_byte_01
					lda	pos_x_lo_player
					sec
					sbc	pos_x_lo_cannon, y

					lda	pos_x_hi_player
					sbc	pos_y_hi_cannon, y
					bmi	:+ ; if ((player.pos_x.hi - this.pos_y.hi) >= 0) {
						lda	zp_byte_02
						sec
						sbc	pos_x_lo_player
						lda	zp_byte_01
						sbc	pos_x_hi_player
						bpl	game_proc_whirlpool_do
					; }
				: ; }
			
				dey
				bpl	:--
			; }
		; }
	: ; }

	rts
; ------------------------------
game_proc_whirlpool_do:
	lda	pos_y_lo_cannon, y
	lsr	a
	sta	zp_byte_00
	lda	pos_x_lo_cannon, y
	clc
	adc	zp_byte_00
	sta	zp_byte_01
	lda	pos_y_hi_cannon, y
	adc	#0
	sta	zp_byte_00

	lda	frame_count
	lsr	a
	bcc	:+++ ; if (frame_count % 2) {
		lda	zp_byte_01
		sec
		sbc	pos_x_lo_player
		lda	zp_byte_00
		sbc	pos_x_hi_player
		bpl	:+ ; if (this.pos_y.hi >= player.pos_x.hi) {
			lda	pos_x_lo_player
			sec
			sbc	#1
			sta	pos_x_lo_player
			lda	pos_x_hi_player
			sbc	#0
			jmp	:++
		: ; } else {
			lda	collision_player
			lsr	a
			bcc	:++
			lda	pos_x_lo_player
			clc
			adc	#1
			sta	pos_x_lo_player
			lda	pos_x_hi_player
			adc	#0
		: ; }

		; if (this.pos_y.hi >= this.pos_x.hi || player.collision == right) {
			sta	pos_x_hi_player
		; }
	: ; }

	lda	#16
	sta	motion_gravity_accel_y_inc
	lda	#1
	sta	eng_whirlpool_flag
	sta	motion_gravity_veloc_y_max_abs
	lsr	a
	tax
	jmp	motion_gravity
; -----------------------------------------------------------
SCORE_PLACE_THOUSANDS		= 3
SCORE_PLACE_THOUSANDS_DIV	= 1000
SCORE_PLACE_HUNDREDS		= 4
SCORE_PLACE_HUNDREDS_DIV	= 100

game_proc_pole_score_hi:
	.byte	5000/(SCORE_PLACE_THOUSANDS_DIV)
	.byte	2000/(SCORE_PLACE_THOUSANDS_DIV)
	.byte	800/(SCORE_PLACE_HUNDREDS_DIV)
	.byte	400/(SCORE_PLACE_HUNDREDS_DIV)
	.byte	100/(SCORE_PLACE_HUNDREDS_DIV)

game_proc_pole_digit_place:
	.byte	SCORE_PLACE_THOUSANDS
	.byte	SCORE_PLACE_THOUSANDS
	.byte	SCORE_PLACE_HUNDREDS
	.byte	SCORE_PLACE_HUNDREDS
	.byte	SCORE_PLACE_HUNDREDS
; -----------------------------
game_proc_pole_b:
	ldx	#5
	stx	actor_index
	lda	actor_id, x
	cmp	#actor::flag_enemy
	bne	game_proc_pole_b_rts
	lda	game_proc_id
	cmp	#game_proc::pole
	bne	:+
	lda	state_player
	cmp	#player_state::climb
	bne	:+
	lda	pos_y_lo_actor, x
	cmp	#170
	bcs	:++
	lda	pos_y_lo_player
	cmp	#162
	bcs	:++ ; if (game_proc_id != pole || player.state != climb || (this.pos_y.lo < 0xAA && player.pos_y.lo < 0xA2)) {
		; if (game_proc_id == pole && player.state == climb) {
			lda	pos_y_actor, x
			adc	#<-1
			sta	pos_y_actor, x
			lda	pos_y_lo_actor, x
			adc	#1
			sta	pos_y_lo_actor, x
			lda	render_flag_score_pos_y_b
			sec
			sbc	#<-1
			sta	render_flag_score_pos_y_b
			lda	render_flag_score_pos_y
			sbc	#1
			sta	render_flag_score_pos_y
		: ; }

		jmp	:++++
	: ; } else {
		ldy	render_flag_score_val
	
		.if	.defined(SMB2M)
		cpy	#FLAG_SCORE_VALUE_ONEUP
		bne	:+ ; if (SMB2M && render_flag_score_val == oneup) {
			inc	player_lives
			lda	#sfx_pulse2::oneup
			sta	apu_pulse2_queue
			jmp	:++
		.endif
		: ; } else {
			lda	game_proc_pole_score_hi, y
			ldx	game_proc_pole_digit_place, y
			sta	score_digit_mod+1, x
			jsr	misc_proc_coin_update_score
		: ; }

		lda	#game_proc::victory
		sta	game_proc_id
	: ; }

	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	render_flag_enemy

game_proc_pole_b_rts:
	rts
; -----------------------------------------------------------
game_proc_spring_pos_y:
	.byte	$08, $10, $08, $00
; -----------------------------
	.export game_proc_spring
game_proc_spring:
	jsr	lib_actor_bits_get
	lda	eng_timer_ctl
	bne	game_proc_spring_ctd
	lda	eng_spring_ani
	beq	game_proc_spring_ctd ; if (!eng_timer_ctl && eng_spring_ani) {
		tay
		dey
		tya
		and	#%00000010
		bne	:+ ; if (!((eng_spring_ani - 1) & 0x02)) {
			inc	pos_y_lo_player
			inc	pos_y_lo_player
			jmp	:++
		: ; } else {
			dec	pos_y_lo_player
			dec	pos_y_lo_player
		: ; }

		lda	veloc_x_actor, x
		clc
		adc	game_proc_spring_pos_y, y
		sta	pos_y_lo_actor, x

		cpy	#1
		bcc	game_proc_spring_skip_accel
		lda	joypad_a_b
		and	#joypad_button::face_a
		beq	game_proc_spring_skip_accel
		and	joypad_a_b_held
		bne	game_proc_spring_skip_accel ; if ((eng_spring_ani - 1) >= 1 && (joypad_a_b & 0x80) && !(joypad_a_b & joypad_a_b_held 0x80)) {
			.if	.defined(SMB2M)
				tya
				pha
			.endif

			lda	#$F4

			.if	.defined(SMB2)
				ldy	course_no
				cpy	#course::no_02
				beq	:+
				cpy	#course::no_03
				beq	:+
				cpy	#course::no_07
				bne	:++
				: ; if (SMB2M && course_no.in(2, 3, 7)) {
					lda	#$E0
				: ; }
			.elseif	.defined(ANN)
				ldy	ENG_HARDMODE_VAR
				beq	:+ ; if (ANN && hard_mode) {
					jsr	sub_C4FE_b
				: ; }
			.endif

			sta	accel_y_spring

			.if	.defined(SMB2M)
				pla
				tay
			.endif
		game_proc_spring_skip_accel: ; }
		cpy	#3
		bne	:+ ; if ((eng_spring_ani - 1) == 3) {
			lda	accel_y_spring
			sta	veloc_y_player
			lda	#0
			sta	eng_spring_ani
		; }
	: ; }

game_proc_spring_ctd:
	jsr	lib_calc_actor_pos
	jsr	render_actor
	jsr	col_actor_oob_proc

	lda	eng_spring_ani
	beq	:+
	lda	timer_spring
	bne	:+ ; if (eng_spring_ani && !timer_spring) {
		lda	#4
		sta	timer_spring
		inc	eng_spring_ani
	: ; }

	rts
; -----------------------------------------------------------
	.export game_proc_vine_init
game_proc_vine_init:
	lda	#actor::vine
	sta	actor_id, x
	lda	#actor_modes::active
	sta	actor_mode, x
	lda	pos_x_hi_block, y
	sta	pos_x_hi_actor, x
	lda	pos_x_lo_block, y
	sta	pos_x_lo_actor, x

	lda	pos_y_lo_block, y
	sta	pos_y_lo_actor, x
	ldy	actor_vine_flag
	bne	:+ ; if (!actor_vine_flag) {
		sta	pos_y_vine
	: ; }

	txa
	sta	actor_vine_offset, y
	inc	actor_vine_flag
	lda	#sfx_pulse2::spawn_vine
	sta	apu_pulse2_queue
	rts
; -----------------------------
GAME_PROC_VINE_ACTOR_ID	= (ENG_ACTOR_MAX-1)

game_proc_vine_heights:
	.byte	$30, $60
; --------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(ANN)
VINE_DO_VAR0	= $26
.elseif	.defined(SMB2)
VINE_DO_VAR0	= $23
.endif

	.export game_proc_vine_do
game_proc_vine_do:
	cpx	#5
.if	.defined(SMB)
	bne	:+++++ ; if (x == 5) {
.elseif	.defined(VS_SMB)|.defined(SMB2M)
	beq	:+ ; if (x != 5) {
		rts
	: ; }
.endif
		ldy	actor_vine_flag
		dey
		lda	height_vine
		cmp	game_proc_vine_heights, y
		beq	:+
		lda	frame_count
		lsr	a
		lsr	a
		bcc	:+ ; if (height_vine != game_proc_vine_heights[actor_vine_flag] && frame_count % 4) {
			lda	pos_y_lo_actor+GAME_PROC_VINE_ACTOR_ID
			sbc	#1
			sta	pos_y_lo_actor+GAME_PROC_VINE_ACTOR_ID
			inc	height_vine
		: ; }
	
		lda	height_vine
		cmp	#8
		bcc	:++++ ; if (height_vine >= 8) {
			jsr	lib_calc_actor_pos
			jsr	lib_actor_bits_get

			ldy	#0
			: ; for (y = 0; y < actor_vine_flag; y++) {
				jsr	render_vine

				iny
				cpy	actor_vine_flag
				bne	:-
			; }
		
			lda	bits_offscr_actor
			and	#%00001100
			beq	:++ ; if (bits_offscr_actor & 0x0C) {
				dey
				: ; for (y = actor_vine_flag - 1; y >= 0; y--) {
					ldx	actor_vine_offset, y
					jsr	actor_erase

					dey
					bpl	:-
				; }

				sta	actor_vine_flag
				sta	height_vine
			: ; }
		
			lda	height_vine
			cmp	#$20
			bcc	:+ ; if (height_vine >= 0x20) {
				ldx	#$06
				lda	#$01
				ldy	#$1B
				jsr	col_box_buffer

				ldy	zp_byte_02
				cpy	#$D0
				bcs	:+
				lda	(eng_buffer_ptr), y
				bne	:+ ; if (zp_byte_02 < 0xD0 && !eng_buffer_ptr[zp_byte_02]) {
					lda	#VINE_DO_VAR0
					sta	(eng_buffer_ptr), y
				; }
			; }
		; }
	: ; }

	.if	.defined(VS_SMB)|.defined(SMB2M)
		lda	pos_x_lo_actor+GAME_PROC_VINE_ACTOR_ID
		sec
		sbc	pos_x_lo_screen_left
		tay
		lda	pos_x_hi_actor+GAME_PROC_VINE_ACTOR_ID
		sbc	pos_x_hi_screen_left
		bmi	:+
		cpy	#9
		bcs	:++++
		: ; if (pos_x_hi_screen_left < 0 || (this.pos_x.lo - pos_x_lo_screen_left) < 9) {
			lda	#actor_modes::free
			sta	actor_mode+GAME_PROC_VINE_ACTOR_ID
			lda	pos_x_hi_actor+GAME_PROC_VINE_ACTOR_ID
			and	#1
			.if	.defined(VS_SMB)
				nop
			.endif
			tay
			lda	bg_buffer_ptr_lo, y
			sta	eng_buffer_ptr
			lda	bg_buffer_ptr_hi, y
			sta	eng_buffer_ptr+1

			lda	pos_x_lo_actor+GAME_PROC_VINE_ACTOR_ID
			lsr	a
			lsr	a
			lsr	a
			lsr	a
			: ; for (a = this.pos_x.lo / 16; a < 0xD0; a += 0x10) {
				tay
				lda	(eng_buffer_ptr), y
				cmp	#VINE_DO_VAR0
				bne	:+ ; if (eng_buffer_ptr[a] == vine_do_var0) {
					lda	#0
					sta	(eng_buffer_ptr), y
				: ; }

				tya
				clc
				adc	#$10
				cmp	#$D0
				bcc	:--
			; }
		: ; }
	.endif

	ldx	actor_index
	rts
; -----------------------------------------------------------
game_proc_cannon_masks:
	.byte	%00001111
	.byte	%00000111
; -----------------------------
game_proc_cannon:
	lda	course_type
	beq	:+++++ ; if (course_type != water) {
		ldx	#2
		: ; for (actor_index = 2; actor_index >= 0; actor_index--) {
			stx	actor_index
			lda	actor_mode, x
			bne	:++
			lda	eng_rand_seed+1, x
			ldy	game_hard_mode_b
			and	game_proc_cannon_masks, y
			cmp	#6
			bcs	:++
			tay
			lda	pos_y_hi_cannon, y
			beq	:++ ; if (
			;	this.mode == dead
			;	&& (eng_rand_seed[actor_index+1] & game_proc_cannon_masks[game_hard_mode_b]) < 6
			;	&& (pos_y_hi_cannon[(eng_rand_seed[actor_index+1])])
			; ) {
				lda	eng_timer_cannon, y
				beq	:+ ; if (eng_timer_cannon[rand_masked]) {
					sbc	#0
					sta	eng_timer_cannon, y
					jmp	:++
				: ; } else {
					lda	eng_timer_ctl
					bne	:+ ; if (eng_timer_ctl == 0) {
						lda	#$0E
						sta	eng_timer_cannon, y
						lda	pos_y_hi_cannon, y
						sta	pos_x_hi_actor, x
						lda	pos_x_lo_cannon, y
						sta	pos_x_lo_actor, x
						lda	pos_y_lo_cannon, y
						sec
						sbc	#8
						sta	pos_y_lo_actor, x
						lda	#actor_modes::active
						sta	pos_y_hi_actor, x
						sta	actor_mode, x
						lsr	a
						sta	state_actor, x
						lda	#9
						sta	col_box_actor, x
						lda	#actor::bullet
						sta	actor_id, x
						jmp	:++
					; }
				; }
			: ; }

			; if (this.mode != dead || rand_masked >= 6 || !pos_y_hi_cannon[rand_masked] || eng_timer_cannon[rand_masked] || eng_timer_ctl != 0) {
				lda	actor_id, x
				cmp	#actor::bullet
				bne	:+ ; if (this.actor_id == bullet) {
					jsr	col_actor_oob_proc
			
					lda	actor_mode, x
					beq	:+ ; if (this.mode != dead) {
						jsr	lib_actor_bits_get
						jsr	game_proc_bullet
					; }
				; }
			: ; }
		
			dex
			bpl	:----
		; }
	: ; }

	rts
; -----------------------------------------------------------
BULLET_VELOC_X_ABS	= 24

game_proc_bullet_veloc_x:
	.byte	BULLET_VELOC_X_ABS, <-BULLET_VELOC_X_ABS
; -----------------------------
game_proc_bullet:
	lda	eng_timer_ctl
	bne	:++++ ; if (!eng_timer_ctl) {
		lda	state_actor, x
		bne	:++ ; if (this.state == dead) {
			lda	bits_offscr_actor
			and	#%00001100
			cmp	#%00001100
			beq	:+++++ ; if ((bits_offscr_actor & 0x0C) != 0x0C) {
				ldy	#DIR_RIGHT
				jsr	col_player_bullet_diff
				bmi	:+ ; if (col_player_bullet_diff() >= 0) {
					iny
				: ; }
				sty	motion_dir_actor, x
				dey
				lda	game_proc_bullet_veloc_x, y
				sta	veloc_x_actor, x
				lda	col_player_bullet_diff_pos_x_rel
				adc	#40
				cmp	#80
				bcc	:++++ ; if ((col_player_bullet_diff_pos_x_rel + 40) >= 80) {
					lda	#actor_states::state_1
					sta	state_actor, x
					lda	#10
					sta	timer_ani_actor, x
					lda	#sfx_pulse2::blast
					sta	apu_pulse2_queue
				; }
			; }
		: ; }

		lda	state_actor, x
		and	#actor_states::bit_5
		beq	:+ ; if (this.state & bit_5) {
			jsr	motion_y
		: ; }
	
		jsr	motion_x
	: ; }

	; if (eng_timer_ctl || this.state != 0 || ((bits_offscr_actor & 0x0C) != 0x0C && (zp_byte_00 + 0x28) >= 0x50)) {
		jsr	lib_actor_bits_get
		jsr	lib_calc_actor_pos
		jsr	col_actor_box
		jsr	col_player_actor_proc
		jmp	render_actor
	: ; } else {
		jsr	actor_erase
		rts
	; }
