.include    "mem.i"
.include    "misc.i"

	.export actor_init_koopa_red
	.export actor_A_03_init
actor_init_koopa_red:
actor_A_03_init:
	jsr	actor_init_base
	lda	#actor_states::descending
	sta	state_actor, x
	rts
