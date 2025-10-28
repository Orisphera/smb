.include	"math.i"
.include	"mem.i"
.include	"joypad.i"

.include	"macros.i"

; ----------------------------------------------------------------------
FLOATER_KOOPA_VELOC_X_CUTOFF	= 19
; ----------------------------------------------------------------------
	.export actor_floater_koopa, actor_floater_do, actor_floater_move
actor_floater_koopa:
	lda	#FLOATER_KOOPA_VELOC_X_CUTOFF
; ----------------------------------
actor_floater_veloc_x_cutoff	= zp_byte_01

actor_floater_do:
	sta	actor_floater_veloc_x_cutoff
	lda	frame_count
	and	#MOD_4
	bne	actor_floater_do_rts ; if ((frame_count % 4)) {
		ldy	veloc_x_actor, x
		lda	veloc_y_actor, x
		lsr	a
		bcs	:++
		cpy	actor_floater_veloc_x_cutoff
		beq	:+ ; if (!(actor.veloc_y % 2) && actor.veloc_x != zp_byte_01) {
			inc	veloc_x_actor, x
		actor_floater_do_rts:
			rts
		: ; } else if (!(actor.veloc_y % 2) && actor.veloc_x == zp_byte_01) {
			inc	veloc_y_actor, x
			rts
		: tya
		beq	:-- ; } else {
			dec	veloc_x_actor, x
			rts
		; }
	; } else rts;
; ----------------------------------------------------------------------
actor_floater_move:
	lda	veloc_x_actor, x
	pha

	ldy	#DIR_RIGHT
	lda	veloc_y_actor, x
	and	#MOD_4_2_UP
	bne	:+ ; if ((actor.veloc_y % 4) < 2) {
		lda	veloc_x_actor, x
		neg_m
		sta	veloc_x_actor, x

		ldy	#DIR_LEFT
	: ; }
	sty	motion_dir_actor, x
	jsr	motion_x
	sta	zp_byte_00

	pla
	sta	veloc_x_actor, x
	rts

