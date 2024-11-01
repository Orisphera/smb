.include	"system/cpu.i"
.include	"system/ppu.i"
.include	"system/palettes.i"

.include	"mem.i"
.include	"chr.i"
.include	"charmap.i"
.include	"joypad.i"
.include	"sound.i"
.include	"tunables.i"
.include	"modes.i"
.include	"misc.i"

	.export sys_victory
sys_victory:
	jsr	victory_enter

	lda	mode_game
	beq	:++
	.if	.defined(SMB2M)
		ldx	course_no
		cpx	#course::no_08
		bne	:+
		cmp	#victory_modes_ending::disk_data3
		beq	sys_victory-1
		cmp	#victory_modes_ending::disk_save
		beq	sys_victory-1
		; NOTE: This assumes this module follows an rts
	.endif
	; if (!SMB2M || course_no != no_08 || mode_game.not_in(data3, save)) {
		: ; if (mode_game != actor_bowser_ending && (!SMB2M || course_no == no_08)) {
			ldx	#0
			stx	actor_index
			jsr	actor_proc
		: ; }

		jsr	lib_calc_player_pos
		jmp	render_player
	; } else rts;
; -----------------------------------------------------------
victory_enter:
	.if	.defined(SMB2M)
		lda	course_no
		cmp	#course::no_08
		beq	victory_course_8 ; if (!SMB2M || course_no != course_8) {
	.endif
		lda	mode_game
		jsr	tbljmp
		.addr	actor_bowser_ending
		.addr	victory_init
		.addr	victory_proc
		.addr	victory_msg
		.if	.defined(SMB2M)|.defined(VS_SMB)
			.addr	victory_time_tally
		.endif
		.addr	victory_finish
		.if	.defined(VS_SMB)
			.addr	victory_84CF
			.addr	victory_8526
			.addr	victory_85E0
			.addr	victory_864C
			.addr	victory_865D
		.endif
	.if	.defined(SMB2M)
	victory_course_8: ; } else {
		lda	mode_game
		jsr	tbljmp
		.addr	actor_bowser_ending
		.addr	victory_init
		.addr	victory_proc
		.addr	disk_loader_victory_init
		.addr	disk_loader_victory_check
		.addr	disk_loader_data3
		.addr	ending_screen_proc
		.addr	ending_victory_msg
		.addr	victory_time_tally
		.addr	ending_extra_lives
		.addr	ending_palcycle
		.addr	ending_lives_draw
		.addr	ending_toad_proc
		.addr	disk_loader_save
	; }
	.endif
; -----------------------------------------------------------
	.if	.defined(ANN)
	ann_toads:
		.addr	ann_toad_1
		.addr	ann_toad_2
		.addr	ann_toad_3
		.addr	ann_toad_4
		.addr	ann_toad_5
		.addr	ann_toad_6
		.addr	ann_toad_7

	ann_toads_hi:
		.byte	>chr_obj_toad
		.byte	>chr_obj_toads_nsm
		.byte	>chr_obj_nsm_char_c
	ann_toads_lo:
		.byte	<chr_obj_toad
		.byte	<chr_obj_toads_nsm
		.byte	<chr_obj_nsm_char_c
	ann_toads_size:
		.byte	$30, $50, $60
; ----------------------------
		.export ann_toad_load
	ann_toad_load:
		lda	player_goals
		cmp	#ENG_HARDMODE_B_GOAL
		bne	:+++
		ldy	ENG_HARDMODE_VAR
		bne	:+++ ; if (player.goals == ENG_HARDMODE_B_GOAL && !ENG_HARDMODE_VAR) {
			sty	zp_byte_06

			lda	course_no
			asl	a
			tax
			lda	ann_toads, x
			sta	zp_addr_00
			inx
			lda	ann_toads, x
			sta	zp_addr_00+1
			: ; for (i = 0; i < 3; i++) {
				ldx	zp_byte_06
				lda	ann_toads_hi, x
				sta	PPU_VRAM_AR
				lda	ann_toads_lo, x
				sta	PPU_VRAM_AR
				: ; for (j; j != ann_toads_size[j]; j++) {
					lda	(zp_addr_00), y
					sta	PPU_VRAM_IO

					iny
					tya
					cmp	ann_toads_size, x
					bne	:-
				; }

				inc	zp_byte_06
				lda	zp_byte_06
				cmp	#3
				bne	:--
			: ; }
		; }

		jmp	screen_title_bg_finish
	.endif
