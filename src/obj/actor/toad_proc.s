	.export actor_proc_toad
	.export	actor_B_20_proc
actor_proc_toad:
actor_B_20_proc:
	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jmp	render_actor

