.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"

	.export actor_init_swarm
actor_init_swarm:
	lda	actor_id, x
	sta	actor_swarm_buffer
	sec
	sbc	#actor::swarm_start
	jsr	eng_farjump
	.addr	actor_init_lakitu_spiny
	.addr	actor_init_swarm_null
	.addr	actor_init_cheep_fly
	.addr	actor_init_bowser_flame
	.addr	actor_init_fireworks
	.addr	actor_init_bullet_cheep
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_init_swarm_null:
	rts 
.endif
; -----------------------------------------------------------
	.export actor_kill_swarm
actor_kill_swarm:
	ldy	#ENG_ACTOR_MAX-1
	: ; for (actor of actors) {
		lda	actor_id, y
		cmp	#actor::lakitu
		bne	:+ ; if (actor.id == lakitu) {
			lda	#actor_states::state_1
			sta	state_actor, y
		: ; }
	
		dey
		bpl	:--
	; }

	lda	#actor_modes::free
	sta	actor_swarm_buffer
	sta	actor_mode, x

.if	.defined(ANN)
actor_init_swarm_null:
.endif
	rts

