.include	"mem.i"

	.export actor_proc_enemy
actor_proc_enemy:
	lda	#obj_attr::priority_high|obj_attr::color0
	sta	attr_actor, x
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	render_actor
	jsr	col_actor_box
	jsr	col_actor_ground_proc
	jsr	col_actor_actor_proc
	jsr	col_player_actor_proc

	ldy	eng_timer_ctl
	bne	:+ ; if (!eng_timer_ctl) {
		jsr	actor_proc_enemy_do
	: ; }
	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_enemy_do:
	lda	actor_id, x
	jsr	tbljmp
	.addr	actor_proc_base
	.addr	actor_proc_base
	.addr	actor_proc_base
	.addr	actor_proc_base

	.if	.defined(SMB)|.defined(VS_SMB)
		.addr	actor_proc_base
	.elseif	.defined(SMB2M)
		.addr	actor_proc_piranha_plant_b
	.endif

	.addr	actor_proc_hammer_bro
	.addr	actor_proc_base
	.addr	actor_proc_blooper
	.addr	actor_proc_bullet
	.addr	actor_proc_null_b
	.addr	actor_proc_cheep
	.addr	actor_proc_cheep
	.addr	actor_proc_podoboo
	.addr	actor_proc_piranha_plant
	.addr	actor_proc_bounce
	.addr	actor_proc_koopa_red_fly
	.addr	actor_proc_koopa_green_fly
	.addr	actor_proc_lakitu
	.addr	actor_proc_base
	.addr	actor_proc_null_b
	.addr	actor_proc_cheep_fly
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_proc_null_b:
	rts
.endif

