.include	"../../inc/engine/mem.i"
.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/misc.i"
.include	"../../inc/engine/tunables.i"

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
	.byte	$04, $20, $73, $01, $00, $00
title_course_no_end:
; ----------------------------
title_proc:
	ldy	#0

	.if	.defined(CONS)
		lda	joypad_p1
		ora	joypad_p2
		cmp	#joypad_button::start
		beq	:+
		cmp	#(joypad_button::face_a|joypad_button::start)
		bne	:++
		: jmp	title_exit
		: ; if (!joypads_start && !joypads_a_start) {
			cmp	#joypad_button::select
			beq	:++ ; if (!joypads_select) {
				ldx	eng_timer_demo
				bne	:+ ; if (!eng_timer_demo) {
					sta	eng_timer_select
					jsr	title_demo

					bcs	title_recycle
					jmp	:+++++++
				: ; }

				ldx	eng_course_sel_on
				beq	:+++++
				cmp	#joypad_button::face_b
				bne	:+++++
				iny
			: ; }

			lda	eng_timer_demo
			beq	title_recycle ; if (eng_timer_demo) {
				lda	#TITLE_DEMO_TIMER
				sta	eng_timer_demo

				lda	eng_timer_select
				bne	:++++ ; if (!eng_timer_select) {
					lda	#TITLE_SELECT_TIMER
					sta	eng_timer_select

					cpy	#1
					beq	:+ ; if (!joypad_face_b) {
						lda	player_count
						eor	#%00000001
						sta	player_count
						jsr	title_cursor_draw
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
					: ; }
				: ; }

				lda	#0
				sta	joypad_p1

			: ; }
	.elseif	.defined(VS)
		ldx	eng_timer_demo
		bne	:+ ; if (!eng_timer_demo) {
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
		bne	title_continue ; if (game_proc_id == lifedown) {
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
		ldy	eng_timer_demo
		beq	title_recycle ; if (eng_timer_demo) {
		.endif
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
			.if	.defined(CONS)
				lda	eng_course_sel_on
			.elseif	.defined(VS)
				lda	byte_7FC
			.endif
			sta	ENG_HARDMODE_VAR
			lda	#gameplay_mode::init_0
			sta	eng_gameplay_mode
			sta	eng_timer_demo

			ldx	#(eng_stats_end-eng_stats)-1
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
title_course_set:
	sta     course_no
        sta     course_no_b
        ldx     #0
        stx     course_sub
        stx     course_sub_b
        rts
