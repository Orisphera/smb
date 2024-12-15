.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
scenery_stairs_height:
	.byte	7, 7, 6, 5, 4, 3, 2, 1, 0
scenery_stairs_height_end:
scenery_stairs_row:
	.byte	3, 3, 4, 5, 6, 7, 8, 9, 10
scenery_stairs_row_end:
; --------------
        .export scenery_stairs
scenery_stairs:
	jsr	scenery_len
	bcc	:+ ; if (scenery_len()) {
		lda	#(scenery_stairs_height_end-scenery_stairs_height)
		sta	scenery_step_no
	: ; }

	dec	scenery_step_no
	ldy	scenery_step_no
	ldx	scenery_stairs_row, y
	lda	scenery_stairs_height, y
	tay
	lda	#metatile_1::stair
	jmp	scenery_render