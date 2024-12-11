.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
bg_scenery_stairs_height:
	.byte	7, 7, 6, 5, 4, 3, 2, 1, 0
bg_scenery_stairs_height_end:
bg_scenery_stairs_row:
	.byte	3, 3, 4, 5, 6, 7, 8, 9, 10
bg_scenery_stairs_row_end:
; --------------
        .export bg_scenery_stairs
bg_scenery_stairs:
	jsr	bg_scenery_len
	bcc	:+ ; if (bg_scenery_len()) {
		lda	#(bg_scenery_stairs_height_end-bg_scenery_stairs_height)
		sta	scenery_step_no
	: ; }

	dec	scenery_step_no
	ldy	scenery_step_no
	ldx	bg_scenery_stairs_row, y
	lda	bg_scenery_stairs_height, y
	tay
	lda	#metatile_1::stair
	jmp	bg_scenery_render