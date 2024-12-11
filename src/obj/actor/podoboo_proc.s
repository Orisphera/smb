.include	"mem.i"
.include	"math.i"

; -----------------------------------------------------------
PODOBOO_VELOC_Y	= <-7
; -----------------------------------------------------------
	.export actor_proc_podoboo
	.export	actor_A_0C_proc
actor_proc_podoboo:
actor_A_0C_proc:
	lda	timer_actor, x
	bne	:+ ; if (actor.timer == 0) {
		jsr	actor_init_podoboo
		lda	srand+1, x
		ora	#%10000000
		sta	accel_y2_actor, x
		and	#MOD_16
		ora	#%00000110
		sta	timer_actor, x
		lda	#PODOBOO_VELOC_Y
		sta	veloc_y_actor, x
	: ; }

	jmp	motion_fall_mid

