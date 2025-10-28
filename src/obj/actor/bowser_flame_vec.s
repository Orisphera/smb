	.export actor_proc_bowser_flame
	.export	actor_B_00_proc
actor_proc_bowser_flame:
actor_B_00_proc:
	jsr	actor_proc_bowser_flame_do

	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jsr	col_actor_box
	jsr	col_player_actor_proc
	jmp	actor_oob_proc

