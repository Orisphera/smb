.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"const.i"
.include	"tiles.i"

; ----------------------------------
scenery_coinrow_tiles:
	.byte	metatile_3::coin_b
	.byte	metatile_3::coin_a
	.byte	metatile_3::coin_a
	.byte	metatile_3::coin_a
; ----------------
        .export scenery_coinrow
scenery_coinrow:
	ldy	course_type
	lda	scenery_coinrow_tiles, y
	jmp	scenery_get_row
