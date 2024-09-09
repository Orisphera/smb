.include	"unk.i"

	.export actor_proc_toad
actor_proc_toad:
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jmp	render_actor

