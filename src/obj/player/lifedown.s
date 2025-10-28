.include	"mem.i"
.include	"sound.i"
.include	"math.i"
.include	"modes.i"
.include	"misc.i"

; ----------------------------------------------------------------------
	.export	lifedown_starts
lifedown_starts:
.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$56, $40
.elseif	.defined(SMB2)
	.byte	$66, $60
.endif

.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$65, $70
.elseif	.defined(SMB2)
	.byte	$88, $60
.endif

.if	.defined(SMBM)
	.byte	$66, $40
.elseif	.defined(VS_SMB)
	.byte	$68, $40
.elseif	.defined(SMB2)
	.byte	$66, $70
.endif

.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$66, $40
.elseif	.defined(SMB2)
	.byte	$77, $60
.endif

.if	.defined(SMB)
	.byte	$66, $40
.elseif	.defined(VS_SMB)|.defined(ANN)
	.byte	$66, $60
.elseif	.defined(SMB2)
	.byte	$D6, $00
.endif

.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$66, $60
.elseif	.defined(SMB2)
	.byte	$77, $80
.endif

.if	.defined(SMB)
	.byte	$65, $70
.elseif	.defined(VS_SMB)
	.byte	$68, $80
.elseif	.defined(ANN)
	.byte	$67, $80
.elseif	.defined(SMB2)
	.byte	$70, $B0
.endif

	.byte	$00, $00

.if	.defined(SMB2)
	.byte	$00, $00
.endif
; ----------------------------------
	.export	player_proc_lifedown
player_proc_lifedown:
	inc	nmi_disp_disable
	lda	#0
	sta	nmi_sprite_overlap
	lda	#music_event::none
	sta	apu_music_event_req

	dec	player_lives
	bpl	:+ ; if (--this.lives < 0) {
		lda	#game_over_modes::init
		sta	proc_id_game
		lda	#system_modes::game_over
		sta	proc_id_system
		rts
	: ; } else {
		lda	course_no
		asl	a
		tax
		lda	player_goals
		and	#MOD_4_2_UP
		beq	:+ ; if ((this.goals % 4) >= 2) {
			inx
		: ; }

		ldy	lifedown_starts, x
		lda	player_goals
		lsr	a
		tya
		bcs	:+ ; if ((this.goals % 2)) {
			lsr	a
			lsr	a
			lsr	a
			lsr	a
		: ; }
		and	#%00001111
		cmp	pos_x_hi_screen_left
		beq	:+
		bcc	:+ ; if (lifedown_starts > pos_x_hi_screen_left) {
			lda	#0
		: ; }
		sta	pos_x_hi_alt_game

		.if	.defined(SMBV1)
			jsr	game_over_player_switch
		.endif

		jmp	game_over_continue
	; }
