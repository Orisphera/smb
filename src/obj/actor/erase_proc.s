.include	"system/cpu.i"

.include	"mem.i"

	.export actor_erase
actor_erase:
	lda	#0
	sta	proc_id_actor, x
	sta	obj_id_actor, x
	sta	state_actor, x
	sta	bg_score_ctl, x
	sta	timer_actor, x
	sta	stomp_counter, x
	sta	attr_actor, x
	sta	timer_ani_actor, x

	rts

