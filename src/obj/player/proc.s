.include	"system/cpu.i"

.include	"mem.i"
.include	"course_flags.i"
.include	"joypad.i"
.include	"sound.i"
.include	"tunables.i"
.include	"modes.i"
.include	"misc.i"
.include	"macros.i"

	.export	player_proc
player_proc:
	lda	proc_id_player
	jsr	tbljmp
	.addr	player_proc_init
	.addr	player_proc_vine
	.addr	player_proc_pipe_h
	.addr	player_proc_pipe_v
	.addr	player_proc_pole
	.addr	player_proc_victory
	.addr	player_proc_lifedown
	.addr	player_proc_enter
	.addr	player_proc_ctrl
	.addr	player_proc_size_chg
	.addr	player_proc_hurt
	.addr	player_proc_death
	.addr	player_proc_firefl
; -----------------------------------------------------------
player_proc_enter:
	lda	game_start_type
	cmp	#2
	beq	:+++ ; if (game.start_type != 2) {
		lda	#joypad_button::none
		ldy	pos_y_lo_player
		cpy	#48
		bcc	player_proc_auto
		lda	course_pos_y_start
		cmp	#COURSE_SCENERY_ENTER_POS_B0_B_VAL
		beq	:+
		cmp	#COURSE_SCENERY_ENTER_POS_B0_C_VAL
		bne	:++++++
		: lda	attr_player
		bne	:+ ; if (course.enter_pos == 0xB0 && this.priority == high && this.flip == none) {
			lda	#joypad_button::right
			jmp	player_proc_auto
		: ; } else {
			jsr	player_proc_pipe_h_enter
			dec	timer_scene_trans
			bne	player_proc_enter_rts ; if (--timer_scene_trans == 0) {
				inc	screen_msg_disable
				jmp	player_proc_victory_do
			; } else rts;
		; }
	: lda	game_joypad_override
	bne	:+ ; } else if (!joypad_override) {
		lda	#$FF
		jsr	game_pos_y_lo_player_add
		lda	pos_y_lo_player
		cmp	#145
		bcc	:+++ ; if (this.pos_y >= 145) {
			rts
		; }
	: ; } else {
		lda	height_vine
		cmp	#$60
		bne	player_proc_enter_rts
		lda	pos_y_lo_player
		cmp	#153
		ldy	#0
		lda	#joypad_button::right
		bcc	:+ ; if (this.pos_y >= 153) {
			lda	#player_state::climb
			sta	state_player
			iny
			lda	#joypad_button::up
			sta	bg_buffer_0+$B4
		: ; }
		sty	col_disable
		jsr	player_proc_auto
		lda	pos_x_lo_player
		cmp	#72
		bcc	player_proc_enter_rts
	: ; } if ((!joypad_override && this.pos_y < 0x91) || (this.pos_y >= 72)) {
		lda	#player_procs::ctrl
		sta	proc_id_player
		lda	#DIR_RIGHT
		sta	disp_dir_player
		lsr	a
		sta	game_start_type
		sta	col_disable
		sta	game_joypad_override
	player_proc_enter_rts: ; }

	rts
; -----------------------------------------------------------
player_proc_ctrl_fall_y_hi_cutoff	= zp_byte_07

	.export	player_proc_auto
player_proc_auto:
	sta	joypad_p1
