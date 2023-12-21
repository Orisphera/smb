.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/sound.i"
.include	"../../inc/engine/tunables.i"
.include	"../../inc/engine/misc.i"

.include	"../../inc/engine/unk.i"

	.export eng_victory
eng_victory:
	jsr	victory_enter
	lda	eng_gameplay_mode
	beq	:+ ; if (eng_gameplay_mode != bridge) {
		ldx	#0
		stx	eng_actor_offset
		jsr	actor_proc
	: ; }

	jsr	lib_calc_player_pos
	jmp	eng_player_render
; -----------------------------------------------------------
victory_enter:
	lda	eng_gameplay_mode
	jsr	eng_farjump
	.addr	eng_bowser_ending
	.addr	victory_init
	.addr	victory_proc
	.addr	victory_msg
	.addr	victory_end
; -----------------------------------------------------------
victory_init:
	ldx	eng_screen_right_hi
	inx
	stx	victory_screen_hi
	lda	#music_event::victory_fanfare
	sta	apu_music_event
	jmp	victory_next
; -----------------------------------------------------------
victory_proc:
	ldy	#0
	sty	victory_proc_ctrl
	lda	eng_player_hi
	cmp	victory_screen_hi
	bne	:+
	lda	eng_player_pos_x_lo
	cmp	#VICTORY_X_POS
	bcs	:++
	: ; if ((eng_player_hi != victory_screen_hi) || eng_player_pos_x_lo < VICTORY_X_POS) {
		inc	victory_proc_ctrl
		iny
	: ; }
	tya
	jsr	player_proc_auto

	lda	eng_screen_left_hi
	cmp	victory_screen_hi
	beq	:+ ; if (eng_screen_left_hi != victory_screen_hi) {
		lda	eng_scroll_subpix
		clc
		adc	#$80
		sta	eng_scroll_subpix
		lda	#1
		adc	#0
		tay
		jsr	game_scroll
		jsr	game_scroll_save
		inc	victory_proc_ctrl
	: ; }
	lda	victory_proc_ctrl
	beq	victory_next_2
	rts
; -----------------------------------------------------------
victory_msg:
        lda     victory_msg_count_inner
        bne     victory_msg_dotick
        lda     victory_msg_count_outer
        beq     victory_msg_do
        cmp     #9
        bcs     victory_msg_dotick
        ldy     eng_course_no
	cpy     #7
        bne     victory_normal
        cmp     #3
        bcc     victory_msg_dotick
        sbc     #1
        jmp     victory_msg_do

victory_normal:
	cmp     #2
        bcc     victory_msg_dotick

victory_msg_do:
	tay
        bne     victory_msg_do_more
        lda     eng_player_id
        beq     victory_msg_sound_check
        iny
        bne     victory_msg_sound_check

victory_msg_do_more:
	iny
        lda     eng_course_no
        cmp     #7
        beq     victory_msg_sound_check
        dey
        cpy     #4
        bcs     victory_msg_notick
        cpy     #3
        bcs     victory_msg_dotick

victory_msg_sound_check:
	cpy     #3
        bne     :+ ; if () {
		lda     #4
		sta     apu_music_event
	: ; }

	tya
        clc
        adc     #$0C
        sta     nmi_addrs_ctl

victory_msg_dotick:
	lda     victory_msg_count_inner
        clc
        adc     #4
        sta     victory_msg_count_inner
        lda     victory_msg_count_outer
        adc     #0
        sta     victory_msg_count_outer
        cmp     #7

victory_msg_notick:
	bcc     :+ ; if (victory_msg_count_outer >= 7) {
		lda     #6
		sta     eng_timer_victory

	victory_next_2:
		inc     eng_gameplay_mode
	: ; }

	rts
; -----------------------------------------------------------
victory_end:
        lda     eng_timer_victory
        bne     victory_end_rts
        ldy     eng_course_no
        cpy     #7
        bcs     :+ ; if (eng_course_no < 7) {
		lda	#0
		sta	eng_course_sub
		sta	eng_goals
		sta	eng_gameplay_mode
		inc	eng_course_no
		jsr	eng_loadareaptr
		inc	eng_req_timer
		lda	#game_mode::normal
		sta	eng_game_mode

	victory_end_rts:
		rts
	: ; } else {
		lda     joypad_p1
		ora     joypad_p2
		and     #joypad_button::face_b
		beq     :+ ; if (joypad_face_b) {
			lda     #1
			sta     eng_course_sel_on
			lda     #$FF
			sta     eng_lives
			jsr	eng_next_game
		: ; }

		rts
	; }
