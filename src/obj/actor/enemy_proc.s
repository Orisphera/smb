.include	"mem.i"
.include	"const.i"

	.export actor_proc_enemy
actor_proc_enemy:
	lda	#obj_attr::priority_high|obj_attr::color0
	sta	attr_actor, x

	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jsr	render_actor

	jsr	col_actor_box
	jsr	col_actor_ground_proc
	jsr	col_actor_actor_proc
	jsr	col_player_actor_proc

	ldy	game_timer_stop
	bne	:+ ; if (!game_timer_stop) {
		jsr	actor_proc_enemy_do
	: ; }
	jmp	actor_oob_proc
; ----------------------------------------------------------------------
actor_proc_enemy_do:
	lda	obj_id_actor, x
	jsr	tbljmp

	.repeat ACTOR_A_COUNT, I
		.export	.ident(.sprintf("actor_proc_A_tbl_%02X", I))
	.ident(.sprintf("actor_proc_A_tbl_%02X", I)):
		.addr	.ident(.sprintf("actor_A_%02X_proc", I))
	.endrep
; ----------------------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_proc_null_b:
actor_A_09_proc:
actor_A_13_proc:
	rts
.endif

