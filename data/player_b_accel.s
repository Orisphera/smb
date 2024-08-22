.if	.defined(STATS_BASE_INCLUDE)
game_proc_player_jump_accel_y:
.endif
	.byte	$18, $18, $18, $22, $22

	.byte	$0D, $04

.if	.defined(STATS_BASE_INCLUDE)
game_proc_player_grav_accel_y:
.endif
	.byte	$42, $42, $3E, $5D, $5D

	.byte	$0A, $09
