.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/joypad.i"
.include	"engine/sound.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

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
	sta	eng_game_over_choice
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

		jmp     eng_game_over_menu

		.if	.defined(SMB2)
			: ; }
		.endif
	.endif

	.if	.defined(SMB)|.defined(SMB2)
		lda	timer_screen
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

	jsr	player_switch
	bcc	eng_game_continue ; if () {
	.if	.defined(VS_SMB)
		lda	player_lives
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
		sta	timer_screen
		sta	eng_game_mode
	eng_next_game_rts_a:
		rts
	eng_game_continue: ; } else {
		jsr	course_descriptor_load
		lda	#player_size::small
		sta	player_size
		inc	eng_req_timer
		lda	#0
		sta	eng_timer_ctl
		sta	player_status
		sta	game_proc_id
		sta	eng_gameplay_mode
		lda	#game_mode::normal
		sta	eng_game_mode
	eng_next_game_rts_b:
		rts
	; }
; -----------------------------------------------------------
	.if	.defined(SMB)|.defined(VS_SMB)
	.export	player_switch
player_switch:
	sec
	lda	player_count
	beq	:++
	lda	player_lives_b
	bmi	:++ ; if (player_count > 0 && player_lives_b >= 0) {
		lda	player_id
		eor	#1
		sta	player_id
		ldx	#(player_lives_b-player_lives)-1
		: ; for (value of per_player_values) {
			lda	player_lives, x
			pha
			lda	player_lives_b, x
			sta	player_lives, x
			pla
			sta	player_lives_b, x

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