; -----------------------------------------------------------
	.if	.defined(SMB2)
	victory_init_mask:
		.byte	1<<0, 1<<1, 1<<2, 1<<3
		.byte	1<<4, 1<<5, 1<<6, 1<<7
	.elseif	.defined(ANN)
		.export ann_toad_pal_common
	ann_toads_pal_a:
	ann_toads_pal_a_1:
		.addr	ann_toad_pal_1
	ann_toads_pal_a_2:
		.addr	ann_toad_pal_2
	ann_toads_pal_a_3:
		.addr	ann_toad_pal_3
	ann_toads_pal_a_4:
		.addr	ann_toad_pal_4

	ann_toads_pal_offsets:
		.byte	ann_toads_pal_a_3-ann_toads_pal_a
		.byte	ann_toads_pal_a_2-ann_toads_pal_a
		.byte	ann_toads_pal_a_1-ann_toads_pal_a
		.byte	ann_toads_pal_a_3-ann_toads_pal_a
		.byte	ann_toads_pal_a_2-ann_toads_pal_a
		.byte	ann_toads_pal_a_1-ann_toads_pal_a
		.byte	$08

	ann_toad_pal_base:
	ann_toad_pal_1:
		.byte	PPU_COLOR_GREY3, PPU_COLOR_BLUE1

	ann_toad_pal_2:
		.byte	PPU_COLOR_GREY3, PPU_COLOR_GREEN1

	ann_toad_pal_3:
		.byte	PPU_COLOR_GREY3, PPU_COLOR_RED1

	ann_toad_pal_4:
		.byte	PPU_COLOR_ORANGE1, PPU_COLOR_GREEN2

	ann_toad_pal_common:
		.byte	PPU_COLOR_PITCH3, PPU_COLOR_YELLOW1
		.byte	PPU_COLOR_MAGENTA0, PPU_COLOR_PITCH0, PPU_COLOR_RED3

	ann_toad_pal_buf:
		.byte	PPU_COLOR_GREY0, PPU_COLOR_GREY0, PPU_COLOR_GREY0
	ann_toad_pal_buf_end:
	.endif
; ----------------------------
victory_init:
	.if	.defined(ANN)
		lda	ENG_HARDMODE_VAR
		bne	:++
		ldx	course_no
		cpx	#course::no_08
		beq	:++ ; if (!ENG_HARDMODE_VAR && course_no != course_08) {
			ldy	ann_toads_pal_offsets, x
			lda	ann_toads_pal_a, y
			sta	zp_addr_00
			iny
			lda	ann_toads_pal_a, y
			sta	zp_addr_00+1
			ldy	#0
			: ; for (byte of ann_toad_pal_buf) {
				lda	(zp_addr_00), y
				sta	ann_toad_pal_buf, y
				iny
				cpy	#(ann_toad_pal_buf_end-ann_toad_pal_buf)-1
				bne	:-
			; }

			lda	#nmi_addr::ann_toad_pal_common
			sta	nmi_addrs_ctl
		: ; }
	.endif

	ldx	pos_x_hi_screen_right
	inx
	stx	pos_x_hi_victory_right

	.if	.defined(SMB2)
		ldy	course_no
		lda	victory_init_mask, y
		ora	game_courses_cleared
		sta	game_courses_cleared
	.endif

	.if	.defined(SMB2M)
		lda	ENG_HARDMODE_VAR
		beq	:+
		lda	course_no
		cmp	#ENG_HARDMODE_B_COURSE
		bcc	:+ ; if (ENG_HARDMODE_VAR && course_no >= course_04) {
			lda	#course::no_08
			sta	course_no
		: ; }
	.endif

	lda	#music_event::victory_castle
	sta	apu_music_event

	.if	.defined(SMB2M)
		.export screen_title_bg, screen_title_bg_finish
	screen_title_bg_finish:
		inc	mode_game
		rts

	screen_title_bg:
		lda	mode_system
		bne	screen_title_bg_finish

		lda	#5
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		jmp	screen_title_end
	.elseif	.defined(SMB2M)
		jmp	screen_color_init_4_end
	.endif
