.include	"mem.i"
.include	"mem_low.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"const.i"
.include	"tiles.i"

        .export scenery_cannon
scenery_cannon:
	jsr	scenery_attr
	ldx	scenery_proc_metatile_id

	lda	#metatile_1::cannon_a
	sta	scenery_metatile, x
	inx
	dey
	bmi	:+ ; if (--y >= 0) {
		lda	#metatile_1::cannon_b
		sta	scenery_metatile, x
		inx
		dey
		bmi	:+ ; if (--y >= 0) {
			lda	#metatile_1::cannon_c
			jsr	scenery_render
		; }
	: ; }

	ldx	actor_cannon_offset
	jsr	scenery_pos_y_get
	sta	pos_y_lo_cannon, x
	lda	pos_x_hi_game
	sta	pos_y_hi_cannon, x
	jsr	scenery_pos_x_get
	sta	pos_x_lo_cannon, x
	inx
	cpx	#6
	bcc	:+ ; if (x >= 6) {
		ldx	#0
	: ; }
	stx	actor_cannon_offset
	rts
