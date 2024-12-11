.include	"mem.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
bg_scenery_pit_tiles:
	.byte	metatile_2::water_b
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
; --------------
        .export bg_scenery_pit
bg_scenery_pit:
	jsr	bg_scenery_len
	bcc	:++
	lda	course_type
	bne	:++ ; if (bg_scenery_len() && course_type == water) {
		ldx	actor_cannon_offset
		jsr	bg_objpos_x_get
		sec
		sbc	#16
		sta	pos_x_lo_cannon, x
		lda	pos_x_hi_game
		sbc	#0
		sta	pos_y_hi_cannon, x
		iny
		iny
		tya
		asl	a
		asl	a
		asl	a
		asl	a
		sta	pos_y_lo_cannon, x
		inx
		cpx	#5
		bcc	:+ ; if (x >= 5) {
			ldx	#0
		: ; }
		stx	actor_cannon_offset
	: ; }

	ldx	course_type
	lda	bg_scenery_pit_tiles, x
	ldx	#8
	ldy	#$0F

        .if     .defined(NOFALLTHROUGH)
                jmp     bg_scenery_render
        .endif
