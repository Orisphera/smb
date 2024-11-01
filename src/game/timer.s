.include	"mem.i"
.include	"misc.i"
.include	"tunables.i"
.include	"sound.i"

	.export	stats_time_proc
stats_time_proc:
	lda	mode_system
	beq	:++++
	lda	player_proc_id
	cmp	#player_procs::ctrl
	bcc	:++++
	cmp	#player_procs::death
	beq	:++++
	lda	pos_y_hi_player
	cmp	#2
	.if	.defined(SMB)|.defined(VS_SMB)
	bcs	:++++
	.elseif	.defined(SMB2M)
	bpl	:++++
	.endif
	lda	timer_game_ctrl
	bne	:++++ ; if (mode_system != title && this.proc_id >= ctrl && this.proc_id != death && this.pos_y.hi < 2 && !timer_game_ctrl) {
		lda	stats_time_end-STATS_TIME_LEN
		ora	stats_time_end-STATS_TIME_LEN+1
		ora	stats_time_end-STATS_TIME_LEN+2
		beq	:+++ ; if (time.digit0 != 0) {
			ldy	stats_time_end-STATS_TIME_LEN
			dey
			bne	:+
			lda	stats_time_end-STATS_TIME_LEN+1
			ora	stats_time_end-STATS_TIME_LEN+2
			bne	:+ ; if (--game.time.digit0 == 0) {
				lda	#music_event::hurry_up
				sta	apu_music_event
			: ; }

			.if	.defined(CONS)
				lda	#GAME_TIMER_CTL
				:
			.elseif	.defined(VS)
				lda	#$11
				ldy	VS_RAM_ARENA0+3
				bne	:+ ; if (!vs_ram_arena0[3]) {
					lda	#$14
				: ; }
			.endif

			sta	timer_game_ctrl
			ldy	#(stats_time_end-stats_tbl)-1
			lda	#$FF
			sta	score_digit_mod+6
			jsr	stats_calc
			lda	#(10<<4)|(stats::time)
			jmp	stats_print_num
		: ; } else {
			sta	player_status
			jsr	col_player_harm_proc_do
			inc	eng_done_timer
		; }
	: ; }

stats_time_proc_rts:
	rts
; ------------------------------------------------------------
	.export actor_proc_warp
actor_proc_warp:
	lda	game_scroll_lock
	beq	stats_time_proc_rts
	lda	pos_y_lo_player
	and	pos_y_hi_player
	bne	stats_time_proc_rts ; if (scroll_lock && this.pos_y == 0) {
		sta	game_scroll_lock

		.if	.defined(SMB)|.defined(VS_SMB)
			inc	eng_warp_ctrl
		.endif

		jmp	actor_erase
	; } else rts;
