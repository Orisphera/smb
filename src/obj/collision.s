.include	"system/ppu.i"

.include	"math.i"
.include	"mem.i"
.include	"modes.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"
.include	"joypad.i"
.include	"sound.i"
.include	"macros.i"

; ------------------------------------------------------------
col_bg_proc_player_halt_dir	= zp_byte_00
col_buffer_ptr_idx		= zp_byte_02
col_box_buffer_tbl_offset	= zp_byte_04
; ------------------------------------------------------------
OOB_PROC_OFFSET_X		= 72
OOB_PROC_SPEC_ENEMY_LEFT_OFF	= 56
; ------------------------------------------------------------
oob_proc_offset_x_left_hi	= zp_byte_00
oob_proc_offset_x_left_lo	= zp_byte_01
oob_proc_offset_x_right_hi	= zp_byte_02
oob_proc_offset_x_right_lo	= zp_byte_03

	.export col_actor_oob_proc
col_actor_oob_proc:
	lda	obj_id_actor, x
	cmp	#actor::cheep_fly
	beq	:++++ ; if (actor.id != cheep_fly) {
		lda	pos_x_lo_screen_left
		ldy	obj_id_actor, x
		cpy	#actor::hammer_bro
		beq	:+
		.if	.defined(SMB2M)
			cpy	#actor::piranha_plant_b
			beq	:+
		.endif
		cpy	#actor::piranha_plant
		bne	:++
		: ; if (actor.id.in(hammer_bro, piranha_plant)) {
			adc	#OOB_PROC_SPEC_ENEMY_LEFT_OFF
		: ; }
		sbc	#<OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_left_lo
	
		lda	pos_x_hi_screen_left
		sbc	#>OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_left_hi
		lda	pos_x_lo_screen_right
		adc	#<OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_right_lo
		lda	pos_x_hi_screen_right
		adc	#>OOB_PROC_OFFSET_X
		sta	oob_proc_offset_x_right_hi

		lda	pos_x_lo_actor, x
		cmp	oob_proc_offset_x_left_lo
		lda	pos_x_hi_actor, x
		sbc	oob_proc_offset_x_left_hi
		bmi	:+
		lda	pos_x_lo_actor, x
		cmp	oob_proc_offset_x_right_lo
		lda	pos_x_hi_actor, x
		sbc	oob_proc_offset_x_right_hi
		bmi	:++
		lda	state_actor, x
		cmp	#actor_states::state_5
		beq	:++
		cpy	#actor::piranha_plant
		beq	:++
		.if	.defined(SMB2M)
			cpy	#actor::piranha_plant_b
			beq	:++
		.endif
		cpy	#actor::flag_enemy
		beq	:++
		cpy	#actor::flag_victory
		beq	:++
		cpy	#actor::spring
		beq	:++
		: ; if (
		;	actor.pos_x < screen.pos_x_left
		;	|| (
		;		actor.pos_x >= screen.pos_x_right
		;		&& actor.state &= state_5
		;		&& actor.id.not_in(piranha_plant, flag_enemy, flag_victory, spring)
		;		&& (!SMB2M || actor.id != piranha_plant_b)
		;	) {
			jsr	actor_erase
		: ; }
	; }

	rts
; ------------------------------------------------------------
.if	.defined(FC_SMB)
	.if	.defined(PAL)
		.res	56, $FF
	.endif
	.res	3, $FF
.elseif	.defined(VS_SMB)
	.res	23, $FF
.elseif	.defined(SMB2)
	.res	1, $FF
.endif
; ------------------------------------------------------------
col_proj_actor_proc_index	= zp_byte_01
	.export col_proj_actor_proc
col_proj_actor_proc:
	lda	state_proj, x
	beq	:+++++
	asl	a
	bcs	:+++++
	lda	frame_count
	lsr	a
	bcs	:+++++ ; if (this.state != inactive && this.bit_7 && !(frame_count % 2)) {
		txa
		asl	a
		asl	a
		clc
		adc	#(7*4)
		tay
		ldx	#(ENG_ACTOR_MAX-2)
		: ; for (x = ENG_ACTOR_MAX-2; x >= 0; x--) {
			stx	col_proj_actor_proc_index
			tya
			pha

			lda	state_actor, x
			and	#actor_states::bit_5
			bne	:+++
			lda	proc_id_actor, x
			beq	:+++
			lda	obj_id_actor, x
			cmp	#actor::plat_start
			bcc	:+
			cmp	#actor::plat_s_up
			bcc	:+++
			: cmp	#actor::goomba
			bne	:+
			lda	state_actor, x
			cmp	#actor_states::state_2
			bcs	:++
			: lda	actor_bits_mask, x
			bne	:+ ; if (
			;	!(actor.state & bit_5)
			;	&& (actor.mode != free)
			;	&& (actor.id < plat_start || actor.id >= plat_s_up)
			;	&& (actor.id != goomba || (actor.id == goomba && actor.state < state_2)
			;	&& actor.bits_mask == 0
			; ) {
				txa
				asl	a
				asl	a
				clc
				adc	#(1*4)
				tax
				jsr	col_base_actor

				ldx	actor_index
				bcc	:+ ; if (col_base_actor(4*(x+1))) {
					lda	#proj_states::bit_7
					sta	state_proj, x
					ldx	col_proj_actor_proc_index
					jsr	col_proj_actor_damage
				; }
			: ; }

			pla
			tay
			ldx	col_proj_actor_proc_index
			dex
			bpl	:----
		; }
	: ; }

	ldx	actor_index
	rts
; ------------------------------------------------------------
SCORE_PROJ_GOOMBA	= scores::value_100
SCORE_PROJ_ENEMY_OTHER	= scores::value_200
SCORE_PROJ_HAMMER_BRO	= scores::value_1000
SCORE_PROJ_BOWSER	= scores::value_5000
; ------------------------------------------------------------
bowser_death_obj_id_actors:
	.byte	actor::goomba
	.byte	actor::koopa_green
	.byte	actor::buzzy_beetle
	.byte	actor::spiny
	.byte	actor::lakitu
	.byte	actor::blooper
	.byte	actor::hammer_bro
	.byte	actor::bowser
.if	.defined(SMB2M)
	.byte	actor::bowser
.endif
; -----------------------------
col_proj_actor_damage:
	jsr	pos_calc_x_rel_actor
	ldx	zp_byte_01
	lda	proc_id_actor, x
	bpl	:+
	and	#ACTOR_MODE_PARENT_MASK
	tax
	lda	obj_id_actor, x
	cmp	#actor::bowser
	beq	:++
	ldx	zp_byte_01
	: lda	obj_id_actor, x
	cmp	#actor::buzzy_beetle
	beq	:+++++++++
	cmp	#actor::bowser
	bne	:+++
	: dec	hp_bowser
	bne	:++++++++ ; if (actor.id == bowser && --hp_bowser == 0) {
		jsr	actor_init_veloc_y
		sta	veloc_x_actor, x
		sta	actor_swarm_buffer
		lda	#<-2
		sta	veloc_y_actor, x
		ldy	course_no
		lda	bowser_death_obj_id_actors, y
		sta	obj_id_actor, x
		lda	#actor_states::bit_5
		cpy	#course::no_04
		bcs	:+ ; if (course.no < no_04) {
			ora	#actor_states::state_3
		: ; }
		sta	state_actor, x
		lda	#sfx_pulse_2::bowser_fall
		sta	apu_sfx_pulse_2_req
		ldx	zp_byte_01
		lda	#SCORE_PROJ_BOWSER
		bne	:++++++
	: cmp	#actor::bullet_swarm
	beq	:++++++
	cmp	#actor::podoboo
	beq	:++++++
	cmp	#actor::actors_page_b
	bcs	:++++++ ; } else if (actor.id.not_in(buzzy_beetle, bullet_swarm, podoboo) && actor.id < actors_page_b) {
	col_actor_kill:
		lda	obj_id_actor, x
		.if	.defined(SMB2M)
			cmp	#actor::piranha_plant_b
			beq	:+
		.endif
		cmp	#actor::piranha_plant
		bne	:+++
		: ; if (actor.id == piranha_plant) {
			.if	.defined(SMB2M)
				tay
			.endif

			lda	pos_y_lo_actor, x
			adc	#24

			.if	.defined(SMB2M)
				cpy	#actor::piranha_plant_b
				bne	:+ ; if () {
					sbc	#49
				; }
			.endif
			:

			sta	pos_y_lo_actor, x
		: ; }
	
		jsr	col_actor_koopa_demote_check
		lda	state_actor, x
		and	#<~(actor_states::spawned|actor_states::bit_6|actor_states::bit_5)
		ora	#actor_states::bit_5
		sta	state_actor, x

		lda	#SCORE_PROJ_ENEMY_OTHER
		ldy	obj_id_actor, x
		cpy	#actor::hammer_bro
		bne	:+ ; if (actor.id == hammer_bro) {
			lda	#SCORE_PROJ_HAMMER_BRO
		:cpy	#actor::goomba
		bne	:+ ; } else if (actor.id == goomba) {
			lda	#SCORE_PROJ_GOOMBA
		; }
	: ; }

	; if (actor.id != bowser && actor.killed) {
		jsr	col_score_do
		lda	#sfx_pulse_1::smack
		sta	apu_sfx_pulse_1_req
	: ; }

	rts
; ------------------------------------------------------------
	.export col_player_hammer_proc
col_player_hammer_proc:
	lda	frame_count
	lsr	a
	bcc	:++
	.if	.defined(SMB)|.defined(VS_SMB)
		lda	game_timer_stop
	.elseif	.defined(SMB2M)
		lda	bits_offscr_player
		ora	game_timer_stop
	.endif
	ora	bits_offscr_misc
	bne	:++ ; if ((frame_count % 2) && !game_timer_stop && misc.bits_offscr == 0) {
		txa
		asl	a
		asl	a
		clc
		adc	#(9*4)
		tay
		jsr	col_base_player
		ldx	actor_index
		bcc	:+
		lda	misc_col_flag, x
		bne	:++ ; ; if (!col_base_player() || misc.col_flag == 0) {
			; if (misc.col_flag == 0) {
				lda	#1
				sta	misc_col_flag, x
	
				lda	veloc_x_misc, x
				neg_m
				sta	veloc_x_misc, x
	
				lda	timer_player_star
				bne	:++ ; if (player.timer_star == 0) {
					jmp	col_player_harm_proc
				; } 
			: ; } else if (!col_base_player()) {
				lda	#0
				sta	misc_col_flag, x
			; }
		; }
	: ; }

	rts
; ------------------------------------------------------------
SCORE_POWERUP	= scores::value_1000
STAR_TIMER	= 35

.if	.defined(SMB)|.defined(SMB2M)
	STAR_MUSIC	= music_base::super_star
.elseif	.defined(VS_SMB)
	STAR_MUSIC	= music_base::clouds
.endif
; ------------------------------------------------------------
col_player_powerup_proc:
	jsr	actor_erase

	.if	.defined(SMB2M)
		lda	actor_powerup_type
		cmp	#powerup_type::mushroom_poison
		bne	:+ ; if (powerup.type == mushroom_poison) {
			jmp	col_player_harm_proc
		: ; }
	.endif

	lda	#SCORE_POWERUP
	jsr	col_score_do
	lda	#sfx_pulse_2::powerup
	sta	apu_sfx_pulse_2_req
	lda	actor_powerup_type
	cmp	#powerup_type::star
	bcc	:+
	cmp	#powerup_type::mushroom_oneup
	beq	:++ ; if (powerup.type == star) {
		lda	#STAR_TIMER
		sta	timer_player_star
		lda	#STAR_MUSIC
		sta	apu_music_base_req
		rts
	: ; } else if (powerup.type.not_in(star, mushroom_oneup)) {
		lda	player_status
		beq	:++
		cmp	#player_statuses::power_mushroom
		bne	:++++ ; if (player.status == power_mushroom) {
			ldx	actor_index
			lda	#player_statuses::power_firefl
			sta	player_status
			jsr	screen_color_player
			ldx	actor_index
			lda	#player_procs::firefl
			jmp	:+++
		; }
	: ; } else if (powerup.type == mushroom_oneup) {
		lda	#scores::value_oneup
		sta	screen_score_ctl, x
		rts
	; }
; -----------------------------
	: ; if (player.status != power_mushroom) {
		; if (player.status == power_none) {
			lda	#player_statuses::power_mushroom
			sta	player_status
			lda	#player_procs::size_chg
		: ; }

		ldy	#0
		jsr	col_player_harm_proc_proc_change
	: ; }

	rts
; ------------------------------------------------------------
LD84D:
	.byte	24, <-24

col_player_actor_kick_veloc_x:
	.byte	KICK_VELOC_X_ABS, <-KICK_VELOC_X_ABS

col_player_stomp_veloc_x:
	.byte	8, <-8
; -----------------------------
	.export col_player_actor_proc
col_player_actor_proc:
	lda	frame_count
	lsr	a
	bcs	:- ; if (!(frame_count % 2)) {
		jsr	col_check_player_pos_y 
		bcs	:+
		lda	actor_bits_mask, x
		bne	:+
		lda	proc_id_player
		cmp	#player_procs::ctrl
		bne	:+
		lda	state_actor, x
		and	#actor_states::bit_5
		bne	:+ ; if (!col_check_player_pos_y() && actor.bits_mask == 0 && game.proc_id == ctrl && (actor.state & bit_5)) {
			jsr	col_actor_box_get
			jsr	col_base_player
			ldx	actor_index
			bcs	col_player_actor_proc_hit ; if (!col_base_player()) {
				lda	collision_actor, x
				and	#<~COL_RIGHT
				sta	collision_actor, x
			; } else col_player_actor_proc_hit();
		: ; }

	col_player_actor_proc_rts:
		rts
	; }
; -----------------------------
col_player_actor_proc_hit:
	ldy	obj_id_actor, x
	cpy	#actor::power_up
	bne	:+ ; if (actor.id == power_up) {
		jmp	col_player_powerup_proc
	: lda	timer_player_star
	beq	col_player_actor_proc_hit_do ; } else if (player.timer_star > 0) {
		jmp	col_actor_kill
	; } else col_player_actor_proc_hit_do();
; -----------------------------
col_player_actor_kick_score:
	.byte	scores::value_8000
	.byte	scores::value_1000
	.byte	scores::value_500
; -----------------------------
col_player_actor_proc_hit_do:
	lda	collision_actor, x
	and	#COL_RIGHT
	ora	actor_bits_mask, x
	bne	:++
	lda	#COL_RIGHT
	ora	collision_actor, x
	sta	collision_actor, x
	cpy	#actor::spiny
	beq	:+++

	.if	.defined(SMB2M)
		cpy	#actor::bullet
		beq	:+++
	.endif

	cpy	#actor::piranha_plant
	beq	col_player_harm_proc

	.if	.defined(SMB2M)
		cpy	#actor::piranha_plant_b
		beq	col_player_harm_proc
	.endif	
	
	cpy	#actor::podoboo
	beq	col_player_harm_proc

	.if	.defined(SMB)|.defined(VS_SMB)
		cpy	#actor::bullet
		beq	:+++
	.endif

	cpy	#actor::actors_page_b
	bcs	col_player_harm_proc
	lda	course_type
	beq	col_player_harm_proc
	lda	state_actor, x
	asl	a
	bcs	:+++
	lda	state_actor, x
	and	#actor_states::state_mask
	cmp	#actor_states::state_2
	bcc	:+++
	lda	obj_id_actor, x
	cmp	#actor::goomba
	beq	:++ ; if (
	;	!(actor.collision & 0x1)
	;	&& actor.bits_mask == 0
	;	&& y.not_in(spiny, piranha_plant, podoboo, bullet)
	;	&& y < actors_page_b
	;	&& course_type != water
	;	&& !(actor.state & 0x80)
	;	&& actor.state >= 2
	;	&& actor.id != goomba
	; ) {
		lda	#sfx_pulse_1::smack
		sta	apu_sfx_pulse_1_req
		lda	state_actor, x
		ora	#actor_states::spawned
		sta	state_actor, x
		jsr	col_actor_kick_dir
		lda	col_player_actor_kick_veloc_x, y
		sta	veloc_x_actor, x
		lda	#scores::value_400
		clc
		adc	counter_stomps
		ldy	timer_actor, x
		cpy	#3
		bcs	:+ ; if (actor.timer < 3) {
			lda	col_player_actor_kick_score, y
		: ; }
		jsr	col_score_do
	: ; } else if ((actor.collision & 0x01) || actor.id == goomba) {
		rts
	: ; } else {
		.if	.defined(SMB)|.defined(VS_SMB)
			lda	veloc_y_player
			bmi	:+
				bne	col_player_actor_stomp
		.elseif	.defined(SMB2M)
			ldy	veloc_y_player
			dey
			bpl	col_player_actor_stomp
		.endif
		:
		.ifndef	PAL
			lda	obj_id_actor, x
			cmp	#actor::blooper
			bcc	:+
			lda	pos_y_lo_player
			clc
			adc	#12
		.else
			lda	#20
			ldy	obj_id_actor, x
			cpy	#actor::cheep_fly
			bne	:+ ; if (actor.id == cheep_fly) {
				lda	#7
			: ; }
			adc	pos_y_lo_player
		.endif

		cmp	pos_y_lo_actor, x
		bcc	col_player_actor_stomp
		: lda	timer_actor_stun
		bne	col_player_actor_stomp ; if (player.veloc_y <= 0 && (actor.id < blooper || (player.pos_y + 12) >= actor.pos_y) && player.timer_stomp == 0) {
			lda	timer_player_injury
			bne	col_player_harm_proc_end ; if (player.timer_injury == 0) {
				lda	pos_x_rel_player
				cmp	pos_x_rel_actor
				bcc	:+ ; if (player.pos_x_rel >= actor.pos_x_rel) {
					jmp	col_player_harm_proc_check_dir
				: lda	motion_dir_actor, x
				cmp	#DIR_RIGHT
				bne	col_player_harm_proc ; } else if (actor.motion_dir == right) {
					jmp	col_player_harm_proc_left
				; } else col_player_harm_proc();
			; } else col_player_harm_proc_end();
		; } else col_player_actor_stomp();
	; }
; ------------------------------------------------------------
PLAYER_DEATH_VELOC_Y	= <-4
; ------------------------------------------------------------
	.export col_player_harm_proc, col_player_harm_proc_do
col_player_harm_proc:
	lda	timer_player_injury
	.if	.defined(SMB2M)
		ora	timer_player_star
	.endif
	bne	col_player_harm_proc_end

col_player_harm_proc_do:
	ldx	player_status
	beq	:++ ; if (player.timer_injury == 0) {
		; if (player.status != 0) {
			sta	player_status
			lda	#(sfx_pulse_1::pipe_entry_16)>>1
			sta	timer_player_injury
			.ifndef	PAL
				asl	a
			.else
				lda	#sfx_pulse_1::pipe_entry_16
			.endif
			sta	apu_sfx_pulse_1_req
			jsr	screen_color_player
			lda	#player_procs::hurt
		: ; }

		ldy	#1
; -----------------------------
	col_player_harm_proc_proc_change:
		sta	proc_id_player
		sty	state_player
		ldy	#255
		sty	game_timer_stop
		iny
		sty	game_scroll_amount
	; }

col_player_harm_proc_end:
	ldx	actor_index
	rts
; -----------------------------
	: ; if (player.status == 0) {
		stx	veloc_x_player
		inx
		stx	apu_music_event_req
		lda	#PLAYER_DEATH_VELOC_Y
		sta	veloc_y_player

		lda	#player_procs::death
		bne	:--
	; }
; ------------------------------------------------------------
col_player_actor_stomp_scores:
	.byte	scores::value_200
	.byte	scores::value_1000
	.byte	scores::value_800
	.byte	scores::value_1000
; -----------------------------
col_player_actor_stomp:
	lda	obj_id_actor, x
	cmp	#actor::spiny
	beq	col_player_harm_proc
	lda	#sfx_pulse_1::stomp
	sta	apu_sfx_pulse_1_req
	lda	obj_id_actor, x
	ldy	#0
	cmp	#actor::cheep_fly
	beq	:+
	cmp	#actor::bullet_swarm
	beq	:+
	cmp	#actor::bullet
	beq	:+
	cmp	#actor::podoboo
	beq	:+
	iny
	cmp	#actor::hammer_bro
	beq	:+
	iny
	cmp	#actor::lakitu
	beq	:+
	iny
	cmp	#actor::blooper
	bne	:++
	: ; if (actor.id.in(cheep_fly, bullet_swarm, bullet, podoboo, hammer_bro, lakitu, blooper)) {
		lda	col_player_actor_stomp_scores, y
		jsr	col_score_do

		lda	motion_dir_actor, x
		pha

		jsr	col_player_actor_stomp_do

		pla
		sta	motion_dir_actor, x

		lda	#actor_states::bit_5
		sta	state_actor, x
		jsr	actor_init_veloc_y
		sta	veloc_x_actor, x

		.if	.defined(SMB)|.defined(VS_SMB)
			lda	#<-3
			sta	veloc_y_player
			rts
		.elseif	.defined(SMB2M)
			jmp	:+++
		.endif
	: cmp	#actor::div_height
	bcc	:+ ; } else if (actor.id >= div_height) {
		.if	.defined(SMB2M)
			jsr	:++
		.endif

		and	#actor::koopa_mask
		sta	obj_id_actor, x

		.if	.defined(SMB)|.defined(VS_SMB)
			ldy	#actor_states::init
			sty	state_actor, x
		.elseif	.defined(SMB2M)
			lda	#actor_states::init
			sta	state_actor, x
		.endif

		lda	#scores::value_400
		jsr	col_score_do
		jsr	actor_init_veloc_y
		jsr	col_actor_kick_dir
		lda	col_player_stomp_veloc_x, y
		sta	veloc_x_actor, x

		.if	.defined(SMB)|.defined(VS_SMB)
			jmp	:++
		.elseif	.defined(SMB2M)
			rts
		.endif
; -----------------------------
col_actor_stomp_resurrect_timer:
	.ifndef	PAL
		.byte	16, 11
	.else
		.byte	13, 9
	.endif
; -----------------------------
	: ; } else {
		lda	#actor_states::state_4
		sta	state_actor, x
		inc	counter_stomps
		lda	counter_stomps
		clc
		adc	timer_actor_stun
		jsr	col_score_do
		inc	timer_actor_stun
		ldy	game_hard_mode
		lda	col_actor_stomp_resurrect_timer, y
		sta	timer_actor, x
	: ; }

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	#<-4
		sta	veloc_y_player
	.elseif	.defined(SMB2M)
		ldy	#<-6
		lda	obj_id_actor, x
		cmp	#actor::koopa_para_fly_red
		beq	:+
		cmp	#actor::koopa_para_fly_green
		bne	:++
		: ; if (actor.id.in(koopa_ara_fly_red|green)) {
			ldy	#<-8
		: ; }
		sty	veloc_y_player
	.endif

	rts
; ------------------------------------------------------------
col_player_harm_proc_check_dir:
	lda	motion_dir_actor, x
	cmp	#DIR_RIGHT
	bne	:+ ; if (actor.motion_dir == right) {
		jmp	col_player_harm_proc
	: ; } else {
	col_player_harm_proc_left:
		jsr	col_actor_calc_dir_check
		jmp	col_player_harm_proc
	; }
; ------------------------------------------------------------
col_actor_kick_dir:
	ldy	#DIR_RIGHT
	jsr	col_player_bullet_diff
	bpl	:+ ; if (col_player_bullet_diff() < 0) {
		iny
	: ; }

	sty	motion_dir_actor, x
	dey
	rts
; ------------------------------------------------------------
	.export col_score_do
col_score_do:
	sta	screen_score_ctl, x
	lda	#48
	sta	timer_score, x
	lda	pos_y_lo_actor, x
	sta	screen_score_pos_y, x
	lda	pos_x_rel_actor
	sta	screen_score_pos_x, x
	: rts
; ------------------------------------------------------------
col_actor_actor_proc_idx	= zp_byte_01

col_actor_actor_set_masks:
	.byte	(1<<7)
	.byte	(1<<6)
	.byte	(1<<5)
	.byte	(1<<4)
	.byte	COL_TOP
	.byte	COL_BOTTOM
	.byte	COL_LEFT

col_actor_actor_clear_masks:
	.byte	<~(1<<7)
	.byte	<~(1<<6)
	.byte	<~(1<<5)
	.byte	<~(1<<4)
	.byte	<~COL_TOP
	.byte	<~COL_BOTTOM
	.byte	<~COL_LEFT
; -----------------------------
	.export col_actor_actor_proc
col_actor_actor_proc:
	lda	frame_count
	lsr	a
	bcc	:-
	lda	course_type
	beq	:- ; if ((frame_count % 2) && course_type != water) {
		lda	obj_id_actor, x
		cmp	#actor::actors_page_b
		bcs	:+++++
		cmp	#actor::lakitu
		beq	:+++++
		cmp	#actor::piranha_plant
		beq	:+++++

		.if	.defined(SMB2M)
			cmp	#actor::piranha_plant_b
			beq	:+++++
		.endif

		lda	actor_bits_mask, x
		bne	:+++++
		jsr	col_actor_box_get
		dex
		bmi	:+++++
		: ; for (x = actor_index - 1; x >= 0; x--) {
			stx	col_actor_actor_proc_idx
			tya
			pha

			lda	proc_id_actor, x
			beq	:+++
			lda	obj_id_actor, x
			cmp	#actor::actors_page_b
			bcs	:+++
			cmp	#actor::lakitu
			beq	:+++
			cmp	#actor::piranha_plant
			beq	:+++

			.if	.defined(SMB2M)
				cmp	#actor::piranha_plant_b
				beq	:+++
			.endif

			lda	actor_bits_mask, x
			bne	:+++ ; if (actor_x.mode == active && actor.id < actors_page_b && actor.id.not_in(lakitu, piranha_plant) && actor.bits_mask == 0) {
				txa
				asl	a
				asl	a
				clc
				adc	#4
				tax
				jsr	col_base_actor
				ldx	actor_index
				ldy	col_actor_actor_proc_idx
				bcc	:++
				lda	state_actor, x
				ora	state_actor, y
				and	#actor_states::spawned
				bne	:+
				lda	collision_actor, y
				and	col_actor_actor_set_masks, x
				bne	:+++
				lda	collision_actor, y
				ora	col_actor_actor_set_masks, x
				sta	collision_actor, y
				: ; if (col_base_actor() && (actor_x.state & spawned || actor_y.state & spawned)) {
					jsr	col_actor_actor_do
					jmp	:++
				: ; } else if (!col_base_actor()) {
					lda	collision_actor, y
					and	col_actor_actor_clear_masks, x
					sta	collision_actor, y
				: ; }
			; }

			pla
			tay
			ldx	col_actor_actor_proc_idx
			dex
			bpl	:----
		: ; }
	
		ldx	actor_index
		rts
	; }
; ------------------------------------------------------------
col_actor_actor_do:
	lda	state_actor, y
	ora	state_actor, x
	and	#actor_states::bit_5
	bne	:++
	lda	state_actor, x
	cmp	#actor_states::state_6
	bcc	:+++
	lda	obj_id_actor, x
	cmp	#actor::hammer_bro
	beq	:++ ; if (actor_x.state == init && actor_y.state == init && actor_x.state >= state_6 && actor_x.id != hammer_bro) {
		lda	state_actor, y
		asl	a
		bcc	:+ ; if (actor.state & 0x80) {
			lda	#scores::value_1000
			jsr	col_score_do

			jsr	col_actor_kill
			ldy	col_actor_actor_proc_idx
		: ; }
		tya
		tax
		jsr	col_actor_kill

		ldx	actor_index

		lda	stomp_counter, x
		clc
		adc	#scores::value_500

		ldx	col_actor_actor_proc_idx

		jsr	col_score_do

		ldx	actor_index

		inc	stomp_counter, x
	: ; }

	rts
; -----------------------------
	: ; if (actor_x.state == init && actor_y.state == init && actor_x.state < 6 || called) {
		lda	state_actor, y
		cmp	#actor_states::state_6
		bcc	:+
		lda	obj_id_actor, y
		cmp	#actor::hammer_bro
		beq	:-- ; if (actor.state >= 6 && actor.id != hammer_bro) {
			jsr	col_actor_kill
			ldy	col_actor_actor_proc_idx

			lda	stomp_counter, y
			clc
			adc	#scores::value_500

			ldx	actor_index

			jsr	col_score_do

			ldx	col_actor_actor_proc_idx

			inc	stomp_counter, x
			rts
		: ; }
	
		tya
		tax
		jsr	col_actor_calc_dir_check
		ldx	actor_index
	; }
; -----------------------------
col_actor_calc_dir_check:
	lda	obj_id_actor, x
	cmp	#actor::piranha_plant
	beq	:++

	.if	.defined(SMB2M)
		cmp	#actor::piranha_plant_b
		beq	:++
	.endif

	cmp	#actor::lakitu
	beq	:++
	cmp	#actor::hammer_bro
	beq	:++
	cmp	#actor::spiny
	beq	:+
	cmp	#actor::koopa_para_jump_green
	beq	:+
	cmp	#actor::blooper
	bcs	:++
	: ; if (actor.id.in(piranha_plant, lakitu, hammer_bro, spiny, koopa_para_jump_green) || actor.id < blooper && (!SMB2M || actor.id != piranha_plant_b)) {
	col_actor_reverse:
		lda	veloc_x_actor, x
		eor	#<-1
		tay
		iny
		sty	veloc_x_actor, x
		lda	motion_dir_actor, x
		eor	#DIR_MASK
		sta	motion_dir_actor, x
	: ; }

	rts
; ------------------------------------------------------------
	.export col_plat_l_proc
col_plat_l_proc:
	lda	#%11111111
	sta	actor_plat_col_flag, x
	lda	game_timer_stop
	bne	:++
	lda	state_actor, x
	bmi	:++
	lda	obj_id_actor, x
	cmp	#actor::plat_start
	bne	:+ ; if (!game_timer_stop && !(actor.state & 0x80) && actor.id == plat_start) {
		lda	state_actor, x
		tax
		jsr	:+
	: ; }
; -----------------------------
	jsr	col_check_player_pos_y
	bcs	:+ ; if (!col_check_player_pos_y()) {
		txa
		jsr	col_actor_box_get_do
		lda	pos_y_lo_actor, x
		sta	zp_byte_00
		txa
		pha
		jsr	col_base_player
		pla
		tax
		bcc	:+ ; if () {
			jsr	col_plat_l_do
		; }
	: ; }

	ldx	actor_index
	rts
; ------------------------------------------------------------
col_plat_s_proc_idx	= zp_byte_00

	.export col_plat_s_proc
col_plat_s_proc:
	lda	game_timer_stop
	bne	:+++
	sta	actor_plat_col_flag, x
	jsr	col_check_player_pos_y
	bcs	:+++ ; if (!game_timer_stop && !col_check_player_pos_y()) {
		lda	#2
		sta	col_plat_s_proc_idx
		: ; for (i = 2; i > 0; i--) {
			ldx	actor_index
			jsr	col_actor_box_get
			and	#%00000010
			bne	:++ ; if (!(col_actor_box_get() & 0x02)) {
				lda	pos_y_col_box_nw, y
				cmp	#32
				bcc	:+ ; if (col_box_nw.pos_y >= 32) {
					jsr	col_base_player
					bcs	col_plat_do
				: ; }

				lda	pos_y_col_box_nw, y
				clc
				adc	#<-128
				sta	pos_y_col_box_nw, y
				lda	pos_y_col_box_se, y
				clc
				adc	#<-128
				sta	pos_y_col_box_se, y
	
				dec	col_plat_s_proc_idx
				bne	:--
			; } else break;
		; }
	: ; }

	ldx	actor_index
	rts
; ------------------------------------------------------------
col_plat_do:
	ldx	actor_index
; -----------------------------
col_plat_l_do:
	lda	pos_y_col_box_se, y
	sec
	sbc	pos_y_col_box_nw
	cmp	#4
	bcs	:+
	lda	veloc_y_player
	bpl	:+ ; if ((col_box_se_y.pos_y - col_box_nw.pos_y) < 4 && player.veloc_y < 0) {
		lda	#1
		sta	veloc_y_player
	: ; }

	lda	pos_y_col_box_se
	sec
	sbc	pos_y_col_box_nw, y
	cmp	#6
	bcs	:+++
	lda	veloc_y_player
	bmi	:+++ ; if ((col_box_se.pos_y - col_box_nw_y.pos_y) < 6 && player.veloc_y >= 0) {
		lda	zp_byte_00
		ldy	obj_id_actor, x
		cpy	#actor::plat_s_up
		beq	:+
		cpy	#actor::plat_s_down
		beq	:+ ; if (actor.id.not_in(plat_s_up, plat_s_down)) {
			txa
		: ; }
	
		ldx	actor_index

		.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
			:
		.elseif	.defined(ANN)
			pha

			lda	pos_y_hi_player
			cmp	#1
			bne	:+
			lda	pos_y_lo_player
			cmp	#223
			bcc	:+ ; if (player.pos_y >= 479) {
				pla
				rts
			: ; } else {
				pla
			; }
		.endif

		; if (!ANN || player.pos_y < 479) {
			sta	actor_plat_col_flag, x
			lda	#0
			sta	state_player
		; }

		rts
	: ; } else {
		lda	#DIR_RIGHT
		sta	col_bg_proc_player_halt_dir
		lda	pos_x_col_box_se
		sec
		sbc	pos_x_col_box_nw, y
		cmp	#8
		bcc	:+
		inc	col_bg_proc_player_halt_dir
		lda	pos_x_col_box_se, y
		clc
		sbc	pos_x_col_box_nw
		cmp	#9
		bcs	:++
		: ; if ((col_box_se.pos_x - col_box_nw_y.pos_x) < 8 || (col_box_se_y.pos_x - col_box_nw.pos_x) < 9) {
			jsr	col_bg_proc_player_halt
		: ; }
	
		ldx	actor_index

		rts
	; }
; ------------------------------------------------------------
col_plat_s_pos_offsets:
	.byte	<-128, 0
; -----------------------------
	.export col_plat_s_player_pos, col_plat_player_pos
col_plat_s_player_pos:
	tay
	lda	pos_y_lo_actor, x
	clc
	adc	col_plat_s_pos_offsets-1, y
.if	.defined(SMB)|.defined(SMB2M)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS_SMB)
	jmp	col_plat_player_pos_do
.endif
; -----------------------------
col_plat_player_pos:
	lda	pos_y_lo_actor, x

col_plat_player_pos_do:
	ldy	proc_id_player
	cpy	#player_procs::death
	beq	:+
	ldy	pos_y_hi_actor, x
	cpy	#1
	bne	:+ ; if (game.proc_id != death && actor.pos_y.hi == 1) {
		sec
		sbc	#32
		sta	pos_y_lo_player
		tya
		sbc	#0
		sta	pos_y_hi_player
		lda	#0
		sta	veloc_y_player
		sta	accel_y2_player
	: ; }

	rts
; ------------------------------------------------------------
COL_CHECK_PLAYER_POS_Y_CUTOFF	= 208
; ------------------------------------------------------------
col_check_player_pos_y:
	lda	bits_offscr_player

	.if	.defined(SMB)|.defined(VS_SMB)
		cmp	#%11110000
		bcs	:+
		ldy	pos_y_hi_player
		dey
		bne	:+
		lda	pos_y_lo_player
		cmp	#COL_CHECK_PLAYER_POS_Y_CUTOFF
		:
	.elseif	.defined(SMB2M)
		and	#%11110000
		clc
		beq	:+ ; if ((player.bits_offscr & 0xF0)) {
			sec
		: ; }
	.endif

	rts
; ------------------------------------------------------------
col_actor_box_get:
	lda	actor_index

col_actor_box_get_do:
	asl	a
	asl	a
	clc
	adc	#(1*4)
	tay
	lda	bits_offscr_actor
	and	#%00001111
	cmp	#%00001111
	rts
; ------------------------------------------------------------
col_bg_proc_player_pos_y_block_cutoff:
	.byte	32, 16
; -----------------------------
	.export col_bg_proc
col_bg_proc:
	lda	col_disable
	bne	col_bg_proc_rts
	lda	proc_id_player
	cmp	#player_procs::death
	beq	col_bg_proc_rts
	cmp	#player_procs::pole
	bcc	col_bg_proc_rts ; if (!col_disable && proc_id_player != death && proc_id_player >= pole) {
		lda	#player_state::jump_swim
		ldy	player_swimming
		bne	:++
		lda	state_player
		beq	:+
		cmp	#player_state::climb
		bne	:+++
		: ; if (player.state.in(ground, climb, swim)) {
			; if (player.state != swim) {
				lda	#player_state::fall
			: ; }
		
			sta	state_player
		: ; }
	
		lda	pos_y_hi_player
		cmp	#1
		bne	col_bg_proc_rts ; if (player.pos_y.hi == 1) 
			lda	#%11110000|(COL_TOP|COL_BOTTOM|COL_LEFT|COL_RIGHT)
			sta	collision_player

			lda	pos_y_lo_player
			cmp	#COL_CHECK_PLAYER_POS_Y_CUTOFF-1 ; if (player.pos_y.lo < (COL_CHECK_PLAYER_POS_Y_CUTOFF - 1)) {
				bcc	col_bg_proc_do
			; }
		; }
	col_bg_proc_rts: ; }

	rts
