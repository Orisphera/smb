.include	"mem.i"
.include	"const.i"
.include	"misc.i"

	.export actor_init_swarm
	.export	actor_A_12_init
	.export	actor_A_14_init
	.export	actor_B_00_init
	.export	actor_B_01_init
	.export	actor_B_02_init
actor_init_swarm:
actor_A_12_init:
actor_A_14_init:
actor_B_00_init:
actor_B_01_init:
actor_B_02_init:
	lda	obj_id_actor, x
	sta	actor_swarm_buffer
	sec
	sbc	#actor::swarm_start
	jsr	tbljmp
	.addr	actor_init_lakitu_spiny
	.addr	actor_init_swarm_null
	.addr	actor_init_cheep_fly
	.addr	actor_init_bowser_flame
	.addr	actor_init_fireworks
	.addr	actor_init_bullet_cheep
; ----------------------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_init_swarm_null:
	rts 
.endif
; ----------------------------------------------------------------------
	.export actor_kill_swarm
	.export	actor_B_03_init
actor_kill_swarm:
actor_B_03_init:
	ldy	#ACTOR_COUNT_MAX-1
	: ; for (actor of actors) {
		lda	obj_id_actor, y
		cmp	#actor::lakitu
		bne	:+ ; if (actor.id == lakitu) {
			lda	#actor_states::state_1
			sta	state_actor, y
		: ; }
	
		dey
		bpl	:--
	; }

	lda	#proc_id_actors::free
	sta	actor_swarm_buffer
	sta	proc_id_actor, x

.if	.defined(ANN)
actor_init_swarm_null:
.endif
	rts

