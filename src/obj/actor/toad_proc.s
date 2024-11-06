	.export actor_proc_toad
actor_proc_toad:
	jsr	lib_actor_bits_get
	jsr	pos_calc_x_rel_actor
	jmp	render_actor

