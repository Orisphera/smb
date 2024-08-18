.include	"engine/mem.i"
.include	"engine/math.i"

; -----------------------------------------------------------
PODOBOO_VELOC_Y	= <-7
; -----------------------------------------------------------
	.export actor_proc_podoboo
actor_proc_podoboo:
	lda	timer_actor, x
	bne	:+ ; if (actor.timer == 0) {
		jsr	actor_init_podoboo
		lda	eng_rand_seed+1, x
		ora	#%10000000
		sta	accel_y_actor_c, x
		and	#MOD_16
		ora	#%00000110
		sta	timer_actor, x
		lda	#PODOBOO_VELOC_Y
		sta	veloc_y_actor, x
	: ; }

	jmp	motion_fall_mid