; ---------------------------
player_proc_ctrl:
	lda	proc_id_player
	cmp	#player_procs::death
	beq	:+++ ; if (this.proc_id != death) {
		lda	course_type
		bne	:++
		ldy	pos_y_hi_player
		dey
		bne	:+
		lda	pos_y_lo_player
		cmp	#$D0
		bcc	:++
		: ; if (course.type == water && this.pos_y >= 0x1D0) {
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
		beq	:+ ; if ((joypad_u_d & down) && this.state == ground && joypad_l_r) {
			lda	#joypad_button::none
			sta	joypad_l_r
			sta	joypad_u_d
		; }
	: ; }

	jsr	player_proc_player_move

	ldy	#col_box_type::small
	lda	player_size
	bne	:+ ; if (this.size == large) {
		ldy	#col_box_type::large

		lda	player_crouching
		beq	:+ ; if (this.crouching) {
			ldy	#col_box_type::crouch
		; }
	: ; }
	sty	col_box_player

	lda	#DIR_RIGHT
	ldy	veloc_x_player
	beq	:++
	bpl	:+ ; if (this.veloc_x != 0) {
		; if (this.veloc_x < 0) {
			asl	a
		: ; }
		sta	motion_dir_player
	: ; }

	jsr	game_scroll

	jsr	pos_bits_get_player
	jsr	pos_calc_x_rel_player

	ldx	#0

	jsr	col_box_proc
	jsr	col_bg_proc

	lda	pos_y_lo_player
	cmp	#64
	bcc	:+
	lda	proc_id_player
	cmp	#player_procs::victory
	beq	:+
	cmp	#player_procs::enter
	beq	:+
	cmp	#player_procs::pole
	bcc	:+ ; if (this.pos_y >= 64 && this.proc_id >= pole && this.proc_id.not_in(victory, enter)) {
		lda	attr_player
		and	#<~obj_attr::priority_bit
		sta	attr_player
	: ; }

	lda	pos_y_hi_player
	cmp	#2
	bmi	player_proc_ctrl_rts ; if (this.pos_y.hi >= 2) {
		ldx	#1
		stx	game_scroll_lock

		ldy	#4
		sty	player_proc_ctrl_fall_y_hi_cutoff
		ldx	#0

		ldy	game_time_up
		bne	:+
		ldy	course_type_cloud
		bne	:+++
		: ; if (game_time_up || course.type != cloud) {
			inx

			ldy	proc_id_player
			cpy	#player_procs::death
			beq	:++ ; if (this.proc_id != death) {
				ldy	music_event_death_flag
				bne	:+ ; if (!music_event_death_flag) {
					iny
					sty	apu_music_event_req
					sty	music_event_death_flag
				: ; }
			
				ldy	#6
				sty	player_proc_ctrl_fall_y_hi_cutoff
			; }
		: ; }

		cmp	player_proc_ctrl_fall_y_hi_cutoff
		bmi	player_proc_ctrl_rts ; if (this.pos_y.hi >= fall_y_hi_cutoff) {
			dex
			bmi	:++ ; if (--x >= 0 && music.event_current == null) {
			ldy	apu_music_event_current
			bne	:+
				lda	#player_procs::lifedown
				sta	proc_id_player
			: ; }
	
			player_proc_ctrl_rts:
				rts
			: ; } else {
				lda	#joypad_button::none
				sta	game_joypad_override
				jsr	player_proc_vine_b
				inc	game_start_type
				rts
			; }
		; }
	; }
; -----------------------------------------------------------
player_proc_vine:
	lda	pos_y_hi_player
	bne	:+
	lda	pos_y_lo_player
	cmp	#$E4
	bcc	:++
	: ; if (this.pos_y >= 0xE4) {
		lda	#joypad_button::up
		sta	game_joypad_override
		ldy	#player_state::climb
		sty	state_player
		jmp	player_proc_auto
	: ; } else {
	player_proc_vine_b:
		lda	#2
		sta	game_start_type
		jmp	player_proc_pipe_h_do_2
	; }
; -----------------------------------------------------------
player_proc_pipe_v:
	lda	#1
	jsr	game_pos_y_lo_player_add

	jsr	game_scroll

	ldy	#0
	lda	game_warp_ctrl
	bne	player_proc_pipe_h_do ; if (!game_warp_ctrl) {
		iny
		lda	course_type
		cmp	#course_types::castle
		bne	player_proc_pipe_h_do ; if (course.type == castle) {
			iny
			jmp	player_proc_pipe_h_do
		; }
	; }
; -----------------------------
game_pos_y_lo_player_add:
	clc
	adc	pos_y_lo_player
	sta	pos_y_lo_player
	rts
; -----------------------------------------------------------
player_proc_pipe_h:
	jsr	player_proc_pipe_h_enter
	ldy	#2

