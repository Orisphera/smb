.include    "engine/mem.i"
.include    "engine/misc.i"

	.export actor_init_koopa_red
actor_init_koopa_red:
	jsr	actor_init_base
	lda	#actor_states::state_1
	sta	state_actor, x
	rts