; -----------------------------
col_bg_proc_do:
	ldy	#(col_bg_buffer_offset_end-col_bg_buffer_offset)-1
	lda	player_crouching
	bne	:+
	lda	player_size
	bne	:+ ; if (!player.crouching && player.size == large) {
		dey

		lda	player_swimming
		bne	:+ ; if (!player.swimming) {
			dey
		; }
	: ; }
	lda	col_bg_buffer_offset, y
	sta	zp_addr_EB
	tay

	ldx	player_size
	lda	player_crouching
	beq	:+ ; if (player.crouching) {
		inx
	: ; }
	lda	pos_y_lo_player
	cmp	col_bg_proc_player_pos_y_block_cutoff, x
	bcc	:+++
	jsr	col_box_player_jump
	beq	:+++
	jsr	col_bg_proc_coin_check
	bcs	:++++
	ldy	veloc_y_player
	bpl	:+++
	ldy	col_box_buffer_tbl_offset
	cpy	#4
	bcc	:+++ ; if (
	;	player.pos_y >= cutoff[crouch]
	;	&& col_box_player_jump()
	;	&& !tile.is_coin
	;	&& player.veloc_y < 0
	; 	&& col_box_buffer_tbl_offset >= 4
	; ) {
		jsr	col_bg_proc_solid_check
		bcs	:+
		ldy	course_type
		beq	:++
		ldy	timer_block_bounce
		bne	:++ ; if (!col_bg_proc_solid_check() && course_type != water && timer_block_bounce == 0) {
			jsr	block_punch
	
			jmp	:+++
		: cmp	#metatile_0::climb_blank
		beq	:+ ; } else if (col_bg_proc_solid_check() != climb_blank) {
			; if (course_type != water && timer_block_bounce == 0) {
				lda	#sfx_pulse_1::bump
				sta	apu_sfx_pulse_1_req
			: ; }
	
			.ifndef	PAL
				lda	#1
				sta	veloc_y_player
			.else
				ldy	#1
				lda	course_type
				bne	col_bg_proc_not_water ; if (course.type == underwater) {
					dey
			col_bg_proc_not_water: ; }
				sty	veloc_y_player
			.endif
		; }
	: ; }

	; if (!tile.is_coin) {
		ldy	zp_addr_EB
		lda	pos_y_lo_player
		cmp	#COL_CHECK_PLAYER_POS_Y_CUTOFF-1
		bcs	col_bg_proc_side ; if (player.pos_y.lo < cutoff-1) {
			jsr	col_box_player_step

			jsr	col_bg_proc_coin_check
			bcs	:+ ; if (!col_bg_proc_coin_check()) {
				pha
	
				jsr	col_box_player_step
				sta	zp_byte_00

				pla
				sta	zp_byte_01
				bne	col_bg_proc_ground_type
				lda	zp_byte_00 ; if (!col_box_player_step()) {
					beq	col_bg_proc_side
				; }
				jsr	col_bg_proc_coin_check ; if (!tile.is_coin) {
					bcc	col_bg_proc_ground_type
				; }
			; }
		; } else col_bg_proc_side();
	: ; }

	jmp	col_bg_proc_coin_do
