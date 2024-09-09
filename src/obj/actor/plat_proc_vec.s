.include	"engine/mem.i"
.include	"engine/misc.i"
.include	"engine/unk.i"

	.export actor_proc_plat_small
actor_proc_plat_small:
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	col_plat_s_box
	jsr	col_plat_s_proc

	jsr	lib_calc_actor_pos
	jsr	render_plat_small

	jsr	actor_proc_plat_small_do

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
	.export actor_proc_plat_large
actor_proc_plat_large:
	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	col_plat_l_box
	jsr	col_plat_l_proc

	lda	eng_timer_ctl
	bne	:+ ; if (eng_timer_ctl) {
		jsr	actor_proc_plat_do
	: ; }

	jsr	lib_calc_actor_pos
	jsr	render_plat_large

	jmp	col_actor_oob_proc
; -----------------------------------------------------------
actor_proc_plat_do:
	lda	actor_id, x
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

