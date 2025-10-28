.include	"sys/ppu.i"

.include	"mem.i"
.include	"joypad.i"
.include	"sound.i"
.include	"modes.i"
.include	"misc.i"

	.export sys_game_over
	.export	game_over_mode_tbl
	.export	game_over_mode_init
	.export	game_over_mode_scr
	.export	game_over_mode_proc
sys_game_over:
	lda	proc_id_game
	jsr	tbljmp
game_over_mode_tbl:
game_over_mode_init:	.addr	game_over_init
game_over_mode_scr:	.addr	bg_proc

.if	.defined(VS_SMB)
		.export	game_over_mode_9902
		.export	game_over_mode_98DC
		.export	game_over_mode_98F2
game_over_mode_9902:	.addr	game_over_9902
game_over_mode_98DC:	.addr	game_over_98DC
game_over_mode_98F2:	.addr	game_over_98F2
.endif

game_over_mode_proc:	.addr	game_over_proc
; ----------------------------
.if	.defined(VS_SMB)
	.include	"vs_game_over.s"
.endif
; ----------------------------
game_over_init:
	lda	#bg_procs::init
	sta	bg_proc_id
	sta	nmi_sprite_overlap

.if	.defined(SMBV2)
	sta	game_over_choice
.endif

	lda	#music_event::game_over
	sta	apu_music_event_req

	inc	nmi_disp_disable

.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
	inc	proc_id_game
	rts
.elseif	.defined(ANN)
	jmp	bg_title_screen_finish
.endif
; ----------------------------
	.export	game_over_continue
game_over_proc:
.if	.defined(CONS)
.if	.defined(SMB)
	GAME_OVER_TIMER_RTS = game_over_next_game_rts_b
.elseif	.defined(SMB2)
	GAME_OVER_TIMER_RTS = game_over_next_game_rts_a
.endif

	lda	#0
	sta	nmi_disp_disable

.if	.defined(SMB)
	lda	joypad_p1
	and	#joypad_button::start
	bne	game_over_next_game
.elseif	.defined(SMBV2)
	.if	.defined(SMB2)
	lda     course_no
	cmp     #course::no_09
	beq     :+ ; if (!SMB2 && course_no != no_09) {
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

	.export	game_over_next_game
game_over_next_game:
	lda	#music_event::none
	sta	apu_music_event_req
.endif
; ----------------------------
.if	.defined(SMBV1)
	jsr	game_over_player_switch
	bcc	game_over_continue ; if () {
	.if	.defined(VS_SMB)
		lda	player_lives
		bpl	game_over_continue
	.endif
		lda	course_no
		sta	course_no_continued
.endif

		lda	#0

	.if	.defined(SMBV1)
		asl	a
	.endif

		sta	proc_id_game
		sta	timer_screen
		sta	proc_id_system
	game_over_next_game_rts_a:
		rts
	game_over_continue: ; } else {
		jsr	course_descriptor_load
		lda	#player_size::small
		sta	player_size
		inc	player_first_start
		lda	#0
		sta	game_timer_stop
		sta	player_status
		sta	proc_id_player
		sta	proc_id_game
		lda	#system_modes::game
		sta	proc_id_system
	game_over_next_game_rts_b:
		rts
	; }
; -----------------------------------------------------------
	.if	.defined(SMBV1)
	.export	game_over_player_switch
game_over_player_switch:
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
