.include	"mem.i"
.include	"misc.i"
.include	"tunables.i"
.include	"sound.i"

SCORE_PLACE_THOUSANDS		= 3
SCORE_PLACE_THOUSANDS_DIV	= 1000
SCORE_PLACE_HUNDREDS		= 4
SCORE_PLACE_HUNDREDS_DIV	= 100

pole_score_hi:
	.byte	5000/(SCORE_PLACE_THOUSANDS_DIV)
	.byte	2000/(SCORE_PLACE_THOUSANDS_DIV)
	.byte	800/(SCORE_PLACE_HUNDREDS_DIV)
	.byte	400/(SCORE_PLACE_HUNDREDS_DIV)
	.byte	100/(SCORE_PLACE_HUNDREDS_DIV)

pole_digit_place:
	.byte	SCORE_PLACE_THOUSANDS
	.byte	SCORE_PLACE_THOUSANDS
	.byte	SCORE_PLACE_HUNDREDS
	.byte	SCORE_PLACE_HUNDREDS
	.byte	SCORE_PLACE_HUNDREDS
; -----------------------------
	.export	pole_proc
pole_proc:
	ldx	#5
	stx	actor_index
	lda	obj_id_actor, x
	cmp	#actor::flag_enemy
	bne	pole_proc_rts
	lda	proc_id_player
	cmp	#player_procs::pole
	bne	:+
	lda	state_player
	cmp	#player_state::climb
	bne	:+
	lda	pos_y_lo_actor, x
	cmp	#170
	bcs	:++
	lda	pos_y_lo_player
	cmp	#162
	bcs	:++ ; if (this.proc_id != pole || this.state != climb || (actor.pos_y.lo < 0xAA && this.pos_y.lo < 0xA2)) {
		; if (this.proc_id == pole && this.state == climb) {
			lda	accel_y_actor, x
			adc	#<-1
			sta	accel_y_actor, x
			lda	pos_y_lo_actor, x
			adc	#1
			sta	pos_y_lo_actor, x
			lda	render_flag_score_pos_y_b
			sec
			sbc	#<-1
			sta	render_flag_score_pos_y_b
			lda	render_flag_score_pos_y
			sbc	#1
			sta	render_flag_score_pos_y
		: ; }

		jmp	:++++
	: ; } else {
		ldy	render_flag_score_val
	
		.if	.defined(SMBV2)
		cpy	#FLAG_SCORE_VALUE_ONEUP
		bne	:+ ; if (SMBV2 && render_flag_score_val == oneup) {
			inc	player_lives
			lda	#sfx_pulse_2::oneup
			sta	apu_sfx_pulse_2_req
			jmp	:++
		.endif
		: ; } else {
			lda	pole_score_hi, y
			ldx	pole_digit_place, y
			sta	score_digit_mod+1, x
			jsr	misc_proc_coin_update_score
		: ; }

		lda	#player_procs::victory
		sta	proc_id_player
	: ; }

	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jsr	render_flag_enemy

pole_proc_rts:
	rts