; -----------------------------
col_bg_proc_ground_type:
	jsr	col_bg_proc_climb_check
	bcs	:++++
	ldy	veloc_y_player
	bmi	:++++ ; if (!tile.is_climbable && player.veloc_y >= 0) {
		cmp	#metatile_3::axe
		bne	:+ ; if (tile == axe) {
			jmp	col_bg_proc_axe_do
		: ; }
		jsr	col_bg_proc_vis
		beq	:+++ ; if (tile.is_visible) {
			ldy	player_on_spring
			bne	:++ ; if (!player.on_spring) {
				ldy	col_box_buffer_tbl_offset
				cpy	#GROUND_PROC_LIMIT
				bcc	:+ ; if (col_box_buffer_tbl_offset >= 5) {
					lda	motion_dir_player
					sta	col_bg_proc_player_halt_dir
					jmp	col_bg_proc_player_halt
				: ; }
			
				jsr	col_bg_proc_spring

				lda	#CLAMP_16
				and	pos_y_lo_player
				sta	pos_y_lo_player

				jsr	col_bg_proc_pipe_v_do

				lda	#0
				sta	veloc_y_player
				sta	accel_y2_player
				sta	counter_stomps
			: ; }
		
			lda	#player_state::ground
			sta	state_player
		; }
	: ; }
