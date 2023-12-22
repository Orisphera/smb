.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/misc.i"
.include	"../../inc/engine/tunables.i"

.include	"../../inc/engine/unk.i"

	.export eng_title
eng_title:
	lda	eng_gameplay_mode
	jsr	eng_farjump
	.addr	title_init_0
	.addr	lib_screen_proc
	.addr	title_init_1
	.addr	title_proc
; -----------------------------------------------------------
title_course_no:
	.byte	$04, $20, $73, $01, $00, $00
title_course_no_end:
; ----------------------------
title_proc:
	ldy	#0
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
					lda	eng_player_count
					eor	#$01
					sta	eng_player_count
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
						sta	ppu_nmi_buffer, x

						inx
						cpx	#(title_course_no_end-title_course_no)
						bmi	:-
					; }

					ldy	eng_course_no
					iny
					sty	ppu_nmi_buffer+4
				: ; }
			: ; }

			lda	#0
			sta	joypad_p1

		: ; }

		jsr	game_proc
		lda	game_proc_id
		cmp	#game_proc::lifedown
		bne	title_continue ; if (game_proc_id == lifedown) {
		title_recycle:
			lda	#0
			sta	eng_game_mode
			sta	eng_gameplay_mode
			sta	eng_sprite_overlap
			inc	eng_disp_disable
		; }
		rts
	title_exit: ; } else {
		ldy	eng_timer_demo
		beq	title_recycle ; if (eng_timer_demo) {
			asl	a
			bcc	:+ ; if (joypad_face_a) {
				lda	eng_continue_course
				jsr	title_course_set
			: ; }

			jsr	eng_loadareaptr
			inc	eng_hidden_one_up
			inc	eng_hidden_one_up_offscr
			inc	eng_req_timer
			inc	eng_game_mode
			lda	eng_course_sel_on
			sta	eng_hard_mode
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
		; }
	; }

title_course_set:
	sta     eng_course_no
        sta     eng_course_no_offscr
        ldx     #0
        stx     eng_course_sub
        stx     eng_course_sub_offscr
        rts