player_proc_pipe_h_do:
	dec	timer_scene_trans
	bne	:+ ; if (--timer_scene_trans == 0) {
		sty	game_start_type
	
	player_proc_pipe_h_do_2:
		inc	nmi_disp_disable
		lda	#game_modes::init
		sta	proc_id_game
		sta	nmi_sprite_overlap
	: ; }

	rts
; ------------------------------
player_proc_pipe_h_enter:
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
		jsr	player_proc_auto
		rts
	.elseif	.defined(ANN)
		jmp	player_proc_auto
	.endif
; -----------------------------------------------------------
player_proc_size_chg:
	lda	game_timer_stop
	cmp	#$F8
	bne	:+ ; if (game_timer_stop == 0xF8) {
		jmp	player_proc_hurt_do
	: cmp	#$C4
	bne	:+ ; } else if (game_timer_stop == 0xC4) {
		jsr	player_proc_player_done
	: ; }

	rts
; -----------------------------------------------------------
player_proc_hurt:
	lda	game_timer_stop
	cmp	#$F0
	bcs	:+ ; if (game_timer_stop < 0xF0) {
		cmp	#$C8 ; if (game_timer_stop == 0xC8) {
			beq	player_proc_player_done
		; } else {
			jmp	player_proc_ctrl
		; }
	: ; }
	bne	:+ ; } else if (game_timer_stop >= 0xF0) {
	player_proc_hurt_do:
		ldy	player_resizing
		bne	:+ ; if (!this.resizing) {
			sty	player_ani_frame
			inc	player_resizing
			lda	player_size
			eor	#1
			sta	player_size
		: ; }
	; }

	rts
; -----------------------------------------------------------
player_proc_death:
	lda	game_timer_stop
	cmp	#$F0
	.if	.defined(SMB)|.defined(VS_SMB)
		bcs	player_proc_player_rts
	.elseif	.defined(SMB2M)
		bcs	player_proc_firefl_rts
	.endif
	jmp	player_proc_ctrl
; -----------------------------------------------------------
player_proc_player_done:
	lda	#0
	sta	game_timer_stop
	lda	#player_procs::ctrl
	sta	proc_id_player
	rts
; -----------------------------------------------------------
	.export	player_proc_firefl_do, player_proc_firefl_do_2
player_proc_firefl:
	lda	game_timer_stop
	cmp	#$C0
	beq	:+ ; if (game_timer_stop != 0xC0) {
		lda	frame_count
		lsr	a
		lsr	a

	player_proc_firefl_do:
		and	#obj_attr::color_bits
		sta	zp_byte_00
		lda	attr_player
		and	#<~obj_attr::color_bits
		ora	zp_byte_00
		sta	attr_player
		rts
	: ; } else {
		jsr	player_proc_player_done

	player_proc_firefl_do_2:
		lda	attr_player
		and	#<~obj_attr::color_bits|obj_attr::color0
		sta	attr_player
	player_proc_firefl_rts:
		rts
	; }
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
player_proc_player_rts:
	rts
.endif
; -----------------------------------------------------------
player_proc_pole:
	lda	obj_id_actor+(ENG_ACTOR_MAX-1)
	cmp	#actor::flag_enemy
	bne	:++ ; if (actor.obj_id_actor == flag_enemy) {
		lda	music_event_goal_flag
		sta	apu_sfx_pulse_1_req

		lda	#joypad_button::none
		sta	music_event_goal_flag
		ldy	pos_y_lo_player
		cpy	#$9E
		bcs	:+ ; if (this.pos_y < 0x9E) {
			lda	#joypad_button::down
		: ; }
		jmp	player_proc_auto
	: ; } else {
		inc	proc_id_player
		rts
	; }
; -----------------------------------------------------------
player_proc_victory_oneup_tallies:
.if	.defined(SMB)|.defined(VS_SMB)
	.byte	$15, $23, $16, $1B
	.byte	$17, $18, $23, $63
.elseif	.defined(ANN)
	.byte	$14, $1E, $14, $1B
	.byte	$13, $18, $13, $63
