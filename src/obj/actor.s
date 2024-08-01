.include	"../../inc/system/cpu.i"
.include	"../../inc/system/ppu.i"
.include	"../../inc/system/vs.i"

.include	"../../inc/engine/mem.i"
.include	"../../inc/engine/tunables.i"
.include	"../../inc/engine/chr.i"
.include	"../../inc/engine/charmap.i"
.include	"../../inc/engine/misc.i"
.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/course_flags.i"
.include	"../../inc/engine/sound.i"

.include	"../../inc/engine/unk.i"

ACTOR_BASE_VELOC_X	= 8
ACTOR_BASE_VELOC_X_HARD	= 12

ACTOR_SWAPPABLE_EASY	= actor::goomba
ACTOR_SWAPPABLE_HARD	= actor::buzzy_beetle

ACTOR_COL_SMALL = 9
ACTOR_COL_LARGE = 3

	.export actor_proc
actor_proc:
	lda	actor_mode, x
	pha

	asl	a
	bcs	:++

	pla
	beq	:+ ; if (!actor.is_child && actor.mode != free) {
		jmp	actor_proc_do
	: lda	bg_proc_id
	and	#bg_procs::mask
	cmp	#<bg_procs::gfx_render_area_d
	beq	:++ ; } else if (!actor.is_child && bg_proc_id != gfx_render_area_d) {
		jmp	actor_loop
	: ; } else if (actor.is_child) {
		pla
		and	#ACTOR_MODE_PARENT_MASK
		tay
		lda	actor_mode, y
		bne	:+ ; if (actor_parent.mode == free) {
			sta	actor_mode, x
		; }
	: ; }
	
	rts
; -----------------------------------------------------------
LOOP_SCROLL_INC		= 4
.if	.defined(CONS)
	COURSE_DATA_LOOP_OFFSETS	= course_data_loop_offsets
.elseif	.defined(VS)
	COURSE_DATA_LOOP_OFFSETS	= VS_RAM
.endif

actor_loop_courses:
	.if	.defined(SMBM)|.defined(VS_SMB)
		.if	.defined(SMBM)
			.byte	course::no_04
			.byte	course::no_04
		.elseif	.defined(VS_SMB)
			.byte	course::no_05
			.byte	course::no_05
		.endif
	
		.byte	course::no_07
		.byte	course::no_07
		.byte	course::no_07
		.byte	course::no_07
		.byte	course::no_07
		.byte	course::no_07
		.byte	course::no_08
		.byte	course::no_08

		.if	.defined(SMB)|.defined(VS_SMB)
			.byte	course::no_08
		.endif
	.elseif	.defined(SMB2)
		.byte	course::no_03
		.byte	course::no_03
		.byte	course::no_03
		.byte	course::no_03
		.byte	course::no_06
		.byte	course::no_06
		.byte	course::no_06
		.byte	course::no_06
		.byte	course::no_07
		.byte	course::no_08
		.byte	course::no_08
		.byte	course::no_05
	.endif

actor_loop_course_pages:
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	5, 9, 4, 5
		.byte	6, 8, 9, 10
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	6
	.elseif	.defined(ANN)
		.byte	5
	.endif

	.byte	11

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	16
	.endif
	.elseif	.defined(SMB2)
		.byte	3, 5, 8, 9
		.byte	3, 6, 7, 10
		.byte	5, 5, 11, 5
	.endif

actor_loop_pos_y_lo:
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	64
		.byte	<-80
		.byte	<-80
	
		.if	.defined(SMB)
			.byte	<-128
		.elseif	.defined(VS_SMB)
			.byte	64
		.endif
	
		.byte	64
	
		.if	.defined(SMB)
			.byte	64
			.byte	<-128
			.byte	64
		.elseif	.defined(VS_SMB)
			.byte	<-80
			.byte	64
			.byte	<-128
		.endif
	
		.byte	<-16
		.byte	<-16
		.byte	<-16
	.elseif	.defined(SMB2)
		.byte	<-80
		.byte	<-80
		.byte	64
		.byte	48
		.byte	<-80
		.byte	48
		.byte	<-80
		.byte	<-80
		.byte	<-16
		.byte	<-16
		.byte	<-80
		.byte	<-16
	.elseif	.defined(ANN)
		.byte	<-80
		.byte	64
		.byte	64
		.byte	64
		.byte	64
		.byte	64
		.byte	<-128
		.byte	<-128
		.byte	<-16
		.byte	<-80
	.endif

.if	.defined(SMB)|.defined(VS_SMB)
ACTOR_LOOP_COUNT	= 3
.elseif	.defined(SMB2)
actor_loop_data_smb2:
	.byte	2, 2, 2, 2
	.byte	2, 2, 2, 2
	.byte	1, 1, 1, 1
.elseif	.defined(ANN)
actor_loop_data_smb2:
	.byte	1, 1, 3, 3
	.byte	3, 3, 3, 3
	.byte	1, 1
.endif
; -----------------------------
actor_area_loop:
	lda	pos_x_hi_player
	sec
	sbc	#LOOP_SCROLL_INC
	sta	pos_x_hi_player
	lda	eng_page_current
	sec
	sbc	#LOOP_SCROLL_INC
	sta	eng_page_current
	lda	pos_x_hi_screen_left
	sec
	sbc	#LOOP_SCROLL_INC
	sta	pos_x_hi_screen_left
	lda	pos_x_hi_screen_right
	sec
	sbc	#LOOP_SCROLL_INC
	sta	pos_x_hi_screen_right
	lda	eng_areaobj_page_loc
	sec
	sbc	#LOOP_SCROLL_INC
	sta	eng_areaobj_page_loc
	lda	#0
	sta	actor_page_on
	sta	eng_areaobj_page_on
	sta	actor_offset
	sta	actor_page_loc

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	lda	COURSE_DATA_LOOP_OFFSETS, y
	sta	eng_area_offset

	rts
; ------------------------------
actor_loop:
	lda	eng_loop_flag
	beq	:+++++
	lda	eng_pos_x
	bne	:+++++ ; if (eng_loop_flag != 0 && eng_pos_x == 0) {
		ldy	#LOOP_VAL_COUNT
		: ; for (loop_descriptor in loop_descriptors) {
			dey
			bmi	:++++

			lda	course_no
			cmp	actor_loop_courses, y
			bne	:-
			lda	eng_page_current
			cmp	actor_loop_course_pages, y
			bne	:-
		; }

		; if (loop_descriptor_found) {
			lda	pos_y_lo_player
			cmp	actor_loop_pos_y_lo, y
			bne	actor_loop_check_not_apply
			lda	state_player
			cmp	#player_state::ground
			bne	actor_loop_check_not_apply
			.if	.defined(SMB)|.defined(VS_SMB)
			lda	course_no
			cmp	#course::no_07
			bne	:++ ; if ((player.pos_y.lo == actor_loop_pos_y_lo[y] && player.state == ground) || course_no == no_07 || SMB2) {
			.endif
				; if (course_no == no_07 || SMB2) {
					inc	eng_loop_counter_real
				; }

				actor_course_loop:
				.if	.defined(SMB2M)
				actor_loop_check_not_apply:
				.endif

				inc	eng_loop_counter
				lda	eng_loop_counter
				.if	.defined(SMB)|.defined(VS_SMB)
					cmp	#ACTOR_LOOP_COUNT
				.elseif	.defined(SMB2M)
					cmp	actor_loop_data_smb2, y
				.endif
				bne	:+++
				lda	eng_loop_counter_real
				.if	.defined(SMB)|.defined(VS_SMB)
					cmp	#ACTOR_LOOP_COUNT
				.elseif	.defined(SMB2M)
					cmp	actor_loop_data_smb2, y
				.endif
				beq	:++

				.if	.defined(SMB)|.defined(VS_SMB)
					bne	:+
	
				actor_loop_check_not_apply:
					lda	course_no
					cmp	#course::no_07
					beq	actor_course_loop
				.endif
			; }
			: ; if ((course_no != no_07 || SMB2) || (++eng_loop_counter == loop_count && eng_loop_counter_real != loop_count)) {
				jsr	actor_area_loop
				jsr	actor_killall
			: ; }
	
			; if (eng_loop_counter == loop_count || (player.pos_y.lo == actor_loop_pos_y_lo[y] && player.state == ground && (course_no != no_07 || SMB2))) {
				lda	#0
				sta	eng_loop_counter
				sta	eng_loop_counter_real
			: ; }

			lda	#0
			sta	eng_loop_flag
		; }
	: ; }

	lda	eng_swarm_queue
	beq	:+ ; if (eng_swarm_queue) {
		sta	actor_id, x
		lda	#actor_modes::active
		sta	actor_mode, x
		lda	#actor_states::state_0
		sta	state_actor, x
		sta	eng_swarm_queue
		jmp	actor_init
	:

	.if	.defined(VS)
                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
                sta     VS_REQ
	.endif

	ldy	actor_offset
	lda	(course_actor_addr), y
	cmp	#COURSE_ACTORS_END
	bne	:+ ; } else if (*course_actor_addr == COURSE_ACTORS_END) {
		jmp	actor_init_check
	: and	#<COURSE_ACTORS_TYPE_MASK
	cmp	#<COURSE_ACTORS_TYPE_E
	beq	:+
	cpx	#ENG_ACTOR_MAX-1
	bcc	:+
	iny

	.if	.defined(VS)
                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
                sta     VS_REQ
	.endif

	lda	(course_actor_addr), y
	and	#>COURSE_ACTORS_ID_MASK
	cmp	#actor::power_up
	beq	:+ ; } else if (actor.type != type_E && x >= (ENG_ACTOR_MAX-1) && actor.id != power_up) {
		rts
	: ; } else {
	actor_loop_screen_right_pos_x_hi	= zp_byte_06
	actor_loop_screen_right_pos_x_lo	= zp_byte_07

		lda	pos_x_lo_screen_right
		clc
		adc	#48
		and	#%11110000
		sta	actor_loop_screen_right_pos_x_lo
		lda	pos_x_hi_screen_right
		adc	#0
		sta	actor_loop_screen_right_pos_x_hi

		ldy	actor_offset
		iny

		.if	.defined(VS)
	                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
	                sta     VS_REQ
		.endif

		lda	(course_actor_addr), y
		asl	a
		bcc	:+
		lda	actor_page_on
		bne	:+ ; if (!actor.page_on) {
			inc	actor_page_on
			inc	actor_page_loc
		: ; }

		dey

		.if	.defined(VS)
	                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
	                sta     VS_REQ
		.endif

		lda	(course_actor_addr), y
		and	#<COURSE_ACTORS_TYPE_MASK
		cmp	#<COURSE_ACTORS_TYPE_F
		bne	:+
		lda	actor_page_on
		bne	:+ ; if (actor.type == type_F && !actor.page_on) {
			iny

			.if	.defined(VS)
		                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		                sta     VS_REQ
			.endif

			lda	(course_actor_addr), y
			and	#>COURSE_ACTORS_PAGE_LOC_MASK
			sta	actor_page_loc
			inc	actor_offset
			inc	actor_offset
			inc	actor_page_on

			jmp	actor_loop
		: ; } else { 
			.if	.defined(VS)
		                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		                sta     VS_REQ
			.endif

			lda	actor_page_loc
			sta	pos_x_hi_actor, x

			.if	.defined(VS)
		                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		                sta     VS_REQ
			.endif

			lda	(course_actor_addr), y
			and	#<COURSE_ACTORS_POSX_MASK
			sta	pos_x_lo_actor, x
			cmp	pos_x_lo_screen_right
			lda	pos_x_hi_actor, x
			sbc	pos_x_hi_screen_right
			bcs	:+

                        .if     .defined(VS)
                                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
                                sta     VS_REQ
                        .endif

			lda	(course_actor_addr), y
			and	#<COURSE_ACTORS_TYPE_MASK
			cmp	#<COURSE_ACTORS_TYPE_E
			beq	actor_special_a ; if ((actor.pos_x >= screen_right.pos_x) && actor.type != type_E) {
				jmp	actor_special_b
			: ; } else if (actor.pos_x < screen_right.pos_x) {
				lda	actor_loop_screen_right_pos_x_lo
				cmp	pos_x_lo_actor, x
				lda	actor_loop_screen_right_pos_x_hi
				sbc	pos_x_hi_actor, x
				bcc	actor_init_check ; if (screen_right_next.pos_x < actor.pos_x) {
					lda	#1
					sta	pos_y_hi_actor, x

		                        .if     .defined(VS)
		                                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		                                sta     VS_REQ
		                        .endif
			
					lda	(course_actor_addr), y
					asl	a
					asl	a
					asl	a
					asl	a
					sta	pos_y_lo_actor, x
					cmp	#(<COURSE_ACTORS_TYPE_E)<<4
					beq	actor_special_a ; if (!actor.type_E) {
						iny

			                        .if     .defined(VS)
			                                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			                                sta     VS_REQ
			                        .endif

						lda	(course_actor_addr), y

						.if	.defined(CONS)
						and	#>COURSE_ACTORS_HARD_ONLY
						beq	:+
						lda	eng_hard_mode_b
						beq	actor_special_do
						: ; if (!actor.hard_only || eng_hard_mode_b || CONS) {
							lda	(course_actor_addr), y
						.endif

							and	#>COURSE_ACTORS_ID_MASK
							cmp	#actor::group_start
							bcc	:+
							cmp	#actor::group_end
							bcc	actor_group
							: ; if (actor.id < group_start || actor.id >= group_end) {
								.if	.defined(CONS)
									cmp	#ACTOR_SWAPPABLE_EASY
									bne	:+
									.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
									ldy	eng_hard_mode
									beq	:+
									.elseif	.defined(ANN)
									ldy	byte_77D
									beq	:+
									ldy	byte_7FB
									bne	:+
									.endif ; if (
									;	actor == ACTOR_SWAPPABLE_EASY
									;	&& ((!ANN && eng_hard_mode) || (ANN && byte_77D && !byte_7FB))
									; ) {
										lda	#ACTOR_SWAPPABLE_HARD
									: ; }
								.endif
							
								sta	actor_id, x
								lda	#actor_modes::active
								sta	actor_mode, x
								jsr	actor_init
								lda	actor_mode, x
								bne	actor_special_do ; if (actor_mode == free) {
									rts
								; } else actor_special_do();
							; } else actor_group();
						; } else actor_special_do();
					; } else actor_special_a();
				; } else actor_init_check();
			; } else actor_special_a();
		; }
	; }
; -----------------------------------------------------------
actor_init_check:
	lda	actor_swarm_buffer
	bne	:+
	lda	actor_vine_flag
	cmp	#1
	bne	:++ ; if (actor_swarm_buffer || actor_vine_flag) {
		; if (!actor_swarm_buffer) {
			lda	#actor::vine
		: ; }
		sta	actor_id, x
	
	actor_init:
		lda	#actor_states::state_0
		sta	state_actor, x
		jsr	actor_init_do
	: ; }

	rts
; -----------------------------------------------------------
actor_group:
	jmp	actor_group_do
