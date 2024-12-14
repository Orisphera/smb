.include	"mem.i"
.include	"tunables.i"

	.export	bg_obj_alloc
bg_obj_alloc:
	ldx	#0
	: ; for (x = 0; proc_id_actor[x] != dead && x < (ENG_ACTOR_MAX-1); x++) {
		clc
		lda	proc_id_actor, x
		beq	:+
		inx
		cpx	#ENG_ACTOR_MAX-1
		bne	:-
	: ; }

	rts
