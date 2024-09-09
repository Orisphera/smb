.include	"mem.i"
.include	"tunables.i"
.include	"sound.i"
.include	"misc.i"

; ------------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	misc_coin_coin_players:
		.byte	stats_coin_player_a_end-stats_tbl-1
		.byte	stats_coin_player_b_end-stats_tbl-1

	misc_coin_score_players:
		.byte	(stats_score_player_a_end-stats_tbl)-1
		.byte	(stats_score_player_b_end-stats_tbl)-1

	misc_coin_stats_players:
		.byte	(stats::score_player_a<<4)|(stats::coin_player_a)
		.byte	(stats::score_player_b<<4)|(stats::coin_player_b)
.endif

.if	.defined(VS)
	misc_coin_max:
		.byte	COIN_MAX+(COIN_VS_INC*0)
		.byte	COIN_MAX+(COIN_VS_INC*1)
		.byte	COIN_MAX+(COIN_VS_INC*2)
		.byte	COIN_MAX+(COIN_VS_INC*3)
.endif
; -----------------------------
    .export misc_proc_coin_add
	.export misc_proc_coin_update_score
	.export misc_proc_coin_update_stats
	.export misc_proc_coin_add_score
misc_proc_coin_add:
	lda	#1
	sta	score_digit_mod+6
	.if	.defined(SMB)|.defined(VS_SMB)
		ldx	player_id
		ldy	misc_coin_coin_players, x
	.elseif	.defined(SMB2M)
		ldy	#(stats_coin_player_end-stats_tbl)-1
	.endif
	jsr	stats_calc
	inc	player_coins
	lda	player_coins

	.if	.defined(CONS)
		cmp	#COIN_MAX
	.elseif	.defined(VS)
		ldx	VS_RAM_ARENA0+2
		cmp	misc_coin_max, x
	.endif
	bne	:++ ; if (player_coins == COIN_MAX) {
		lda	#0
		sta	player_coins

		.if	.defined(VS_SMB)
			ldx	player_id
			ldy	misc_coin_coin_players, x
			ldx	#4-1
			: ; for (x = 4-1; x > 0; x--) {
				sta	stats_tbl, y

				dey
				dex
				bpl	:-
			; }
		.else
			:
		.endif

		inc	player_lives
		lda	#sfx_pulse2::oneup
		sta	apu_pulse2_queue
	: ; }

	lda	#2
	sta	score_digit_mod+5

misc_proc_coin_update_score:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldx	player_id
		ldy	misc_coin_score_players, x
	.elseif	.defined(SMB2M)
		ldy	#(stats_score_player_end-stats_tbl)-1
	.endif
	jsr	stats_calc

misc_proc_coin_update_stats:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	player_id
		lda	misc_coin_stats_players, y
	.elseif	.defined(SMB2M)
		lda	#(stats::score_player_a)|(stats::coin_player_a)
	.endif

misc_proc_coin_add_score:
	jsr	stats_print_num

	ldy	nmi_list_0_offset
	lda	OAM_DMA_BUFFER+$FB, y
	bne	:+ ; if (!OAM_DMA_BUFFER[0xFB]) {
		lda	#$24
		sta	OAM_DMA_BUFFER+$FB, y
	: ; }

	ldx	actor_index
	rts