; -----------------------------------------------------------
actor_special_a:
	.if	.defined(VS)
                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
                sta     VS_REQ
	.endif

	iny
	iny

	.if	.defined(SMB2)
		lda	course_no
		cmp	#course::no_09
		beq	:+
	.endif
	lda	(course_actor_addr), y
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	cmp	course_no
	bne	:++
	: ; if ((SMB2 && course_no == no_09) || course_no == course_actor_addr_hi) {
		dey

		.if	.defined(VS)
	                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
	                sta     VS_REQ
		.endif

	actor_special_a_next_byte:
		lda	(course_actor_addr), y
		sta	course_descriptor

		iny
		lda	(course_actor_addr), y
		and	#COURSE_ACTORS_TYPE_E_STARTPAGE_MASK
		sta	eng_startpage_init
	: ; }

	jmp	:+
; ------------------------------
actor_special_b:
	.if	.defined(VS)
                lda     #vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
                sta     VS_REQ
	.endif

	ldy	actor_offset
	lda	(course_actor_addr), y
	and	#<COURSE_ACTORS_TYPE_MASK
	cmp	#<COURSE_ACTORS_TYPE_E
	bne	:++
; ------------------------------
	: ; if (actor.type == type_E) {
		inc	actor_offset
	: ; }

actor_special_do:
	inc	actor_offset
	inc	actor_offset
	lda	#0
	sta	actor_page_on
	ldx	actor_index
	rts
; -----------------------------------------------------------
ACTOR_PAGE_A_OFFSET_Y	= 8

actor_init_do:
	lda	actor_id, x
	cmp	#actor::actors_page_b
	bcs	:+ ; if (actor.id < page_b) {
		tay
		lda	pos_y_lo_actor, x
		adc	#ACTOR_PAGE_A_OFFSET_Y
		sta	pos_y_lo_actor, x
		lda	#1
		sta	actor_bits_mask, x
		tya
	: ; }

	jsr	eng_farjump
	.addr	actor_init_base
	.addr	actor_init_base
	.addr	actor_init_base
	.addr	actor_init_koopa_red

	.if	.defined(SMB)|.defined(VS_SMB)
		.addr	actor_init_null
	.elseif	.defined(SMB2M)
		.addr	actor_init_piranha_plant
	.endif

	.addr	actor_init_hammer_bro
	.addr	actor_init_goomba
	.addr	actor_init_bloober
	.addr	actor_init_bullet
	.addr	actor_init_null
	.addr	actor_init_cheep
	.addr	actor_init_cheep
	.addr	actor_init_podoboo
	.addr	actor_init_piranha_plant
	.addr	actor_init_koopa_green_bounce
	.addr	actor_init_koopa_red_fly
	.addr	actor_init_veloc_x_none
	.addr	actor_init_lakitu
	.addr	actor_init_swarm
	.addr	actor_init_null
	.addr	actor_init_swarm

	.addr	actor_init_swarm
	.addr	actor_init_swarm
	.addr	actor_init_swarm
	.addr	actor_kill_swarm
	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_firebar_short
	.addr	actor_init_firebar_short
	.addr	actor_init_firebar_short
	.addr	actor_init_firebar_short
	.addr	actor_init_firebar_long
	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_plat_bal
	.addr	actor_init_plat_std_v
	.addr	actor_init_plat_l_up
	.addr	actor_init_plat_l_down
	.addr	actor_init_plat_std_h
	.addr	actor_init_plat_drop
	.addr	actor_init_plat_std_h
	.addr	actor_init_plat_s_up
	.addr	actor_init_plat_s_down
	.addr	actor_init_bowser

	.addr	obj_spec_powerup_init_b
	.addr	game_proc_vine_init

	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_null
	.addr	actor_init_toad
	.addr	actor_plat_pos_rts
; -----------------------------------------------------------
actor_init_null:
	rts
; -----------------------------------------------------------
actor_init_goomba:
	jsr	actor_init_base
	jmp	actor_init_col_small
; -----------------------------------------------------------
actor_init_podoboo:
	lda	#2
	sta	pos_y_hi_actor, x
	sta	pos_y_lo_actor, x
	lsr	a
	sta	eng_timer_actor, x
	lsr	a
	sta	state_actor, x
	jmp	actor_init_col_small
; -----------------------------------------------------------
TOAD_POS_Y_LO	= <-72

actor_init_toad:
	lda	#TOAD_POS_Y_LO
	sta	pos_y_lo_actor, x
	rts
; -----------------------------------------------------------
actor_init_base_veloc_x:
	.byte	<-ACTOR_BASE_VELOC_X, <-ACTOR_BASE_VELOC_X_HARD
; ------------------------------
actor_init_base:
	ldy	#1
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		lda	eng_hard_mode
	.elseif	.defined(ANN)
		lda	byte_77D
	.endif
	bne	:+ ; if (!eng_hard_mode) {
		dey
	: ; }
	lda	actor_init_base_veloc_x, y
; ------------------------------
actor_init_veloc_x:
	sta	veloc_x_actor, x
	jmp	actor_init_col_large
; -----------------------------------------------------------
actor_init_koopa_red:
	jsr	actor_init_base
	lda	#actor_states::state_1
	sta	state_actor, x
	rts
; -----------------------------------------------------------
HAMMER_BRO_COL_SIZE	= 11
HAMMER_BRO_TIMER_VS	= 255
HAMMER_BRO_TIMER_EASY	= 128
HAMMER_BRO_TIMER_HARD	= 80

.if	.defined(CONS)
actor_init_hammer_bro_timer:
	.byte	HAMMER_BRO_TIMER_EASY, HAMMER_BRO_TIMER_HARD
.endif
; ------------------------------
actor_init_hammer_bro:
	lda	#0
	sta	eng_timer_hammer_throw, x
	sta	veloc_x_actor, x

	.if	.defined(SMB2M)
		lda	course_no
		cmp	#course::no_07
		bcs	:+
	.endif ; if (!SMB2M || course_no < no_07) {
		.if	.defined(CONS)
			ldy	eng_hard_mode_b
			lda	actor_init_hammer_bro_timer, y
		.elseif	.defined(VS)
			lda	#HAMMER_BRO_TIMER_VS
		.endif
		sta	eng_timer_actor, x
	: ; }
	lda	#HAMMER_BRO_COL_SIZE
	jmp	actor_init_col
; -----------------------------------------------------------
actor_init_veloc_x_none:
	lda	#0
	jmp	actor_init_veloc_x
; -----------------------------------------------------------
actor_init_bloober:
	lda	#0
	sta	veloc_x_actor, x
; ------------------------------
actor_init_col_small:
	lda	#ACTOR_COL_SMALL
	bne	actor_init_col
; ------------------------------
ACTOR_KOOPA_RED_ACCEL_X_RIGHT	= 48
ACTOR_KOOPA_RED_ACCEL_X_LEFT	= 32

actor_init_koopa_red_fly:
	ldy	#ACTOR_KOOPA_RED_ACCEL_X_RIGHT
	lda	pos_y_lo_actor, x
	sta	accel_x_actor, x
	bpl	:+ ; if (actor.accel_x < 0) {
		ldy	#<-ACTOR_KOOPA_RED_ACCEL_X_LEFT
	: ; }
	tya
	adc	pos_y_lo_actor, x
	sta	veloc_x_actor, x
; ------------------------------
actor_init_col_large:
	lda	#ACTOR_COL_LARGE

actor_init_col:
	sta	col_box_actor, x
	lda	#MOTION_DIR_LEFT
	sta	motion_dir_actor, x

actor_init_veloc_y:
	lda	#0
	sta	veloc_y_actor, x
	sta	accel_y_actor_c, x
	rts
; -----------------------------------------------------------
actor_init_bullet:
	lda	#MOTION_DIR_LEFT
	sta	motion_dir_actor, x
	lda	#ACTOR_COL_SMALL
	sta	col_box_actor, x
	rts
; -----------------------------------------------------------
actor_init_cheep:
	jsr	actor_init_col_small
	lda	eng_rand_seed, x
	and	#%00010000
	sta	veloc_x_actor, x
	lda	pos_y_lo_actor, x
	sta	accel_y_actor_c, x
	rts
; -----------------------------------------------------------
actor_init_lakitu:
	lda	actor_swarm_buffer
	bne	:+ ; if (!actor_swarm_buffer) {
	actor_init_lakitu_do:
		lda	#0
		sta	eng_timer_lakitu_new
		jsr	actor_init_veloc_x_none
		jmp	actor_init_col_large_b
	: ; } else {
		jmp	actor_erase
	; }
; -----------------------------------------------------------
LAKITU_SPINY_SWARM_TIMER	= 128

.if	.defined(SMB)|.defined(VS_SMB)
	LAKITU_SPAWN_TIME		= 7
.elseif	.defined(SMB2M)
	LAKITU_SPAWN_TIME		= 3
.endif

LAKITU_OFFSET_X			= 32
LAKITU_OFFSET_X_B		= 96
SPINY_PLAYER_Y_CUTOFF		= 44

actor_spiny_data:
	.byte	$26, $2C, $32, $38
	.byte	$20, $22, $24, $26
	.byte	$13, $14, $15, $16
; ------------------------------
actor_init_lakitu_spiny:
	lda	eng_timer_swarm
	bne	:+++++
	cpx	#ENG_ACTOR_MAX-1
	bcs	:+++++ ; if (eng_timer_swarm == 0 && actor_index < (ENG_ACTOR_MAX-1)) {
		lda	#LAKITU_SPINY_SWARM_TIMER
		sta	eng_timer_swarm
		ldy	#ENG_ACTOR_MAX-2
		: ; for (y = ENG_ACTOR_MAX-2; y >= 0; y--) {
			lda	actor_id, y
			cmp	#actor::lakitu
			beq	actor_spiny_do

			dey
			bpl	:-
		; }

		; if (lakitu_not_found) {
			inc	eng_timer_lakitu_new
			lda	eng_timer_lakitu_new
			cmp	#LAKITU_SPAWN_TIME
			bcc	:++++ ; if (++lakitu.timer_new >= LAKITU_SPAWN_TIME) {
				ldx	#ENG_ACTOR_MAX-2
				: ; for (x = ENG_ACTOR_MAX-2; x >= 0; x--) {
					lda	actor_mode, x
					beq	:+

					dex
					bpl	:-
					bmi	:++
				: ; }
				; if (free_actor_found) {
					lda	#actor_states::state_0
					sta	state_actor, x
					lda	#actor::lakitu
					sta	actor_id, x
					jsr	actor_init_lakitu_do
					lda	#LAKITU_OFFSET_X

					.if	.defined(SMB2M)
						ldy	byte_7FB

						.if	.defined(SMB2)
						bne	actor_init_lakitu_offset_x_b
						ldy	course_no
						cpy	#course::no_07
						bcc	actor_init_lakitu_offset_x_b_skip
						.elseif	.defined(ANN)
						beq	actor_init_lakitu_offset_x_b_skip
						.endif
						; if (byte_7FB || (SMB2 && course_no >= no_07)) {
						actor_init_lakitu_offset_x_b:
							lda	#LAKITU_OFFSET_X_B
						actor_init_lakitu_offset_x_b_skip: ; }
					.endif

					jsr	actor_init_right_side
				: ; }
			
				ldx	actor_index
			; }
		; }
	: ; }

	rts
; ------------------------------
actor_spiny_do:
	lda	pos_y_lo_player
	cmp	#SPINY_PLAYER_Y_CUTOFF
	bcc	:-
	lda	state_actor, y
	bne	:- ; if (player.pos_y >= SPINY_PLAYER_Y_CUTOFF && actor.state == state_0) {
		lda	pos_x_hi_actor, y
		sta	pos_x_hi_actor, x
		lda	pos_x_lo_actor, y
		sta	pos_x_lo_actor, x
		lda	#1
		sta	pos_y_hi_actor, x
		lda	pos_y_lo_actor, y
		sec
		sbc	#8
		sta	pos_y_lo_actor, x
	
		lda	eng_rand_seed, x
		and	#%00000011
		tay
		ldx	#3-1
		: ; for (x = 3-1; x >= 0; x--) {
			lda	actor_spiny_data, y
			sta	zp_byte_01, x
	
			iny
			iny
			iny
			iny
			dex
			bpl	:-
		; }
	
		ldx	actor_index
		jsr	actor_proc_lakitu_spiny
		ldy	veloc_x_player
		cpy	#8
		bcs	:++ ; if (player.veloc_x < 8) {
			tay
	
			lda	eng_rand_seed+1, x
			and	#%00000011
			beq	:+ ; if (eng_rand_seed[1] % 4) {
				tya
				eor	#<-1
				tay
				iny
			: ; }
		
			tya
		: ; }
	
		jsr	actor_init_col_small
		ldy	#MOTION_DIR_LEFT
		sta	veloc_x_actor, x
		cmp	#0
		bmi	:+ ; if (actor.veloc_x > 0) {
			dey
		: ; }
		sty	motion_dir_actor, x
		lda	#<-3
		sta	veloc_y_actor, x
		lda	#actor_modes::active
		sta	actor_mode, x
		lda	#actor_states::state_5
		sta	state_actor, x
	; }

actor_spiny_rts:
	rts
; -----------------------------------------------------------
FIREBAR_OFFSET		= 4
FIREBAR_OFFSET_X	= FIREBAR_OFFSET
FIREBAR_OFFSET_Y	= FIREBAR_OFFSET

firebar_veloc_ang:
	.byte	40, 56, 40, 56, 40

actor_firebar_victory_right_x_hi:
	.byte	0, 0, 16, 16, 0
; ------------------------------
actor_init_firebar_long:
	jsr	actor_init_dup
; ------------------------------
actor_init_firebar_short:
	lda	#0
	sta	veloc_x_actor, x
	lda	actor_id, x
	sec
	sbc	#actor::firebar_start
	tay
	lda	firebar_veloc_ang, y
	sta	veloc_ang_firebar, x
	lda	actor_firebar_victory_right_x_hi, y
	sta	pos_x_hi_victory_right, x
	lda	pos_y_lo_actor, x
	clc
	adc	#FIREBAR_OFFSET_Y
	sta	pos_y_lo_actor, x
	lda	pos_x_lo_actor, x
	clc
	adc	#FIREBAR_OFFSET_X
	sta	pos_x_lo_actor, x
	lda	pos_x_hi_actor, x
	adc	#0
	sta	pos_x_hi_actor, x
	jmp	actor_init_col_large_b
; -----------------------------------------------------------
CHEEP_FLY_COUNT_BASE	= 3

actor_cheep_fly_count	= zp_byte_00
actor_cheep_fly_offset_rand	= zp_byte_00
actor_cheep_fly_veloc_x_rand	= zp_byte_01

actor_cheep_fly_player_offset:
	.byte	<-128, 48, 64, <-128
	.byte	48, 80, 80, 112
	.byte	32, 64, <-128, <-96
	.byte	112, 64, <-112, 104

actor_cheep_fly_veloc_x:
	.byte	14, 5, 6, 14
	.byte	28, 32, 16, 12
	.byte	30, 34, 24, 20

actor_cheep_fly_timers:
	.byte	16, 96, 32, 72
