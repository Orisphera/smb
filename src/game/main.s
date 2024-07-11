.include	"../../inc/system/cpu.i"

.include	"../../inc/engine/course_flags.i"
.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/sound.i"
.include	"../../inc/engine/tunables.i"
.include	"../../inc/engine/misc.i"

.include	"../../inc/engine/unk.i"

	.export	eng_game
eng_game:
	lda	eng_gameplay_mode
	jsr	eng_farjump

	.if	.defined(VS_SMB)
		.addr	game_vs_init
	.elseif	.defined(SMB2M)
		.addr	sub_C04D
	.endif

	.addr	eng_init_0_do

	.if	.defined(ANN)
		.addr	sub_6311
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
GAME_PROC_BTN_A_B	= zp_byte_0A
GAME_PROC_BTN_U_D	= zp_byte_0B
GAME_PROC_BTN_L_R	= zp_byte_0C
GAME_PROC_BTN_A_B_HELD	= zp_byte_0D

	.export	game_proc, game_proc_scroll_save
game_proc:
	.if	.defined(VS_SMB)
		lda	eng_player_count
		beq	:+ ; if (eng_player_count) {
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
				ldx	eng_player_id
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
	jsr	eng_player_render
	jsr	obj_spec_block_flatten
	ldx	#ACTIVE_BLOCK_MAX-1
	stx	actor_index
	jsr	obj_spec_block_proc
	dex
	stx	actor_index
	jsr	obj_spec_block_proc

	jsr	obj_misc_routine

	jsr	game_proc_cannon
	jsr	game_proc_whirlpool
	jsr	game_proc_pole_b
	jsr	game_proc_timer

	jsr	gfx_color_rotate

	.if	.defined(SMB2)
		lda	byte_7F7
		beq	:+ ; if (byte_7F7) {
			jsr	sub_C550
		: ; }
	.endif

	lda	eng_player_pos_y_hi
	cmp	#2
	bpl	:+
	lda	eng_timer_star
	beq	:+++
	cmp	#4
	bne	:+
	lda	eng_timer_int
	bne	:+ ; if (eng_timer_star) {
		; if (eng_player_pos_y_hi < 2 && eng_timer_star == 4 && !eng_timer_int) {
			jsr	sub_load_area_music
		: ; }
		ldy	eng_timer_star
		lda	frame_count
		cpy	#8
		bcs	:+ ; if (eng_timer_star < 8) {
			lsr	a
			lsr	a
		: ; }
		lsr	a
		jsr	game_proc_firefl_do
		jmp	:++
	: ; } else {
		jsr	game_proc_firefl_do_2
	: ; }

	lda	GAME_PROC_BTN_A_B
	sta	GAME_PROC_BTN_A_B_HELD
	lda	#joypad_button::none
	sta	GAME_PROC_BTN_L_R

GAME_SCROLL_END	= $20

game_proc_scroll_save:
	lda	nmi_addrs_ctl
	cmp	#nmi_addr::buffer_11_A
	beq	:++
	lda	bg_proc_id
	bne	:+
	lda	eng_scroll_h
	cmp	#GAME_SCROLL_END
	bmi	:++ ; if (nmi_addrs_ctl != buffer_11_A && (bg_proc_id == init || eng_scroll_h > GAME_SCROLL_END)) {
		; if (bg_proc_id == 0) {
			lda	eng_scroll_h
			sbc	#GAME_SCROLL_END
			sta	eng_scroll_h
			lda	#0
			sta	ppu_nmi_buffer+$40
		: ; }
		jsr	bg_proc
	: ; }
	rts
; -----------------------------------------------------------
	.export	game_proc_scroll_do
game_proc_scroll:
	lda	player_scroll_x
	clc
	adc	ppu_nmi_buffer+$A1
	sta	player_scroll_x
	lda	eng_scroll_lock
	bne	:+++
	lda	player_scroll_x_b
	cmp	#$50
	bcc	:+++
	lda	eng_timer_col_x
	bne	:+++
	ldy	player_scroll_x
	dey
	bmi	:+++ ; if (!eng_scroll_lock && player_scroll_x_b >= 0x50 && !eng_timer_col_x && --player_scroll_x >= 0) {
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
		adc	eng_screen_left_lo
		sta	eng_screen_left_lo
		sta	eng_scc_h_b
		lda	eng_screen_left_hi
		adc	#0
		sta	eng_screen_left_hi
		and	#ppu_ctlr0::bg_parity
		.if	.defined(SMB)|.defined(VS_SMB)
			sta	zp_byte_00
	
			lda	ppu_ctlr0_b
			and	#<~ppu_ctlr0::bg_parity
			ora	zp_byte_00
			sta	ppu_ctlr0_b
		.elseif	.defined(SMB2M)
			sta	byte_77A
		.endif

		jsr	game_proc_disp_pos

		lda	#8
		sta	eng_timer_scroll
		jmp	:++
	: ; } else {
		lda	#0
		sta	eng_scroll_amount
	: ; }

	ldx	#0
	jsr	lib_player_bits_h_get
	sta	zp_byte_00
	ldy	#0
	asl	a
	bcs	:+
	iny
	lda	zp_byte_00
	and	#%00100000
	beq	:++
	: ; if (zp_byte_00 & 0xC0) {
		lda	eng_screen_left_lo, y
		sec
		sbc	game_proc_scroll_off, y
		sta	eng_player_pos_x_lo
		lda	eng_screen_left_hi, y
		sbc	#0
		sta	eng_player_pos_x_hi
		lda	GAME_PROC_BTN_L_R
		cmp	game_proc_scroll_btn_mask, y
		beq	:+ ; if (GAME_PROC_BTN_L_R != game_proc_scroll_btn_mask[y]) {
			lda	#0
			sta	eng_player_veloc_x
		: ; }
	; }

	lda	#0
	sta	ppu_nmi_buffer+$A1
	rts
; ----------------------------
game_proc_scroll_off:
	.byte	$00, $10

game_proc_scroll_btn_mask:
	.byte	joypad_button::right
	.byte	joypad_button::left
; -----------------------------------------------------------
	.export	game_proc_disp_pos
game_proc_disp_pos:
	lda	eng_screen_left_lo
	clc
	adc	#$FF
	sta	eng_screen_right_lo
	lda	eng_screen_left_hi
	adc	#0
	sta	eng_screen_right_hi
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
		ldy	eng_player_pos_y_lo
		cpy	#$30
		bcc	game_proc_auto
		lda	course_enter_pos
		cmp	#COURSE_DATA_ENTER_POS_B0_B_VAL
		beq	:+
		cmp	#COURSE_DATA_ENTER_POS_B0_C_VAL
		bne	:++++++
		: lda	ppu_nmi_buffer+$C4
		bne	:+ ; if (course_enter_pos == 0xB0 && !ppu_nmi_buffer[0xC4]) {
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
		jsr	game_player_pos_y_lo_add
		lda	eng_player_pos_y_lo
		cmp	#$91
		bcc	:+++ ; if (eng_player_pos_y_lo >= 0x91) {
			rts
		; }
	: ; } else {
		lda	ppu_nmi_buffer+$99
		cmp	#$60
		bne	game_proc_enter_rts
		lda	eng_player_pos_y_lo
		cmp	#$99
		ldy	#0
		lda	#joypad_button::right
		bcc	:+ ; if (eng_player_pos_y_lo >= 0x99) {
			lda	#player_state::climb
			sta	state_player
			iny
			lda	#joypad_button::up
			sta	bg_buffer_0+$B4
		: ; }
		sty	eng_col_off
		jsr	game_proc_auto
		lda	eng_player_pos_x_lo
		cmp	#$48
		bcc	game_proc_enter_rts
	: ; } if ((!eng_joypad_override && eng_player_pos_y_lo < 0x91) || (eng_player_pos_x_lo >= 0x48)) {
		lda	#game_proc::ctrl
		sta	game_proc_id
		lda	#PLAYER_DIR_RIGHT
		sta	eng_player_dir
		lsr	a
		sta	eng_start_alt
		sta	eng_col_off
		sta	eng_joypad_override
	game_proc_enter_rts: ; }

	rts
; -----------------------------------------------------------
	.export	game_proc_auto
game_proc_auto:
	sta	joypad_p1
; ---------------------------
game_proc_ctrl:
	lda	game_proc_id
	cmp	#game_proc::death
	beq	:+++ ; if (game_proc_id != death) {
		lda	course_type
		bne	:++
		ldy	eng_player_pos_y_hi
		dey
		bne	:+
		lda	eng_player_pos_y_lo
		cmp	#$D0
		bcc	:++
		: ; if (course_type == water && eng_player_pos_y >= 0x1D0) {
			lda	#joypad_button::none
			sta	joypad_p1
		: ; }
	
		lda	joypad_p1
		and	#(joypad_button::face_a|joypad_button::face_b)
		sta	GAME_PROC_BTN_A_B
		lda	joypad_p1
		and	#(joypad_button::left|joypad_button::right)
		sta	GAME_PROC_BTN_L_R
		lda	joypad_p1
		and	#(joypad_button::up|joypad_button::down)
		sta	GAME_PROC_BTN_U_D
		and	#joypad_button::down
		beq	:+
		lda	state_player
		bne	:+
		ldy	GAME_PROC_BTN_L_R
		beq	:+ ; if ((GAME_PROC_BTN_U_D & down) && player.state == ground && GAME_PROC_BTN_L_R) {
			lda	#joypad_button::none
			sta	GAME_PROC_BTN_L_R
			sta	GAME_PROC_BTN_U_D
		; }
	: ; }

	jsr	game_proc_player_move

	ldy	#col_box_type::small
	lda	eng_player_size
	bne	:+ ; if (eng_player_size == large) {
		ldy	#col_box_type::large

		lda	eng_crouch
		beq	:+ ; if (eng_crouch) {
			ldy	#col_box_type::crouch
		; }
	: ; }
	sty	eng_player_col_box

	lda	#PLAYER_DIR_RIGHT
	ldy	eng_player_veloc_x
	beq	:++
	bpl	:+ ; if (eng_player_veloc_x != 0) {
		; if (eng_player_veloc_x < 0) {
			asl	a
		: ; }
		sta	eng_player_motion_dir
	: ; }

	jsr	game_proc_scroll

	jsr	lib_player_bits_get
	jsr	lib_calc_player_pos
	ldx	#0
	jsr	col_box_proc
	jsr	col_bg_proc

	lda	eng_player_pos_y_lo
	cmp	#$40
	bcc	:+
	lda	game_proc_id
	cmp	#game_proc::victory
	beq	:+
	cmp	#game_proc::enter
	beq	:+
	cmp	#game_proc::pole
	bcc	:+ ; if (player.pos_y.lo >= 0x40 && game_proc_id >= pole && game_proc_id.not_in(victory, enter)) {
		lda	ppu_nmi_buffer+$C4
		and	#<~(%00100000)
		sta	ppu_nmi_buffer+$C4
	: ; }

	lda	eng_player_pos_y_hi
	cmp	#2
	bmi	:++++ ; if (player.pos_y > 0x200) {
		ldx	#1
		stx	eng_scroll_lock
		ldy	#4
		sty	zp_byte_07
		ldx	#0

		ldy	eng_done_timer
		bne	:+
		ldy	course_type_cloud
		bne	:+++
		: ; if (!eng_done_timer || !course_type_cloud) {
			inx
			ldy	game_proc_id
			cpy	#game_proc::death
			beq	:++ ; if (game_proc_id != death) {
				ldy	eng_music_event_death
				bne	:+ ; if (!eng_music_event_death) {
					iny
					sty	apu_music_event
					sty	eng_music_event_death
				: ; }
			
				ldy	#6
				sty	zp_byte_07
			; }
		: ; }
		cmp	zp_byte_07
		bmi	:+
		dex
		bmi	:++ ; if (zp_byte_07 & 0x80 || x >= 1) {
			ldy	snd_ram+1
			bne	:+ ; if (!(zp_byte_07 & 0x80) && !snd_ram[1]) {
				lda	#game_proc::lifedown
				sta	game_proc_id
			: ; }
			rts
		: ; } else {
			lda	#joypad_button::none
			sta	eng_joypad_override
			jsr	game_proc_vine_b
			inc	eng_start_alt
			rts
		; }
	; }
; -----------------------------------------------------------
game_proc_vine:
	lda	eng_player_pos_y_hi
	bne	:+
	lda	eng_player_pos_y_lo
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
	jsr	game_player_pos_y_lo_add

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
game_player_pos_y_lo_add:
	clc
	adc	eng_player_pos_y_lo
	sta	eng_player_pos_y_lo
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
	sta	eng_player_veloc_x
	ldy	#joypad_button::right
	lda	eng_player_pos_x_lo
	and	#(joypad_button::right|joypad_button::left|joypad_button::down|joypad_button::up)
	bne	:+ ; if (!(player.pos_x & 0x0F)) {
		sta	eng_player_veloc_x
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
		ldy	eng_player_resizing
		bne	:+ ; if (!eng_player_resizing) {
			sty	eng_player_animating
			inc	eng_player_resizing
			lda	eng_player_size
			eor	#1
			sta	eng_player_size
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
		and	#%00000011
		sta	zp_byte_00
		lda	ppu_nmi_buffer+$C4
		and	#%11111100
		ora	zp_byte_00
		sta	ppu_nmi_buffer+$C4
		rts
	: ; } else {
		jsr	game_proc_player_done

	game_proc_firefl_do_2:
		lda	ppu_nmi_buffer+$C4
		and	#%11111100
		sta	ppu_nmi_buffer+$C4
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
		ldy	eng_player_pos_y_lo
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

	lda	eng_player_pos_y_lo
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
			lda	#music_event::event_20
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

	lda	eng_player_collision
	lsr	a
	bcs	:++ ; if (!(player.collision & right)) {
		lda	eng_task_star_flag
		bne	:+ ; if (!eng_task_star_flag) {
			inc	eng_task_star_flag
		: ; }

		lda	#$20
		sta	ppu_nmi_buffer+$C4
	: ; }

	lda	eng_task_star_flag
	cmp	#5
	bne	:+++ ; if (eng_task_star_flag == 5) {
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
	ldy	eng_player_size
	bne	:+
	lda	state_player
	bne	:++ ; if (player.size == small || player.state == ground) {
		; if (player.size == large) {
			lda	GAME_PROC_BTN_U_D
			and	#joypad_button::down
		: ; }
		sta	eng_crouch
	: ; }

	jsr	game_proc_player_physics

	lda	eng_player_resizing
	bne	:++ ; if (!player.resizing) {
		lda	state_player
		cmp	#player_state::climb
		beq	:+ ; if (player.state != climb) {
			ldy	#$18
			sty	eng_timer_climb_side
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

	lda	GAME_PROC_BTN_L_R
	beq	:+ ; if (GAME_PROC_BTN_L_R) {
		sta	eng_player_dir
	: ; }

	jsr	game_proc_player_friction

game_proc_player_ground_b:
	jsr	motion_x_check_spring
	sta	player_scroll_x

	.if	.defined(SMB2)
		lda	byte_7F7
		beq	:+ ; if (byte_7F7) {
			jsr	sub_C4FE
		: ; }
	.endif

	rts
; -----------------------------------------------------------
game_proc_player_fall:
	lda	eng_player_gravity
	sta	eng_player_accel_y
	jmp	game_proc_player_jump_swim_do
; -----------------------------------------------------------
game_proc_player_jump_swim:
	ldy	eng_player_veloc_y
	bpl	:+
	lda	GAME_PROC_BTN_A_B
	and	#joypad_button::face_a
	and	GAME_PROC_BTN_A_B_HELD
	bne	:++
	lda	eng_player_jump_org_y_lo
	sec
	sbc	eng_player_pos_y_lo
	cmp	byte_706
	bcc	:++
	: ; if (
	;	!(eng_player_veloc_y & 0x80)
	;	|| (
	;		!((GAME_PROC_BTN_A_B & GAME_PROC_BTN_A_B_HELD) & face_a)
	;		&& ((eng_player_jump_org_y_lo - eng_player_pos_y_lo) >= eng_player_mid_jump_y)
	;	)
	; ) {
		lda	eng_player_gravity
		sta	eng_player_accel_y
	: ; }

	lda	eng_player_swimming
	beq	:++ ; if (eng_player_swimming) {
		jsr	game_proc_player_ani_speed
		lda	eng_player_pos_y_lo
		cmp	#$14
		bcs	:+ ; if (eng_player_pos_y < 0x14) {
			lda	#$18
			sta	eng_player_accel_y
		: ; }
	
		lda	GAME_PROC_BTN_L_R
		beq	:+ ; if (GAME_PROC_BTN_L_R) {
			sta	eng_player_dir
		; }
	: ; }

game_proc_player_jump_swim_do:
	lda	GAME_PROC_BTN_L_R
	beq	:+ ; if (GAME_PROC_BTN_L_R) {
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
		sta	eng_player_accel_y
	: ; }

	jmp	motion_y_check_spring
; -----------------------------------------------------------
game_proc_player_climb_pos_lo:
	.byte	<14, <4, <-4, <-14

game_proc_player_climb_pos_hi:
	.byte	>14, >4, >-4, >-14
; -----------------------------
game_proc_player_climb:
	lda	eng_actor_accel_y_b
	clc
	adc	eng_actor_accel_y
	sta	eng_actor_accel_y_b

	ldy	#0
	lda	eng_player_veloc_y
	bpl	:+ ; if (eng_player_veloc_y & 0x80) {
		dey
	: ; }
	sty	zp_byte_00
	adc	eng_player_pos_y_lo
	sta	eng_player_pos_y_lo
	lda	eng_player_pos_y_hi
	adc	zp_byte_00
	sta	eng_player_pos_y_hi

	lda	GAME_PROC_BTN_L_R
	and	eng_player_collision
	beq	:++++ ; if (GAME_PROC_BTN_L_R & eng_player_collision) {
		ldy	eng_timer_climb_side
		bne	:+++ ; if (!eng_timer_climb_side) {
			ldy	#$18
			sty	eng_timer_climb_side
			ldx	#0
			ldy	eng_player_dir
			lsr	a
			bcs	:+ ; if ((GAME_PROC_BTN_L_R & eng_player_collision) & right) {
				inx
				inx
			: ; }
			dey
			beq	:+ ; if (eng_player_dir == right) {
				inx
			: ; }
		
			lda	eng_player_pos_x_lo
			clc
			adc	game_proc_player_climb_pos_lo, x
			sta	eng_player_pos_x_lo
			lda	eng_player_pos_x_hi
			adc	game_proc_player_climb_pos_hi, x
			sta	eng_player_pos_x_hi
			lda	GAME_PROC_BTN_L_R
			eor	#joypad_button::left|joypad_button::right
			sta	eng_player_dir
		: ; }
	
		rts
	: ; } else {
		sta	eng_timer_climb_side
		rts
	; }
; -----------------------------------------------------------
game_proc_player_jump_accel_y:
	.byte	$20, $20, $1E, $28, $28

	.byte	$0D, $04

game_proc_player_grav_accel_y:
	.byte	$70, $70, $60, $90, $90

	.byte	$0A, $09

.if	.defined(SMB2M)
	game_proc_player_data_friction:
		.byte	<-$1C, <-$68, <-$30
.endif

game_proc_player_veloc_y:
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
	game_proc_player_data_friction:
		.byte	<-$1C, <-$68, <-$30
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
		lda	GAME_PROC_BTN_U_D
		and	eng_player_collision
		beq	:+ ; if (player.collision & GAME_PROC_BTN_U_D) {
			iny
			and	#PLAYER_COL_TOP
			bne	:+ ; if (!(player.collision & GAME_PROC_BTN_U_D & top)) {
				iny
			; }
		: ; }
		ldx	game_proc_player_climb_accel_y, y
		stx	eng_actor_accel_y
	
		lda	#8
		ldx	game_proc_player_climb_veloc_y, y
		stx	eng_player_veloc_y
		bmi	:+ ; (eng_player_veloc_y >= 0) { 
			lsr	a
		: ; }
		sta	timer_player_ani
	
		rts
	: lda	eng_spring_ani
	bne	:+
	lda	GAME_PROC_BTN_A_B
	and	#joypad_button::face_a
	beq	:+
	and	GAME_PROC_BTN_A_B_HELD
	beq	:++
	: ; } else if (eng_spring_ani || pressed_a || held_a || (player.state != ground && !player.swimming)) {
		jmp	:+++++++
	:
	lda	state_player
	beq	:+
	lda	eng_player_swimming
	beq	:--
	lda	eng_timer_jump_swim
	bne	:+
	lda	eng_player_veloc_y
	bpl	:+ ; } else if (player.state != ground && player.swimming && !eng_timer_jump_swim && player.veloc_y < 0) {
		jmp	:++++++
	: ; } else {
		lda	#$20
		sta	eng_timer_jump_swim
		ldy	#0
		sty	eng_actor_accel_y_b
		sty	eng_actor_accel_y
		lda	eng_player_pos_y_hi
		sta	eng_player_jump_org_y_hi
		lda	eng_player_pos_y_lo
		sta	eng_player_jump_org_y_lo
		lda	#player_state::jump_swim
		sta	state_player
		lda	eng_player_veloc_x_abs
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
		sta	byte_706

		lda	eng_player_swimming
		beq	:+ ; if (player.swimming) {
			ldy	#$05
			lda	eng_whirlpool_flag
			beq	:+ ; if (eng_whirlpool_flag) {
				iny
			; }
		: ; }

		lda	game_proc_player_jump_accel_y, y
		sta	eng_player_accel_y
		lda	game_proc_player_grav_accel_y, y
		sta	eng_player_gravity
		lda	game_proc_player_init_accel_y, y
		sta	eng_actor_accel_y
		lda	game_proc_player_veloc_y, y
		sta	eng_player_veloc_y

		lda	eng_player_swimming
		beq	:+ ; if (player.swimming) {
			lda	#$04
			sta	apu_pulse1_queue
	
			lda	eng_player_pos_y_lo
			cmp	#$14
			bcs	:+++ ; if (player.pos_y < 0x14) {
				lda	#0
				sta	eng_player_veloc_y
				jmp	:+++
			; }
		: ; } else {
			lda	#$01
			ldy	eng_player_size
			beq	:+ ; if (player.size == small) {
				lda	#$80
			: ; }
			sta	apu_pulse1_queue
		; }
	: ; }

	ldy	#0
	sty	zp_byte_00
	lda	state_player
	beq	:+ ; if (player.state != ground) {
		lda	eng_player_veloc_x_abs
		cmp	#$19
		bcs	:+++++
		bcc	:++
	: ; } else {
		iny
		lda	course_type
		beq	:+ ; if (course_type != water) {
			dey
			lda	GAME_PROC_BTN_L_R
			cmp	eng_player_motion_dir
			bne	:+ ; if (player_button == motion_dir) {
				lda	GAME_PROC_BTN_A_B
				and	#joypad_button::face_b
				bne	:+++
				lda	eng_timer_run
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
		lda	eng_player_veloc_run
		bne	:+
		lda	eng_player_veloc_x_abs
		cmp	#$21
		bcc	:+++
		: inc	zp_byte_00
		jmp	:++
	: ; } if (pressed_b || player.veloc_run) {
		lda	#$0A
		sta	eng_timer_run
	: ; }

	lda	game_proc_player_max_veloc_left, y
	sta	eng_player_max_veloc_left
	lda	game_proc_id
	cmp	#game_proc::enter
	bne	:+ ; if (game_proc_id == enter) {
		ldy	#game_proc_player_max_veloc_right_enter-game_proc_player_max_veloc_right
	: ; }
	lda	game_proc_player_max_veloc_right, y
	sta	eng_player_max_veloc_right
	ldy	zp_byte_00
	lda	game_proc_player_data_friction, y
	sta	eng_friction_add_lo
	lda	#0
	sta	eng_friction_add_hi
	lda	eng_player_dir
	cmp	eng_player_motion_dir
	beq	:+ ; if (player.dir != player.motion_dir) {
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
	lda	eng_player_veloc_x_abs
	cmp	#$1C
	bcs	:++ ; if (eng_player_veloc_x_abs < 0x1C) {
		iny
		cmp	#$0E
		bcs	:+ ; if (eng_player_veloc_x_abs < 0x0E) {
			iny
		: ; }

		lda	joypad_p1
		and	#<~(joypad_button::face_a)
		beq	:+++
		and	#(joypad_button::left|joypad_button::right)
		cmp	eng_player_motion_dir
		bne	:++ ; if (no_motion) {
			lda	#0
		; }
	: ; } if (run_motion) {
		sta	eng_player_veloc_run
		jmp	:++
	: ; } else {
		lda	eng_player_veloc_x_abs
		cmp	#$0B
		bcs	:+ ; if (eng_player_veloc_x_abs < 0x0B) {
			lda	eng_player_dir
			sta	eng_player_motion_dir
			lda	#0
			sta	eng_player_veloc_x
			sta	eng_player_accel_x
		; }
	: ; }

	lda	game_proc_player_ani_timers, y
	sta	timer_player_ani
	rts
; -----------------------------------------------------------
game_proc_player_friction:
	and	eng_player_collision
	cmp	#PLAYER_COL_NONE
	bne	:+
	lda	eng_player_veloc_x
	beq	:+++++
	bpl	:+++
	bmi	:++
	: lsr	a
	bcc	:++
	: ; if (eng_player_collision_none && eng_player_veloc_x < 0) {
		lda	eng_player_accel_x
		clc
		adc	eng_friction_add_lo
		sta	eng_player_accel_x
		lda	eng_player_veloc_x
		adc	eng_friction_add_hi
		sta	eng_player_veloc_x
		cmp	eng_player_max_veloc_right
		bmi	:++ ; if (eng_player_veloc_x > eng_player_max_veloc_right) {
			lda	eng_player_max_veloc_right
			sta	eng_player_veloc_x
			jmp	:+++
		; }
	: ; } else {
		lda	eng_player_accel_x
		sec
		sbc	eng_friction_add_lo
		sta	eng_player_accel_x
		lda	eng_player_veloc_x
		sbc	eng_friction_add_hi
		sta	eng_player_veloc_x
		cmp	eng_player_max_veloc_left
		bpl	:+ ; if (eng_player_veloc_x < eng_player_max_veloc_left) {
			lda	eng_player_max_veloc_left
			sta	eng_player_veloc_x
		; }
	: ; } if () {
		cmp	#0
		bpl	:+ ; if (eng_player_veloc_x < 0) {
			eor	#$FF
			clc
			adc	#1
		; }
	: ; }

	sta	eng_player_veloc_x_abs
	rts
; -----------------------------------------------------------
game_proc_proj:
	lda	eng_player_status
	cmp	#2
	bcc	:++ ; if (eng_player_status >= 2) {
		lda	GAME_PROC_BTN_A_B
		and	#joypad_button::face_b
		beq	:+
		and	GAME_PROC_BTN_A_B_HELD
		bne	:+
		lda	eng_fireball_counter
		and	#1
		tax
		lda	state_proj, x
		bne	:+
		ldy	eng_player_pos_y_hi
		dey
		bne	:+
		lda	eng_crouch
		bne	:+
		lda	state_player
		cmp	#player_state::climb
		beq	:+ ; if (
			;	(pressed_b)
			;	&& !(held_b)
			;	&& !proj.state[eng_fireball_counter&1]
			;	&& !(--player.pos_y.hi)
			;	&& !eng_crouch
			;	&& player.state != climb
			; ) {
			lda	#$20
			sta	apu_pulse1_queue
			lda	#2
			sta	state_proj, x
			ldy	timer_player_ani
			sty	eng_timer_fireball_throw
			dey
			sty	eng_timer_fireball_ani
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
			jsr	eng_bubble_render

			dex
			bpl	:-
		; }
	: ; }
	rts
; -----------------------------------------------------------
game_proc_proj_veloc_x:
	.byte	$40, <-$40
; -----------------------------
game_proc_proj_do:
	stx	actor_index
	lda	state_proj, x
	asl	a
	bcs	:+++ ; if (!(proj.state & 0x80)) {
		ldy	state_proj, x
		beq	game_proc_proj_do_rts
		dey
		beq	:+ ; if (proj.state == 1) {
			lda	eng_player_pos_x_lo
			adc	#4
			sta	eng_proj_pos_x_lo, x
			lda	eng_player_pos_x_hi
			adc	#0
			sta	eng_proj_pos_x_hi, x
			lda	eng_player_pos_y_lo
			sta	eng_proj_pos_y_lo, x
			lda	#1
			sta	eng_proj_pos_y_hi, x
			ldy	eng_player_dir
			dey
			lda	game_proc_proj_veloc_x, y
			sta	eng_proj_veloc_x, x
			lda	#4
			sta	eng_proj_veloc_y, x
			lda	#7
			sta	eng_proj_col_box, x
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

		lda	ppu_nmi_buffer+$D2
		and	#%11001100
		bne	:+ ; if () {
			jsr	col_proj_actor_proc
			jmp	eng_proj_render
		: ; } else {
			lda	#0
			sta	state_proj, x
		game_proc_proj_do_rts:
			rts
		; }
	: ; } else {
		jsr	lib_calc_proj_pos
		jmp	eng_proj_hit_render
	; }
; -----------------------------------------------------------
	.export	game_proc_bubble_init
game_proc_bubble_do:
	lda	eng_rand_seed+1, x
	and	#1
	sta	zp_byte_07
	lda	eng_bubble_pos_y_lo, x
	cmp	#ENG_OAM_CLEAR_SCANLINE
	bne	:++
	lda	eng_timer_bubble
	bne	:++++ ; if () {
		; if () {
		game_proc_bubble_init:
			ldy	#0
			lda	eng_player_dir
			lsr	a
			bcc	:+ ; if (eng_player_dir == right) {
				ldy	#8
			: ; }
			tya
			adc	eng_player_pos_x_lo
			sta	eng_bubble_pos_x_lo, x
			lda	eng_player_pos_x_hi
			adc	#0
			sta	eng_bubble_pos_x_hi, x
			lda	eng_player_pos_y_lo
			clc
			adc	#8
			sta	eng_bubble_pos_y_lo, x
			lda	#1
			sta	eng_bubble_pos_y_hi, x
			ldy	zp_byte_07
			lda	game_proc_bubble_timers, y
			sta	eng_timer_bubble
		: ; }

		ldy	zp_byte_07
		lda	eng_bubble_accel_y, x
		sec
		sbc	game_proc_bubble_accel_y, y
		sta	eng_bubble_accel_y, x
		lda	eng_bubble_pos_y_lo, x
		sbc	#0
		cmp	#$20
		bcs	:+ ; if () {
			lda	#ENG_OAM_CLEAR_SCANLINE
		: ; }
		sta	eng_bubble_pos_y_lo, x
	: ; }

	rts
; -----------------------------
game_proc_bubble_accel_y:
	.byte	<-1, $50

game_proc_bubble_timers:
	.byte	$40, $20
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
	lda	eng_player_pos_y_hi
	cmp	#2
	.if	.defined(SMB)|.defined(VS_SMB)
	bcs	:++++
	.elseif	.defined(SMB2M)
	bpl	:++++
	.endif
	lda	eng_timer_game_ctrl
	bne	:++++ ; if (eng_game_mode != 0 && game_proc_id >= ctrl && game_proc_id != death && eng_player_pos_y_hi < 2 && !eng_timer_game_ctrl) {
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
				lda	#music_event::event_40
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

			sta	eng_timer_game_ctrl
			.if	.defined(SMB)|.defined(VS_SMB)
				ldy	#$23
			.elseif	.defined(SMB2M)
				ldy	#$17
			.endif
			lda	#$FF
			sta	STACK_BASE+$39
			jsr	eng_stats_math
			.if	.defined(SMB)|.defined(VS_SMB)
				lda	#$A4
			.elseif	.defined(SMB2M)
				lda	#$A2
			.endif
			jmp	eng_stats_print_num
		: ; } else {
			sta	eng_player_status
			jsr	col_player_harm_proc
			inc	eng_done_timer
		; }
	: ; }

game_proc_timer_rts:
	rts
; -----------------------------------------------------------
game_proc_warp:
	lda	eng_scroll_lock
	beq	game_proc_timer_rts
	lda	eng_player_pos_y_lo
	and	eng_player_pos_y_hi
	bne	game_proc_timer_rts ; if (eng_scroll_lock && eng_player_pos_y == 0) {
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
				lda	eng_cannon_pos_x_lo, y
				clc
				adc	eng_cannon_pos_y_lo, y
				sta	zp_byte_02

				lda	eng_cannon_pos_y_hi, y
				beq	:+ ; if (this.pos_y.hi > 0) {
					adc	#0
					sta	zp_byte_01
					lda	eng_player_pos_x_lo
					sec
					sbc	eng_cannon_pos_x_lo, y

					lda	eng_player_pos_x_hi
					sbc	eng_cannon_pos_y_hi, y
					bmi	:+ ; if ((player.pos_x.hi - this.pos_y.hi) >= 0) {
						lda	zp_byte_02
						sec
						sbc	eng_player_pos_x_lo
						lda	zp_byte_01
						sbc	eng_player_pos_x_hi
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
	lda	eng_cannon_pos_y_lo, y
	lsr	a
	sta	zp_byte_00
	lda	eng_cannon_pos_x_lo, y
	clc
	adc	zp_byte_00
	sta	zp_byte_01
	lda	eng_cannon_pos_y_hi, y
	adc	#0
	sta	zp_byte_00

	lda	frame_count
	lsr	a
	bcc	:+++ ; if (frame_count % 2) {
		lda	zp_byte_01
		sec
		sbc	eng_player_pos_x_lo
		lda	zp_byte_00
		sbc	eng_player_pos_x_hi
		bpl	:+ ; if (this.pos_y.hi >= player.pos_x.hi) {
			lda	eng_player_pos_x_lo
			sec
			sbc	#1
			sta	eng_player_pos_x_lo
			lda	eng_player_pos_x_hi
			sbc	#0
			jmp	:++
		: ; } else {
			lda	eng_player_collision
			lsr	a
			bcc	:++
			lda	eng_player_pos_x_lo
			clc
			adc	#1
			sta	eng_player_pos_x_lo
			lda	eng_player_pos_x_hi
			adc	#0
		: ; }

		; if (this.pos_y.hi >= this.pos_x.hi || player.collision.right) {
			sta	eng_player_pos_x_hi
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
game_proc_pole_score_hi:
	.byte	$05, $02, $08, $04, $01

game_proc_pole_digit_count:
	.byte	$03, $03, $04, $04, $04
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
	lda	eng_actor_pos_y_lo, x
	cmp	#$AA
	bcs	:++
	lda	eng_player_pos_y_lo
	cmp	#$A2
	bcs	:++ ; if (game_proc_id != pole || player.state != climb || (this.pos_y.lo < 0xAA && player.pos_y.lo < 0xA2)) {
		; if (game_proc_id == pole && player.state == climb) {
			lda	eng_actor_pos_y, x
			adc	#<-1
			sta	eng_actor_pos_y, x
			lda	eng_actor_pos_y_lo, x
			adc	#1
			sta	eng_actor_pos_y_lo, x
			lda	STACK_BASE+$0E
			sec
			sbc	#<-1
			sta	STACK_BASE+$0E
			lda	STACK_BASE+$0D
			sbc	#1
			sta	STACK_BASE+$0D
		: ; }

		jmp	:++++
	: ; } else {
		ldy	STACK_BASE+$0F
	
		.if	.defined(SMB2M)
		cpy	#5
		bne	:+ ; if (SMB2M && STACK_BASE[15] == 5) {
			inc	eng_lives
			lda	#$40
			sta	apu_pulse2_queue
			jmp	:++
		.endif
		: ; } else {
			lda	game_proc_pole_score_hi, y
			ldx	game_proc_pole_digit_count, y
			sta	STACK_BASE+$34, x
			jsr	obj_misc_update_score
		: ; }

		lda	#game_proc::victory
		sta	game_proc_id
	: ; }

	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	eng_flag_score_render

game_proc_pole_b_rts:
	rts
; -----------------------------------------------------------
game_proc_spring_pos_y:
	.byte	$08, $10, $08, $00
; -----------------------------
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
			inc	eng_player_pos_y_lo
			inc	eng_player_pos_y_lo
			jmp	:++
		: ; } else {
			dec	eng_player_pos_y_lo
			dec	eng_player_pos_y_lo
		: ; }

		lda	eng_actor_veloc_x, x
		clc
		adc	game_proc_spring_pos_y, y
		sta	eng_actor_pos_y_lo, x

		cpy	#1
		bcc	game_proc_spring_skip_accel
		lda	GAME_PROC_BTN_A_B
		and	#joypad_button::face_a
		beq	game_proc_spring_skip_accel
		and	GAME_PROC_BTN_A_B_HELD
		bne	game_proc_spring_skip_accel ; if ((eng_spring_ani - 1) >= 1 && (GAME_PROC_BTN_A_B & 0x80) && !(GAME_PROC_BTN_A_B & 0x80 & GAME_PROC_BTN_A_B_HELD)) {
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
				ldy	byte_7FB
				beq	:+ ; if (ANN && byte_7FB) {
					jsr	sub_C4FE_b
				: ; }
			.endif

			sta	eng_spring_accel_y

			.if	.defined(SMB2M)
				pla
				tay
			.endif
		game_proc_spring_skip_accel: ; }
		cpy	#3
		bne	:+ ; if ((eng_spring_ani - 1) == 3) {
			lda	eng_spring_accel_y
			sta	eng_player_veloc_y
			lda	#0
			sta	eng_spring_ani
		; }
	: ; }

game_proc_spring_ctd:
	jsr	lib_calc_actor_pos
	jsr	eng_actor_render
	jsr	col_actor_oob_proc

	lda	eng_spring_ani
	beq	:+
	lda	eng_timer_spring
	bne	:+ ; if (eng_spring_ani && !eng_timer_spring) {
		lda	#4
		sta	eng_timer_spring
		inc	eng_spring_ani
	: ; }

	rts
; -----------------------------------------------------------
	.export game_proc_vine_init
game_proc_vine_init:
	lda	#actor::vine
	sta	actor_id, x
	lda	#1
	sta	actor_mode, x
	lda	eng_spec_pos_x_hi, y
	sta	eng_actor_pos_x_hi, x
	lda	eng_spec_pos_x_lo, y
	sta	eng_actor_pos_x_lo, x

	lda	eng_spec_pos_y_lo, y
	sta	eng_actor_pos_y_lo, x
	ldy	ppu_nmi_buffer+$98
	bne	:+ ; if (!ppu_nmi_buffer[0x98]) {
		sta	ppu_nmi_buffer+$9D
	: ; }

	txa
	sta	ppu_nmi_buffer+$9A, y
	inc	ppu_nmi_buffer+$98
	lda	#4
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

game_proc_vine_do:
	cpx	#5
.if	.defined(SMB)
	bne	:+++++ ; if (x == 5) {
.elseif	.defined(VS_SMB)|.defined(SMB2M)
	beq	:+ ; if (x != 5) {
		rts
	: ; }
.endif
		ldy	ppu_nmi_buffer+$98
		dey
		lda	ppu_nmi_buffer+$99
		cmp	game_proc_vine_heights, y
		beq	:+
		lda	frame_count
		lsr	a
		lsr	a
		bcc	:+ ; if (ppu_nmi_buffer[0x99] != game_proc_vine_heights[ppu_nmi_buffer[0x98]-1] && frame_count % 4) {
			lda	eng_actor_pos_y_lo+GAME_PROC_VINE_ACTOR_ID
			sbc	#1
			sta	eng_actor_pos_y_lo+GAME_PROC_VINE_ACTOR_ID
			inc	ppu_nmi_buffer+$99
		: ; }
	
		lda	ppu_nmi_buffer+$99
		cmp	#8
		bcc	:++++ ; if (ppu_nmi_buffer[0x99] >= 8) {
			jsr	lib_calc_actor_pos
			jsr	lib_actor_bits_get

			ldy	#0
			: ; for (y = 0; y < ppu_nmi_buffer[0x98]; y++) {
				jsr	eng_vine_render

				iny
				cpy	ppu_nmi_buffer+$98
				bne	:-
			; }
		
			lda	ppu_nmi_buffer+$D1
			and	#%00001100
			beq	:++ ; if (ppu_nmi_buffer[0xD1] & 0x0C) {
				dey
				: ; for (y = ppu_nmi_buffer[0x98] - 1; y >= 0; y--) {
					ldx	ppu_nmi_buffer+$9A, y
					jsr	actor_erase

					dey
					bpl	:-
				; }

				sta	ppu_nmi_buffer+$98
				sta	ppu_nmi_buffer+$99
			: ; }
		
			lda	ppu_nmi_buffer+$99
			cmp	#$20
			bcc	:+ ; if (ppu_nmi_buffer[0x99] >= 0x20) {
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
		lda	eng_actor_pos_x_lo+GAME_PROC_VINE_ACTOR_ID
		sec
		sbc	eng_screen_left_lo
		tay
		lda	eng_actor_pos_x_hi+GAME_PROC_VINE_ACTOR_ID
		sbc	eng_screen_left_hi
		bmi	:+
		cpy	#9
		bcs	:++++
		: ; if (eng_screen_left_hi < 0 || (this.pos_x.lo - eng_screen_left_lo) < 9) {
			lda	#0
			sta	actor_mode+GAME_PROC_VINE_ACTOR_ID
			lda	eng_actor_pos_x_hi+GAME_PROC_VINE_ACTOR_ID
			and	#1
			.if	.defined(VS_SMB)
				nop
			.endif
			tay
			lda	bg_buffer_ptr_lo, y
			sta	eng_buffer_ptr
			lda	bg_buffer_ptr_hi, y
			sta	eng_buffer_ptr+1

			lda	eng_actor_pos_x_lo+GAME_PROC_VINE_ACTOR_ID
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
			ldy	eng_hard_mode_b
			and	game_proc_cannon_masks, y
			cmp	#6
			bcs	:++
			tay
			lda	eng_cannon_pos_y_hi, y
			beq	:++
			lda	eng_timer_cannon, y
			beq	:+
			; if (
			;	this.mode == dead
			;	&& (eng_rand_seed[actor_index+1] & game_proc_cannon_masks[eng_hard_mode_b]) < 6
			;	&& (eng_cannon_pos_y_hi[(eng_rand_seed[actor_index+1] & game_proc_cannon_masks[eng_hard_mode_b])])
			;	&& (eng_timer_cannon[(eng_rand_seed[actor_index+1] & game_proc_cannon_masks[eng_hard_mode_b])])
			; ) {
				sbc	#0
				sta	eng_timer_cannon, y
				jmp	:++
			: ; } else {
				lda	eng_timer_ctl
				bne	:+ ; if (eng_timer_ctl == 0) {
					lda	#$0E
					sta	eng_timer_cannon, y
					lda	eng_cannon_pos_y_hi, y
					sta	eng_actor_pos_x_hi, x
					lda	eng_cannon_pos_x_lo, y
					sta	eng_actor_pos_x_lo, x
					lda	eng_cannon_pos_y_lo, y
					sec
					sbc	#8
					sta	eng_actor_pos_y_lo, x
					lda	#1
					sta	eng_actor_pos_y_hi, x
					sta	actor_mode, x
					lsr	a
					sta	state_actor, x
					lda	#9
					sta	eng_actor_col_box, x
					lda	#actor::bullet
					sta	actor_id, x
					jmp	:++
				; }
			: ; }

			; if (eng_timer_cannon[y] != 0 || eng_timer_ctl != 0) {
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
game_proc_bullet_veloc_x:
	.byte	$18, <-$18
; -----------------------------
game_proc_bullet:
	lda	eng_timer_ctl
	bne	:++++ ; if (!eng_timer_ctl) {
		lda	state_actor, x
		bne	:++ ; if (this.state == 0) {
			lda	ppu_nmi_buffer+$D1
			and	#%00001100
			cmp	#%00001100
			beq	:+++++ ; if ((ppu_nmi_buffer[0xD1] & 0x0C) != 0x0C) {
				ldy	#PLAYER_DIR_RIGHT
				jsr	col_player_bullet_diff
				bmi	:+ ; if (col_player_bullet_diff() >= 0) {
					iny
				: ; }
				sty	eng_actor_motion_dir, x
				dey
				lda	game_proc_bullet_veloc_x, y
				sta	eng_actor_veloc_x, x
				lda	zp_byte_00
				adc	#$28
				cmp	#$50
				bcc	:++++ ; if ((zp_byte_00 + 0x28) >= 0x50) {
					lda	#1
					sta	state_actor, x
					lda	#$0A
					sta	eng_timer_actor_ani, x
					lda	#8
					sta	apu_pulse2_queue
				; }
			; }
		: ; }

		lda	state_actor, x
		and	#%00100000
		beq	:+ ; if (this.state & 0x20) {
			jsr	motion_y
		: ; }
	
		jsr	motion_x
	: ; }

	; if (eng_timer_ctl || this.state != 0 || ((ppu_nmi_buffer[0xD1] & 0x0C) != 0x0C && (zp_byte_00 + 0x28) >= 0x50)) {
		jsr	lib_actor_bits_get
		jsr	lib_calc_actor_pos
		jsr	col_actor_box
		jsr	col_player_actor_proc
		jmp	eng_actor_render
	: ; } else {
		jsr	actor_erase
		rts
	; }
