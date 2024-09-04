.if	.defined(STATS_BASE_INCLUDE)
game_proc_player_jump_accel_y:
.endif
	.ifndef	PAL
		.byte	$20, $20, $1E, $28, $28
	.else
		.byte	$30, $30, $2D, $38, $38
	.endif

	.byte	$0D, $04

.if	.defined(STATS_BASE_INCLUDE)
game_proc_player_grav_accel_y:
.endif
	.ifndef	PAL
		.byte	$70, $70, $60, $90, $90
	.else
		.byte	$A8, $A8, $90, $D0, $D0
	.endif

	.byte	$0A, $09