.endif
; ----------------------------
player_proc_victory:
	lda	#joypad_button::right
	jsr	player_proc_auto

	lda	pos_y_lo_player
	cmp	#$AE
	bcc	:+
	.if	.defined(SMB)|.defined(VS_SMB)
	lda	game_scroll_lock
	beq	:+ ; if (this.pos_y >= 0xAE && scroll_lock || !(SMB|VS_SMB)) {
	.endif
		.if	.defined(SMB2M)
			lda	#0
			sta	game_scroll_lock
		.endif

		.if	.defined(SMB2M)
		lda	game_level_end_apu_on
		bne	:+ ; if (!game_level_end_apu_on) {
		.endif
			lda	#music_event::level_end
			sta	apu_music_event_req
			.if	.defined(SMB)|.defined(VS_SMB)
				lda	#0
				sta	game_scroll_lock
			.endif

		.if	.defined(SMB2M)
			inc	game_level_end_apu_on
		; }
		.endif
	: ; }

	lda	collision_player
	lsr	a
	bcs	:++ ; if (!(this.collision & right)) {
		lda	proc_id_victory_flag
		bne	:+ ; if (victory_flag.proc_id == null) {
			inc	proc_id_victory_flag
		: ; }

		lda	#obj_attr::priority_low|obj_attr::color0
		sta	attr_player
	: ; }

	lda	proc_id_victory_flag
	cmp	#<victory_flag_proc::done
	bne	:+++ ; if (victory_flag.proc_id == done) {
		inc	player_goals
		lda	player_goals
		cmp	#3
		bne	:+
		ldy	course_no
		lda	game_bonus_counter
		.if	.defined(SMB)|.defined(VS_SMB)|.defined(ANN)
		cmp	player_proc_victory_oneup_tallies, y
		.elseif	.defined(SMB2)
		cmp	#10
		.endif
		bcc	:+ ; if (++this.goals == 3 && (game_bonus_counter >= player_proc_victory_oneup_tallies[course.no] || (SMB2M && game_bonus_counter >= 10)) {
			inc	bg_hidden_one_up_req
		: ; }

	player_proc_victory_do:
		inc	course_sub

		.if	.defined(SMB2)
			lda	course_no
			cmp	#course::no_09
			bne	:+
			lda	player_goals
			cmp	#4
			bne	:+ ; if (course.no == no_09 && player.goals == 4) {
				lda	#0
				sta	player_goals
				sta	course_sub
			; }
		.endif
		:

		jsr	course_descriptor_load
		inc	player_first_start
		jsr	player_proc_pipe_h_do_2
		sta	pos_x_hi_alt_game
		lda	#music_event::none
		sta	apu_music_event_req
	: ; }

	rts
; -----------------------------------------------------------
player_proc_player_move:
	lda	#0
	ldy	player_size
	bne	:+
	lda	state_player
	bne	:++ ; if (this.size == small || this.state == ground) {
		; if (this.size == large) {
			lda	joypad_u_d
			and	#joypad_button::down
		: ; }
		sta	player_crouching
	: ; }

	jsr	player_proc_player_physics

	lda	player_resizing
	bne	:++ ; if (!this.resizing) {
		lda	state_player
		cmp	#player_state::climb
		beq	:+ ; if (this.state != climb) {
			ldy	#$18
			sty	timer_player_climb
		: ; }

		jsr	tbljmp
		.addr	player_proc_player_ground
		.addr	player_proc_player_jump_swim
		.addr	player_proc_player_fall
		.addr	player_proc_player_climb
	: ; }

	rts
; -----------------------------------------------------------
player_proc_player_ground:
	jsr	player_proc_player_ani_speed

	lda	joypad_l_r
	beq	:+ ; if (joypad_l_r) {
		sta	disp_dir_player
	: ; }

	jsr	player_proc_player_friction

player_proc_player_ground_b:
	jsr	motion_x_check_spring
	sta	scroll_x_player

	.if	.defined(SMB2)
		lda	disk_loader_file_id
		beq	:+ ; if (disk_loader_file_id != main) {
			jsr	bg_scenery_wind_col
		: ; }
	.endif

	rts
; -----------------------------------------------------------
player_proc_player_fall:
	lda	accel_y_gravity
	sta	accel_y_player
	jmp	player_proc_player_jump_swim_do
; -----------------------------------------------------------
player_proc_player_jump_swim:
	ldy	veloc_y_player
	bpl	:+
	lda	joypad_a_b
	and	#joypad_button::face_a
	and	joypad_a_b_held
	bne	:++
	lda	pos_y_player_jump+1
	sec
	sbc	pos_y_lo_player
	cmp	offset_y_player_jump
	bcc	:++
	: ; if (
	;	player.veloc_y >= 0
	;	|| (
	;		!((joypad_a_b & joypad_a_b_held) & face_a)
	;		&& ((player.jump_pos_y - player.pos_y) >= player.jump_offset_y)
	;	)
	; ) {
		lda	accel_y_gravity
		sta	accel_y_player
	: ; }

	lda	player_swimming
	beq	:++ ; if (this.swimming) {
		jsr	player_proc_player_ani_speed
		lda	pos_y_lo_player
		cmp	#20
		bcs	:+ ; if (this.pos_y < 20) {
			lda	#24
			sta	accel_y_player
		: ; }
	
		lda	joypad_l_r
		beq	:+ ; if (joypad_l_r) {
			sta	disp_dir_player
		; }
	: ; }

player_proc_player_jump_swim_do:
	lda	joypad_l_r
	beq	:+ ; if (joypad_l_r) {
		jsr	player_proc_player_friction
	: ; }

	.if	.defined(SMB)|.defined(VS_SMB)
		jsr	motion_x_check_spring
		sta	scroll_x_player
	.elseif	.defined(SMB2M)
		jsr	player_proc_player_ground_b
	.endif

	lda	proc_id_player
	cmp	#player_procs::death
	bne	:+ ; if (this.proc_id == death) {
		lda	#$28
		sta	accel_y_player
	: ; }

	jmp	motion_y_check_spring
; -----------------------------------------------------------
CLIMB_OFFSET_SMALL	= 4
CLIMB_OFFSET_LARGE	= 14

player_proc_player_climb_offset_x_lo:
	.byte	<CLIMB_OFFSET_LARGE, <CLIMB_OFFSET_SMALL, <-CLIMB_OFFSET_SMALL, <-CLIMB_OFFSET_LARGE

player_proc_player_climb_offset_x_hi:
	.byte	>CLIMB_OFFSET_LARGE, >CLIMB_OFFSET_SMALL, >-CLIMB_OFFSET_SMALL, >-CLIMB_OFFSET_LARGE
; -----------------------------
player_proc_player_climb:
	lda	accel_y1_player
	clc
	adc	accel_y2_player
	sta	accel_y1_player

	ldy	#0
	lda	veloc_y_player
	bpl	:+ ; if (this.veloc_y  < 0) {
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
	beq	:++++ ; if ((joypad.l_r & this.collision) != none) {
		ldy	timer_player_climb
		bne	:+++ ; if (this.timer_climb == 0) {
			ldy	#24
			sty	timer_player_climb
			ldx	#0
			ldy	disp_dir_player
			lsr	a
			bcs	:+ ; if ((joypad.l_r & this.collision) & right) {
				inx
				inx
			: ; }
			dey
			beq	:+ ; if (this.disp_dir == right) {
				inx
			: ; }
		
			lda	pos_x_lo_player
			clc
			adc	player_proc_player_climb_offset_x_lo, x
			sta	pos_x_lo_player
			lda	pos_x_hi_player
			adc	player_proc_player_climb_offset_x_hi, x
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

	.export	player_proc_player_stats
player_proc_player_stats:
	.include	"../../../data/player_a_accel.s"

.if	.defined(SMB2M)
	.include	"../../../data/player_a_friction.s"
.endif

	.include	"../../../data/player_phys.s"

.if	.defined(SMB)|.defined(VS_SMB)
	.include	"../../../data/player_a_friction.s"
.endif

	.include	"../../../data/player_phys_climb.s"
; ------------------------
player_proc_player_physics:
	lda	state_player
	cmp	#player_state::climb
	bne	:+++ ; if (player.state == climb) {
		ldy	#0
		lda	joypad_u_d
		and	collision_player
		beq	:+ ; if ((this.collision & joypad.u_d) != none) {
			iny
			and	#COL_TOP
			bne	:+ ; if ((this.collision & joypad.u_d) != top) {
				iny
			; }
		: ; }
		ldx	player_proc_player_climb_accel_y, y
		stx	accel_y2_player
	
		lda	#8
		ldx	player_proc_player_climb_veloc_y, y
		stx	veloc_y_player
		bmi	:+ ; (this.veloc_y >= 0) { 
			lsr	a
		: ; }
		sta	timer_player_ani
	
		rts
	: lda	player_on_spring
	bne	:+
	lda	joypad_a_b
	and	#joypad_button::face_a
	beq	:+
	and	joypad_a_b_held
	beq	:++
	: ; } else if (player.on_spring || pressed_a || held_a || (this.state != ground && !this.swimming)) {
		jmp	:+++++++
	:
	lda	state_player
	beq	:+
	lda	player_swimming
	beq	:--
	lda	timer_player_jump_swim
	bne	:+
	lda	veloc_y_player
	bpl	:+ ; } else if (this.state != ground && this.swimming && !this.timer_jump_swim && this.veloc_y < 0) {
		jmp	:++++++
	: ; } else {
		lda	#$20
		sta	timer_player_jump_swim
		ldy	#0
		sty	accel_y1_player
		sty	accel_y2_player
		lda	pos_y_hi_player
		sta	pos_y_player_jump
		lda	pos_y_lo_player
		sta	pos_y_player_jump+1
		lda	#player_state::jump_swim
		sta	state_player
		lda	veloc_x_player_abs
		cmp	#JUMP_VELOC_X_CUTOFF_A
		bcc	:+ ; if (abs(this.veloc_x) >= cutoff_a) {
			iny
			cmp	#JUMP_VELOC_X_CUTOFF_B
			bcc	:+ ; if (abs(this.veloc_x) >= cutoff_b) {
				iny
				cmp	#JUMP_VELOC_X_CUTOFF_C
				bcc	:+ ; if (abs(this.veloc_x) >= cutoff_c) {
					iny
					cmp	#JUMP_VELOC_X_CUTOFF_D
					bcc	:+ ; if (abs(this.veloc_x) >= cutoff_d) {
						iny
					; }
				; }
			; }
		: ; }
		lda	#1
		sta	offset_y_player_jump

		lda	player_swimming
		beq	:+ ; if (this.swimming) {
			ldy	#$05
			lda	game_whirlpool_flag
			beq	:+ ; if (game.whirlpool_flag) {
				iny
			; }
		: ; }

		lda	player_proc_player_jump_accel_y, y
		sta	accel_y_player
		lda	player_proc_player_grav_accel_y, y
		sta	accel_y_gravity
		lda	player_proc_player_init_accel_y, y
		sta	accel_y2_player
		lda	player_proc_veloc_y_player, y
		sta	veloc_y_player

		lda	player_swimming
		beq	:+ ; if (this.swimming) {
			lda	#sfx_pulse_1::stomp
			sta	apu_sfx_pulse_1_req
	
			lda	pos_y_lo_player
			cmp	#20
			bcs	:+++ ; if (this.pos_y < 20) {
				lda	#0
				sta	veloc_y_player
				jmp	:+++
			; }
		: ; } else {
			lda	#sfx_pulse_1::jump_big
			ldy	player_size
			beq	:+ ; if (this.size == small) {
				lda	#sfx_pulse_1::jump_small
			: ; }
			sta	apu_sfx_pulse_1_req
		; }
	: ; }

	ldy	#0
	sty	zp_byte_00
	lda	state_player
	beq	:+ ; if (this.state != ground) {
		lda	veloc_x_player_abs
		cmp	#JUMP_VELOC_X_CUTOFF_C
		bcs	:+++++
		bcc	:++
	: ; } else {
		iny
		lda	course_type
		beq	:+ ; if (course.type != water) {
			dey
			lda	joypad_l_r
			cmp	motion_dir_player
			bne	:+ ; if (joypad_l_r == this.motion_dir) {
				lda	joypad_a_b
				and	#joypad_button::face_b
				bne	:+++
				lda	timer_player_run
				bne	:++++
			; }
		: ; }
	; }

	; if (
	;	(this.state != ground && abs(this.veloc_x) >= 0x19)
	;	|| (this.state == ground && course.type == water)
	; ) {
		iny
		inc	zp_byte_00
		lda	veloc_x_player_run
		bne	:+
		lda	veloc_x_player_abs
		cmp	#PLAYER_VELOC_X_CAP_SLOW
		bcc	:+++
		: inc	zp_byte_00
		jmp	:++
	: ; } if (pressed_b || this.veloc_run) {
		lda	#10
		sta	timer_player_run
	: ; }

	lda	player_proc_player_max_veloc_left, y
	sta	player_max_veloc_left
	lda	proc_id_player
	cmp	#player_procs::enter
	bne	:+ ; if (this.proc_id == enter) {
		ldy	#player_proc_player_max_veloc_right_enter-player_proc_player_max_veloc_right
	: ; }
	lda	player_proc_player_max_veloc_right, y
	sta	player_max_veloc_right
	ldy	zp_byte_00
	lda	player_proc_player_data_friction, y
	sta	accel_x_friction+1
	lda	#PLAYER_FRICTION_ADD_HI
	sta	accel_x_friction
	lda	disp_dir_player
	cmp	motion_dir_player
	beq	:+ ; if (this.disp_dir != this.motion_dir) {
		.export player_proc_player_physics_friction_shift
	player_proc_player_physics_friction_shift:
		asl	accel_x_friction+1
		rol	accel_x_friction
	: ; }

	rts
; -----------------------------------------------------------
player_proc_player_ani_timers:
	.byte	2

	.ifndef	PAL
		.byte	4, 7
	.else
		.byte	3, 5
	.endif
; ---------------------------
player_proc_player_ani_speed:
	ldy	#0
	lda	veloc_x_player_abs
	cmp	#ANI_VELOC_X_CUTOFF_A
	bcs	:++ ; if (abs(this.veloc_x) < cutoff_a) {
		iny
		cmp	#ANI_VELOC_X_CUTOFF_B
		bcs	:+ ; if (abs(this.veloc_x) < cutoff_b) {
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
		sta	veloc_x_player_run
		jmp	:++
	: ; } else {
		lda	veloc_x_player_abs
		cmp	#ANI_VELOC_X_CUTOFF_C
		bcs	:+ ; if (abs(this.veloc_x) < cutoff_c) {
			lda	disp_dir_player
			sta	motion_dir_player
			lda	#0
			sta	veloc_x_player
			sta	veloc_x_player_hi
		; }
	: ; }

	lda	player_proc_player_ani_timers, y
	sta	timer_player_ani
	rts
; -----------------------------------------------------------
player_proc_player_friction:
	and	collision_player
	cmp	#COL_NONE
	bne	:+
	lda	veloc_x_player
	beq	:+++++
	bpl	:+++
	bmi	:++
	: lsr	a
	bcc	:++
	: ; if (this.collision == none && this.veloc_x < 0) {
		lda	veloc_x_player_hi
		clc
		adc	accel_x_friction+1
		sta	veloc_x_player_hi
		lda	veloc_x_player
		adc	accel_x_friction
		sta	veloc_x_player
		cmp	player_max_veloc_right
		bmi	:++ ; if (this.veloc_x > this.max_veloc_right) {
			lda	player_max_veloc_right
			sta	veloc_x_player
			jmp	:+++
		; }
	: ; } else {
		lda	veloc_x_player_hi
		sec
		sbc	accel_x_friction+1
		sta	veloc_x_player_hi
		lda	veloc_x_player
		sbc	accel_x_friction
		sta	veloc_x_player
		cmp	player_max_veloc_left
		bpl	:+ ; if (this.veloc_x < this.max_veloc_left) {
			lda	player_max_veloc_left
			sta	veloc_x_player
		; }
	: ; } if () {
		cmp	#0
		bpl	:+ ; if (this.veloc_x < 0) {
			neg_m
		; }
	: ; }

	sta	veloc_x_player_abs
	rts