; -----------------------------
SIDE_REPS	= 2

col_bg_proc_side_rep	= zp_byte_00

col_bg_proc_side:
	ldy	zp_addr_EB
	iny
	iny
	lda	#SIDE_REPS
	sta	col_bg_proc_side_rep
	: ; for (side of sides) {
		iny
		sty	zp_addr_EB
		lda	pos_y_lo_player
		cmp	#32
		bcc	:+
		cmp	#228
		bcs	:++
		jsr	col_box_player_back
		beq	:+
		cmp	#metatile_0::pipe_h_a
		beq	:+
		cmp	#metatile_1::pipe_water_a
		beq	:+
		jsr	col_bg_proc_climb_check
		bcc	col_bg_proc_side_do
		: ; if ((player.pos_y < 32 || (player.pos_y < 228 && (tile.in(blank_a_0, pipe_h_a, pipe_water_a) || tile.can_climb))) {
			ldy	zp_addr_EB
			iny
			lda	pos_y_lo_player
			cmp	#8
			bcc	:+
			cmp	#COL_CHECK_PLAYER_POS_Y_CUTOFF
			bcs	:+ ; if (player.pos_y >= 8 && player.pos_y < cutoff) {
				jsr	col_box_player_back ; if (col_box_player_back()) {
					bne	col_bg_proc_side_do
				; }

				dec	col_bg_proc_side_rep
				bne	:--
			; }
		; } else col_bg_proc_side_do();
	: ; }

	rts
; -----------------------------
col_bg_proc_side_do:
	jsr	col_bg_proc_vis
	beq	:++++++++ ; if (tile.is_visible) {
		jsr	col_bg_proc_climb_check
		bcc	:+
		jmp	col_bg_proc_climb_do
		: ; } if (!tile.can_climb) {
			jsr	col_bg_proc_coin_check
			bcs	col_bg_proc_coin_do ; if (!tile.is_coin) {
				jsr	col_bg_proc_spring_check
				bcc	:+
				lda	player_on_spring
				bne	:+++++++ ; if (tile.is_spring && !player.on_spring) {
					jmp	:++++++
				: ldy	state_player
				cpy	#player_state::ground
				bne	:+++++
				ldy	disp_dir_player
				dey
				bne	:+++++
				cmp	#metatile_1::pipe_water_b
				beq	:+
				cmp	#metatile_0::pipe_h_d
				bne	:+++++
				: ; } else if (player.state == ground && player.disp_dir == right && tile.in(pipe_h_d, pipe_water_b)) {
					lda	attr_player
					bne	:+ ; if (player.priority_high || player.flipped) {
						ldy	#sfx_pulse_1::pipe_entry_16
						sty	apu_sfx_pulse_1_req
					: ; }
					ora	#obj_attr::priority_low
					sta	attr_player
				
					lda	pos_x_lo_player
					and	#MOD_16
					beq	:++ ; if ((player.pos_x % 16)) {
						ldy	#0
						lda	pos_x_hi_screen_left
						beq	:+ ; if (screen_left.pos_x.hi != 0) {
							iny
						: ; }
						lda	col_bg_timer_scene_trans, y
						sta	timer_scene_trans
					: ; }
				
					lda	proc_id_player
					cmp	#player_procs::enter
					beq	:++
					cmp	#player_procs::ctrl
					bne	:++ ; if (game.proc_id == ctrl) {
						lda	#player_procs::pipe_h
						sta	proc_id_player
						rts
					; }
				: ; }
			
				; if (!tile.is_spring || !player.on_spring) {
					jsr	col_bg_proc_player_halt
				: ; }
		
				rts
			; } else col_bg_proc_coin_do();
		; } else col_bg_proc_climb_do();
	; } else rts;
