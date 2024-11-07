	.export actor_proc_bowser_flame
actor_proc_bowser_flame:
	jsr	actor_proc_bowser_flame_do

	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jsr	col_actor_box
	jsr	col_player_actor_proc
	jmp	col_actor_oob_proc