; ------------------------------
actor_init_cheep_fly:
	lda	eng_timer_swarm
	bne	actor_spiny_rts ; if (eng_timer_swarm == 0) {
		jsr	actor_init_col_small
	
		lda	eng_rand_seed+1, x
		and	#%00000011
		tay
		lda	actor_cheep_fly_timers, y
		sta	eng_timer_swarm
	
		ldy	#CHEEP_FLY_COUNT_BASE
		lda	eng_hard_mode_b
		beq	:+ ; if (eng_hard_mode_b) {
			iny
		: ; }
		sty	actor_cheep_fly_count
		cpx	actor_cheep_fly_count
		bcs	actor_spiny_rts ; if (actor_index < 3 || (eng_hard_mode_b && actor_index < 4)) {
			lda	eng_rand_seed, x
			and	#%00000011
			sta	actor_cheep_fly_offset_rand
			sta	actor_cheep_fly_veloc_x_rand
			lda	#<-5
			sta	veloc_y_actor, x
		
			lda	#0
			ldy	veloc_x_player
			beq	:+ ; if (player.veloc_x) {
				lda	#4

				cpy	#25
				bcc	:+ ; if (player.veloc_x >= 25) {
					asl	a
				; }
			: ; }
			pha
		
			clc
			adc	actor_cheep_fly_offset_rand
			sta	actor_cheep_fly_offset_rand
			lda	eng_rand_seed+1, x
			and	#%00000011
			beq	:+ ; if (eng_rand_seed[1] % 4) {
				lda	eng_rand_seed+2, x
				and	#%00001111
				sta	actor_cheep_fly_offset_rand
			: ; }
		
			pla
			clc
			adc	actor_cheep_fly_veloc_x_rand
			tay
			lda	actor_cheep_fly_veloc_x, y
			sta	veloc_x_actor, x
			lda	#MOTION_DIR_RIGHT
			sta	motion_dir_actor, x
		
			lda	veloc_x_player
			bne	:+
			ldy	actor_cheep_fly_offset_rand
			tya
			and	#%00000010
			beq	:+ ; if ((actor_cheep_fly_offset_rand % 4) >= 2) {
				lda	veloc_x_actor, x
				eor	#<-1
				clc
				adc	#1
				sta	veloc_x_actor, x
				inc	motion_dir_actor, x
			: ; }
			tya
			and	#%00000010
			beq	:+ ; if ((actor_cheep_fly_offset_rand % 4) >= 2) {
				lda	pos_x_lo_player
				clc
				adc	actor_cheep_fly_player_offset, y
				sta	pos_x_lo_actor, x
				lda	pos_x_hi_player
				adc	#0

				jmp	:++
			: ; } else {
				lda	pos_x_lo_player
				sec
				sbc	actor_cheep_fly_player_offset, y
				sta	pos_x_lo_actor, x
				lda	pos_x_hi_player
				sbc	#0
			: ; }
			sta	pos_x_hi_actor, x
		
			lda	#actor_modes::active
			sta	actor_mode, x
			sta	pos_y_hi_actor, x
			lda	#ENG_OAM_CLEAR_SCANLINE
			sta	pos_y_lo_actor, x
			rts
		; } else rts;
	; } else rts;
; -----------------------------------------------------------
BOWSER_FLAME_TIMER_INIT	= 223
BOWSER_HP	= 5

actor_init_bowser:
	.if	.defined(SMB2M)
	        ldy     #ENG_ACTOR_MAX-2
		: ; for (y = ENG_ACTOR_MAX-2; y >= 0; y--) {
		        cpy     actor_index
		        beq     :+
		        lda     actor_id, y
		        cmp     #actor::bowser
		        bne     :+ ; if (actor.idx != 0 && actor.id == bowser) {
		        	lda     #0
		        	sta     actor_id, y
		        	sta     actor_mode, y
			: ; }

		        dey
		        bpl     :--
		; }
	.endif

	jsr	actor_init_dup
	stx	ppu_nmi_buffer_1_data+$27
	lda	#0
	sta	ppu_nmi_buffer_1_data+$22
	sta	ppu_nmi_buffer_1_data+$28
	lda	pos_x_lo_actor, x
	sta	ppu_nmi_buffer_1_data+$25
	lda	#BOWSER_FLAME_TIMER_INIT
	sta	eng_timer_bowser_flame
	sta	motion_dir_actor, x
	lda	#$20
	sta	ppu_nmi_buffer_1_data+$23
	sta	eng_timer_actor_ani, x
	lda	#BOWSER_HP
	sta	hp_bowser
	lsr	a
	sta	ppu_nmi_buffer_1_data+$24
	rts
; -----------------------------------------------------------
actor_init_dup:
	ldy	#<-1
	: ; for (y = 0; actor[y].mode != free; y++) {
		iny
		lda	actor_mode, y
		bne	:-
	; }
	sty	actor_dup_offset

	txa
	ora	#ACTOR_MODE_CHILD_BIT
	sta	actor_mode, y
	lda	pos_x_hi_actor, x
	sta	pos_x_hi_actor, y
	lda	pos_x_lo_actor, x
	sta	pos_x_lo_actor, y
	lda	#actor_modes::active
	sta	actor_mode, x
	sta	pos_y_hi_actor, y
	lda	pos_y_lo_actor, x
	sta	pos_y_lo_actor, y

actor_init_dup_rts:
	rts
; -----------------------------------------------------------
BOWSER_FLAME_TIMESLICE	= 16
BOWSER_FLAME_OFFSET_X	= 32

BOWSER_FLAME_SHOOT_OFFSET_X	= 14
BOWSER_FLAME_SHOOT_OFFSET_Y	= 8

BOWSER_FLAME_COL_BOX	= 8

bowser_flame_pos_y_offset:
	.byte	<-112, <-128, 112, <-112
bowser_flame_accel_y:
	.byte	<-1, 1
; ------------------------------
actor_init_bowser_flame:
	lda	eng_timer_swarm
	bne	actor_init_dup_rts ; if (eng_timer_swarm == 0) {
		sta	accel_y_actor_c, x
		lda	apu_noise_event
		ora	#noise_event::flame
		sta	apu_noise_event
		ldy	ppu_nmi_buffer_1_data+$27
		lda	actor_id, y
		cmp	#actor::bowser
		beq	:++ ; if (actor.id != bowser) {
			jsr	actor_proc_bowser_flame_timer_init
			clc
			adc	#2*BOWSER_FLAME_TIMESLICE
			ldy	eng_hard_mode_b
			beq	:+ ; if (eng_hard_mode_b) {
				sec
				sbc	#BOWSER_FLAME_TIMESLICE
			: ; }
			sta	eng_timer_swarm
		
			lda	eng_rand_seed, x
			and	#%00000011
			sta	pos_y_actor, x
			tay
			lda	bowser_flame_pos_y_offset, y
		
		actor_init_right_side:
			sta	pos_y_lo_actor, x
			lda	pos_x_lo_screen_right
			clc
			adc	#<BOWSER_FLAME_OFFSET_X
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_screen_right
			adc	#>BOWSER_FLAME_OFFSET_X
			sta	pos_x_hi_actor, x
	
			jmp	:+++
		: ; } else {
			lda	pos_x_lo_actor, y
			sec
			sbc	#BOWSER_FLAME_SHOOT_OFFSET_X
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_actor, y
			sta	pos_x_hi_actor, x
			lda	pos_y_lo_actor, y
			clc
			adc	#BOWSER_FLAME_SHOOT_OFFSET_Y
			sta	pos_y_lo_actor, x
		
			lda	eng_rand_seed, x
			and	#%00000011
			sta	pos_y_actor, x
			tay
			lda	bowser_flame_pos_y_offset, y
			ldy	#0
			cmp	pos_y_lo_actor, x
			bcc	:+ ; if (actor.pos_y.lo <= *bowser_flame_pos_y_offset) {
				iny
			: ; }
			lda	bowser_flame_accel_y, y
			sta	accel_y_actor_c, x
		
			lda	#0
			sta	actor_swarm_buffer
		: ; }
	
		lda	#BOWSER_FLAME_COL_BOX
		sta	col_box_actor, x
		lda	#actor_modes::active
		sta	pos_y_hi_actor, x
		sta	actor_mode, x
		lsr	a
		sta	accel_x_actor, x
		sta	state_actor, x
		rts
	; } else rts;
; -----------------------------------------------------------
FIREWORKS_SWARM_TIMER	= 32
FIREWORKS_VELOC_Y	= 8

fireworks_pos_x:	.byte	0,  48, 96,  96, 0,  32
fireworks_pos_y:	.byte	96, 64, 112, 64, 96, 48
; ------------------------------
actor_init_fireworks:
	lda	eng_timer_swarm
	bne	:++ ; if (eng_timer_swarm == 0) {
		lda	#FIREWORKS_SWARM_TIMER
		sta	eng_timer_swarm
		dec	actor_firework_counter

		ldy	#ENG_ACTOR_MAX
		: ; for (actor of actors) {
			dey
			lda	actor_id, y
			cmp	#actor::flag_victory
			bne	:-
		; }
	
		lda	pos_x_lo_actor, y
		sec
		sbc	#48
		pha

		lda	pos_x_hi_actor, y
		sbc	#0
		sta	zp_byte_00
		lda	actor_firework_counter
		clc
		adc	state_actor, y
		tay

		pla
		clc
		adc	fireworks_pos_x, y
		sta	pos_x_lo_actor, x

		lda	zp_byte_00
		adc	#0
		sta	pos_x_hi_actor, x
		lda	fireworks_pos_y, y
		sta	pos_y_lo_actor, x
		lda	#actor_modes::active
		sta	pos_y_hi_actor, x
		sta	actor_mode, x
		lsr	a
		sta	veloc_x_actor, x
		lda	#FIREWORKS_VELOC_Y
		sta	veloc_y_actor, x
	: ; }

	rts
; -----------------------------------------------------------
BULLET_CHEEP_SLOTS	= 3
BULLET_CHEEP_RAND_MASK	= %00000111
BULLET_CHEEP_RED_CHANCE	= $AA
BULLET_CHEEP_TIMER_INIT	= 32

	.export actor_init_bullet_cheep_data_a
actor_init_bullet_cheep_data_a:
	.byte	1<<0, 1<<1, 1<<2, 1<<3
	.byte	1<<4, 1<<5, 1<<6, 1<<7

bullet_cheep_pos_x_lo:
	.byte	64, 48, <-112, 80
	.byte	32, 96, <-96, 112

BULLET_CHEEP_ACTOR_ID_MASK	= %00000001

bullet_cheep_actor_ids:
	.byte	actor::cheep_grey
	.byte	actor::cheep_red
; ------------------------------
actor_init_bullet_cheep:
	lda	eng_timer_swarm
	bne	actor_init_bullet_cheep_rts
	lda	course_type
	bne	:++++++
	cpx	#BULLET_CHEEP_SLOTS
	bcs	actor_init_bullet_cheep_rts ; if (eng_timer_swarm == 0 && course_type == water && actor_index < BULLET_CHEEP_SLOTS) {
		ldy	#0
		lda	eng_rand_seed, x
		cmp	#BULLET_CHEEP_RED_CHANCE
		bcc	:+ ; if (*eng_rand_seed >= BULLET_CHEEP_RED_CHANCE) {
			iny
		: ; }
		lda	course_no
		cmp	#course::no_02
		beq	:+ ; if (course_no != no_02) {
			iny
		: ; }
		tya
		and	#BULLET_CHEEP_ACTOR_ID_MASK
		tay
		lda	bullet_cheep_actor_ids, y
	
	actor_init_bullet_cheep_do:
		sta	actor_id, x

		lda	byte_6DD
		cmp	#$FF
		bne	:+ ; if (byte_6DD == max) {
			lda	#0
			sta	byte_6DD
		: ; }
		lda	eng_rand_seed, x
		and	#BULLET_CHEEP_RAND_MASK
		: ; for (i = rand_seed % 8; (actor_init_bullet_cheep_data_a[i] & byte_6DD); i = ((i + 1) % 8)) {
			tay
			lda	actor_init_bullet_cheep_data_a, y
			bit	byte_6DD
			beq	:+
	
			iny
			tya
			and	#BULLET_CHEEP_RAND_MASK
	
			jmp	:-
		: ; }
		ora	byte_6DD
		sta	byte_6DD

		lda	bullet_cheep_pos_x_lo, y
		jsr	actor_init_right_side
		sta	pos_y_actor, x
		lda	#BULLET_CHEEP_TIMER_INIT
		sta	eng_timer_swarm
		jmp	actor_init_do
	: ; } else if (eng_timer_swarm == 0 && course_type != water) {
		ldy	#<-1
		: ; for (y = 0; y < (ENG_ACTOR_MAX-1) && (actor[y].mode == free || actor[y].id != bullet_swarm); y++) {
			iny
			cpy	#ENG_ACTOR_MAX-1
			bcs	:+
		
			lda	actor_mode, y
			beq	:-
			lda	actor_id, y
			cmp	#actor::bullet_swarm
			bne	:-
		; }
		; if (found_bullet_swarm) {
		actor_init_bullet_cheep_rts:
			rts
		: ; } else {
			lda	apu_pulse2_queue
			ora	#pulse_queue::pulse_8
			sta	apu_pulse2_queue
		
			lda	#actor::bullet_swarm
			bne	actor_init_bullet_cheep_do ; if (actor.is_group) {
			ACTOR_GROUP_MEMBER_OFFSET_X	= 24

			actor_group_pos_y_lo	= zp_byte_00
			actor_group_actor_id	= zp_byte_01
			actor_group_pos_x_hi	= zp_byte_02
			actor_group_pos_x_lo	= zp_byte_03

			actor_group_do:
				ldy	#actor::koopa_green
				sec
				sbc	#actor::group_start
				pha

				cmp	#actor::koopa_trio_lo-actor::group_start
				bcs	:++ ; if (actor.group_id < koopa_trio_lo) {
					pha
				
					ldy	#ACTOR_SWAPPABLE_EASY

					.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
					lda	eng_hard_mode
					beq	:+
					.elseif	.defined(ANN)
					lda	byte_77D
					beq	:+
					lda	byte_7FB
					bne	:+
					.endif ; if ((!ANN && eng_hard_mode) || (ANN && byte_77D && !byte_7FB)) {
						ldy	#ACTOR_SWAPPABLE_HARD
					: ; }

					pla
				: ; }
				sty	actor_group_actor_id

				ldy	#<-80
				and	#%00000010
				beq	:+ ; if (actor.group_id & 0x02) {
					ldy	#112
				: ; }
				sty	actor_group_pos_y_lo

				lda	pos_x_hi_screen_right
				sta	actor_group_pos_x_hi
				lda	pos_x_lo_screen_right
				sta	actor_group_pos_x_lo

				ldy	#2

				pla
				lsr	a
				bcc	:+ ; if (!(actor.group_id % 2)) {
					iny
				: ; }
				sty	actor_group_count
				: ; for (actor_group_count; actor_group_count > 0 && x < (ENG_ACTOR_MAX-1); actor_group_count--) {
					ldx	#<-1
					: ; for (x = 0; x < (ENG_ACTOR_MAX-1) && actor[x].mode != free; x++) {
						inx
						cpx	#ENG_ACTOR_MAX-1
						bcs	:+
				
						lda	actor_mode, x
						bne	:-
					; }
			
					; if (x < (ENG_ACTOR_MAX-1) && actor[x].mode == free) {	
						lda	actor_group_actor_id
						sta	actor_id, x

						lda	actor_group_pos_x_hi
						sta	pos_x_hi_actor, x
						lda	actor_group_pos_x_lo
						sta	pos_x_lo_actor, x
						clc
						adc	#ACTOR_GROUP_MEMBER_OFFSET_X
						sta	actor_group_pos_x_lo
						lda	actor_group_pos_x_hi
						adc	#0
						sta	actor_group_pos_x_hi

						lda	actor_group_pos_y_lo
						sta	pos_y_lo_actor, x
						lda	#actor_modes::active
						sta	pos_y_hi_actor, x
						sta	actor_mode, x
						jsr	actor_init_do
				
						dec	actor_group_count
						bne	:--
					; } else break;
				: ; }
			
				jmp	actor_special_do
			; } else actor_init_bullet_cheep_do();
		; }
	; } else rts;
