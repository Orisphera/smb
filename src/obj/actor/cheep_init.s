.include	"mem.i"

; ------------------------------------------------------------
CHEEP_VELOC_X_RAND_MASK	= %00010000
; ------------------------------------------------------------
	.export actor_init_cheep
	.export	actor_A_0A_init
	.export	actor_A_0B_init
actor_init_cheep:
actor_A_0A_init:
actor_A_0B_init:
	jsr	actor_init_col_small
	lda	srand, x
	and	#%00010000
	sta	veloc_x_actor, x
	lda	pos_y_lo_actor, x
	sta	accel_y2_actor, x
	rts