; -----------------------------
col_bg_timer_scene_trans:
	.ifndef	PAL
		.byte	160, 52
	.else
		.byte	133, 43
	.endif
; -----------------------------
col_bg_proc_coin_do:
	jsr	col_bg_proc_bg_tile_blank
	inc	game_bonus_counter
	jmp	misc_proc_coin_add
; -----------------------------
AXE_PLAYER_VELOC_X	= 24

col_bg_proc_axe_do:
	lda	#victory_modes::bowser
	sta	proc_id_game
	lda	#system_modes::victory
	sta	proc_id_system

	.if	.defined(SMB2M)
		jsr	player_phys_load_default
	.endif

	lda	#AXE_PLAYER_VELOC_X
	sta	veloc_x_player
; -----------------------------
col_bg_proc_bg_tile_blank:
	ldy	col_buffer_ptr_idx
	lda	#metatile_0::blank_a
	sta	(game_buffer), y
	jmp	gfx_clear_small
; -----------------------------
col_bg_proc_climb_offset_x_lo:
	.byte	<-7, 7

col_bg_proc_climb_offset_x_hi:
	.byte	<-1, 0

col_bg_proc_pole_cutoffs_y:
	.byte	24, 34, 80, 104, 144
col_bg_proc_pole_cutoffs_y_end:
; -----------------------------
.if	.defined(SMB)|.defined(SMB2M)
CLIMB_POS_X	= pos_x_lo_player
CLIMB_DIR_BOUND	= 16
.elseif	.defined(VS_SMB)
CLIMB_POS_X	= pos_x_lo_actor+(ENG_ACTOR_MAX-1)
CLIMB_DIR_BOUND	= 10
.endif

col_bg_proc_climb_do:
	ldy	col_box_buffer_tbl_offset
	cpy	#6
	bcc	:+
	cpy	#10
	bcc	:++
	: rts
	: ; if (col_box_buffer_tbl_offset >= 6 && col_box_buffer_tbl_offset < 10) {
		cmp	#metatile_0::flag_ball
		beq	:+
		cmp	#metatile_0::pole
		bne	:++++++
		: lda	proc_id_player
		cmp	#player_procs::victory
		beq	:++++++ ; if (tile.in(flag_ball, pole) && game.proc_id != victory) {
			lda	#DIR_RIGHT
			sta	disp_dir_player
			inc	game_scroll_lock

			lda	proc_id_player
			cmp	#player_procs::pole
			beq	:++++ ; if (game.proc_id != pole) {
				lda	#actor::bullet
				jsr	bg_actor_kill
				lda	#music_event::none
				sta	apu_music_event_req
				lsr	a
				sta	music_event_goal_flag

				ldx	#(col_bg_proc_pole_cutoffs_y_end-col_bg_proc_pole_cutoffs_y)-1
				lda	pos_y_lo_player
				sta	pos_y_goal
				: ; for (cutoff of cutoffs) {
					cmp	col_bg_proc_pole_cutoffs_y, x
					bcs	:+
			
					dex
					bne	:-
				: ; }
				stx	render_flag_score_val
			: ; }

			.if	.defined(SMB2M)
				lda	stats_coin_player_end-2
				cmp	stats_coin_player_end-1
				bne	:+
				cmp	stats_time_end-STATS_TIME_LEN+2
				bne	:+ ; if (player.coin.digit_second == player.coin.digit_last && time.digit_2 == 0) {
					lda	#FLAG_SCORE_VALUE_ONEUP
					sta	render_flag_score_val
				; }
			.endif
			:
		
			lda	#player_procs::pole
			sta	proc_id_player

			jmp	:++
		: cmp	#metatile_0::climb_blank
		bne	:+
		lda	pos_y_lo_player
		cmp	#32
		bcs	:+ ; } else if (tile == climb_blank && player.pos_y < 32) {
			lda	#player_procs::vine
			sta	proc_id_player
		: ; }
	
		lda	#player_state::climb
		sta	state_player
		lda	#0
		sta	veloc_x_player
		sta	veloc_x_player_hi

		lda	CLIMB_POS_X
		sec
		sbc	pos_x_lo_screen_left
		cmp	#CLIMB_DIR_BOUND
		bcs	:+ ; if ((climb.pos_x - screen_left.pos_x) < bound) {
			lda	#DIR_LEFT
			sta	disp_dir_player
		: ; }
	
		ldy	disp_dir_player
		lda	game_buffer
		asl	a
		asl	a
		asl	a
		asl	a
		clc
		adc	col_bg_proc_climb_offset_x_lo-1, y
		sta	pos_x_lo_player

		lda	game_buffer
		bne	:+ ; if (!(game_buffer % 256)) {
			lda	pos_x_hi_screen_right
			clc
			adc	col_bg_proc_climb_offset_x_hi-1, y
			sta	pos_x_hi_player
		: ; }
	
		rts
	; } else rts;
; ------------------------------------------------------------
col_bg_proc_vis:
	.if	.defined(SMB2)
		cmp	#metatile_1::blank_e
		beq	:+
	.endif

	.if	.defined(SMB2M)
		cmp	#metatile_1::blank_d
		beq	:+
	.endif

	cmp	#metatile_1::blank_b
	beq	:+
	cmp	#metatile_1::blank_c
	: rts
; ------------------------------------------------------------
SPRING_ACCEL_Y_INIT	= 112
SPRING_ACCEL_TIMER	= 3

col_bg_proc_spring:
	jsr	col_bg_proc_spring_check
	bcc	:+ ; if (col_bg_proc_spring_check()) {
		lda	#SPRING_ACCEL_Y_INIT
		sta	accel_y_player

		.if	.defined(SMB2M)
			sta	accel_y_gravity
		.endif

		lda	#SPRING_ACCEL_Y_COL
		sta	accel_y_spring
		lda	#SPRING_ACCEL_TIMER
		sta	timer_spring
		lsr	a
		sta	player_on_spring
	: ; }

	rts
; ------------------------------------------------------------
col_bg_proc_spring_check:
	cmp	#metatile_1::spring_bg_a
	beq	:+
	cmp	#metatile_1::spring_bg_b
	clc
	bne	:++
	: ; if (tile.in(spring_bg_a, spring_bg_b)) {
		sec
	: ; }

	rts