; -----------------------------------------------------------
PIRANHA_PLANT_VELOC_X	= 1
PIRANHA_PLANT_OFFSET_Y	= 24
	.export actor_init_piranha_plant
actor_init_piranha_plant:
	.if	.defined(SMB2)
	        lda     #$22
	        sta     zp_byte_00
	        lda     #$13
	        sta     zp_byte_01

	        lda     byte_7FB
	        bne     :+
	        lda     course_no
	        cmp     #course::no_04
	        bcs     :+ ; if (!byte_7FB && course_no < no_04) {
		        dec     zp_byte_00
		        lda     #$21
		        sta     zp_byte_01
		: ; }

	        lda     zp_byte_00
	        sta     data_B517
	        lda     zp_byte_01
	        sta     actor_proc_piranha_plant_smb2_cmp+1
	.endif

	lda	#PIRANHA_PLANT_VELOC_X
	sta	veloc_x_actor, x
	lsr	a
	sta	state_actor, x
	sta	veloc_y_actor, x
	lda	pos_y_lo_actor, x
	sta	accel_y_actor_c, x
	sec
	sbc	#PIRANHA_PLANT_OFFSET_Y
	sta	pos_y_actor, x
	lda	#ACTOR_COL_SMALL
	jmp	actor_init_col_b
; -----------------------------------------------------------
actor_init_swarm:
	lda	actor_id, x
	sta	actor_swarm_buffer
	sec
	sbc	#actor::swarm_start
	jsr	eng_farjump
	.addr	actor_init_lakitu_spiny
	.addr	actor_init_swarm_null
	.addr	actor_init_cheep_fly
	.addr	actor_init_bowser_flame
	.addr	actor_init_fireworks
	.addr	actor_init_bullet_cheep
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_init_swarm_null:
	rts 
.endif
; -----------------------------------------------------------
actor_kill_swarm:
	ldy	#ENG_ACTOR_MAX-1
	: ; for (actor of actors) {
		lda	actor_id, y
		cmp	#actor::lakitu
		bne	:+ ; if (actor.id == lakitu) {
			lda	#actor_states::state_1
			sta	state_actor, y
		: ; }
	
		dey
		bpl	:--
	; }

	lda	#actor_modes::free
	sta	actor_swarm_buffer
	sta	actor_mode, x

.if	.defined(ANN)
actor_init_swarm_null:
.endif
	rts
; -----------------------------------------------------------
.if	.defined(SMBM)|.defined(VS_SMB)
	KOOPA_GREEN_BOUNCE_VELOC_X	= <-8
.elseif	.defined(SMB2)
	KOOPA_GREEN_BOUNCE_VELOC_X	= <-12
.endif

actor_init_koopa_green_bounce:
	lda	#MOTION_DIR_LEFT
	sta	motion_dir_actor, x
	lda	#KOOPA_GREEN_BOUNCE_VELOC_X
	sta	veloc_x_actor, x
; ------------------------------
actor_init_col_large_b:
	lda	#ACTOR_COL_LARGE

actor_init_col_b:
	sta	col_box_actor, x
	rts
; -----------------------------------------------------------
actor_init_plat_bal:
	dec	pos_y_lo_actor, x
	dec	pos_y_lo_actor, x

	ldy	eng_hard_mode_b
	bne	:+ ; if (!eng_hard_mode_b) {
		ldy	#2
		jsr	actor_plat_pos
	: ; }

	ldy	#$FF
	lda	actor_plat_align
	sta	state_actor, x
	bpl	:+ ; if (actor.state & 0x80) {
		txa
		tay
	: ; }
	sty	actor_plat_align

	lda	#0
	sta	motion_dir_actor, x
	tay
	jsr	actor_plat_pos
; ------------------------------
actor_init_plat_drop:
	lda	#255
	sta	eng_timer_hammer_throw, x
	jmp	actor_init_plat_std_do
; ------------------------------
actor_init_plat_std_h:
	lda	#0
	sta	veloc_x_actor, x
	jmp	actor_init_plat_std_do
; ------------------------------
ACTOR_PLAT_V_INC	= 64

actor_init_plat_std_v:
	ldy	#ACTOR_PLAT_V_INC
	lda	pos_y_lo_actor, x
	bpl	:+ ; if (actor[x].pos_y < 0) {
		eor	#<-1
		clc
		adc	#1
		ldy	#<-ACTOR_PLAT_V_INC
	: ; }
	sta	accel_x_actor, x

	tya
	clc
	adc	pos_y_lo_actor, x
	sta	veloc_x_actor, x
; ------------------------------
actor_init_plat_std_do:
	jsr	actor_init_veloc_y
; ------------------------------
PLAT_SIZE_EASY	= 6
PLAT_SIZE_HARD	= 5

actor_init_plat_do:
	lda	#PLAT_SIZE_HARD
	ldy	course_type
	cpy	#course_types::castle
	beq	:+
	ldy	eng_hard_mode_b
	bne	:+ ; if (course_type != castle && !eng_hard_mode_b) {
		lda	#PLAT_SIZE_EASY
	: ; }
	sta	col_box_actor, x

	rts
; -----------------------------------------------------------
actor_init_plat_l_up:
	jsr	actor_init_plat_s_up
	jmp	:+
; ------------------------------
actor_init_plat_l_down:
	jsr	actor_init_plat_s_down
; ------------------------------
:
	jmp	actor_init_plat_do
; -----------------------------------------------------------
actor_init_plat_s_up:
	lda	#16
	sta	accel_y_actor_c, x
	lda	#<-1
	sta	veloc_y_actor, x

	jmp	:+
; ------------------------------
actor_init_plat_s_down:
	lda	#<-16
	sta	accel_y_actor_c, x
	lda	#0
	sta	veloc_y_actor, x
; ------------------------------
:
	ldy	#1
	jsr	actor_plat_pos
	lda	#4
	sta	col_box_actor, x
	rts
; -----------------------------------------------------------
actor_plat_pos_data_a:
	.byte	ACTOR_BASE_VELOC_X, ACTOR_BASE_VELOC_X_HARD, <-ACTOR_BASE_VELOC_X

actor_plat_pos_data_b:
	.byte	0, 0, <-1
; ------------------------------
actor_plat_pos:
	lda	pos_x_lo_actor, x
	clc
	adc	actor_plat_pos_data_a, y
	sta	pos_x_lo_actor, x
	lda	pos_x_hi_actor, x
	adc	actor_plat_pos_data_b, y
	sta	pos_x_hi_actor, x
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		rts
	.endif

.if	.defined(ANN)
actor_proc_null:
actor_proc_null_b:
.endif

actor_plat_pos_rts:
	rts
; -----------------------------------------------------------
actor_proc_do:
	ldx	actor_index
	lda	#0
	ldy	actor_id, x
	cpy	#actor::actors_page_b
	bcc	:+ ; if (actor_id[x] >= page_b) {
		tya
		sbc	#(actor::actors_page_b)-1
	: ; }

	jsr	eng_farjump
	.addr	actor_proc_enemy

	.addr	actor_proc_bowser_flame
	.addr	actor_proc_fireworks
	.addr	actor_proc_null
	.addr	actor_proc_null
	.addr	actor_proc_null
	.addr	actor_proc_null
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_null
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_small
	.addr	actor_proc_plat_small
	.addr	actor_proc_bowser

	.addr	obj_spec_powerup_do
	.addr	game_proc_vine_do

	.addr	actor_proc_null
	.addr	actor_proc_flag_victory

	.addr	game_proc_spring

	.addr	actor_proc_null

	.addr	game_proc_warp

	.addr	actor_proc_toad
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_proc_null:
	rts
.endif
; -----------------------------------------------------------
actor_proc_toad:
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jmp	render_actor
; -----------------------------------------------------------
actor_proc_enemy:
	lda	#0
	sta	actor_attr, x
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	render_actor
	jsr	col_actor_box
	jsr	col_actor_ground_proc
	jsr	col_actor_actor_proc
	jsr	col_player_actor_proc

	ldy	eng_timer_ctl
	bne	:+ ; if (!eng_timer_ctl) {
		jsr	actor_proc_enemy_do
	: ; }
	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_enemy_do:
	lda	actor_id, x
	jsr	eng_farjump
	.addr	actor_proc_base
	.addr	actor_proc_base
	.addr	actor_proc_base
	.addr	actor_proc_base

	.if	.defined(SMB)|.defined(VS_SMB)
		.addr	actor_proc_base
	.elseif	.defined(SMB2M)
		.addr	sub_C4C0
	.endif

	.addr	actor_proc_hammer_bro
	.addr	actor_proc_base
	.addr	actor_proc_bloober
	.addr	actor_proc_bullet
	.addr	actor_proc_null_b
	.addr	actor_proc_cheep
	.addr	actor_proc_cheep
	.addr	actor_proc_podoboo
	.addr	actor_proc_piranha_plant
	.addr	actor_proc_bounce
	.addr	actor_proc_koopa_red_fly
	.addr	actor_proc_koopa_green_fly
	.addr	actor_proc_lakitu
	.addr	actor_proc_base
	.addr	actor_proc_null_b
	.addr	actor_proc_cheep_fly
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_proc_null_b:
	rts
.endif
; -----------------------------------------------------------
actor_proc_bowser_flame:
	jsr	actor_proc_bowser_flame_do

	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	col_actor_box
	jsr	col_player_actor_proc

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_firebar:
	jsr	actor_proc_firebar_do

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_plat_small:
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	col_plat_s_box
	jsr	col_plat_s_proc

	jsr	lib_calc_actor_pos
	jsr	render_plat_small

	jsr	actor_proc_plat_small_do

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_plat_large:
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	col_plat_l_box
	jsr	col_plat_l_proc

	lda	eng_timer_ctl
	bne	:+ ; if (eng_timer_ctl) {
		jsr	actor_proc_plat_do
	: ; }

	jsr	lib_calc_actor_pos
	jsr	render_plat_large

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_plat_do:
	lda	actor_id, x
	sec
	sbc	#actor::plat_start
	jsr	eng_farjump
	.addr	actor_proc_plat_bal
	.addr	actor_proc_plat_mov_v
	.addr	actor_proc_plat_lift
	.addr	actor_proc_plat_lift
	.addr	actor_proc_plat_move_h
	.addr	actor_proc_plat_drop
	.addr	actor_proc_plat_right
; -----------------------------------------------------------
	.export actor_erase
actor_erase:
	lda	#0
	sta	actor_mode, x
	sta	actor_id, x
	sta	state_actor, x
	sta	STACK_BASE+$10, x
	sta	eng_timer_actor, x
	sta	STACK_BASE+$25, x
	sta	actor_attr, x
	sta	eng_timer_actor_ani, x

	rts
; -----------------------------------------------------------
PODOBOO_VELOC_Y	= <-7

actor_proc_podoboo:
	lda	eng_timer_actor, x
	bne	:+ ; if (actor.timer == 0) {
		jsr	actor_init_podoboo
		lda	eng_rand_seed+1, x
		ora	#%10000000
		sta	accel_y_actor_c, x
		and	#%00001111
		ora	#%00000110
		sta	eng_timer_actor, x
		lda	#PODOBOO_VELOC_Y
		sta	veloc_y_actor, x
	: ; }

	jmp	motion_fall_mid
; -----------------------------------------------------------
actor_hammer_bro_timers:
	.byte	48, 28

actor_proc_accel_x:
	.byte	0, <-24
	.byte	0, 24

actor_proc_veloc_x:
	.byte	ACTOR_BASE_VELOC_X, <-ACTOR_BASE_VELOC_X
	.byte	ACTOR_BASE_VELOC_X_HARD, <-ACTOR_BASE_VELOC_X_HARD
; ------------------------------
actor_proc_hammer_bro:
	lda	state_actor, x
	and	#%00100000
	beq	:+ ; if (actor.state & 0x20) {
		jmp	actor_proc_base_defeated
	: ; } else {
		lda	eng_timer_hammer_bro_jump, x
		beq	actor_proc_hammer_bro_jump ; if (eng_timer_hammer_bro_jump) {
			dec	eng_timer_hammer_bro_jump, x
			lda	bits_offscr_actor
			and	#%00001100
			bne	actor_proc_hammer_bro_move_h ; if (!(bits_offscr_actor & 0x0C)) {
				lda	eng_timer_hammer_throw, x
				bne	:+ ; if (eng_timer_hammer_throw == 0) {
					ldy	eng_hard_mode_b
					lda	actor_hammer_bro_timers, y
					sta	eng_timer_hammer_throw, x
					jsr	obj_hammer_init
					bcc	:+ ; if (obj_hammer_init()) {
						lda	state_actor, x
						ora	#%00001000
						sta	state_actor, x
						jmp	actor_proc_hammer_bro_move_h
					; }
				: ; }
			
				dec	eng_timer_hammer_throw, x
				jmp	actor_proc_hammer_bro_move_h
			; } else actor_proc_hammer_bro_move_h();
		; } else actor_proc_hammer_bro_jump();
	; }
; ------------------------------
hammer_bro_jump_timers:
	.byte	32, 55
; ------------------------------
actor_proc_hammer_bro_jump_rand	= zp_byte_00

actor_proc_hammer_bro_jump:
	lda	state_actor, x
	and	#%00000111
	cmp	#actor_states::state_1
	beq	:+++ ; if (actor.state != state_1) {
		lda	#0
		sta	zp_byte_00
		ldy	#<-6
		lda	pos_y_lo_actor, x
		bmi	:+
		ldy	#<-3
		cmp	#112
		inc	actor_proc_hammer_bro_jump_rand
		bcc	:+ ; if (actor.pos_y.lo > 112)
			dec	actor_proc_hammer_bro_jump_rand
			lda	eng_rand_seed+1, x
			and	#%00000001
			bne	:+ ; if () {
				ldy	#<-6
			; }
		: ; }
		sty	veloc_y_actor, x
	
		lda	state_actor, x
		ora	#actor_states::state_1
		sta	state_actor, x
	
		lda	actor_proc_hammer_bro_jump_rand
		and	eng_rand_seed+2, x
		tay
		lda	eng_hard_mode_b
		bne	:+ ; if (!eng_hard_mode_b) {
			tay
		: ; }
		lda	hammer_bro_jump_timers, y
		sta	eng_timer_actor_ani, x
		lda	eng_rand_seed+1, x
		ora	#%11000000
		sta	eng_timer_hammer_bro_jump, x
	: ; }
