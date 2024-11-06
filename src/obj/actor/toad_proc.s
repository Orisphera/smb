	.export actor_proc_toad
actor_proc_toad:
	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jmp	render_actor