; ------------------------------------------------------------
col_bg_proc_pipe_v_metatile_a	= zp_byte_00
col_bg_proc_pipe_v_metatile_b	= zp_byte_01

col_bg_proc_pipe_v_do:
	lda	joypad_u_d
	and	#joypad_button::down
	beq	:+++
	lda	col_bg_proc_pipe_v_metatile_a
	cmp	#metatile_0::pipe_v_b
	bne	:+++
	lda	col_bg_proc_pipe_v_metatile_b
	cmp	#metatile_0::pipe_v_a
	bne	:+++ ; if ((joypad_u_d & down) && zp_byte_00 == pipe_v_b && zp_byte_01 == pipe_v_a) {
		lda	#PIPE_TRANSITION_TIME
		sta	timer_scene_trans
		lda	#player_procs::pipe_v
		sta	proc_id_player
		lda	#sfx_pulse_1::pipe_entry_16
		sta	apu_sfx_pulse_1_req
		lda	#obj_attr::priority_low|obj_attr::color0
		sta	attr_player
		lda	game_warp_ctrl
		beq	:+++ ; if (game_warp_ctrl) {
			.if	.defined(SMB)|.defined(VS_SMB)
				PIPE_POS_MASK	= %00000011
			.elseif	.defined(SMB2)
				PIPE_POS_MASK	= %00001111
			.elseif	.defined(ANN)
				PIPE_POS_MASK	= %00000111
			.endif

			and	#PIPE_POS_MASK

			.if	.defined(SMBM)|.defined(VS_SMB)
				asl	a
				asl	a
			.endif
			
			tax

			.if	.defined(SMBM)|.defined(VS_SMB)
				lda	pos_x_lo_player
				cmp	#96
				bcc	:+ ; if (player.pos_x >= 96) {
					inx
	
					cmp	#160
					bcc	:+ ; if (player.pos_x >= 160) {
						inx
					; }
				; }
			.endif
			:

			.if	.defined(SMB)|.defined(VS_SMB)
				: ldy	screen_text_warps, x
			.elseif	.defined(SMB2M)
				lda	screen_text_warps, x

				ldy	ENG_HARDMODE_VAR
				beq	:+ ; if (hard_mode) {
					sec
					sbc	#9
				: ; }

				tay
			.endif

			dey
			sty	course_no
			ldx	courses_world_offsets, y
			lda	courses_area_offsets, x
			sta	course_descriptor

			lda	#music_event::none
			sta	apu_music_event_req
			lda	#0
			sta	pos_x_hi_init_game
			sta	course_sub
			sta	player_goals
			sta	game_start_type

			.if	.defined(SMB)|.defined(SMB2M)
				inc	bg_hidden_one_up_req
			.endif

			inc	player_first_start
		; }
	: ; }

	rts
; ------------------------------------------------------------
col_bg_proc_player_halt:
	lda	#0
	ldy	veloc_x_player
	ldx	col_bg_proc_player_halt_dir
	dex
	bne	:+
	inx
	cpy	#0
	bmi	:++++
	lda	#<-1
	jmp	:++
	: ldx	#2
	cpy	#1
	bpl	:+++ ; if () {
		; if () {
			lda	#1
		:  ;  ; }

		ldy	#16
		sty	timer_col_x
		ldy	#0
		sty	veloc_x_player
		cmp	#0
		bpl	:+ ; if (player.veloc_x <= 0) {
			dey
		: ; }
		sty	zp_byte_00
		clc
		adc	pos_x_lo_player
		sta	pos_x_lo_player
		lda	pos_x_hi_player
		adc	zp_byte_00
		sta	pos_x_hi_player
	: ; }

	txa
	eor	#<-1
	and	collision_player
	sta	collision_player
	rts
; ------------------------------------------------------------
col_bg_proc_tiles_solid:
	.byte	metatile_0::pipe_v_a
	.byte	metatile_1::stair
	.byte	metatile_2::cloud_small
	.byte	metatile_3::block_invis
; -----------------------------
col_bg_proc_solid_check:
	jsr	col_bg_proc_get_tile_page
	cmp	col_bg_proc_tiles_solid, x
	rts
; ------------------------------------------------------------
col_bg_proc_tiles_climb:
	.byte	metatile_0::flag_ball
	.byte	metatile_1::flag_ball
	.byte	metatile_2::end
	.byte	metatile_3::end
; -----------------------------
col_bg_proc_climb_check:
	jsr	col_bg_proc_get_tile_page
	cmp	col_bg_proc_tiles_climb, x
	rts
; ------------------------------------------------------------
col_bg_proc_coin_check:
	cmp	#metatile_3::coin_a
	beq	:+
	cmp	#metatile_3::coin_b
	beq	:+ ; if (!coin_a && !coin_b) {
		clc
		rts
	: ; } else {
		lda	#sfx_pulse_2::coin_01
		sta	apu_sfx_pulse_2_req
		rts
	; }
; ------------------------------------------------------------
col_bg_proc_get_tile_page:
	tay
	and	#TILE_PAGE_BITS
	asl	a
	rol	a
	rol	a
	tax
	tya
	: rts
; ------------------------------------------------------------
col_actor_side_col_states:
	.byte	actor_states::state_1
	.byte	actor_states::state_1
	.byte	actor_states::state_2
	.byte	actor_states::state_2
	.byte	actor_states::state_2
	.byte	actor_states::state_5

col_actor_stomp_veloc_x:
	.byte	16, <-16
; -----------------------------
	.export col_actor_ground_proc
col_actor_ground_proc:
	lda	state_actor, x
	and	#actor_states::bit_5
	bne	:-
	jsr	col_actor_pos_y_diff
	bcc	:-
	ldy	obj_id_actor, x
	cpy	#actor::spiny
	bne	:+
	lda	pos_y_lo_actor, x
	cmp	#37
	bcc	:-
	: ; if (!(actor.state & bit_5) && col_actor_pos_y_diff() && (actor.id != spiny || actor.pos_y >= 37)) {
		cpy	#actor::koopa_para_jump_green
		bne	:+ ; if (actor.id == koopa_para_jump_green) {
			jmp	col_actor_bounce_proc
		: cpy	#actor::hammer_bro
		bne	:+ ; } else if (actor.id == hammer_bro) {
			jmp	col_hammer_bro_block_check
			.if	.defined(SMB2M)
			col_actor_ground_proc_rts:
				rts
			.endif
		: cpy	#actor::spiny
		beq	:+
		cpy	#actor::power_up
		beq	:+
	
		.if	.defined(SMB2M)
			cpy	#actor::piranha_plant_b
			beq	col_actor_ground_proc_rts
		.endif

		cpy	#actor::blooper
		bcs	col_actor_ground_proc_rts
		: jsr	col_actor_block_col
		bne	:++
		: ; } else if ((actor.id.in(spiny, power_up) || actor.id < blooper) && (!col_actor_block_col() || !block.non_solid)) {
			jmp	col_actor_check_side
		: ; }

		jsr	col_bg_proc_check_non_solid
		beq	:--
		cmp	#metatile_0::blank_d
		bne	col_actor_land ; } else if (tile == blank_d) {
			.if	.defined(SMB)|.defined(VS_SMB)
				ldy	col_buffer_ptr_idx
				lda	#metatile_0::blank_a
				sta	(game_buffer), y
			.endif

			lda	obj_id_actor, x
			cmp	#actor::actors_page_b
			bcs	col_actor_koopa_demote_check ; if (actor.id < actors_page_b) {
				cmp	#actor::goomba
				bne	:+ ; if (actor.id == goomba) {
					jsr	col_actor_block_bump_kill
				: ; }
			
				lda	#scores::value_100
				jsr	col_score_do
			; } else col_actor_koopa_demote_check();
		; } else col_actor_land();
	; } else rts;
; -----------------------------
col_actor_koopa_demote_check:
	.if	.defined(SMB2M)
		lda	obj_id_actor, x
	.endif

	cmp	#actor::div_height
	bcc	:++
	cmp	#actor::lakitu
	bcs	:++

	.if	.defined(SMB2M)
		cmp	#actor::piranha_plant
		beq	:++
		cmp	#actor::piranha_plant_b
		beq	:++
	.endif

	cmp	#actor::cheep_grey
	bcc	:+
	cmp	#actor::piranha_plant
	bcc	:++
	: ; if ((actor.id >= div_height && actor.id < lakitu) && (actor.id < cheep_grey || actor.id >= piranha_plant)) {
		and	#actor::koopa_mask
		sta	obj_id_actor, x
	: ; }
; -----------------------------
col_player_actor_stomp_do:
	.if	.defined(SMB)|.defined(VS_SMB)
		lda	state_actor, x
		and	#<~(actor_states::bit_3|actor_states::state_mask)
		ora	#actor_states::state_2
		sta	state_actor, x
	.elseif	.defined(SMB2M)
		cmp	#actor::power_up
		beq	:+
		cmp	#actor::goomba
		beq	:+ 
		; if (actor.id.not_in(goomba, power_up)) {
			lda	#actor_states::state_2
			sta	state_actor, x
		: ; }
	.endif

	dec	pos_y_lo_actor, x
	dec	pos_y_lo_actor, x

	lda	obj_id_actor, x
	cmp	#actor::blooper
	beq	:+
	lda	#<-3
	ldy	course_type
	bne	:++
	: ; if (actor.id == blooper || course_type == water) {
		lda	#<-1
	: ; }
	sta	veloc_y_actor, x

	ldy	#DIR_RIGHT
	jsr	col_player_bullet_diff
	bpl	:+ ; if (col_player_bullet_diff() < 0) {
		iny
	: ; }
	lda	obj_id_actor, x
	cmp	#actor::bullet
	beq	:+
	cmp	#actor::bullet_swarm
	beq	:+ ; if (actor.id.not_in(bullet, bullet_swarm)) {
		sty	motion_dir_actor, x
	: ; }
	dey
	lda	col_actor_stomp_veloc_x, y
	sta	veloc_x_actor, x

.if	.defined(SMB)|.defined(VS_SMB)
col_actor_ground_proc_rts:
.endif
	rts