; ------------------------------
HAMMER_BRO_VELOC_X	= 4

actor_proc_hammer_bro_move_h:
	ldy	#<-HAMMER_BRO_VELOC_X
	lda	frame_count
	and	#%01000000
	bne	:+ ; if ((frame_count % 128) < 64) {
		ldy	#HAMMER_BRO_VELOC_X
	: ; }
	sty	veloc_x_actor, x

	ldy	#MOTION_DIR_RIGHT
	jsr	col_player_bullet_diff
	bmi	:+ ; if (col_player_bullet_diff() >= 0) {
		iny
		lda	eng_timer_actor, x
		bne	:+ ; if (!actor.timer) {
			lda	#<-ACTOR_BASE_VELOC_X
			sta	veloc_x_actor, x
		; }
	: ; }
	sty	motion_dir_actor, x
; -----------------------------------------------------------
	.export actor_proc_base
actor_proc_base:
	ldy	#0
	lda	state_actor, x
	and	#%01000000
	bne	:+
	lda	state_actor, x
	asl	a
	bcs	:++++
	lda	state_actor, x
	and	#%00100000
	bne	actor_proc_base_defeated
	lda	state_actor, x
	and	#%00000111
	beq	:++++
	cmp	#actor_states::state_5
	beq	:+
	cmp	#actor_states::state_3
	bcs	:++++++
	: ; if ((actor.state & 0x40) || (!(actor.state & 0xA0) && actor.state.in(1, 2, 5))) {
		jsr	motion_y
	; }
	ldy	#0
	lda	state_actor, x
	cmp	#actor_states::state_2
	beq	:+
	and	#%01000000
	beq	:+++
	lda	actor_id, x
	cmp	#actor::power_up
	beq	:+++
	bne	:++
	: ; if (((actor_state & 0x40) || !(actor_state & 0xA0)) && (actor.state == state_2)) {
		jmp	motion_x
	: ; } else if (actor.state != 2 && ()) {
		; if (actor_state & 0x40 && actor.id != power_up) {
			ldy	#1
		: ; }
	
		lda	veloc_x_actor, x
		pha

		bpl	:+ ; if (actor.veloc_x < 0) {
			iny
			iny
		: ; }
		clc
		adc	actor_proc_accel_x, y
		sta	veloc_x_actor, x
		jsr	motion_x

		pla
		sta	veloc_x_actor, x
		rts
	: ; } else {
		lda	eng_timer_actor, x
		bne	:++ ; if (actor.timer == 0) {
			sta	state_actor, x
			lda	frame_count
			and	#%00000001
			tay
			iny
			sty	motion_dir_actor, x
			dey
			.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
			lda	eng_hard_mode
			beq	:+
			.elseif	.defined(ANN)
			lda	byte_77D
			beq	:+
			lda	byte_7FB
			bne	:+
			.endif ; if ((!ANN && eng_hard_mode) || (ANN && byte_77D && !byte_7FB)) {
				iny
				iny
			: ; }
			lda	actor_proc_veloc_x, y
			sta	veloc_x_actor, x
			rts
		; } else if () {
		actor_proc_base_defeated:
			jsr	motion_y
			jmp	motion_x
		: ; } else {
			cmp	#14
			bne	:+
			lda	actor_id, x
			cmp	#actor::goomba
			bne	:+ ; if (actor.timer == 14 && actor_id == goomba) {
				jsr	actor_erase
			: ; }
		
			rts
		; }
	; }
; -----------------------------------------------------------
	.export actor_proc_bounce
actor_proc_bounce:
	jsr	motion_fall_mid
	jmp	motion_x
; -----------------------------------------------------------
actor_proc_koopa_red_fly:
	lda	veloc_y_actor, x
	ora	accel_y_actor_c, x
	bne	:++
	sta	pos_y_actor, x
	lda	pos_y_lo_actor, x
	cmp	accel_x_actor, x
	bcs	:++ ; if () {
		lda	frame_count
		and	#%00000111
		bne	:+ ; if (!(frame_count % 8)) {
			inc	pos_y_lo_actor, x
		: ; }
	
		rts
	: ; } else {
		lda	pos_y_lo_actor, x
		cmp	veloc_x_actor, x
		bcc	:+ ; if (actor.pos_y >= actor.veloc_x) {
			jmp	motion_bounce_up
		: ; } else {
			jmp	motion_bounce_down
		; }
	; }
; -----------------------------------------------------------
actor_proc_koopa_green_fly:
	jsr	actor_floater_koopa
	jsr	actor_floater_move

	ldy	#1
	lda	frame_count
	and	#%00000011
	bne	:++ ; if (!(frame_count % 4)) {
		lda	frame_count
		and	#%01000000
		bne	:+ ; if ((frame_count % 128) < 64) {
			ldy	#<-1
		: ; }
		sty	zp_byte_00
	
		lda	pos_y_lo_actor, x
		clc
		adc	zp_byte_00
		sta	pos_y_lo_actor, x
	: ; }

	rts
; -----------------------------------------------------------
actor_floater_koopa:
	lda	#19
; ----------------------------
actor_floater_do:
	sta	zp_byte_01
	lda	frame_count
	and	#%00000011
	bne	actor_floater_do_rts ; if ((frame_count % 4)) {
		ldy	veloc_x_actor, x
		lda	veloc_y_actor, x
		lsr	a
		bcs	:++
		cpy	zp_byte_01
		beq	:+ ; if (!(actor.veloc_y % 2) && actor.veloc_x != zp_byte_01) {
			inc	veloc_x_actor, x
		actor_floater_do_rts:
			rts
		: ; } else if (!(actor.veloc_y % 2) && actor.veloc_x == zp_byte_01) {
			inc	veloc_y_actor, x
			rts
		: tya
		beq	:-- ; } else {
			dec	veloc_x_actor, x
			rts
		; }
	; } else rts;
; -----------------------------------------------------------
actor_floater_move:
	lda	veloc_x_actor, x
	pha

	ldy	#MOTION_DIR_RIGHT
	lda	veloc_y_actor, x
	and	#%0000010
	bne	:+ ; if ((actor.veloc_y % 4) < 2) {
		lda	veloc_x_actor, x
		eor	#<-1
		clc
		adc	#1
		sta	veloc_x_actor, x

		ldy	#MOTION_DIR_LEFT
	: ; }
	sty	motion_dir_actor, x
	jsr	motion_x
	sta	zp_byte_00

	pla
	sta	veloc_x_actor, x
	rts
; -----------------------------------------------------------
actor_proc_blooper_flip_chance:
	.byte	%00111111
	.byte	%00000011
; ----------------------------
actor_proc_bloober:
	lda	state_actor, x
	and	#%00100000
	bne	:++++++ ; if (!(actor.state & 0x20)) {
		ldy	eng_hard_mode_b
		lda	eng_rand_seed+1, x
		and	actor_proc_blooper_flip_chance, y
		bne	:+++ ; if (!(flip_chance[is_hard] & eng_rand_seed[1])) {
			txa
			lsr	a
			bcc	:+ ; if ((actor_index % 2)) {
				ldy	motion_dir_player

				bcs	:++
			: ; } else {
				ldy	#MOTION_DIR_LEFT

				jsr	col_player_bullet_diff
				bpl	:+ ; if (col_player_bullet_diff() < 0) {
					dey
				; }
			: ; }
			sty	motion_dir_actor, x
		: ; }

		jsr	actor_proc_swim

		lda	pos_y_lo_actor, x
		sec
		sbc	accel_y_actor_c, x
		cmp	#32
		bcc	:+ ; if ((actor.pos_y.lo - actor.accel_y) >= 32) {
			sta	pos_y_lo_actor, x
		: ; }

		ldy	motion_dir_actor, x
		dey
		bne	:+ ; if () {
			lda	pos_x_lo_actor, x
			clc
			adc	veloc_x_actor, x
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_actor, x
			adc	#0
			sta	pos_x_hi_actor, x

			rts
		: ; } else {
			lda	pos_x_lo_actor, x
			sec
			sbc	veloc_x_actor, x
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_actor, x
			sbc	#0
			sta	pos_x_hi_actor, x

			rts
		; }
	: ; } else {
		jmp	motion_fall_slow
	; }
; -----------------------------------------------------------
actor_proc_swim:
	lda	veloc_y_actor, x
	and	#%00000010
	bne	:++++ ; if ((actor.veloc_y % 4) >= 2) {
		lda	frame_count
		and	#%00000111
		pha

		lda	veloc_y_actor, x
		lsr	a
		bcs	:++ ; if (!(actor.veloc_y % 2)) {
			pla
			bne	:+ ; if (!(frame_count % 8)) {
				lda	accel_y_actor_c, x
				clc
				adc	#1
				sta	accel_y_actor_c, x
				sta	veloc_x_actor, x
				cmp	#2
				bne	:+ ; if (actor.veloc_x == 2) {
					inc	veloc_y_actor, x
				; }
			: ; }

			rts
		: ; } else {
			pla
			bne	:+ ; if (!(frame_count % 8)) {
				lda	accel_y_actor_c, x
				sec
				sbc	#1
				sta	accel_y_actor_c, x
				sta	veloc_x_actor, x
				bne	:+ ; if (actor.veloc_x == 0) {
					inc	veloc_y_actor, x

					lda	#2
					sta	eng_timer_actor, x
				; }
			: ; }

			rts
		; }
	: ; } else {
		lda	eng_timer_actor, x
		beq	:+++
		: ; if (actor.timer != 0 || (actor.pos_y + 16) < player.pos_y) {
			lda	frame_count
			lsr	a
			bcs	:+ ; if (!(frame_count % 2)) {
				inc	pos_y_lo_actor, x
			: ; }

			rts
		: lda	pos_y_lo_actor, x
		adc	#16
		cmp	pos_y_lo_player
		bcc	:--- ; } else {
			lda	#0
			sta	veloc_y_actor, x

			rts
		; }
	; }
; -----------------------------------------------------------
actor_proc_bullet:
	lda	state_actor, x
	and	#%00100000
	beq	:+ ; if (actor_state & 0x20) {
		jmp	motion_fall_mid
	: ; } else {
		lda	#<-24
		sta	veloc_x_actor, x
		jmp	motion_x
	; }
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	CHEEP_VELOC_Y	= 32
.elseif	.defined(SMB2M)
	CHEEP_VELOC_Y	= 64
.endif

actor_proc_cheep_accel_x_val	= zp_byte_02
actor_proc_cheep_veloc_y_abs	= zp_byte_02
actor_proc_cheep_veloc_y	= zp_byte_03

actor_proc_cheep_accel_x:
	.byte	64, <-128, 4, 4
; -----------------------------
actor_proc_cheep:
	lda	state_actor, x
	and	#%00100000
	beq	:+ ; if (actor.state & 0x20) {
		jmp	motion_fall_slow
	: ; } else {
		sta	actor_proc_cheep_veloc_y
		lda	actor_id, x
		sec
		sbc	#actor::cheep
		tay
		lda	actor_proc_cheep_accel_x, y
		sta	actor_proc_cheep_accel_x_val
		lda	accel_x_actor, x
		sec
		sbc	actor_proc_cheep_accel_x_val
		sta	accel_x_actor, x
		lda	pos_x_lo_actor, x
		sbc	#0
		sta	pos_x_lo_actor, x
		lda	pos_x_hi_actor, x
		sbc	#0
		sta	pos_x_hi_actor, x
		lda	#CHEEP_VELOC_Y
		sta	actor_proc_cheep_veloc_y_abs
		cpx	#2
		bcc	:++++ ; if (actor.idx >= 2) {
			lda	veloc_x_actor, x
			cmp	#16
			bcc	:+ ; if (actor.veloc_x >= 16) {
				lda	pos_y_actor, x
				clc
				adc	actor_proc_cheep_veloc_y_abs
				sta	pos_y_actor, x
				lda	pos_y_lo_actor, x
				adc	actor_proc_cheep_veloc_y
				sta	pos_y_lo_actor, x
				lda	pos_y_hi_actor, x
				adc	#0

				jmp	:++
			: ; } else {
				lda	pos_y_actor, x
				sec
				sbc	actor_proc_cheep_veloc_y_abs
				sta	pos_y_actor, x
				lda	pos_y_lo_actor, x
				sbc	actor_proc_cheep_veloc_y
				sta	pos_y_lo_actor, x
				lda	pos_y_hi_actor, x
				sbc	#0
			: ; }
			sta	pos_y_hi_actor, x

			ldy	#0
			lda	pos_y_lo_actor, x
			sec
			sbc	accel_y_actor_c, x
			bpl	:+ ; if (actor.pos_y < actor.accel_y) { 
				ldy	#16
				eor	#<-1
				clc
				adc	#1
			: ; }

			cmp	#15
			bcc	:+ ; if ((actor.pos_y - actor.accel_y) >= 15) {
				tya
				sta	veloc_x_actor, x
			; }
		: ; }

		rts
	; }
; -----------------------------------------------------------
actor_firebar_pos_tbl:
actor_firebar_pos_tbl_0:
	.byte	$00, $01, $03, $04, $05, $06, $07, $07, $08
actor_firebar_pos_tbl_1:
	.byte	$00, $03, $06, $09, $0B, $0D, $0E, $0F, $10
actor_firebar_pos_tbl_2:
	.byte	$00, $04, $09, $0D, $10, $13, $16, $17, $18
actor_firebar_pos_tbl_3:
	.byte	$00, $06, $0C, $12, $16, $1A, $1D, $1F, $20
actor_firebar_pos_tbl_4:
	.byte	$00, $07, $0F, $16, $1C, $21, $25, $27, $28
actor_firebar_pos_tbl_5:
	.byte	$00, $09, $12, $1B, $21, $27, $2C, $2F, $30
actor_firebar_pos_tbl_6:
	.byte	$00, $0B, $15, $1F, $27, $2E, $33, $37, $38
actor_firebar_pos_tbl_7:
	.byte	$00, $0C, $18, $24, $2D, $35, $3B, $3E, $40
actor_firebar_pos_tbl_8:
	.byte	$00, $0E, $1B, $28, $32, $3B, $42, $46, $48
actor_firebar_pos_tbl_9:
	.byte	$00, $0F, $1F, $2D, $38, $42, $4A, $4E, $50
actor_firebar_pos_tbl_A:
	.byte	$00, $11, $22, $31, $3E, $49, $51, $56, $58
actor_firebar_pos_tbl_B:

actor_proc_firebar_flips:
	.byte	1, 3, 2, 0

actor_firebar_pos_tbl_idx:
	.byte	actor_firebar_pos_tbl_0-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_1-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_2-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_3-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_4-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_5-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_6-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_7-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_8-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_9-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_A-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_B-actor_firebar_pos_tbl

