.include	"system/cpu.i"

.include	"mem.i"

	.export actor_erase
actor_erase:
	lda	#0
	sta	actor_mode, x
	sta	actor_id, x
	sta	state_actor, x
	sta	screen_score_ctl, x
	sta	timer_actor, x
	sta	stomp_counter, x
	sta	attr_actor, x
	sta	timer_ani_actor, x

	rts

