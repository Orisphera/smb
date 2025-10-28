.include	"sys/cpu.i"

.include	"mem.i"
.include	"misc.i"
.include	"const.i"

scenery_swarm_ids:
	.byte	actor::cheep_fly
	.byte	actor::bullet_cheep_swarm
	.byte	actor::swarm_stop

	.export	scenery_swarm
scenery_swarm:
	ldx	scenery_tbl_base
	lda	scenery_swarm_ids-((scenery_tbl_swarm_a-scenery_spec_D)/WORD_SIZE), x
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
