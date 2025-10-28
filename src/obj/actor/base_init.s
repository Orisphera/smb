.include    "mem.i"
.include    "const.i"

actor_init_base_veloc_x:
	.byte	<-ACTOR_BASE_VELOC_X, <-ACTOR_BASE_VELOC_X_HARD
; ----------------------------------
	.export actor_init_base, actor_init_veloc_x
	.export	actor_A_00_init
	.export	actor_A_01_init
	.export	actor_A_02_init
actor_init_base:
actor_A_00_init:
actor_A_01_init:
actor_A_02_init:
	ldy	#1
	lda	game_hard_mode
	bne	:+ ; if (!game.hard_mode) {
		dey
	: ; }
	lda	actor_init_base_veloc_x, y
; ----------------------------------
actor_init_veloc_x:
	sta	veloc_x_actor, x
	jmp	actor_init_col_large
