.include	"unk.i"

	.export actor_proc_firebar
actor_proc_firebar:
	jsr	actor_proc_firebar_do

	jmp	col_actor_oob_proc

