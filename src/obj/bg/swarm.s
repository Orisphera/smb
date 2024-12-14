.include	"system/cpu.i"

.include	"mem.i"
.include	"misc.i"
.include	"tunables.i"

bg_swarm_ids:
	.byte	actor::cheep_fly
	.byte	actor::bullet_cheep_swarm
	.byte	actor::swarm_stop

	.export	bg_scenery_swarm
bg_scenery_swarm:
	ldx	bg_obj_tbl_base
	lda	bg_swarm_ids-((bg_obj_tbl_swarm_a-bg_obj_spec_D)/WORD_SIZE), x
	ldy	#ENG_ACTOR_MAX-1
	: ; for (actor of applicable_actors) {
		dey
		bmi	:+

		cmp	obj_id_actor, y
		bne	:-
	; }
	; if (actor_found) {
		lda	#0
	: ; }
	sta	actor_swarm_queue
	rts
