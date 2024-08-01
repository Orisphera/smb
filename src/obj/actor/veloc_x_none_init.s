.include    "engine/mem.i"

	.export actor_init_veloc_x_none
actor_init_veloc_x_none:
	lda	#0
	jmp	actor_init_veloc_x
