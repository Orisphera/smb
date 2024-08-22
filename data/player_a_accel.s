.if	.defined(STATS_BASE_INCLUDE)
game_proc_player_jump_accel_y:
.endif
	.byte	$20, $20, $1E, $28, $28

	.byte	$0D, $04

.if	.defined(STATS_BASE_INCLUDE)
game_proc_player_grav_accel_y:
.endif
	.byte	$70, $70, $60, $90, $90

	.byte	$0A, $09

