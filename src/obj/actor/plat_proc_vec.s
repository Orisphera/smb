.include	"mem.i"
.include	"misc.i"

	.export actor_proc_plat_small
	.export	actor_B_16_proc
	.export	actor_B_17_proc
actor_proc_plat_small:
actor_B_16_proc:
actor_B_17_proc:
	jsr	pos_bits_get_actor
	jsr	pos_calc_x_rel_actor

	jsr	col_plat_s_box
	jsr	col_plat_s_proc

	jsr	pos_calc_x_rel_actor

	jsr	render_plat_small

	jsr	actor_proc_plat_small_do

	jmp	actor_oob_proc
; -----------------------------------------------------------
	.export actor_proc_plat_large
	.export	actor_B_0F_proc
	.export	actor_B_10_proc
	.export	actor_B_11_proc
	.export	actor_B_12_proc
	.export	actor_B_13_proc
	.export	actor_B_14_proc
	.export	actor_B_15_proc
actor_proc_plat_large:
actor_B_0F_proc:
actor_B_10_proc:
actor_B_11_proc:
actor_B_12_proc:
actor_B_13_proc:
actor_B_14_proc:
actor_B_15_proc:
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

	jmp	actor_oob_proc
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