actor_proc_firebar_pos_y:
	.byte	12, 24
; -----------------------------------------------------------
FIREBAR_SHORT_COUNT	= 6
FIREBAR_LONG_COUNT	= 12

actor_firebar_loop_idx		= zp_byte_00
actor_firebar_pos_x_rel		= zp_byte_06
actor_firebar_pos_y_rel		= zp_byte_07
actor_firebar_loop_size		= zp_addr_ED
actor_firebar_veloc_y		= zp_byte_EF

actor_proc_firebar_do:
	jsr	lib_actor_bits_get
	lda	bits_offscr_actor
	and	#%00001000
	bne	:+++++++ ; if (!(actor.bits_offscr & 0x08)) {
		lda	eng_timer_ctl
		bne	:+ ; if (eng_timer_ctl == 0) {
			lda	veloc_ang_firebar, x
			jsr	actor_proc_firebar_spin
			and	#%00011111
			sta	veloc_y_actor, x
		: ; }
	
		lda	veloc_y_actor, x
		ldy	actor_id, x
		cpy	#actor::firebar_end-1
		bcc	:++
		cmp	#8
		beq	:+
		cmp	#24
		bne	:++
		: ; if (actor.id > firebar_end && (actor.veloc_y == 8 || actor.veloc_y == 24)) {
			clc
			adc	#1
			sta	veloc_y_actor, x
		: ; }
		sta	actor_firebar_veloc_y
	
		jsr	lib_calc_actor_pos
		jsr	actor_firebar_get_pos
		ldy	obj_data_offset_enemy, x
		lda	pos_y_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		sta	actor_firebar_pos_y_rel
		lda	pos_x_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_H, y
		sta	actor_firebar_pos_x_rel
		lda	#1
		sta	actor_firebar_loop_idx
		jsr	actor_firebar_col

		ldy	#FIREBAR_SHORT_COUNT-1
		lda	actor_id, x
		cmp	#actor::firebar_end-1
		bcc	:+ ; if (actor.id > firebar_end) {
			ldy	#FIREBAR_LONG_COUNT-1
		: ; }
		sty	actor_firebar_loop_size

		lda	#0
		sta	actor_firebar_loop_idx
		: ; for (i = 0; i < actor_firebar_loop_size; i++) {
			lda	actor_firebar_veloc_y
			jsr	actor_firebar_get_pos
			jsr	actor_firebar_col_draw

			lda	actor_firebar_loop_idx
			cmp	#4
			bne	:+ ; if (actor_firebar_loop_idx == 4) {
				ldy	actor_dup_offset
				lda	obj_data_offset_enemy, y
				sta	actor_firebar_pos_x_rel
			: ; }

			inc	actor_firebar_loop_idx
			lda	actor_firebar_loop_idx
			cmp	actor_firebar_loop_size
			bcc	:--
		; }
	: ; }

	rts
; -----------------------------------------------------------
actor_firebar_col_draw:
	lda	zp_byte_03
	sta	zp_byte_05
	ldy	actor_firebar_pos_x_rel
	lda	zp_byte_01

	lsr	zp_byte_05
	bcs	:+ ; if (zp_byte_03 % 2) {
		eor	#<-1
		adc	#1
	: ; }
	clc
	adc	pos_x_rel_actor
	sta	OAM_DMA_BUFFER+OBJ_POS_H, y
	sta	actor_firebar_pos_x_rel
	cmp	pos_x_rel_actor
	bcs	:+ ; if (actor_firebar_pos_x_rel < pos_x_rel_actor) {
		lda	pos_x_rel_actor
		sec
		sbc	actor_firebar_pos_x_rel

		jmp	:++
	: ; } else {
		sec
		sbc	pos_x_rel_actor
	: ; }

	cmp	#89
	bcc	:+
	lda	#<-8
	bne	:+++
	: lda	pos_y_rel_actor
	cmp	#<-8
	beq	:++ ; if ((pos_x_rel_actor < 89 || pos_x_rel_actor == -8) && pos_y_rel_actor != -8) {
		lda	zp_byte_02
		lsr	zp_byte_05
		bcs	:+ ; if (zp_byte_03 % 2) {
			eor	#<-1
			adc	#1
		: ; }
		clc
		adc	pos_y_rel_actor
	: ; }
	sta	OAM_DMA_BUFFER+OBJ_POS_V, y
	sta	actor_firebar_pos_y_rel
; -----------------------------
actor_firebar_col:
	jsr	render_firebar
	tya
	pha

	lda	eng_timer_star
	ora	eng_timer_ctl
	bne	:+++++++++
	sta	zp_byte_05
	ldy	pos_y_hi_player
	dey
	bne	:+++++++++ ; if () {
		ldy	pos_y_lo_player
		lda	player_size
		bne	:+
		lda	eng_crouch
		beq	:++
		: ; if () {
			inc	zp_byte_05
			inc	zp_byte_05
			tya
			clc
			adc	#24
			tay
		: ; }

		tya
		: ; for () {
			sec
			sbc	actor_firebar_pos_y_rel
			bpl	:+ ; if () {
				eor	#<-1
				clc
				adc	#1
			: ; }
		
			cmp	#8
			bcs	:++
			lda	actor_firebar_pos_x_rel
			cmp	#<-16
			bcs	:++ ; if (a < 8 && actor_firebar_pos_x_rel < -16) {
				lda	OAM_DMA_BUFFER+OBJ_POS_H+(OBJ_SIZE*1)
				clc
				adc	#4
				sta	zp_byte_04
				sec
				sbc	actor_firebar_pos_x_rel
				bpl	:+ ; if (zp_byte_04 < actor_firebar_pos_x_rel) {
					eor	#<-1
					clc
					adc	#1
				: ; }
			
				cmp	#8
				bcc	:++ ; if ((zp_byte_04 - actor_firebar_pos_x_rel) < 8) break;
			: ; }

			lda	zp_byte_05
			cmp	#2
			beq	:+++
			ldy	zp_byte_05
			lda	pos_y_lo_player
			clc
			adc	actor_proc_firebar_pos_y, y
			inc	zp_byte_05
			jmp	:----
		: ; }

		; if () {
			ldx	#MOTION_DIR_RIGHT
			lda	zp_byte_04
			cmp	actor_firebar_pos_x_rel
			bcs	:+ ; if (zp_byte_04 < actor_firebar_pos_x_rel) {
				inx
			: ; }
			stx	motion_dir_actor
	
			ldx	#0
			lda	actor_firebar_loop_idx
			pha
		
			jsr	col_player_harm_proc_b
		
			pla
			sta	actor_firebar_loop_idx
		; }
	: ; }

	pla
	clc
	adc	#4
	sta	actor_firebar_pos_x_rel
	ldx	actor_index
	rts
; -----------------------------------------------------------
actor_firebar_get_pos:
	pha

	and	#%00001111
	cmp	#9
	bcc	:+; if ((a & 0x0F) >= 9) {
		eor	#%00001111
		clc
		adc	#1
	: ; }
	sta	zp_byte_01
	ldy	zp_byte_00
	lda	actor_firebar_pos_tbl_idx, y
	clc
	adc	zp_byte_01
	tay
	lda	actor_firebar_pos_tbl, y
	sta	zp_byte_01

	pla
	pha

	clc
	adc	#8
	and	#%00001111
	cmp	#9
	bcc	:+ ; if () {
		eor	#%00001111
		clc
		adc	#1
	: ; }
	sta	zp_byte_02
	ldy	zp_byte_00
	lda	actor_firebar_pos_tbl_idx, y
	clc
	adc	zp_byte_02
	tay
	lda	actor_firebar_pos_tbl, y
	sta	zp_byte_02

	pla
	lsr	a
	lsr	a
	lsr	a
	tay
	lda	actor_proc_firebar_flips, y
	sta	zp_byte_03
	rts
; -----------------------------------------------------------
actor_cheep_fly_offset_y:
	.byte	<-8
	.byte	<-96
	.byte	112
	.byte	<-67
	.byte	0

actor_cheep_fly_attr:
	.byte	%00100000
	.byte	%00100000
	.byte	%00100000
	.byte	%00000000
	.byte	%00000000
; -----------------------------
actor_proc_cheep_fly:
	lda	state_actor, x
	and	#%00100000
	beq	:+ ; if () {
		lda	#0
		sta	actor_attr, x
		jmp	motion_fall_mid
	: ; } else {
		jsr	motion_x
		ldy	#13
		lda	#5
		jsr	motion_fall
		lda	accel_y_actor_c, x
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		tay
		lda	pos_y_lo_actor, x
		sec
		sbc	actor_cheep_fly_offset_y, y
		bpl	:+ ; if (actor.pos_y < actor_cheep_fly_offset_y) {
			eor	#<-1
			clc
			adc	#1
		: ; }
	
		cmp	#8
		bcs	:+ ; if ((actor.pos_y - actor_cheep_fly_offset_y) < 8) {
			lda	accel_y_actor_c, x
			clc
			adc	#16
			sta	accel_y_actor_c, x
			lsr	a
			lsr	a
			lsr	a
			lsr	a
			tay
		: ; }
	
		lda	actor_cheep_fly_attr, y
		sta	actor_attr, x
		rts
	; }
; -----------------------------------------------------------
actor_proc_lakitu_data:
	.byte	$15, $30, $40
; -----------------------------
actor_proc_lakitu:
	lda	state_actor, x
	and	#%00100000
	beq	:+ ; if (actor.state & 0x20) {
		jmp	motion_y
	: ; } else {
		lda	state_actor, x
		beq	:+ ; if (actor_state != state_0) {
			lda	#0
			sta	veloc_y_actor, x
			sta	actor_swarm_buffer
			lda	#16

			bne	:+++
		: ; } else {
			lda	#actor::spiny
			sta	actor_swarm_buffer
			ldy	#3-1
			: ; for (y = 3-1; y >= 0; y--) {
				lda	actor_proc_lakitu_data, y
				sta	zp_byte_01, y
				dey
				bpl	:-
			; }
		
			jsr	actor_proc_lakitu_spiny
		: ; }
		sta	veloc_x_actor, x

		ldy	#MOTION_DIR_RIGHT
		lda	veloc_y_actor, x
		and	#%00000001
		bne	:+ ; if (!(actor.veloc_y % 2)) {
			lda	veloc_x_actor, x
			eor	#<-1
			clc
			adc	#1
			sta	veloc_x_actor, x
			iny
		: ; }
		sty	motion_dir_actor, x
		jmp	motion_x
	; }
; -----------------------------
actor_proc_lakitu_spiny:
	ldy	#0
	jsr	col_player_bullet_diff
	bpl	:+ ; if (col_player_bullet_diff() < 0) {
		iny
		lda	zp_byte_00
		eor	#<-1
		clc
		adc	#1
		sta	zp_byte_00
	: ; }

	lda	zp_byte_00
	cmp	#$3C
	bcc	:++
	lda	#$3C
	sta	zp_byte_00
	lda	actor_id, x
	cmp	#actor::lakitu
	bne	:++
	tya
	cmp	veloc_y_actor, x
	beq	:++
	lda	veloc_y_actor, x
	beq	:+
	dec	veloc_x_actor, x
	lda	veloc_x_actor, x
	bne	:+++++++
	: ; if (zp_byte_00 < 0x3C || actor.id != lakitu || actor.veloc_y == dir_parity || actor.veloc_y == 0 || --actor.veloc_x == 0) {
		; if (actor.veloc_y == 0 || actor.veloc_x == 0) {
			tya
			sta	veloc_y_actor, x
		: ; }

		lda	zp_byte_00
		and	#%00111100
		lsr	a
		lsr	a
		sta	zp_byte_00
		ldy	#0
		lda	veloc_x_player
		beq	:+++
		lda	eng_scroll_amount
		beq	:+++ ; if (player.veloc_x != 0 && eng_scroll_amount != 0) {
			iny
			lda	veloc_x_player
			cmp	#25
			bcc	:+
			lda	eng_scroll_amount
			cmp	#2
			bcc	:+ ; if (player.veloc_x >= 25 && eng_scroll_amount >= 2) {
				iny
			: ; }
		
			lda	actor_id, x
			cmp	#actor::spiny
			bne	:+
			lda	veloc_x_player
			bne	:++
			: lda	veloc_y_actor, x
			bne	:+ ; if ((actor.id != spiny || player.veloc_x == 0) && actor.veloc_y == 0) {
				ldy	#0
			; }
		: ; }

		lda	zp_byte_01, y
		ldy	zp_byte_00
		: ; for (i = zp_byte_00; i >= 0; i--) {
			sec
			sbc	#1
	
			dey
			bpl	:-
		; }
	: ; }

	rts
; -----------------------------------------------------------
actor_bowser_ending_data:
	.byte	$1A, $58
	.byte	$98, $96, $94, $92, $90, $8E, $8C
	.byte	$8A, $88, $86, $84, $82, $80
; -----------------------------
	.export actor_bowser_ending
actor_bowser_ending:
	ldx	ppu_nmi_buffer_1_data+$27
	lda	actor_id, x
	cmp	#actor::bowser
	bne	:+
	stx	actor_index
	lda	state_actor, x
	beq	:+++
	and	#%01000000
	beq	:+
	lda	pos_y_lo_actor, x
	cmp	#<-32
	bcc	:++
	: ; if (actor.id != bowser || (actor.state != state_0 && actor_state & 0x40) || actor.pos_y >= -32) {
		lda	#music_event::none
		sta	apu_music_event
		inc	eng_gameplay_mode
		jmp	actor_killall
	: ; } else if () {
		jsr	motion_fall_slow
		jmp	actor_proc_bowser_finish
	: ; } else {
		dec	ppu_nmi_buffer_1_data+$23
		bne	:+ ; if () {
			lda	#$04
			sta	ppu_nmi_buffer_1_data+$23
			lda	ppu_nmi_buffer_1_data+$22
			eor	#$01
			sta	ppu_nmi_buffer_1_data+$22
			lda	#$22
			sta	zp_byte_05
			ldy	ppu_nmi_buffer_1_data+$28
			lda	actor_bowser_ending_data, y
			sta	zp_byte_04
			ldy	ppu_nmi_buffer_0_offset
			iny
			ldx	#clear_blocks::blank_a*METATILE_SIZE
			jsr	gfx_clear_put_do
			ldx	actor_index
			jsr	gfx_meta_step
			lda	#pulse_queue::pulse_8
			sta	apu_pulse2_queue
			lda	#noise_event::bowser_die
			sta	apu_noise_event
			inc	ppu_nmi_buffer_1_data+$28
			lda	ppu_nmi_buffer_1_data+$28
			cmp	#$0F
			bne	:+ ; if () {
				jsr	actor_init_veloc_y
				lda	#%01000000
				sta	state_actor, x
				lda	#pulse_queue::pulse_128
				sta	apu_pulse2_queue
			; }
		: ; }
	
		jmp	actor_proc_bowser_finish
	; }
; -----------------------------------------------------------
actor_proc_bowser_timer_data:
	.byte	33, 65, 17, 49
