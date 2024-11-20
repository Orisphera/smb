.include	"system/ppu.i"

.include	"math.i"
.include	"mem.i"
.include	"misc.i"
.include	"chr.i"
.include	"sound.i"

; -----------------------------------------------------------
actor_proc_flag_pos_y:
	.byte	0, 0, 8, 8

actor_proc_flag_pos_x:
	.byte	0, 8, 0, 8

actor_proc_flag_chr_nos:
	.byte	chr_obj::flag_victory
	.byte	chr_obj::flag_victory+1
	.byte	chr_obj::flag_victory+2
	.byte	chr_obj::flag_victory+3
actor_proc_flag_chr_nos_end:
; ----------------------------
	.export actor_proc_flag_victory
	.export actor_proc_flag_victory_tbl
	.export actor_proc_flag_victory_tbl_null
	.export actor_proc_flag_victory_tbl_fireworks
	.export actor_proc_flag_victory_tbl_timer_score
	.export actor_proc_flag_victory_tbl_raise
	.export actor_proc_flag_victory_tbl_delay
	.export actor_proc_flag_victory_tbl_done
actor_proc_flag_victory:
	lda	#0
	sta	actor_swarm_buffer
	lda	proc_id_flag_victory
	cmp	#<flag_victory_proc::done
	bcs	actor_proc_flag_victory_fireworks_rts
	jsr	tbljmp
actor_proc_flag_victory_tbl:
actor_proc_flag_victory_tbl_null:
	.addr	actor_proc_flag_victory_fireworks_rts
actor_proc_flag_victory_tbl_fireworks:
	.addr	actor_proc_flag_victory_fireworks
actor_proc_flag_victory_tbl_timer_score:
	.addr	actor_proc_flag_victory_timer_score
actor_proc_flag_victory_tbl_raise:
	.addr	actor_proc_flag_victory_raise
actor_proc_flag_victory_tbl_delay:
	.addr	actor_proc_flag_victory_delay
actor_proc_flag_victory_tbl_done:
; -----------------------------------------------------------
actor_proc_flag_victory_fireworks:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	#actor_states::state_5
		lda	stats_time_end-STATS_TIME_LEN+2
		cmp	#1
		beq	:+ ; if (game.time.digit_last != 1) {
			ldy	#actor_states::state_3
	
			cmp	#3
			beq	:+ ; if (game.time.digit_last != 3) {
				ldy	#actor_states::init
	
				cmp	#6
				beq	:+ ; if (game.time.digit_last != 6) {
					lda	#<-1
				; }
			; }
		: ; }
	.elseif	.defined(SMB2M)
	        lda     stats_time_end-STATS_TIME_LEN+2
	        cmp     stats_coin_player_end-1
	        bne     :++
	        and     #MOD_2
	        beq     :+ ; if ((game.time.digit_last == player.coin.digit_last) && (game.time.digit_last % 2)) {
	        	ldy     #actor_states::state_3
	        	lda     #3

	        	bne     :+++
		: ; } else if ((game.time.digit_last == player.coin.digit_last) && !(game.time.digit_last % 2)) {
	        	ldy     #actor_states::init
	        	lda     #6

	        	bne     :++
		: ; } else {
	        	ldy     #actor_states::init
			lda	#<-1
		: ; }
	.endif
	sta	actor_firework_counter
	sty	state_actor, x

actor_proc_flag_victory_fireworks_step:
	inc	proc_id_flag_victory

actor_proc_flag_victory_fireworks_rts:
	rts
; -----------------------------------------------------------
	.export actor_proc_flag_victory_timer_score_do
	.export actor_proc_course_end_stats
actor_proc_flag_victory_timer_score:
	lda	stats_time_end-STATS_TIME_LEN
	ora	stats_time_end-STATS_TIME_LEN+1
	ora	stats_time_end-STATS_TIME_LEN+2
	beq	actor_proc_flag_victory_fireworks_step

actor_proc_flag_victory_timer_score_do:
	lda	frame_count
	and	#MOD_8_4_UP
	beq	:+ ; if ((frame_count % 8) >= 4) {
		lda	#sfx_pulse_2::tick
		sta	apu_sfx_pulse_2_req
	: ; }

	ldy	#(stats_time_end-stats_tbl)-1
	lda	#$FF
	sta	score_digit_mod+6
	jsr	stats_calc
	lda	#5
	sta	score_digit_mod+6
; ------------------------------
actor_proc_course_end_stats:
	ldy	#(stats_score_player_a_end-stats_tbl)-1

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	player_id
		beq	:+ ; if (player_id) {
			ldy	#(stats_score_player_b_end-stats_tbl)-1
		: ; }
	.endif

	jsr	stats_calc

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	player_id
		asl	a
		asl	a
		asl	a
		asl	a
		ora	#%00000100
	.elseif	.defined(SMB2M)
		lda	#2
	.endif
	jmp	misc_proc_coin_add_score
; -----------------------------------------------------------
actor_proc_flag_victory_raise:
	lda	pos_y_lo_actor, x
	cmp	#114
	bcc	:+ ; if (actor.pos_y >= 114) {
		dec	pos_y_lo_actor, x

		jmp	actor_proc_flag_victory_draw
	: lda	actor_firework_counter
	beq	actor_proc_flag_victory_start_flag
	bmi	actor_proc_flag_victory_start_flag ; } else if (actor_firework_counter > 0) {
		lda	#actor::fireworks
		sta	actor_swarm_buffer
	; } else actor_proc_flag_victory_start_flag();
; ------------------------------
actor_proc_flag_victory_draw:
	jsr	pos_calc_x_rel_actor
	ldy	obj_data_offset_actor, x
	ldx	#(actor_proc_flag_chr_nos_end-actor_proc_flag_chr_nos)-1
	: ; for () {
		lda	pos_y_rel_actor
		clc
		adc	actor_proc_flag_pos_y, x
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		lda	actor_proc_flag_chr_nos, x
		sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
		lda	#obj_attr::priority_low|obj_attr::color2
		sta	OAM_DMA_BUFFER+OBJ_ATTR, y
		lda	pos_x_rel_actor
		clc
		adc	actor_proc_flag_pos_x, x
		sta	OAM_DMA_BUFFER+OBJ_POS_H, y

		iny
		iny
		iny
		iny
		dex
		bpl	:-
	; }

	ldx	actor_index
	rts
; -----------------------------
actor_proc_flag_victory_start_flag:
	jsr	actor_proc_flag_victory_draw
	lda	#6
	sta	timer_actor, x

actor_proc_flag_victory_next:
	inc	proc_id_flag_victory
	rts
; -----------------------------------------------------------
actor_proc_flag_victory_delay:
	jsr	actor_proc_flag_victory_draw

	lda	timer_actor, x
	bne	:+
	lda	apu_music_event_current
	beq	actor_proc_flag_victory_next
	: ; if (this.timer != 0 || music.event_current != null) {
		rts
	; else actor_proc_flag_victory_next();
