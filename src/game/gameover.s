.include	"../../inc/system/ppu.i"

.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/sound.i"
.include	"../../inc/engine/misc.i"

.include	"../../inc/engine/unk.i"

	.export eng_game_over
eng_game_over:
	lda	eng_gameplay_mode
	jsr	eng_farjump
	.addr	eng_game_over_init
	.addr	screen_proc
	.if	.defined(VS_SMB)
		.addr	sub_9902
		.addr	sub_98DC
		.addr	sub_98F2
	.endif
	.addr	eng_game_over_run
; ----------------------------
.if	.defined(VS_SMB)
	.include	"vs_gameover.s"
.endif
; ----------------------------
eng_game_over_init:
	lda	#0
	sta	eng_screen_proc_id
	sta	eng_sprite_overlap

.if	.defined(SMB2M)
	sta	eng_timer_disp
.endif

	lda	#music_event::game_over
	sta	apu_music_event
	inc	eng_disp_disable

.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
	inc	eng_gameplay_mode
	rts
.elseif	.defined(ANN)
	jmp	screen_title_bg_finish
.endif
; ----------------------------
eng_game_over_run:
.if	.defined(SMB)|.defined(SMB2M)
	.if	.defined(SMB)
		GAME_OVER_TIMER_RTS = eng_next_game_rts_b
	.elseif	.defined(SMB2)
		GAME_OVER_TIMER_RTS = eng_next_game_rts_a
	.endif

		lda	#0
		sta	eng_disp_disable

	.if	.defined(SMB)
		lda	joypad_p1
		and	#joypad_button::start
		bne	eng_next_game
	.elseif	.defined(SMB2M)
		.if	.defined(SMB2)
			lda     course_no
			cmp     #course::no_09
			beq     :+ ; if (course_no != no_09) {
		.endif

		jmp     sub_C1C2

		.if	.defined(SMB2)
			: ; }
		.endif
	.endif

	.if	.defined(SMB)|.defined(SMB2)
		lda	eng_timer_screen
		bne	GAME_OVER_TIMER_RTS
	.endif

		.export eng_next_game
	eng_next_game:
		lda	#music_event::none
		sta	apu_music_event
.endif
; ----------------------------
	.export	eng_game_continue
.if	.defined(SMB)|.defined(VS_SMB)

	jsr	eng_player_switch
	bcc	eng_game_continue ; if () {
	.if	.defined(VS_SMB)
		lda	eng_lives
		bpl	eng_game_continue
	.endif
		lda	course_no
		sta	eng_continue_course
.endif

		lda	#0

	.if	.defined(SMB)|.defined(VS_SMB)
		asl	a
	.endif

		sta	eng_gameplay_mode
		sta	eng_timer_screen
		sta	eng_game_mode
	eng_next_game_rts_a:
		rts
	eng_game_continue: ; } else {
		jsr	course_descriptor_load
		lda	#1
		sta	eng_player_size
		inc	eng_req_timer
		lda	#0
		sta	eng_timer_ctl
		sta	eng_player_status
		sta	game_proc_id
		sta	eng_gameplay_mode
		lda	#game_mode::normal
		sta	eng_game_mode
	eng_next_game_rts_b:
		rts
	; }
; -----------------------------------------------------------
	.if	.defined(SMB)|.defined(VS_SMB)
	.export	eng_player_switch
eng_player_switch:
	sec
	lda	eng_player_count
	beq	:++
	lda	eng_lives_b
	bmi	:++ ; if () {
		lda	eng_player_id
		eor	#1
		sta	eng_player_id
		ldx	#(eng_lives_b-eng_lives)-1
		: ; for (value of per_player_values) {
			lda	eng_lives, x
			pha
			lda	eng_lives_b, x
			sta	eng_lives, x
			pla
			sta	eng_lives_b, x

			dex
			bpl	:-
		; }

		clc
	: ; }

	rts
	.endif
; -----------------------------------------------------------
	.export	sub_92AA, sub_92AA_rts
sub_92AA:
	lda	#$FF
	sta	byte_6C9

sub_92AA_rts:
	rts