; -----------------------------------------------------------
victory_proc:
	ldy	#joypad_button::none
	sty	victory_proc_ctrl
	lda	pos_x_hi_player
	cmp	pos_x_hi_victory_right
	bne	:+
	lda	pos_x_lo_player
	cmp	#VICTORY_X_POS
	bcs	:++
	: ; if ((player.pos_x < victory.pos_x) {
		inc	victory_proc_ctrl
		iny
	: ; }
	tya
	jsr	player_proc_auto

	lda	pos_x_hi_screen_left
	cmp	pos_x_hi_victory_right
	beq	:+ ; if (screen_left.pos_x.hi != victory_right.pos_x.hi) {
		lda	eng_scroll_subpix
		clc
		adc	#VICTORY_SCROLL
		sta	eng_scroll_subpix
		lda	#1
		adc	#0
		tay
		jsr	game_scroll_do
		jsr	game_proc_scroll_save
		inc	victory_proc_ctrl
	: ; }
	lda	victory_proc_ctrl
	beq	victory_next
	rts
; -----------------------------------------------------------
victory_msg:
	lda	victory_msg_timer_lo
	bne	victory_msg_dotick

	.if	.defined(CONS)
		lda	victory_msg_timer_hi
		beq	victory_msg_do
		cmp	#VICTORY_MSG_TIMER_UPPER
		bcs	victory_msg_dotick

		.if	.defined(SMB)
			ldy	course_no
			cpy	#course::no_08
			bne	:+ ; if (course_no == course_8) {
				cmp	#3
				bcc	victory_msg_dotick
				sbc	#1
				jmp	victory_msg_do
			: ; }
		.endif

		cmp	#VICTORY_MSG_TIMER_LOWER
		bcc	victory_msg_dotick

	victory_msg_do:
		tay
		.if	.defined(SMB)
			bne	:+ ; if () {
				lda	player_id
				beq	victory_msg_sound_check
				iny
				bne	victory_msg_sound_check
			: ; }

			iny
			lda	course_no
			cmp	#course::no_08
			beq	victory_msg_sound_check
			dey
		.elseif	.defined(SMB2M)
			beq	victory_msg_finish
		.endif

		cpy	#VICTORY_NOTICK_END
		bcs	victory_msg_notick
		cpy	#VICTORY_DOTICK_END
		bcs	victory_msg_dotick
	.elseif	.defined(VS)
		ldy	victory_msg_timer_hi
		lda	course_no
		cmp	#course::no_08
		beq	:++ ; if (!victory_msg_timer_lo && course_no != no_08) {
			cpy	#0
			bne	:+ ; if (victory_msg_timer_hi == 0) {
				inc	victory_msg_timer_hi
				lda	player_id
				beq	:+ ; if (player_id != 0) {
					iny
				; }
			: ; }

			cpy	#VICTORY_NOTICK_END
			bcc	victory_msg_finish
			bcs	victory_msg_notick
		: ; } else if (!victory_msg_timer_lo) {
			cpy	#VICTORY_MSG_TIMER_LOWER
			beq	:+
			cpy	#VICTORY_MSG_TIMER_LOWER_B
			bne	:++
			: ; if (victory_msg_timer_hi.in(2, 6)) {
				inc	victory_msg_timer_hi
				lda	player_id
				beq	:+ ; if (player.id != 0) {
					iny
				; }
			: ; }

			cpy	#VICTORY_MSG_TIMER_UPPER
			bcs	victory_msg_notick
		; }
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
	victory_msg_sound_check:
		.if	.defined(SMB)
			cpy	#3
		.elseif	.defined(VS_SMB)
			iny
			iny
			iny
			cpy	#7
		.endif
		bne	:+ ; if ((SMB && victory_msg_timer_hi == 3) || (VS_SMB && (victory_msg_timer_hi += 3) == 7)) {
			lda	#music_event::victory_normal
			sta	apu_music_event
		: ; }
	.endif

victory_msg_finish:
	tya
	clc
	adc	#nmi_addr::msg_ty_mario
	sta	nmi_addrs_ctl

victory_msg_dotick:
	lda	victory_msg_timer_lo
	clc
	adc	#VICTORY_TICK
	sta	victory_msg_timer_lo
	lda	victory_msg_timer_hi
	adc	#0
	sta	victory_msg_timer_hi
	.if	.defined(CONS)
		cmp	#VICTORY_MSG_TIMER_END
	.elseif	.defined(VS)
		rts
	.endif

victory_msg_notick:
	.if	.defined(CONS)
		bcc	:+ ; if (victory_msg_timer_hi >= end) {
	.endif
		lda	#VICTORY_TIMER_SET
		sta	timer_victory

	victory_next:
		inc	mode_game

	.if	.defined(VS)
		lda	#0
		sta	VS_RAM_ARENA0+$18
		sta	VS_RAM_ARENA0+$22
		sta	VS_RAM_ARENA0+$1F
	.endif
	: ; }

	rts
; -----------------------------------------------------------
	.if	.defined(SMB2M)|.defined(VS_SMB)

	.if	.defined(SMB2M)
		TALLY_TIMER_CUTOFF	= 6
	.elseif	.defined(VS_SMB)
		TALLY_TIMER_CUTOFF	= 10
	.endif

	victory_time_tally:
		lda	timer_victory
		cmp	#TALLY_TIMER_CUTOFF
		bcs	:++ ; if (timer_victory < cutoff) {
			.if	.defined(VS_SMB)|.defined(SMB2)
				jsr	actor_proc_flag_victory_timer_score_do
			.endif

			lda	stats_time_end-STATS_TIME_LEN
			ora	stats_time_end-STATS_TIME_LEN+1
			ora	stats_time_end-STATS_TIME_LEN+2
			.if	.defined(SMB2)|.defined(VS_SMB)
				bne	:++ ; if (time == 0) {
			.elseif	.defined(ANN)
				beq	:+ ; if (time != 0) {
					jmp	actor_proc_flag_victory_timer_score_do
				; } else {
			.endif
			: ; if (time == 0) {
				lda	#$30
				sta	timer_select
				.if	.defined(SMB2M)
					lda	#6
					sta	timer_victory
				.endif
				inc	mode_game
			; }
		: ; }

		rts
	.endif
; -----------------------------------------------------------
	.if	.defined(VS_SMB)
pal_8492:
	.byte	PPU_COLOR_YGREEN0, PPU_COLOR_YELLOW1, PPU_COLOR_ROSE2,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_GREY3,   PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0,	PPU_COLOR_PITCH0
	.byte	PPU_COLOR_AZURE2,  PPU_COLOR_BLUE1,   PPU_COLOR_AZURE2, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0,	PPU_COLOR_YELLOW1
pal_8492_end:

pal_84A6:
	.byte	PPU_COLOR_AZURE0, PPU_COLOR_BLUE0, PPU_COLOR_AZURE1, PPU_COLOR_AZURE2

ppu_84AA:
	.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_20+PPU_BG_COL_6
	.byte	NMI_REPEAT|21
	.byte	" "

	.dbyt	PPU_VRAM_BG2+PPU_BG_ROW_21+PPU_BG_COL_6
	.byte	NMI_REPEAT|21
	.byte	" "

	.byte	NMI_LIST_END
ppu_84AA_end:

obj_data_offset_actor_84B3:
	.byte	$50, $B0, $E0, $68
	.byte	$98, $C8

obj_data_offset_actor_84B9:
	.byte	$80, $50, $68, $80
	.byte	$98, $B0, $C8

actor_pos_y_lo_84C0:
	.byte	$E0, $B8, $90, $70
	.byte	$68, $70, $90

ppu_84C7:
	.byte	$B8, $38, $48, $60
	.byte	$80, $A0, $B8, $C8
; ----------------------------
victory_84CF:
	lda	course_no
	cmp	#course::no_08
	beq	:+ ; if (course_no != no_08) {
		lda	mode_game
		clc
		adc	#2
		sta	mode_game
		rts
	: ; } else {
		inc	VS_RAM_ARENA0+$18
		lda	VS_RAM_ARENA0+$1F
		bne	:+ ; if (!vs_ram_arena0[0x1F]) {
			lda	VS_RAM_ARENA0+$18
			and	#$FF
			bne	:++++++
			inc	VS_RAM_ARENA0+$1F
			jmp	:++
		: ; } else {
			lda	VS_RAM_ARENA0+$18
			and	#$0F
			bne	:+++++
		: ; }

		; if ((!vs_ram_arena0[0x1F] && vs_ram_arena0[0x18] == 0) || !(vs_ram_arena0[0x18] & 0xF)) {
			ldx	#(pal_8492_end-pal_8492)-1
			: ; for (color of pal_8492) {
				lda	pal_8492, x
				sta	nmi_list_0_data+0, x

				dex
				bpl	:-
			; }

			ldx	#12
			ldy	VS_RAM_ARENA0+$22
			: ; for (x = 12; x > 0; x -= 4) {
				lda	pal_84A6, y
				sta	nmi_list_0_data+3, x

				dex
				dex
				dex
				dex
				bpl	:-
			; }

			inc	VS_RAM_ARENA0+$22
			lda	VS_RAM_ARENA0+$22
			cmp	#4
			bne	:+ ; if (++vs_ram_arena0[0x22] == 4) {
				inc	mode_game
			: ; }
		: ; }

		rts
	; }
; -----------------------------------------------------------
victory_8526:
	ldx	#(ppu_84AA_end-ppu_84AA)-1
	: ; for (entry of ppu_84AA) {
		lda	ppu_84AA, x
		sta	nmi_list_0_data, x
		dex
		bpl	:-
	; }

	inc	mode_game
	ldx	player_id
	lda	#1
	sta	VS_RAM_ARENA0+$28, x
	lda	#0
	sta	VS_RAM_ARENA0+$22
	sta	VS_RAM_ARENA0+$18
	sta	VS_RAM_ARENA0+$1F
	lda	#6
	sta	timer_victory
	lda	#$60
	sta	VS_RAM_ARENA0+$2A
	rts
; -----------------------------------------------------------
victory_8552:
	lda	VS_RAM_ARENA0+$2A
	beq	:+ ; if (vs_ram_arena0[0x2A]) {
		dec	VS_RAM_ARENA0+$2A
		rts
	: ; } else {
		ldx	VS_RAM_ARENA0+$22
		cpx	#7
		beq	:+ ; if (vs_ram_arena0[0x22] != 7) {
			lda	VS_RAM_ARENA0+$18
			and	#$1F
			bne	:++ ; if (!(vs_ram_arena0[0x18] & 0x1F)) {
				inc	VS_RAM_ARENA0+$22
				lda	#sfx_pulse2::coin_01
				sta	apu_pulse2_queue
				jmp	:++
			; }
		: ; } else {
			lda	VS_RAM_ARENA0+$18
			and	#$1F
			bne	:+ ; if (!(vs_ram_arena0[0x18] & 0x1F)) {
				inc	VS_RAM_ARENA0+$1F
				lda	VS_RAM_ARENA0+$1F
				cmp	#11
				bcc	:+ ; if (+vs_ram_arena0[0x1F] >= 11) {
					lda	#4
					sta	VS_RAM_ARENA0+$1F
				; }
			; }
		: ; }

		inc	VS_RAM_ARENA0+$18
		lda	course_no
		pha
		lda	VS_RAM_ARENA0+$22
		pha
		tax
		: ; for (vs_ram_arena0[0x22]; vs_ram_arena0[0x22] > 0; vs_ram_arena0[0x22]--){
			lda	VS_RAM_ARENA0+$1F
			cmp	#4
			bcc	:+
			sbc	#4
			tay
			lda	obj_data_offset_actor_84B3, y
			cmp	obj_data_offset_actor_84B9, x
			beq	:++
			: ; if ((vs_ram_arena0[0x1F] < 4) || (obj_data_offset_actor_84B3[vs_ram_arena[0x1F]-4] != obj_data_offset_actor_84B9[vs_ram_arena0[0x22]])) {
				ldy	obj_data_offset_actor_84B9, x
				sty	obj_data_offset_actor
				lda	#actor::toad
				sta	actor_id
				lda	actor_pos_y_lo_84C0, x
				sta	pos_y_lo_actor
				lda	ppu_84C7, x
				sta	pos_x_rel_actor
				ldx	#0
				stx	course_no
				stx	actor_index
				jsr	render_actor
			: ; }

			dec	VS_RAM_ARENA0+$22
			ldx	VS_RAM_ARENA0+$22
			bne	:---
		; }

		pla
		sta	VS_RAM_ARENA0+$22
		pla
		sta	course_no
		lda	#$30
		sta	obj_data_offset_actor
		lda	#$B8
		sta	pos_y_lo_actor
		rts
	; }
; -----------------------------------------------------------
victory_85E0:
	lda	course_no
	cmp	#course::no_08
	bne	:+ ; if (course_no == no_08) {
		jsr	victory_8552
	: ; }

	lda	timer_victory
	bne	:+
	ldy	course_no
	cpy	#course::no_08
	bcs	:++ ; if (!timer_victory || course_no < no_08) {
		; if (!timer_victory) {
			lda	#0
			sta	course_sub
			sta	player_goals
			sta	mode_game
			inc	course_no
			jsr	course_descriptor_load
			inc	eng_req_timer
			lda	#system_modes::game
			sta	mode_system
		: ; }

		rts
	: ; } else {
		lda	#0
		sta	eng_timer_ctl
		lda	#$1C
		sta	timer_actor+1
		inc	mode_game
		rts
	; }
	.endif
; -----------------------------------------------------------
victory_finish:
	lda	timer_victory
	bne	victory_finish_rts

	.if	.defined(CONS)
		.export	victory_finish_do
	victory_finish_do:
		.if	.defined(SMB)
			ldy	course_no
			cpy	#course::no_08
			bcs	:+ ; if (course_no < course_8) {
		.endif

		lda	#0
		sta	course_sub
		sta	player_goals
		sta	mode_game

		.if	.defined(SMBM)
			inc	course_no
		.elseif	.defined(SMB2)
			lda	course_no
			clc
			adc	#1
			cmp	#course::no_09
			bcc	:+ ; if (course_no >= course_09) {
				lda	#course::no_09
			: ; }
			sta	course_no
		.endif

		jsr	course_descriptor_load
		inc	eng_req_timer
		lda	#system_modes::game
		sta	mode_system
	.elseif	.defined(VS)
		lda	course_no
		cmp	#course::no_08
		bne	:+
		lda	player_lives
		bmi	:+
		lda	timer_select
		bne	:++ ; if (course.no == no_08 && player.lives >= 0 && !timer_select) {
			lda	#48
			sta	timer_select
			lda	#sfx_pulse2::oneup
			sta	apu_pulse2_queue
			dec	player_lives
			lda	#1
			sta	score_digit_mod+2
			jmp	actor_proc_course_end_stats
		: ; } else if (course.no != no_08 || player.lives < 0) {
			inc	mode_game
		: ; }
	.endif

	victory_finish_rts:
		rts

	.if	.defined(SMB)
		: ; } else {
			lda	joypad_p1
			ora	joypad_p2
			and	#joypad_button::face_b
			beq	:+ ; if (joypad_face_b) {
				lda	#1
				sta	title_course_sel_on
				lda	#255
				sta	player_lives
				jsr	eng_next_game
			: ; }

			rts
		; }
	.endif
; -----------------------------------------------------------
	.if	.defined(VS_SMB)
victory_864C:
	jsr	victory_8552

	lda	timer_actor+1
	bne	victory_865D_rts ; if (!actor.timer+1) {
		inc	mode_game
		lda	#$D8
		sta	timer_select
		rts
	; } else rts;
; -----------------------------------------------------------
victory_865D:
	jsr	victory_8552

	lda	timer_select
	bne	:+
	lda	snd_music_event_current
	bne	:+ ; if (!timer_select && !snd.music_event) {
		sta	title_course_sel_on
		lda	#255
		sta	player_lives
		lda	#system_modes::game_over
		sta	mode_system
		lda	#game_over_modes::init
		sta	mode_game
	: ; }

victory_865D_rts:
	rts
	.endif
; -----------------------------------------------------------
SCORE_METASPR_W_TILES	= 2
SCORE_DIGIT_MASK	= $0F

screen_score_disp_tiles:
	.byte	$FF, $FF

	.byte	chr_obj::digits_10, chr_obj::digits_0
	.byte	chr_obj::digits_20, chr_obj::digits_0
	.byte	chr_obj::digits_40, chr_obj::digits_0
	.byte	chr_obj::digits_50, chr_obj::digits_0
	.byte	chr_obj::digits_80, chr_obj::digits_0
	.byte	chr_obj::digits_10, chr_obj::digits_00
	.byte	chr_obj::digits_20, chr_obj::digits_00
	.byte	chr_obj::digits_40, chr_obj::digits_00
	.byte	chr_obj::digits_50, chr_obj::digits_00
	.byte	chr_obj::digits_80, chr_obj::digits_00

	.byte	chr_obj::oneup_left, chr_obj::oneup_right

	.if	.defined(VS_SMB)
		.byte	chr_obj::digits_80, chr_obj::digits_00
	.endif
screen_score_disp_tiles_end:

	.export screen_score_disp_incs
	.export screen_score_value_100, screen_score_value_200
	.export screen_score_value_400, screen_score_value_500
	.export screen_score_value_800, screen_score_value_1000
	.export screen_score_value_2000, screen_score_value_4000
	.export screen_score_value_5000, screen_score_value_8000
	.export screen_score_value_oneup
screen_score_disp_incs:
	.byte	$FF

SCORE_DIGIT_PLACE_100	= (((SCORE_DIGITS_MAX-1)-2)<<4)
SCORE_DIGIT_PLACE_1000	= (((SCORE_DIGITS_MAX-1)-3)<<4)

screen_score_value_100:
	.byte	1|SCORE_DIGIT_PLACE_100
screen_score_value_200:
	.byte	2|SCORE_DIGIT_PLACE_100
screen_score_value_400:
	.byte	4|SCORE_DIGIT_PLACE_100
screen_score_value_500:
	.byte	5|SCORE_DIGIT_PLACE_100
screen_score_value_800:
	.byte	8|SCORE_DIGIT_PLACE_100
screen_score_value_1000:
	.byte	1|SCORE_DIGIT_PLACE_1000
screen_score_value_2000:
	.byte	2|SCORE_DIGIT_PLACE_1000
screen_score_value_4000:
	.byte	4|SCORE_DIGIT_PLACE_1000
screen_score_value_5000:
	.byte	5|SCORE_DIGIT_PLACE_1000
screen_score_value_8000:
	.byte	8|SCORE_DIGIT_PLACE_1000
screen_score_value_oneup:
	.byte	0

	.if	.defined(VS_SMB)
		.byte	8|SCORE_DIGIT_PLACE_1000
	.endif
screen_score_disp_incs_end:
; ----------------------------
	.export screen_score_disp, screen_score_disp_end
screen_score_disp:
	lda	screen_score_ctl, x
	.if	.defined(CONS)
		beq	victory_finish_rts
	.elseif	.defined(VS)
		beq	victory_865D_rts
	.endif
	cmp	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-1
	bcc	:+ ; if (stack[0x10] >= sizeof (disp_tiles))) {
		lda	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-1
		sta	screen_score_ctl, x
	: ; }
	tay

	lda	timer_score, x
	bne	:+ ; if (score.timer == 0) {
		sta	screen_score_ctl, x
		rts
	: ; }

	dec	timer_score, x
	cmp	#43
	bne	:++ ; if (stack[0x2C] == 43) {
		.if	.defined(CONS)
			cpy	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-1
		.elseif	.defined(VS)
			cpy	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-2
		.endif
		bne	:+ ; if (stack[0x10] == 1UP) {
			inc	player_lives
			lda	#sfx_pulse2::oneup
			sta	apu_pulse2_queue
		: ; }

		lda	screen_score_disp_incs, y
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		tax
		lda	screen_score_disp_incs, y
		and	#SCORE_DIGIT_MASK
		sta	score_digit_mod+1, x
		jsr	misc_proc_coin_update_score
	: ; }

	ldy	obj_data_offset_actor, x
	lda	actor_id, x
	cmp	#actor::spiny
	beq	:++
	cmp	#actor::piranha_plant
	beq	:++
	cmp	#actor::hammer_bro
	beq	:+
	cmp	#actor::cheep_grey
	beq	:++
	cmp	#actor::cheep_red
	beq	:++
	cmp	#actor::div_height
	bcs	:+
	lda	state_actor, x
	cmp	#actor_states::state_2
	bcs	:++
	: ; if (actor.id == hammer_bro || actor.id >= div_height || actor.state < 2) {
		ldx	obj_data_offset_ctl
		ldy	obj_data_offset_block, x
		ldx	actor_index
	: ; }

	lda	screen_score_pos_y, x
	cmp	#24
	bcc	:+ ; if (score.pos_y >= 24) {
		sbc	#1
		sta	screen_score_pos_y, x
	: ; }

	lda	screen_score_pos_y, x
	sbc	#PPU_CHR_HEIGHT_PX
	jsr	render_set_two_sprites_v
	lda	screen_score_pos_x, x
	sta	OAM_DMA_BUFFER+OBJ_POS_H, y
	clc
	adc	#PPU_CHR_HEIGHT_PX
	sta	OAM_DMA_BUFFER+OBJ_POS_H+OBJ_SIZE, y
	lda	#(obj_attr::priority_high|obj_attr::color2)
	sta	OAM_DMA_BUFFER+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+OBJ_ATTR+OBJ_SIZE, y
	lda	screen_score_ctl, x
	asl	a
	tax
	lda	screen_score_disp_tiles, x
	sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
	lda	screen_score_disp_tiles+1, x
	sta	OAM_DMA_BUFFER+OBJ_CHR_NO+OBJ_SIZE, y
	ldx	actor_index

screen_score_disp_end:
	rts
