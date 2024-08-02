.include	"system/cpu.i"

.include	"engine/mem.i"

	.export actor_erase
actor_erase:
	lda	#0
	sta	actor_mode, x
	sta	actor_id, x
	sta	state_actor, x
	sta	STACK_BASE+$10, x
	sta	eng_timer_actor, x
	sta	STACK_BASE+$25, x
	sta	attr_actor, x
	sta	eng_timer_actor_ani, x

	rts