; -----------------------------
col_actor_land:
	lda	col_box_buffer_tbl_offset
	sec
	sbc	#8
	cmp	#5
	bcs	col_actor_check_side
	lda	state_actor, x
	and	#actor_states::bit_6
	bne	col_actor_land_init
	lda	state_actor, x
	asl	a
	bcc	:++
	: ; if ((col_box_buffer_tbl_offset - 8) < 5 && !(actor.state & bit_6) && ((actor.state & spawned) || actor.state == init)) {
		jmp	col_actor_check_side_do
	: ; }
	lda	state_actor, x
	beq	:--
	cmp	#actor_states::state_5
	beq	col_actor_land_dir
	cmp	#actor_states::state_3
	bcs	:++
	lda	state_actor, x
	cmp	#actor_states::state_2
	bne	col_actor_land_dir ; } else if (actor.state == state_2) {
		lda	#16
		ldy	obj_id_actor, x
		cpy	#actor::spiny
		bne	:+ ; if (actor.id == spiny) {
			lda	#0
		: ; }
		sta	timer_actor, x
	
		lda	#actor_states::state_3
		sta	state_actor, x
		jsr	col_actor_land_do
	: ; }

	rts
; -----------------------------
col_actor_land_dir:
	lda	obj_id_actor, x
	cmp	#actor::goomba
	beq	:+++
	cmp	#actor::spiny
	bne	:+ ; if (actor.id == spiny) {
		lda	#DIR_RIGHT
		sta	motion_dir_actor, x
		lda	#8
		sta	veloc_x_actor, x

		lda	frame_count	
		and	#MOD_8
		beq	:+++
	; }
	: ; if (obj_id_actor == 6 || (obj_id_actor == 0x12 && (frame_count % 8))) {
		ldy	#DIR_RIGHT
		jsr	col_player_bullet_diff
		bpl	:+ ; if (col_player_bullet_diff() < 0) {
			iny
		: ; }
		tya
		cmp	motion_dir_actor, x
		bne	:+ ; if (calced_dir == actor.motion_dir) {
			jsr	col_actor_check_side_bump
		; }
	: ; }
; -----------------------------
col_actor_land_init:
	jsr	col_actor_land_do
	lda	state_actor, x
	and	#actor_states::spawned
	bne	:+ ; if (actor.spawned) {
		lda	#actor_states::init
		sta	state_actor, x
		rts
	: ; } else {
		lda	state_actor, x
		and	#<~actor_states::bit_6
		sta	state_actor, x
		rts
	; }
; ------------------------------------------------------------
col_actor_check_side:
	lda	obj_id_actor, x
	cmp	#actor::koopa_red
	bne	:+
	lda	state_actor, x
	beq	col_actor_check_side_bump
	: ; if (actor.id != koopa_red || actor.state != init) {
		lda	state_actor, x
		tay
		asl	a
		bcc	:+ ; if (actor.spawned) {
			lda	state_actor, x
			ora	#actor_states::bit_6
	
			jmp	:++
		: ; } else {
			lda	col_actor_side_col_states, y
		: ; }
		sta	state_actor, x

	col_actor_check_side_do:
		lda	pos_y_lo_actor, x
		cmp	#32
		bcc	:+++ ; if (actor.pos_y >= 32) {
			ldy	#$16
			lda	#DIR_LEFT
			sta	zp_byte_EB
			: ; for (y = 0x16; y < 0x18; y++) {
				lda	zp_byte_EB
				cmp	motion_dir_actor, x
				bne	:+
				lda	#$01
				jsr	col_box_buffer_check_actor
				beq	:+ ; if (actor.motion_dir == zp_byte_EB && col_box_buffer_check_actor()) {
					jsr	col_bg_proc_check_non_solid ; if (col_bg_proc_check_non_solid()) {
						bne	col_actor_check_side_bump
					; }
				: ; }
		
				dec	zp_byte_EB
				iny
				cpy	#$18
				bcc	:--
			; }
		: ; }
	
		rts
	; }
; ------------------------------------------------------------
col_actor_check_side_bump:
	cpx	#ENG_ACTOR_MAX-1
	beq	:+
	lda	state_actor, x
	asl	a
	bcc	:+ ; if (actor.idx != last && actor.spawned) {
		lda	#sfx_pulse_1::bump
		sta	apu_sfx_pulse_1_req
	: ; }

	lda	obj_id_actor, x
	cmp	#actor::hammer_bro
	bne	:+ ; if () {
		lda	#0
		sta	zp_byte_00
		ldy	#<-6
		jmp	actor_proc_hammer_bro_jump_do
	: ; } else {
		jmp	col_actor_reverse
	; }
; ------------------------------------------------------------
	.export col_player_bullet_diff
col_player_bullet_diff:
	lda	pos_x_lo_actor, x
	sec
	sbc	pos_x_lo_player
	sta	col_player_bullet_diff_pos_x_rel
	lda	pos_x_hi_actor, x
	sbc	pos_x_hi_player
	rts
; ------------------------------------------------------------
col_actor_land_do:
	jsr	actor_init_veloc_y
	lda	pos_y_lo_actor, x
	and	#CLAMP_16
	ora	#%00001000
	sta	pos_y_lo_actor, x
	rts
; ------------------------------------------------------------
col_actor_pos_y_diff:
	lda	pos_y_lo_actor, x
	clc
	adc	#62
	cmp	#68
	rts
; ------------------------------------------------------------
	.export col_actor_bounce_proc
col_actor_bounce_proc:
	jsr	col_actor_pos_y_diff
	bcc	:+
	lda	veloc_y_actor, x
	clc
	adc	#2
	cmp	#3
	bcc	:+
	jsr	col_actor_block_col
	beq	:+
	jsr	col_bg_proc_check_non_solid
	beq	:+ ; if (col_actor_pos_y_diff() && (actor.veloc_y + 2) >= 3 && col_actor_block_col() && col_bg_proc_check_non_solid()) {
		jsr	col_actor_land_do
		lda	#<-3
		sta	veloc_y_actor, x
	: ; }

	jmp	col_actor_check_side_do
; ------------------------------------------------------------
col_hammer_bro_block_check:
	jsr	col_actor_block_col
	beq	col_actor_fall
	cmp	#metatile_0::blank_d
	bne	col_actor_fall_check
; -----------------------------
col_actor_block_bump_kill:
	jsr	col_actor_kill
	lda	#<-4
	sta	veloc_y_actor, x
	rts
; -----------------------------
col_actor_fall_check:
	lda	timer_ani_actor, x
	bne	col_actor_fall ; if () {
		lda	state_actor, x
		and	#(actor_states::spawned|actor_states::bit_3)
		sta	state_actor, x
		jsr	col_actor_land_do
		jmp	col_actor_check_side_do
	; } else col_actor_fall();
; ------------------------------------------------------------
col_actor_fall:
	lda	state_actor, x
	ora	#actor_states::state_1
	sta	state_actor, x
	rts
; ------------------------------------------------------------
col_actor_block_col:
	lda	#$00
	ldy	#$15
	jmp	col_box_buffer_check_actor
; ------------------------------------------------------------
col_bg_proc_check_non_solid:
	cmp	#metatile_0::climb_blank
	beq	:+
	cmp	#metatile_3::coin_a
	beq	:+
	cmp	#metatile_3::coin_b
	beq	:+

	.if	.defined(SMB2)
		cmp	#metatile_1::blank_e
		beq	:+
	.endif

	.if	.defined(SMB2M)
		cmp	#metatile_1::blank_d
		beq	:+
	.endif

	cmp	#metatile_1::blank_b
	beq	:+
	cmp	#metatile_1::blank_c
	: rts
; ------------------------------------------------------------
	.export col_proj_proc
col_proj_proc:
	lda	pos_y_lo_proj, x
	cmp	#24
	bcc	:+
	jsr	col_box_buffer_check_proj
	beq	:+
	jsr	col_bg_proc_check_non_solid
	beq	:+
	lda	veloc_y_proj, x
	bmi	:++
	lda	proj_bounce_flag, x
	bne	:++ ; if () {
		lda	#<-3
		sta	veloc_y_proj, x
		lda	#1
		sta	proj_bounce_flag, x
		lda	pos_y_lo_proj, x
		and	#CLAMP_8
		sta	pos_y_lo_proj, x
		rts
	: ; } else if () {
		lda	#0
		sta	proj_bounce_flag, x
		rts
	: ; } else {
		lda	#proj_states::bit_7
		sta	state_proj, x
		lda	#sfx_pulse_1::bump
		sta	apu_sfx_pulse_1_req
		rts
	; }
; ------------------------------------------------------------
	.export col_box_tbl
	.export col_box_0, col_box_1
	.export col_box_2, col_box_3
	.export col_box_4, col_box_5
	.export col_box_6, col_box_7
	.export col_box_8, col_box_9
	.export col_box_10, col_box_11
col_box_tbl:
col_box_0:
	.byte	2, 8, 14, 32
col_box_1:
	.byte	3, 20, 13, 32
col_box_2:
	.byte	2, 20, 14, 32
col_box_3:
	.byte	2, 9, 14, 21
col_box_4:
	.byte	0, 0, 24, 6
col_box_5:
	.byte	0, 0, 32, 13
col_box_6:
	.byte	0, 0, 48, 13
col_box_7:
	.byte	0, 0, 8, 8
col_box_8:
	.byte	6, 4, 10, 8
col_box_9:
	.byte	3

	.ifndef	PAL
		.byte	14
	.else
		.byte	12
	.endif

	.byte	13

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	20
	.elseif	.defined(SMB2M)
		.byte	22
	.endif
col_box_10:
	.byte	0, 2, 16, 21
col_box_11:
	.byte	4, 4, 12, 28
; -----------------------------
	.export col_proj_box, col_misc_box
col_proj_box:
	txa
	clc
	adc	#$07
	tax
	ldy	#$02

	bne	col_box_proc_basic
; -----------------------------
col_misc_box:
	txa
	clc
	adc	#$09
	tax
	ldy	#$06
; -----------------------------
col_box_proc_basic:
	jsr	col_box_proc
	jmp	col_box_screen_right
; ------------------------------------------------------------
col_box_w_bits_mask		= zp_byte_00
col_box_w_bits_offset_x_lo	= zp_byte_01

	.export col_actor_box, col_plat_s_box
col_actor_box:
	ldy	#$48
	sty	col_box_w_bits_mask
	ldy	#$44

	jmp	col_box_w_bits
; -----------------------------
col_plat_s_box:
	ldy	#$08
	sty	col_box_w_bits_mask
	ldy	#$04
