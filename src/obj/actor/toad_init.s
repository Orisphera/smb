.include	"mem.i"

; ----------------------------------------------------------------------
TOAD_POS_Y_LO	= 184
; ----------------------------------------------------------------------
	.export actor_init_toad
	.export	actor_B_20_init
actor_init_toad:
actor_B_20_init:
	lda	#TOAD_POS_Y_LO
	sta	pos_y_lo_actor, x
	rts
