	.export	player_proc_veloc_y_player
player_proc_veloc_y_player:
	.ifndef	PAL
		.byte	<-4, <-4, <-4, <-5, <-5
	.else
		.byte	<-5, <-5, <-5, <-6, <-6
	.endif

	.byte	<-2, <-1

	.export	player_proc_player_init_accel_y
player_proc_player_init_accel_y:
	.ifndef	PAL
		.byte	0, 0, 0
	.else
		.byte	52, 52, 52
	.endif

	.byte	0, 0

	.byte	$80, $00

	.export	player_proc_player_max_veloc_left
player_proc_player_max_veloc_left:
	.ifndef	PAL
		.byte	<-$28, <-$18, <-$10
	.else
		.byte	<-$30, <-$1C, <-$13
	.endif

	.export	player_proc_player_max_veloc_right
player_proc_player_max_veloc_right:
	.ifndef	PAL
		.byte	$28, $18, $10
	.else
		.byte	$30, $1C, $13
	.endif

	.export	player_proc_player_max_veloc_right_enter
player_proc_player_max_veloc_right_enter:
	.ifndef	PAL
		.byte	$0C
	.else
		.byte	$0E
	.endif

