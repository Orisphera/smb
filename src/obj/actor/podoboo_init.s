.include    "mem.i"

; ----------------------------------------------------------------------
PODOBOO_POS_Y_INIT_2    = 2
; ----------------------------------------------------------------------
	.export actor_init_podoboo
	.export	actor_A_0C_init
actor_init_podoboo:
actor_A_0C_init:
	lda	#PODOBOO_POS_Y_INIT_2
	sta	pos_y_hi_actor, x
	sta	pos_y_lo_actor, x
	lsr	a
	sta	timer_actor, x
	lsr	a
	sta	state_actor, x
	jmp	actor_init_col_small
