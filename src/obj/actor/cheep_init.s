.include	"mem.i"

; ------------------------------------------------------------
CHEEP_VELOC_X_RAND_MASK	= %00010000
; ------------------------------------------------------------
	.export actor_init_cheep
actor_init_cheep:
	jsr	actor_init_col_small
	lda	lib_rand, x
	and	#%00010000
	sta	veloc_x_actor, x
	lda	pos_y_lo_actor, x
	sta	accel_y_actor_c, x
	rts