; ----------------------------
actor_proc_bowser:
	lda	state_actor, x
	and	#%00100000
	beq	:++
	lda	pos_y_lo_actor, x
	cmp	#<-32
	bcc	:--- ; if ((actor.state & 0x20) && actor.pos_y >= -32) {
	actor_killall:
		ldx	#ENG_ACTOR_MAX-2
		: ; for (x = ENG_ACTOR_MAX-2; x >= 0; x--) {
			jsr	actor_erase
	
			dex
			bpl	:-
		; }
	
		sta	actor_swarm_buffer
		ldx	actor_index
		rts
	: ; }
	lda	#0
	sta	actor_swarm_buffer
	lda	eng_timer_ctl
	beq	:+
	jmp	actor_proc_bowser_motion_skip
	: lda	ppu_nmi_buffer_1_data+$22
	bpl	:+
	jmp	:+++++++
	: ; if () {
		dec	ppu_nmi_buffer_1_data+$23
		bne	:+ ; if () {
			lda	#$20
			sta	ppu_nmi_buffer_1_data+$23
			lda	ppu_nmi_buffer_1_data+$22
			eor	#1
			sta	ppu_nmi_buffer_1_data+$22
		: ; }
	
		lda	frame_count
		and	#%00001111
		bne	:+ ; if (!(frame_count % 32))
			lda	#MOTION_DIR_LEFT
			sta	motion_dir_actor, x
		: ; }
	
		lda	eng_timer_actor_ani, x
		beq	:+
		jsr	col_player_bullet_diff
		bpl	:+ ; if (eng_timer_actor_ani && col_player_bullet_dif() < 0) {
			lda	#MOTION_DIR_RIGHT
			sta	motion_dir_actor, x
			lda	#$02
			sta	ppu_nmi_buffer_1_data+$24
			lda	#32
			sta	eng_timer_actor_ani, x
			sta	eng_timer_bowser_flame
			lda	pos_x_lo_actor, x
			cmp	#<-56
			bcs	:++++
		: ; }
	
		lda	frame_count
		and	#%00000011
		bne	:+++ ; if ((!eng_timer_actor_ani || col_player_bullet_diff() >= 0 || (actor.pos_x < -56)) && !(frame_count % 4)) {
			lda	pos_x_lo_actor, x
			cmp	ppu_nmi_buffer_1_data+$25
			bne	:+ ; if () {
				lda	eng_rand_seed, x
				and	#%00000011
				tay
				lda	actor_proc_bowser_timer_data, y
				sta	eng_bowser_rand_offset
			: ; }
		
			lda	pos_x_lo_actor, x
			clc
			adc	ppu_nmi_buffer_1_data+$24
			sta	pos_x_lo_actor, x
			ldy	motion_dir_actor, x
			cpy	#MOTION_DIR_RIGHT
			beq	:++ ; if (actor.motion_dir == right) {
				ldy	#<-1
				sec
				sbc	ppu_nmi_buffer_1_data+$25
				bpl	:+ ; if () {
					eor	#<-1
					clc
					adc	#1
					ldy	#1
				: ; }
			
				cmp	eng_bowser_rand_offset
				bcc	:+ ; if (actor.pos_x >= eng_bowser_rand_offset) {
					sty	ppu_nmi_buffer_1_data+$24
				; }
			; }
		; }
	: ; }

	lda	eng_timer_actor_ani, x
	bne	:++
	jsr	motion_fall_slow
	lda	course_no
	cmp	#course::no_06
	bcc	:+
	lda	frame_count
	and	#%00000011
	bne	:+ ; if (course_no >= no_06 && !(frame_count % 4)) {
		jsr	obj_hammer_init
	: ; }

	lda	pos_y_lo_actor, x
	cmp	#<-128
	bcc	:++ ; if (actor.pos_y >= -128) {
		lda	eng_rand_seed, x
		and	#%00000011
		tay
		lda	actor_proc_bowser_timer_data, y
		sta	eng_timer_actor_ani, x
	; }

actor_proc_bowser_motion_skip:
	jmp	:++
	: cmp	#1
	bne	:+ ; if (eng_timer_actor_ani == 1) {
		dec	pos_y_lo_actor, x
		jsr	actor_init_veloc_y
		lda	#<-2
		sta	veloc_y_actor, x
	; }
	
	: ; for () {
		lda	course_no
		cmp	#course::no_08
		beq	:+
		cmp	#course::no_06
		bcs	actor_proc_bowser_finish
		: lda	eng_timer_bowser_flame
		bne	actor_proc_bowser_finish ; if (course_no != no_07 && eng_timer_bowser_flame == 0) {
			lda	#32
			sta	eng_timer_bowser_flame
			lda	ppu_nmi_buffer_1_data+$22
			eor	#%10000000
			sta	ppu_nmi_buffer_1_data+$22
			bmi	:--
		; }
	; }

	; if () {
		jsr	actor_proc_bowser_flame_timer_init
		ldy	eng_hard_mode_b
		beq	:+ ; if (eng_hard_mode_b) {
			sec
			sbc	#16
		: ; }
		sta	eng_timer_bowser_flame
	
		lda	#actor::bowser_flame
		sta	actor_swarm_buffer
	; }

actor_proc_bowser_finish:
	jsr	actor_proc_bowser_col
	ldy	#16
	lda	motion_dir_actor, x
	lsr	a
	bcc	:+ ; if () {
		ldy	#<-16
	: ; }
	tya
	clc
	adc	pos_x_lo_actor, x
	ldy	actor_dup_offset
	sta	pos_x_lo_actor, y
	lda	pos_y_lo_actor, x
	clc
	adc	#8
	sta	pos_y_lo_actor, y
	lda	state_actor, x
	sta	state_actor, y
	lda	motion_dir_actor, x
	sta	motion_dir_actor, y
	lda	actor_index
	pha

	ldx	actor_dup_offset
	stx	actor_index
	lda	#actor::bowser
	sta	actor_id, x
	jsr	actor_proc_bowser_col

	pla
	sta	actor_index
	tax
	lda	#0
	sta	ppu_nmi_buffer_1_data+$29
	: rts
; -----------------------------
actor_proc_bowser_col:
	inc	ppu_nmi_buffer_1_data+$29
	jsr	actor_proc_toad
	lda	state_actor, x
	bne	:- ; if (actor.state == state_0) {
		lda	#10
		sta	col_box_actor, x
		jsr	col_actor_box
		jmp	col_player_actor_proc
	; }
; -----------------------------------------------------------
actor_proc_bowser_flame_timer_data:
	.byte	191, 64, 191, 191, 191, 64, 64, 191
; ----------------------------
actor_proc_bowser_flame_timer_init:
	ldy	ppu_nmi_buffer_1_data+$26
	inc	ppu_nmi_buffer_1_data+$26
	lda	ppu_nmi_buffer_1_data+$26
	and	#%00000111
	sta	ppu_nmi_buffer_1_data+$26
	lda	actor_proc_bowser_flame_timer_data, y
	: rts
; -----------------------------------------------------------
actor_proc_bowser_flame_obj_tile	= zp_byte_00
actor_proc_bowser_flame_obj_attr	= zp_byte_01

actor_proc_bowser_flame_do:
	lda	eng_timer_ctl
	bne	:++ ; if (eng_timer_ctl == 0) {
		lda	#64
		ldy	eng_hard_mode_b
		beq	:+ ; if (eng_hard_mode_b) {
			lda	#96
		: ; }
		sta	zp_byte_00

		lda	accel_x_actor, x
		sec
		sbc	zp_byte_00
		sta	accel_x_actor, x
		lda	pos_x_lo_actor, x
		sbc	#1
		sta	pos_x_lo_actor, x
		lda	pos_x_hi_actor, x
		sbc	#0
		sta	pos_x_hi_actor, x
		ldy	pos_y_actor, x
		lda	pos_y_lo_actor, x
		cmp	bowser_flame_pos_y_offset, y
		beq	:+ ; if () {
			clc
			adc	accel_y_actor_c, x
			sta	pos_y_lo_actor, x
		; }
	: ; }

	jsr	lib_calc_actor_pos
	lda	state_actor, x
	bne	:---
	lda	#tile_obj::fire_koopa
	sta	actor_proc_bowser_flame_obj_tile

	ldy	#obj_attr::color2
	lda	frame_count
	and	#%00000010
	beq	:+ ; if ((frame_count % 4) >= 2) {
		ldy	#obj_attr::v_flip|obj_attr::color2
	: ; }
	sty	actor_proc_bowser_flame_obj_attr

	ldy	obj_data_offset_enemy, x
	ldx	#0
	: ; for (tile of bowser_flame) {
		lda	pos_y_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		lda	actor_proc_bowser_flame_obj_tile
		sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
		inc	actor_proc_bowser_flame_obj_tile
		lda	actor_proc_bowser_flame_obj_attr
		sta	OAM_DMA_BUFFER+OBJ_ATTR, y
		lda	pos_x_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_H, y
		clc
		adc	#PPU_TILE_WIDTH_PX
		sta	pos_x_rel_actor

		iny
		iny
		iny
		iny
		inx
		cpx	#tile_obj::fire_koopa_end-tile_obj::fire_koopa
		bcc	:-
	; }

	ldx	actor_index
	jsr	lib_actor_bits_get

	ldy	obj_data_offset_enemy, x
	lda	bits_offscr_actor
	lsr	a
	pha

	bcc	:+ ; if () {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*3), y
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if () {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*2), y
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if () {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*1), y
	: ; }

	pla
	lsr	a
	bcc	:+ ; if () {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*0), y
	: ; }

	rts
; -----------------------------------------------------------
actor_proc_fireworks:
	dec	veloc_y_actor, x
	bne	:+
	lda	#8
	sta	veloc_y_actor, x
	inc	veloc_x_actor, x
	lda	veloc_x_actor, x
	cmp	#3
	bcs	:++
	: ; if (--actor.veloc_y > 0 || ++actor.veloc_x < 3) {
		jsr	lib_calc_actor_pos
		lda	pos_y_rel_actor
		sta	pos_y_rel_proj
		lda	pos_x_rel_actor
		sta	pos_x_rel_proj
		ldy	obj_data_offset_enemy, x
		lda	veloc_x_actor, x
		jsr	render_fireworks
		rts
	: ; } else {
		lda	#actor_modes::free
		sta	actor_mode, x
		lda	#pulse_queue::pulse_8
		sta	apu_pulse2_queue
		lda	#$05
		sta	STACK_BASE+$38
		jmp	actor_proc_course_end_stats
	; }
; -----------------------------------------------------------
actor_proc_flag_pos_y:
	.byte	0, 0, 8, 8

actor_proc_flag_pos_x:
	.byte	0, 8, 0, 8

actor_proc_flag_chr_nos:
	.byte	tile_obj::flag_victory
	.byte	tile_obj::flag_victory+1
	.byte	tile_obj::flag_victory+2
	.byte	tile_obj::flag_victory+3
actor_proc_flag_chr_nos_end:
; ----------------------------
	.export actor_proc_flag_victory_tbl
	.export actor_proc_flag_victory_tbl_null
	.export actor_proc_flag_victory_tbl_fireworks
	.export actor_proc_flag_victory_tbl_timer_score
	.export actor_proc_flag_victory_tbl_raise
	.export actor_proc_flag_victory_tbl_delay
	.export actor_proc_flag_victory_tbl_done
actor_proc_flag_victory:
	lda	#0
	sta	actor_swarm_buffer
	lda	actor_proc_flag_victory_id
	cmp	#<victory_flag_proc::done
	bcs	actor_proc_flag_victory_fireworks_rts
	jsr	eng_farjump
actor_proc_flag_victory_tbl:
actor_proc_flag_victory_tbl_null:
	.addr	actor_proc_flag_victory_fireworks_rts
actor_proc_flag_victory_tbl_fireworks:
	.addr	actor_proc_flag_victory_fireworks
actor_proc_flag_victory_tbl_timer_score:
	.addr	actor_proc_flag_victory_timer_score
actor_proc_flag_victory_tbl_raise:
	.addr	actor_proc_flag_victory_raise
actor_proc_flag_victory_tbl_delay:
	.addr	actor_proc_flag_victory_delay
actor_proc_flag_victory_tbl_done:
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	ENG_TIMER_DISP	= eng_timer_disp
.elseif	.defined(SMB2M)
	ENG_TIMER_DISP	= eng_timer_disp_b
.endif

actor_proc_flag_victory_fireworks:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	#actor_states::state_5
		lda	ENG_TIMER_DISP+2
		cmp	#1
		beq	:+ ; if (eng_timer_disp[2] != 1) {
			ldy	#actor_states::state_3
	
			cmp	#3
			beq	:+ ; if (eng_timer_disp[2] != 3) {
				ldy	#actor_states::state_0
	
				cmp	#6
				beq	:+ ; if (eng_timer_disp[2] != 6) {
					lda	#<-1
				; }
			; }
		: ; }
	.elseif	.defined(SMB2M)
	        lda     ENG_TIMER_DISP+2
	        cmp     byte_7E8
	        bne     :++
	        and     #%00000001
	        beq     :+ ; if ((byte_7EE == byte_7E8) && (byte_7EE % 2)) {
	        	ldy     #actor_states::state_3
	        	lda     #3

	        	bne     :+++
		: ; } else if ((byte_7EE == byte_7E8) && !(byte_7EE % 2)) {
	        	ldy     #actor_states::state_0
	        	lda     #6

	        	bne     :++
		: ; } else {
	        	ldy     #actor_states::state_0
			lda	#<-1
		: ; }
	.endif
	sta	actor_firework_counter
	sty	state_actor, x

actor_proc_flag_victory_fireworks_step:
	inc	actor_proc_flag_victory_id

actor_proc_flag_victory_fireworks_rts:
	rts
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
ACTOR_PROC_FLAG_VICTORY_TIMER_VAL	= $23
.elseif	.defined(SMB2M)
ACTOR_PROC_FLAG_VICTORY_TIMER_VAL	= $17
.endif

	.export actor_proc_flag_victory_timer_score_do
	.export actor_proc_course_end_stats
actor_proc_flag_victory_timer_score:
	lda	ENG_TIMER_DISP
	ora	ENG_TIMER_DISP+1
	ora	ENG_TIMER_DISP+2
	beq	actor_proc_flag_victory_fireworks_step

actor_proc_flag_victory_timer_score_do:
	lda	frame_count
	and	#%00000100
	beq	:+ ; if ((frame_count % 8) >= 4) {
		lda	#pulse_queue::pulse_16
		sta	apu_pulse2_queue
	: ; }

	ldy	#ACTOR_PROC_FLAG_VICTORY_TIMER_VAL
	lda	#$FF
	sta	STACK_BASE+$39
	jsr	eng_stats_math
	lda	#$05
	sta	STACK_BASE+$39
; ------------------------------
actor_proc_course_end_stats:
	ldy	#$0B

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	player_id
		beq	:+ ; if (player_id) {
			ldy	#$11
		: ; }
	.endif

	jsr	eng_stats_math

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	player_id
		asl	a
		asl	a
		asl	a
		asl	a
		ora	#%00000100
	.elseif	.defined(SMB2M)
		lda	#2
	.endif
	jmp	obj_misc_add_score
