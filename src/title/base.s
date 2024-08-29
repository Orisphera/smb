.include	"engine/mem.i"
.include	"engine/joypad.i"
.include	"engine/misc.i"
.include	"engine/tunables.i"
.include	"engine/charmap.i"

.include	"engine/unk.i"

.if	.defined(SMB)|.defined(VS_SMB)
		.export eng_title
	eng_title:
		.if	.defined(VS)
			lda	VS_RAM_ARENA0+$10
			beq	:+ ; if (VS_RAM_ARENA0[0x10]) {
				lda	#0
				sta	eng_gameplay_mode
				sta	eng_sprite_overlap
				inc	eng_game_mode
				lda	#1
				sta	eng_disp_disable
				rts
			: ; } else {
		.endif

		lda	eng_gameplay_mode
		jsr	eng_farjump
		.if	.defined(VS)
			.addr	sub_82AF
		.endif
		.addr	eng_init_0
		.addr	screen_proc
		.addr	eng_init_1
		.addr	title_proc
		.if	.defined(VS)
			.addr	sub_942C
			.addr	sub_9502
			.addr	sub_953B
			.addr	sub_9588
		; }
	; ----------------------------
			sub_82AF:
				lda	#1
				sta	eng_disp_disable
				lda	#0
				sta	eng_sprite_overlap
				inc	eng_gameplay_mode
				rts
		.endif
	; -----------------------------------------------------------
	title_course_no:
		.byte	(:+++)-(:+)
		: .dbyt	PPU_VRAM_BG1+$73
		.byte	(:++)-(:+)
		: .byte	"0"
		:

		.byte	NMI_DATA_END
	title_course_no_end:
.endif
; ----------------------------
.if	.defined(SMB)|.defined(VS_SMB)
TITLE_PLAYER_ID	= player_count
TITLE_STATS_END	= eng_stats_end
.elseif	.defined(SMB2M)
TITLE_PLAYER_ID = player_id
TITLE_STATS_END	= eng_stats_end_b
.endif
TITLE_PRESSED_B	= 1

	.export title_proc
