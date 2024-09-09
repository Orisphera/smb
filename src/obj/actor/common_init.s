.include	"system/vs.i"

.include	"math.i"
.include	"mem.i"
.include	"tunables.i"
.include	"misc.i"
.include	"course_flags.i"

.include	"unk.i"

; -----------------------------------------------------------
ACTOR_PAGE_A_OFFSET_Y	= 8
ACTOR_INIT_BITS_MASK	= %00000001
ACTOR_LOOP_SCROLL_INC	= 4
ACTOR_LOOP_OFFSET_X	= 48

.if	.defined(CONS)
	COURSE_SCENERY_LOOP_OFFSETS	= course_scenery_loop_offsets
.elseif	.defined(VS)
	COURSE_SCENERY_LOOP_OFFSETS	= VS_RAM
.endif
; -----------------------------------------------------------
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
		.byte	64, 176, 176
	
		.if	.defined(SMB)
			.byte	128
		.elseif	.defined(VS_SMB)
			.byte	64
		.endif
	
		.byte	64
	
		.if	.defined(SMB)
			.byte	64
			.byte	128
			.byte	64
		.elseif	.defined(VS_SMB)
			.byte	176
			.byte	64
			.byte	128
		.endif
	
		.byte	240
		.byte	240
		.byte	240
	.elseif	.defined(SMB2)
		.byte	176
		.byte	176
		.byte	64
		.byte	48
		.byte	176
		.byte	48
		.byte	176
		.byte	176
		.byte	240
		.byte	240
		.byte	176
		.byte	240
	.elseif	.defined(ANN)
		.byte	176
		.byte	64
		.byte	64
		.byte	64
		.byte	64
		.byte	64
		.byte	128
		.byte	128
		.byte	240
		.byte	176
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
	sbc	#ACTOR_LOOP_SCROLL_INC
	sta	pos_x_hi_player
	lda	pos_x_hi_game
	sec
	sbc	#ACTOR_LOOP_SCROLL_INC
	sta	pos_x_hi_game
	lda	pos_x_hi_screen_left
	sec
	sbc	#ACTOR_LOOP_SCROLL_INC
	sta	pos_x_hi_screen_left
	lda	pos_x_hi_screen_right
	sec
	sbc	#ACTOR_LOOP_SCROLL_INC
	sta	pos_x_hi_screen_right
	lda	scenery_page_loc
	sec
	sbc	#ACTOR_LOOP_SCROLL_INC
	sta	scenery_page_loc
	lda	#0
	sta	actor_page_on
	sta	scenery_page_on
	sta	actor_offset
	sta	actor_page_loc

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	lda	COURSE_SCENERY_LOOP_OFFSETS, y
	sta	scenery_offset

	rts
; ------------------------------
actor_loop:
	lda	eng_loop_flag
	beq	:+++++
	lda	pos_x_lo_game
	bne	:+++++ ; if (eng_loop_flag != 0 && pos_x_lo_game == 0) {
		ldy	#LOOP_VAL_COUNT
		: ; for (loop_descriptor in loop_descriptors) {
			dey
			bmi	:++++

			lda	course_no
			cmp	actor_loop_courses, y
			bne	:-
			lda	pos_x_hi_game
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
		lda	#actor_states::init
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
		adc	#<ACTOR_LOOP_OFFSET_X
		and	#CLAMP_16
		sta	actor_loop_screen_right_pos_x_lo
		lda	pos_x_hi_screen_right
		adc	#>ACTOR_LOOP_OFFSET_X
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
						lda	game_hard_mode_b
						beq	actor_special_do
						: ; if (!actor.hard_only || game_hard_mode_b || CONS) {
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
									ldy	game_hard_mode
									beq	:+
									.elseif	.defined(ANN)
									ldy	byte_77D
									beq	:+
									ldy	ENG_HARDMODE_VAR
									bne	:+
									.endif ; if (
									;	actor == ACTOR_SWAPPABLE_EASY
									;	&& ((!ANN && game.hard_mode) || (ANN && byte_77D && !game.hard_mode))
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
		lda	#actor_states::init
		sta	state_actor, x
		jsr	actor_init_do
	: ; }

	rts
; -----------------------------------------------------------
actor_group:
	jmp	actor_group_do
; -----------------------------------------------------------
	.export actor_special_do
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
		sta	pos_x_hi_init_game
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
	.export actor_init_do
actor_init_do:
	lda	actor_id, x
	cmp	#actor::actors_page_b
	bcs	:+ ; if (actor.id < page_b) {
		tay
		lda	pos_y_lo_actor, x
		adc	#ACTOR_PAGE_A_OFFSET_Y
		sta	pos_y_lo_actor, x
		lda	#ACTOR_INIT_BITS_MASK
		sta	actor_bits_mask, x
		tya
	: ; }

	jsr	tbljmp
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
	.addr	actor_init_blooper
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
	.addr	actor_init_powerup

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
