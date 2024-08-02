.include	"engine/mem.i"
.include	"engine/misc.i"

; --------------------------------------------------------------
BULLET_VELOC_X	= <-24
; --------------------------------------------------------------
	.export actor_proc_bullet
actor_proc_bullet:
	lda	state_actor, x
	and	#actor_states::bit_5
	beq	:+ ; if (actor_state & 0x20) {
		jmp	motion_fall_mid
	: ; } else {
		lda	#BULLET_VELOC_X
		sta	veloc_x_actor, x
		jmp	motion_x
	; }