title_proc:
	.if	.defined(SMB)|.defined(VS_SMB)
	ldy	#0
	.endif

	.if	.defined(CONS)
		lda	joypad_p1
		.if	.defined(SMB)|.defined(VS_SMB)
			ora	joypad_p2
			cmp	#joypad_button::start
			beq	:+
			cmp	#(joypad_button::face_a|joypad_button::start)
			bne	:++
			: jmp	title_exit
			: ; if (!joypads_start && !joypads_a_start) {
		.elseif	.defined(SMB2M)
			and	#joypad_button::start
			beq	:++ ; if (joypad[0].start == PRESSED) {
				lda	#0
				.if	.defined(SMB2)
				sta	game_courses_cleared
				.endif
				sta	disk_loader_proc
				sta	game_hard_mode_new

				lda	save
				cmp	#8
				bcc	:+
				lda	joypad_p1
				and	#joypad_button::face_a
				beq	:+ ; if (save >= 8 && joypad[0].a == PRESSED) {
					inc	game_hard_mode_new
				: ; }
				jmp	title_exit
			; }
		.endif
	: ; } else {
		.if	.defined(SMB2M)
		lda	joypad_p1
		.endif
			cmp	#joypad_button::select
			beq	:++
				ldx	timer_demo
				.if	.defined(SMB)|.defined(VS_SMB)
				bne	:+
				.elseif	.defined(SMB2M)
				bne	:+++++ ; if (!timer_demo) {
				.endif
					sta	timer_select
					jsr	title_demo

					bcs	title_recycle
					.if	.defined(SMB)|.defined(VS_SMB)
					jmp	:++++++
					.elseif	.defined(SMB2M)
					bcc	:++++++
					.endif
				: ; }

				.if	.defined(SMB)|.defined(VS_SMB)
					ldx	eng_course_sel_on
					beq	:++++
					cmp	#joypad_button::face_b
					bne	:++++
					iny
				.endif
			: ; }

			lda	timer_demo
			beq	title_recycle ; if (timer_demo) {
				lda	#TITLE_DEMO_TIMER
				sta	timer_demo

				.if	.defined(SMB2M)
					lda	frame_count
					and	#<~1
					sta	frame_count
				.endif

				lda	timer_select
				bne	:+++ ; if (!timer_select) {
					lda	#TITLE_SELECT_TIMER
					sta	timer_select

					.if	.defined(SMB)|.defined(VS_SMB)
						cpy	#TITLE_PRESSED_B
						beq	:+ ; if (joypad[0].b != PRESSED) {
					.endif
						lda	TITLE_PLAYER_ID
						eor	#1
						sta	TITLE_PLAYER_ID
						jsr	title_cursor_draw
					.if	.defined(SMB)|.defined(VS_SMB)
							jmp	:+++
						: ; } else {
							ldx	title_course_sel_no
							inx
							txa
							and	#$07
							sta	title_course_sel_no
							jsr	title_course_set
							: ; for (x = title_course_sel_no+1; x < 0x06; x++) {
								lda	title_course_no, x
								sta	ppu_nmi_buffer_0_data-1, x

								inx
								cpx	#(title_course_no_end-title_course_no)
								bmi	:-
							; }

							ldy	course_no
							iny
							sty	ppu_nmi_buffer_0_data+3
						; }
					.elseif	.defined(SMB2M)
					:
					:
					.endif
				: ; }

				lda	#joypad_button::none
				sta	joypad_p1

			: ; }
	.elseif	.defined(VS)
		ldx	timer_demo
		bne	:+ ; if (!timer_demo) {
			jsr	title_demo
			bcs	title_next
			jmp	:++
		: ; } else {
			lda	#0
			sta	joypad_p1
			sta	joypad_p2
		: ; }
	.endif

		jsr	game_proc
		lda	game_proc_id
		cmp	#game_proc::lifedown
		bne	title_continue ; if (game.proc_id == lifedown) {
		.if	.defined(VS)
		title_next:
			inc	eng_gameplay_mode
			lda	#0
			sta	eng_sprite_overlap
			inc	eng_disp_disable
			rts
		.endif

			.export title_recycle
		title_recycle:
			lda	#0
			sta	eng_game_mode
			sta	eng_gameplay_mode
			sta	eng_sprite_overlap
			inc	eng_disp_disable
		; }
		rts
		.export title_exit
	title_exit: ; } else {
		.if	.defined(CONS)
		.if	.defined(SMB)|.defined(VS_SMB)
			ldy	timer_demo
		.elseif	.defined(SMB2M)
			lda	timer_demo
		.endif
		beq	title_recycle ; if (timer_demo) {
		.endif
			.if	.defined(SMB)|.defined(VS_SMB)
				asl	a
				bcc	:+ ; if (joypad_face_a) {
					lda	eng_continue_course
					jsr	title_course_set
				: ; }

				jsr	course_descriptor_load
				inc	eng_hidden_one_up
				inc	eng_hidden_one_up_b
				inc	eng_req_timer
				inc	eng_game_mode
				lda	eng_course_sel_on
				sta	ENG_HARDMODE_VAR

				lda	#gameplay_mode::init_0
				sta	eng_gameplay_mode

				sta	timer_demo
			.elseif	.defined(SMB2M)
				inc	eng_gameplay_mode

				jsr	sub_C5BA

				lda	#course::no_01
				sta	course_no
				lda	#0
				sta	eng_goals
				lda	#0
				sta	course_sub
			.endif

			ldx	#(TITLE_STATS_END-eng_stats)-1
			lda	#0
			: ; for (byte of eng_stats) {
				sta	eng_stats, x

				dex
				bpl	:-
			; }

		title_continue:
			rts

		.if	.defined(CONS)
		; }
		.endif
	; }
; ----------------------------
.if	.defined(SMB)|.defined(VS_SMB)
title_course_set:
	sta	course_no
	sta	course_no_b
	ldx	#0
	stx	course_sub
	stx	course_sub_b
	rts
.endif
