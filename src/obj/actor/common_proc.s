.include	"mem.i"
.include	"misc.i"

	.export actor_proc_do
actor_proc_do:
	ldx	actor_index
	lda	#0
	ldy	obj_id_actor, x
	cpy	#actor::actors_page_b
	bcc	:+ ; if (obj_id_actor[x] >= page_b) {
		tya
		sbc	#(actor::actors_page_b)-1
	: ; }

	jsr	tbljmp
	.addr	actor_proc_enemy

	.repeat ACTOR_B_COUNT, I
		.addr	.ident(.sprintf("actor_B_%02X_proc", I))
	.endrep
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_B_02_proc:
actor_B_03_proc:
actor_B_04_proc:
actor_B_05_proc:
actor_B_0E_proc:
actor_B_1B_proc:
actor_B_1E_proc:
actor_proc_null:
	rts
.endif

