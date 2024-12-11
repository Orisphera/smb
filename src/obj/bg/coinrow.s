.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
bg_scenery_coinrow_tiles:
	.byte	metatile_3::coin_b
	.byte	metatile_3::coin_a
	.byte	metatile_3::coin_a
	.byte	metatile_3::coin_a
; --------------
        .export bg_scenery_coinrow
bg_scenery_coinrow:
	ldy	course_type
	lda	bg_scenery_coinrow_tiles, y
	jmp	bg_scenery_get_row
