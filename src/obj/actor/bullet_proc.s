.include	"mem.i"
.include	"misc.i"

; ----------------------------------------------------------------------
BULLET_VELOC_X	= <-24
; ----------------------------------------------------------------------
	.export actor_proc_bullet
	.export	actor_A_08_proc
actor_proc_bullet:
actor_A_08_proc:
	lda	state_actor, x
	and	#actor_states::dying
	beq	:+ ; if (actor_state & 0x20) {
		jmp	motion_fall_mid
	: ; } else {
		lda	#BULLET_VELOC_X
		sta	veloc_x_actor, x
		jmp	motion_x
	; }

