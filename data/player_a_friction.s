.if	.defined(STATS_BASE_INCLUDE)
game_proc_player_data_friction:
.endif
	.ifndef	PAL
		.byte	<-$1C, <-$68, <-$30
	.else
		.byte	<-$40, 00, <-$80
	.endif
