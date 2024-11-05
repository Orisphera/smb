.include    "mem.i"
.include    "tunables.i"

actor_init_base_veloc_x:
	.byte	<-ACTOR_BASE_VELOC_X, <-ACTOR_BASE_VELOC_X_HARD
; ------------------------------
	.export actor_init_base, actor_init_veloc_x
actor_init_base:
	ldy	#1
	lda	game_hard_mode
	bne	:+ ; if (!game.hard_mode) {
		dey
	: ; }
	lda	actor_init_base_veloc_x, y
; ------------------------------
actor_init_veloc_x:
	sta	veloc_x_actor, x
	jmp	actor_init_col_large