; -----------------------------------------------------------
actor_proc_flag_victory_raise:
	lda	pos_y_lo_actor, x
	cmp	#114
	bcc	:+ ; if (actor.pos_y >= 114) {
		dec	pos_y_lo_actor, x

		jmp	actor_proc_flag_victory_draw
	: lda	actor_firework_counter
	beq	actor_proc_flag_victory_start_flag
	bmi	actor_proc_flag_victory_start_flag ; } else if (actor_firework_counter > 0) {
		lda	#actor::fireworks
		sta	actor_swarm_buffer
	; } else actor_proc_flag_victory_start_flag();
; ------------------------------
actor_proc_flag_victory_draw:
	jsr	lib_calc_actor_pos
	ldy	obj_data_offset_enemy, x
	ldx	#(actor_proc_flag_chr_nos_end-actor_proc_flag_chr_nos)-1
	: ; for () {
		lda	pos_y_rel_actor
		clc
		adc	actor_proc_flag_pos_y, x
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		lda	actor_proc_flag_chr_nos, x
		sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
		lda	#obj_attr::priority_low|obj_attr::color2
		sta	OAM_DMA_BUFFER+OBJ_ATTR, y
		lda	pos_x_rel_actor
		clc
		adc	actor_proc_flag_pos_x, x
		sta	OAM_DMA_BUFFER+OBJ_POS_H, y

		iny
		iny
		iny
		iny
		dex
		bpl	:-
	; }

	ldx	actor_index
	rts
; -----------------------------
actor_proc_flag_victory_start_flag:
	jsr	actor_proc_flag_victory_draw
	lda	#6
	sta	eng_timer_actor, x

actor_proc_flag_victory_next:
	inc	actor_proc_flag_victory_id
	rts
; -----------------------------------------------------------
actor_proc_flag_victory_delay:
	jsr	actor_proc_flag_victory_draw

	lda	eng_timer_actor, x
	bne	:+ ; if (actor.timer == 0) {
		lda	snd_ram+1
		beq	actor_proc_flag_victory_next
	: ; }

	rts
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
PIRANHA_PLANT_CUTOFF_A	= 33
.elseif	.defined(ANN)
PIRANHA_PLANT_CUTOFF_A	= 19
.endif

actor_proc_piranha_plant:
	lda	state_actor, x
	bne	:++++++
	lda	eng_timer_actor_ani, x
	bne	:++++++ ; if (actor_state == state_0 && eng_timer_actor_ani == 0) {
		lda	veloc_y_actor, x
		bne	:+++
		lda	veloc_x_actor, x
		bmi	:++ ; if (actor.veloc_y == 0 && actor.veloc_x >= 0) {
			jsr	col_player_bullet_diff
			bpl	:+ ; if (col_player_bullet_diff() < 0) {
				lda	zp_byte_00
				eor	#<-1
				clc
				adc	#1
				sta	zp_byte_00
			: ; }
		
			lda	zp_byte_00
			actor_proc_piranha_plant_smb2_cmp:
			cmp	#PIRANHA_PLANT_CUTOFF_A
			bcc	:+++++
		: ; }
	
		; if (actor.veloc_y != 0 || actor.veloc_x < 0 || zp_byte_00_abs >= 0x21) {
			; if (actor.veloc_y == 0) {
				lda	veloc_x_actor, x
				eor	#<-1
				clc
				adc	#1
				sta	veloc_x_actor, x
				inc	veloc_y_actor, x
			: ; }
		
			lda	accel_y_actor_c, x
			ldy	veloc_x_actor, x
			bpl	:+ ; if (actor.veloc_y < 0) {
				lda	pos_y_actor, x
			: ; }
			sta	zp_byte_00

			.if	.defined(SMB2)
				lda	data_B517
				cmp	#$22
				beq	:+
			.endif
		
			lda	frame_count
			lsr	a
			bcc	:++
			: lda	eng_timer_ctl
			bne	:+ ; if (((SMB2 && data_B517 == 0x22) || ((frame_count % 2)) && eng_timer_ctl == 0) {
				lda	pos_y_lo_actor, x
				clc
				adc	veloc_x_actor, x
				sta	pos_y_lo_actor, x
				cmp	zp_byte_00
				bne	:+ ; if (actor.pos_y == zp_byte_00) {
					lda	#0
					sta	veloc_y_actor, x
					lda	#64
					sta	eng_timer_actor_ani, x
				; }
			; }
		; }
	: ; }

	lda	#%00100000
	sta	actor_attr, x
	rts
; -----------------------------------------------------------
actor_proc_firebar_spin_accel_x	= zp_byte_07

actor_proc_firebar_spin:
	sta	actor_proc_firebar_spin_accel_x
	lda	pos_x_hi_victory_right, x
	bne	:+ ; if (victory_right.pos_x_hi == 0) {
		ldy	#24
		lda	veloc_x_actor, x
		clc
		adc	actor_proc_firebar_spin_accel_x
		sta	veloc_x_actor, x
		lda	veloc_y_actor, x
		adc	#0

		rts
	: ; } else {
		ldy	#8
		lda	veloc_x_actor, x
		sec
		sbc	actor_proc_firebar_spin_accel_x
		sta	veloc_x_actor, x
		lda	veloc_y_actor, x
		sbc	#0

		rts
	; }
; -----------------------------------------------------------
actor_proc_plat_bal:
	lda	pos_y_hi_actor, x
	cmp	#3
	bne	:+ ; if (actor.pos_y >= 0x300) {
		jmp	actor_erase
	: lda	state_actor, x
	bpl	:++
	: ; } else if (actor.state & 0x80 || actor.id != plat_bal) {
		rts
	: ; }
	tay

	.if	.defined(SMB2M)
		lda	actor_id, y
		cmp	#actor::plat_bal
		bne	:--
	.endif

	lda	eng_timer_hammer_throw, x
	sta	zp_byte_00
	lda	motion_dir_actor, x
	beq	:+ ; if (actor.motion_dir != 0) {
		jmp	actor_proc_plat_fall_do
	: lda	#45
	cmp	pos_y_lo_actor, x
	bcc	:++
	cpy	zp_byte_00
	beq	:+ ; } else if (actor.pos_y >= 45 && actor.state != eng_timer_hammer_throw) {
		clc
		adc	#2
		sta	pos_y_lo_actor, x
		jmp	actor_proc_plat_stop
	: ; } else if () {
		jmp	actor_init_plat_fall
	: cmp	pos_y_lo_actor, y
	bcc	:+
	cpx	zp_byte_00
	beq	:-- ; } else if () {
		clc
		adc	#2
		sta	pos_y_lo_actor, y
		jmp	actor_proc_plat_stop
	: ; }

	lda	pos_y_lo_actor, x
	pha

	lda	eng_timer_hammer_throw, x
	bpl	:+
	lda	accel_y_actor_c, x
	clc
	adc	#5
	sta	zp_byte_00
	lda	veloc_y_actor, x
	adc	#0
	bmi	:++++
	bne	:++
	lda	zp_byte_00
	cmp	#11
	bcc	:+++
	bcs	:++
	: cmp	actor_index
	beq	:+++
	: ; if () {
		jsr	motion_platform_up

		jmp	:+++
	: ; } else if () {
		jsr	actor_proc_plat_stop

		jmp	:++
	: ; } else {
		jsr	motion_platform_down
	: ; }

	ldy	state_actor, x

	pla
	sec
	sbc	pos_y_lo_actor, x
	clc
	adc	pos_y_lo_actor, y
	sta	pos_y_lo_actor, y
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if () {
		tax
		jsr	col_DC21
	: ; }

	ldy	actor_index
	lda	veloc_y_actor, y
	ora	accel_y_actor_c, y
	beq	:+++++
	ldx	ppu_nmi_buffer_0_offset
	cpx	#32
	bcs	:+++++ ; if () {
		lda	veloc_y_actor, y
		pha
		pha

		jsr	actor_init_plat_rope
		lda	zp_byte_01
		sta	ppu_nmi_buffer_0_data+0, x
		lda	zp_byte_00
		sta	ppu_nmi_buffer_0_data+1, x
		lda	#2
		sta	ppu_nmi_buffer_0_data+2, x
		lda	veloc_y_actor, y
		bmi	:+ ; if (actor.veloc_y >= 0) {
			lda	#tile_bg::pole
			sta	ppu_nmi_buffer_0_data+3, x
			lda	#tile_bg::pole+1
			sta	ppu_nmi_buffer_0_data+4, x
	
			jmp	:++
		: ; } else {
			lda	#' '
			sta	ppu_nmi_buffer_0_data+3, x
			sta	ppu_nmi_buffer_0_data+4, x
		: ; }
	
		lda	state_actor, y
		tay

		pla
		eor	#<-1
		jsr	actor_init_plat_rope
		lda	zp_byte_01
		sta	ppu_nmi_buffer_0_data+5, x
		lda	zp_byte_00
		sta	ppu_nmi_buffer_0_data+6, x
		lda	#2
		sta	ppu_nmi_buffer_0_data+7, x
	
		pla
		bpl	:+ ; if () {
			lda	#tile_bg::pole
			sta	ppu_nmi_buffer_0_data+8, x
			lda	#tile_bg::pole+1
			sta	ppu_nmi_buffer_0_data+9, x
	
			jmp	:++
		: ; } else {
			lda	#' '
			sta	ppu_nmi_buffer_0_data+8, x
			sta	ppu_nmi_buffer_0_data+9, x
		: ; }
	
		lda	#NMI_DATA_END
		sta	ppu_nmi_buffer_0_data+10, x
		lda	ppu_nmi_buffer_0_offset
		clc
		adc	#2*(WORD_SIZE+1+2)
		sta	ppu_nmi_buffer_0_offset
	: ; }

	ldx	actor_index
	rts
; -----------------------------------------------------------
actor_init_plat_rope:
	pha

	lda	pos_x_lo_actor, y
	clc
	adc	#8
	ldx	eng_hard_mode_b
	bne	:+ ; if (!eng_hard_mode_b)) {
		clc
		adc	#16
	: ; }
	pha

	lda	pos_x_hi_actor, y
	adc	#0
	sta	zp_byte_02

	pla
	and	#%11110000
	lsr	a
	lsr	a
	lsr	a
	sta	zp_byte_00
	ldx	pos_y_lo_actor, y

	pla
	bpl	:+ ; if () {
		txa
		clc
		adc	#8
		tax
	: ; }
	txa
	ldx	ppu_nmi_buffer_0_offset
	asl	a
	rol	a
	pha

	rol	a
	and	#%00000011
	ora	#%00100000
	sta	zp_byte_01
	lda	zp_byte_02
	and	#%00000001
	asl	a
	asl	a
	ora	zp_byte_01
	sta	zp_byte_01

	pla
	and	#%11100000
	clc
	adc	zp_byte_00
	sta	zp_byte_00
	lda	pos_y_lo_actor, y
	cmp	#<-24
	bcc	:+ ; if () {
		lda	zp_byte_00
		and	#<~%01000000
		sta	zp_byte_00
	: ; }

	rts
; -----------------------------------------------------------
actor_init_plat_fall:
	tya
	tax
	jsr	lib_actor_bits_get
	lda	#6
	jsr	col_DA11
	lda	pos_x_rel_player
	sta	STACK_BASE+$17, x
	lda	pos_y_lo_player
	sta	STACK_BASE+$1E, x
	lda	#MOTION_DIR_RIGHT
	sta	motion_dir_actor, x
; ------------------------------
actor_proc_plat_stop:
	jsr	actor_init_veloc_y
	sta	veloc_y_actor, y
	sta	accel_y_actor_c, y
	rts
; -----------------------------------------------------------
actor_proc_plat_fall_do:
	tya
	pha

	jsr	motion_y_state_5

	pla
	tax
	jsr	motion_y_state_5

	ldx	actor_index
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if (eng_timer_hammer_throw >= 0) {
		tax
		jsr	col_DC21
	: ; }

	ldx	actor_index
	rts
; -----------------------------------------------------------
actor_proc_plat_mov_v:
	lda	veloc_y_actor, x
	ora	accel_y_actor_c, x
	bne	:++
	sta	pos_y_actor, x
	lda	pos_y_lo_actor, x
	cmp	accel_x_actor, x
	bcs	:++ ; if (actor.pos_y < actor.accel_x) {
		lda	frame_count
		and	#%00000111
		bne	:+ ; if (!(frame_count % 8)) {
			inc	pos_y_lo_actor, x
		: ; }
	
		jmp	:+++
	: ; } else {
		lda	pos_y_lo_actor, x
		cmp	veloc_x_actor, x
		bcc	:+ ; if (actor.pos_y >= actor.veloc_x) {
			jsr	motion_platform_up
	
			jmp	:++
		: ; } else {
			jsr	motion_platform_down
		: ; }
	; }
; ------------------------------
actor_proc_plat_lift_player:
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if (eng_timer_hammer_throw >= 0) {
		jsr	col_DC21
	: ; }

	rts
; -----------------------------------------------------------
actor_proc_plat_move_h:
	lda	#14
	jsr	actor_floater_do
	jsr	actor_floater_move
	lda	eng_timer_hammer_throw, x
	bmi	:+++ ; if (hammer_throw_timer >= 0) {
	actor_proc_plat_move_player_h:
		lda	pos_x_lo_player
		clc
		adc	zp_byte_00
		sta	pos_x_lo_player
		lda	pos_x_hi_player
		ldy	zp_byte_00
		bmi	:+ ; if (zp_byte_00 >= 0) {
			adc	#0
	
			jmp	:++
		: ; } else {
			sbc	#0
		: ; }
		sta	pos_x_hi_player
		sty	actor_plat_scroll_x
		jsr	col_DC21
	: ; }

	rts
; -----------------------------------------------------------
actor_proc_plat_drop:
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if () {
		jsr	motion_fall_fast
		jsr	col_DC21
	: ; }

	rts
; -----------------------------------------------------------
actor_proc_plat_right:
	jsr	motion_x
	sta	zp_byte_00
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if () {
		lda	#16
		sta	veloc_x_actor, x
		jsr	actor_proc_plat_move_player_h
	: ; }

	rts
; -----------------------------------------------------------
actor_proc_plat_lift:
	jsr	actor_proc_plat_lift_move
	jmp	actor_proc_plat_lift_player
; -----------------------------------------------------------
actor_proc_plat_small_do:
	jsr	actor_proc_plat_lift_move
	jmp	actor_proc_plat_lift_col
; -----------------------------------------------------------
actor_proc_plat_lift_move:
	lda	eng_timer_ctl
	bne	actor_proc_plat_lift_col_rts ; if (!eng_timer_ctl) {
		lda	pos_y_actor, x
		clc
		adc	accel_y_actor_c, x
		sta	pos_y_actor, x
		lda	pos_y_lo_actor, x
		adc	veloc_y_actor, x
		sta	pos_y_lo_actor, x
		rts
	; } else rts;
; -----------------------------
actor_proc_plat_lift_col:
	lda	eng_timer_hammer_throw, x
	beq	:+ ; if () {
		jsr	col_DC19
	: ; }

actor_proc_plat_lift_col_rts:
	rts
