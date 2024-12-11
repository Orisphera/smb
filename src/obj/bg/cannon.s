.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

        .export bg_scenery_cannon
bg_scenery_cannon:
	jsr	bg_scenery_attr
	ldx	bg_proc_metatile_id

	lda	#metatile_1::cannon_a
	sta	gfx_metatile, x
	inx
	dey
	bmi	:+ ; if (--y >= 0) {
		lda	#metatile_1::cannon_b
		sta	gfx_metatile, x
		inx
		dey
		bmi	:+ ; if (--y >= 0) {
			lda	#metatile_1::cannon_c
			jsr	bg_scenery_render
		; }
	: ; }

	ldx	actor_cannon_offset
	jsr	bg_objpos_y_get
	sta	pos_y_lo_cannon, x
	lda	pos_x_hi_game
	sta	pos_y_hi_cannon, x
	jsr	bg_objpos_x_get
	sta	pos_x_lo_cannon, x
	inx
	cpx	#6
	bcc	:+ ; if (x >= 6) {
		ldx	#0
	: ; }
	stx	actor_cannon_offset
	rts
