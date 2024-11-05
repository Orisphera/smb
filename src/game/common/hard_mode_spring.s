.include	"mem.i"
.include	"misc.i"
.include	"tunables.i"

; ------------------------------------------------------------
.if	.definedmacro(HARDMODE_SPRING_BASE)
	.export	game_hard_mode_spring, game_hard_mode_render_spring
.endif
game_hard_mode_spring:
	ldy	course_no
	cpy	#course::no_02
	beq	:+
	cpy	#course::no_03
	bne	:++
	: ; if (course_no.in(no_02, no_03)) {
		lda	#SPRING_SPECIAL_ACCEL_Y
	: ; }

	rts

game_hard_mode_render_spring:
	ldy	course_no
	cpy	#course::no_02
	beq	:+
	cpy	#course::no_03
	bne	:++
	: ; if (course_no.in(no_02, no_03)) {
		lsr	a
	: ; }

	rts
; ------------------------------------------------------------
	.res	183, $FF
