.include	"engine/mem.i"

; -----------------------------------------------------------
TOAD_POS_Y_LO	= <-72
; -----------------------------------------------------------
	.export actor_init_toad
actor_init_toad:
	lda	#TOAD_POS_Y_LO
	sta	pos_y_lo_actor, x
	rts