; -----------------------------
col_box_w_bits:
	lda	pos_x_lo_actor, x
	sec
	sbc	pos_x_lo_screen_left
	sta	col_box_w_bits_offset_x_lo
	lda	pos_x_hi_actor, x
	sbc	pos_x_hi_screen_left
	bmi	:+
	ora	col_box_w_bits_offset_x_lo
	beq	:+ ; if ((actor.pos_x - screen_left.pos_x) >= 0) {
		ldy	col_box_w_bits_mask
	: ; }
	tya
	and	bits_offscr_actor
	sta	actor_bits_mask, x
	bne	col_box_offscr
	jmp	col_box_actor_offset
; -----------------------------
	.export col_plat_l_box
col_plat_l_box:
	inx
	jsr	lib_bits_get_do_x
	dex
	cmp	#$FE
	bcs	col_box_offscr

col_box_actor_offset:
	txa
	clc
	adc	#1
	tax
	ldy	#1
	jsr	col_box_proc
	jmp	col_box_screen_right
; -----------------------------
col_box_offscr:
	txa
	asl	a
	asl	a
	tay
	lda	#$FF
	sta	pos_x_col_box_nw_actor, y
	sta	pos_y_col_box_nw_actor, y
	sta	pos_x_col_box_se_actor, y
	sta	pos_y_col_box_se_actor, y
	rts
; --------------------------------------------------------------
col_box_proc_box_idx		= zp_byte_00
col_box_proc_pos_x_rel_player	= zp_byte_01
col_box_proc_pos_y_rel_player	= zp_byte_02
	.export col_box_proc
col_box_proc:
	stx	col_box_proc_box_idx
	lda	pos_y_rel_player, y
	sta	col_box_proc_pos_y_rel_player
	lda	pos_x_rel_player, y
	sta	col_box_proc_pos_x_rel_player
	txa
	asl	a
	asl	a
	pha
	tay
	lda	col_box_player, x
	asl	a
	asl	a
	tax
	lda	col_box_proc_pos_x_rel_player
	clc
	adc	col_box_tbl, x
	sta	pos_x_col_box_nw, y
	lda	col_box_proc_pos_x_rel_player
	clc
	adc	col_box_tbl+2, x
	sta	pos_x_col_box_se, y
	inx
	iny
	lda	col_box_proc_pos_y_rel_player
	clc
	adc	col_box_tbl, x
	sta	pos_x_col_box_nw, y
	lda	col_box_proc_pos_y_rel_player
	clc
	adc	col_box_tbl+2, x
	sta	pos_x_col_box_se, y
	pla
	tay
	ldx	col_box_proc_box_idx
	rts
; ------------------------------------------------------------
col_box_screen_right_offset_x_hi	= zp_byte_01
col_box_screen_right_offset_x_lo	= zp_byte_02

col_box_screen_right:
	lda	pos_x_lo_screen_left
	clc
	adc	#<-128
	sta	col_box_screen_right_offset_x_lo
	lda	pos_x_hi_screen_left
	adc	#0
	sta	col_box_screen_right_offset_x_hi
	lda	pos_x_lo_player, x
	cmp	col_box_screen_right_offset_x_lo
	lda	pos_x_hi_player, x
	sbc	col_box_screen_right_offset_x_hi
	bcc	:+++ ; if () {
		lda	pos_x_col_box_se, y
		bmi	:++ ; if (col_box_se.pos_x >= 0) {
			lda	#255
		
			ldx	pos_x_col_box_nw, y
			bmi	:+ ; if (col_bx_nw.pos_x >= 0) {
				sta	pos_x_col_box_nw, y
			: ; }
		
			sta	pos_x_col_box_se, y
		: ; }
	
		ldx	actor_index
		rts
	: ; } else {
		lda	pos_x_col_box_nw, y
		bpl	:++
		cmp	#160
		bcc	:++ ; if (col_bx_nw.pos_x >= 160) {
			lda	#0
	
			ldx	pos_x_col_box_se, y
			bpl	:+ ; if (col_box_se.pos_x < 0) {
				sta	pos_x_col_box_se, y
			: ; }
	
			sta	pos_x_col_box_nw, y
		: ; }
	
		ldx	actor_index
		rts
	; }
; ------------------------------------------------------------
COL_BASE_SIDE_COUNT	= 2
; ------------------------------------------------------------
col_base_actor_b_index	= zp_byte_06
col_base_box_side	= zp_byte_07

col_base_player:
	ldx	#0

col_base_actor:
	sty	col_base_actor_b_index
	lda	#COL_BASE_SIDE_COUNT-1
	sta	col_base_box_side
	: ; for (i = COL_BASE_SIDE_COUNT-1; i >= 0; i--) {
		lda	pos_x_col_box_nw, y
		cmp	pos_x_col_box_nw, x
		bcs	:++
		cmp	pos_x_col_box_se, x
		bcc	:+
		beq	:++++
		lda	pos_x_col_box_se, y
		cmp	pos_x_col_box_nw, y
		bcc	:++++
		cmp	pos_x_col_box_nw, x
		bcs	:++++ ; if (
		;	that.col_box.nw.x < this.col_box.nw.x
		;	&& that.col_box.nw.x > this.col_box.se.x
		;	&& that.col_box.se.x >= that.col_box.nw.x
		;	&& that.col_box.se.x < this.col_box.nw.x
		; ) {
			ldy	col_base_actor_b_index
			rts
		: ; }
		lda	pos_x_col_box_se, x
		cmp	pos_x_col_box_nw, x
		bcc	:+++
		lda	pos_x_col_box_se, y
		cmp	pos_x_col_box_nw, x
		bcs	:+++ ; } else if (
		;	that.col_box.nw.x < this.col_box.nw.x
		;	&& that.col_box.nw.x < this.col_box.se.x
		;	&& this.col_box.se.x >= this.col_box.nw.x
		;	&& that.col_box.se.x < this.col_box.nw.x
		; ) {
			ldy	col_base_actor_b_index
			rts
		: ; }
		cmp	pos_x_col_box_nw, x
		beq	:++
		cmp	pos_x_col_box_se, x
		bcc	:++
		beq	:++
		cmp	pos_x_col_box_se, y
		bcc	:+
		beq	:+
		lda	pos_x_col_box_se, y
		cmp	pos_x_col_box_nw, x
		bcs	:++
		: ; } else if (
		;	that.col_box.nw.x >= this.col_box.nw.x
		;	&& that.col_box.nw.x != this.col_box.nw.x
		;	&& that.col_box.nw.x > this.col_box.se.x
		;	&& that.col_box.nw.x <= that.col_box.se.x
		;	&& that.col_box.se.x < this.col_box.nw.x
		; ) {
			clc
			ldy	col_base_actor_b_index
			rts
		: ; }

		inx
		iny
		dec	col_base_box_side
		bpl	:-----
	; }

	sec
	ldy	col_base_actor_b_index
	rts
; ------------------------------------------------------------
col_box_buffer_check_actor:
	pha
	txa
	clc
	adc	#$01
	tax
	pla
	jmp	col_box_buffer_check_do
; -----------------------------
col_box_buffer_check_misc:
	txa
	clc
	adc	#$0D
	tax
	ldy	#$1B
	jmp	col_box_buffer_check
; -----------------------------
col_box_buffer_check_proj:
	ldy	#$1A
	txa
	clc
	adc	#$07
	tax
; -----------------------------
col_box_buffer_check:
	lda	#$00
; -----------------------------
col_box_buffer_check_do:
	jsr	col_box_buffer
	ldx	actor_index
	cmp	#0
	rts
; --------------------------------------------------------------
col_bg_buffer_offset:
col_bg_buffer_offset_tall:
	.byte	0
col_bg_buffer_offset_swimming:
	.byte	7
col_bg_buffer_offset_short:
	.byte	14
col_bg_buffer_offset_end:

col_bg_buffer_offset_x:
col_bg_buffer_offset_x_tall:
	.byte	8, 3, 12, 2, 2,  13, 13
col_bg_buffer_offset_x_swimming:
	.byte	8, 3, 12, 2, 2,  13, 13
col_bg_buffer_offset_x_short:
	.byte	8, 3, 12, 2, 2,  13, 13

	.byte	8, 0, 16, 4, 20, 4,  4

col_bg_buffer_offset_y:
col_bg_buffer_offset_y_tall:
	.byte	4,  32, 32, 8,  24, 8,  24
col_bg_buffer_offset_y_swimming:
	.byte	2,  32, 32, 8,  24, 8,  24
col_bg_buffer_offset_y_short:
	.byte	18, 32, 32, 24, 24, 24, 24

	.byte	24, 20, 20, 6,  6,  8,  16
; -------------------------------
col_box_player_step:
	iny
; -----------------------------
col_box_player_jump:
	lda	#0
.if	.defined(SMB)|.defined(SMB2M)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS_SMB)
	jmp	col_box_player_buffer_do
.endif
; -----------------------------
col_box_player_back:
	lda	#1

col_box_player_buffer_do:
	ldx	#0
; -----------------------------
col_box_buffer_old_tile		= zp_byte_03
col_box_buffer_player_offset	= zp_byte_05

	.export col_box_buffer
col_box_buffer:
	pha
	sty	col_box_buffer_tbl_offset
	lda	col_bg_buffer_offset_x, y
	clc
	adc	pos_x_lo_player, x
	sta	col_box_buffer_player_offset
	lda	pos_x_hi_player, x
	adc	#0
	and	#MOD_2
	lsr	a
	ora	col_box_buffer_player_offset
	ror	a
	lsr	a
	lsr	a
	lsr	a
	jsr	bg_get_buffer_ptr
	ldy	col_box_buffer_tbl_offset
	lda	pos_y_lo_player, x
	clc
	adc	col_bg_buffer_offset_y, y
	and	#CLAMP_16
	sec
	sbc	#32
	sta	col_buffer_ptr_idx
	tay
	lda	(game_buffer), y
	sta	col_box_buffer_old_tile
	ldy	col_box_buffer_tbl_offset
	pla
	bne	:+ ; if () {
		lda	pos_y_lo_player, x

		jmp	:++
	: ; } else {
		lda	pos_x_lo_player, x
	: ; }
	and	#MOD_16
	sta	col_box_buffer_tbl_offset
	lda	col_box_buffer_old_tile
	rts

.if	.defined(FC_SMB)
	.ifndef	PAL
	.res	1, $FF
	.endif
.elseif	.defined(VS_SMB)
	.res	6, $FF
.elseif	.defined(SMB2)
	.res	7, $FF
.endif
