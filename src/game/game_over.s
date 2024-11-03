.include	"system/ppu.i"

.include	"mem.i"
.include	"joypad.i"
.include	"sound.i"
.include	"modes.i"
.include	"misc.i"

	.export sys_game_over
sys_game_over:
	lda	mode_game
	jsr	tbljmp
	.addr	game_over_init
	.addr	screen_proc
	.if	.defined(VS_SMB)
		.addr	game_over_9902
		.addr	game_over_98DC
		.addr	game_over_98F2
	.endif
	.addr	game_over_proc
; ----------------------------
.if	.defined(VS_SMB)
	.include	"vs_game_over.s"
.endif
; ----------------------------
game_over_init:
	lda	#screen_procs::init
	sta	screen_proc_id
	sta	nmi_sprite_overlap

.if	.defined(SMB2M)
	sta	game_over_choice
.endif

	lda	#music_event::game_over
	sta	apu_music_event_req
	inc	nmi_disp_disable

.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
	inc	mode_game
	rts
.elseif	.defined(ANN)
	jmp	screen_title_bg_finish
.endif
; ----------------------------
game_over_proc:
.if	.defined(SMB)|.defined(SMB2M)
	.if	.defined(SMB)
		GAME_OVER_TIMER_RTS = eng_next_game_rts_b
	.elseif	.defined(SMB2)
		GAME_OVER_TIMER_RTS = eng_next_game_rts_a
	.endif

		lda	#0
		sta	nmi_disp_disable

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

		jmp     game_over_menu

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
		sta	apu_music_event_req
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

		sta	mode_game
		sta	timer_screen
		sta	mode_system
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
		sta	player_proc_id
		sta	mode_game
		lda	#system_modes::game
		sta	mode_system
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
