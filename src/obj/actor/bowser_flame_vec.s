.include	"unk.i"

	.export actor_proc_bowser_flame
actor_proc_bowser_flame:
	jsr	actor_proc_bowser_flame_do

	jsr	lib_actor_bits_get
	jsr	lib_calc_actor_pos
	jsr	col_actor_box
	jsr	col_player_actor_proc

	jmp	col_actor_oob_proc

