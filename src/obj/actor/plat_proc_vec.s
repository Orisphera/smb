.include	"mem.i"
.include	"misc.i"

	.export actor_proc_plat_small
actor_proc_plat_small:
	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jsr	col_plat_s_box
	jsr	col_plat_s_proc

	jsr	pos_calc_x_rel_actor

	jsr	render_plat_small

	jsr	actor_proc_plat_small_do

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
	.export actor_proc_plat_large
actor_proc_plat_large:
	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jsr	col_plat_l_box
	jsr	col_plat_l_proc

	lda	game_timer_stop
	bne	:+ ; if (game_timer_stop) {
		jsr	actor_proc_plat_do
	: ; }

	jsr	pos_calc_x_rel_actor

	jsr	render_plat_large

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_plat_do:
	lda	obj_id_actor, x
	sec
	sbc	#actor::plat_start
	jsr	tbljmp
	.addr	actor_proc_plat_bal
	.addr	actor_proc_plat_mov_v
	.addr	actor_proc_plat_lift
	.addr	actor_proc_plat_lift
	.addr	actor_proc_plat_move_h
	.addr	actor_proc_plat_drop
	.addr	actor_proc_plat_right

