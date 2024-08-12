.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"
.include	"engine/joypad.i"

; -----------------------------------------------------------
BLOOBER_VELOC_X		= 0
KOOPA_RED_ACCEL_X_RIGHT	= 48
KOOPA_RED_ACCEL_X_LEFT	= <-32
; -----------------------------------------------------------
	.export actor_init_bloober
	.export actor_init_koopa_red_fly
	.export actor_init_col_small, actor_init_col_large, actor_init_col
	.export actor_init_veloc_y
actor_init_bloober:
	lda	#BLOOBER_VELOC_X
	sta	veloc_x_actor, x
; ------------------------------
actor_init_col_small:
	lda	#ACTOR_COL_BOX_SMALL
	bne	actor_init_col
; ------------------------------
actor_init_koopa_red_fly:
	ldy	#KOOPA_RED_ACCEL_X_RIGHT
	lda	pos_y_lo_actor, x
	sta	accel_x_actor, x
	bpl	:+ ; if (actor.accel_x < 0) {
		ldy	#KOOPA_RED_ACCEL_X_LEFT
	: ; }
	tya
	adc	pos_y_lo_actor, x
	sta	veloc_x_actor, x
; ------------------------------
actor_init_col_large:
	lda	#ACTOR_COL_BOX_LARGE

actor_init_col:
	sta	col_box_actor, x
	lda	#DIR_LEFT
	sta	motion_dir_actor, x

actor_init_veloc_y:
	lda	#0
	sta	veloc_y_actor, x
	sta	accel_y_actor_c, x
	rts

