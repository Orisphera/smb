.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
bg_scenery_floor_tiles:
	.byte	metatile_1::floor_underwater
	.byte	metatile_1::stair
	.byte	metatile_1::stair
	.byte	metatile_1::floor_castle
bg_scenery_brick_tiles:
	.byte	metatile_0::coral
	.byte	metatile_1::brick_a
	.byte	metatile_1::brick_b
	.byte	metatile_1::brick_b
	.byte	metatile_2::cloud_small
; --------------
        .export bg_scenery_brickrow
        .export bg_scenery_floorrow
        .export bg_scenery_get_row
        .export bg_scenery_brickcol
        .export bg_scenery_floorcol
bg_scenery_brickrow:
	ldy	course_type
	lda	course_type_cloud
	beq	:+ ; if (course_type == cloud) {
		ldy	#course_types::cloud
	: ; }
	lda	bg_scenery_brick_tiles, y
	jmp	bg_scenery_get_row

bg_scenery_floorrow:
	ldy	course_type
	lda	bg_scenery_floor_tiles, y
bg_scenery_get_row:
	pha

	jsr	bg_scenery_len

	.export	bg_scenery_draw_row
bg_scenery_draw_row:
	ldx	bg_proc_metatile_id
	ldy	#0

	pla
	jmp	bg_scenery_render

bg_scenery_brickcol:
	ldy	course_type
	lda	bg_scenery_brick_tiles, y
	jmp	bg_scenery_get_col

bg_scenery_floorcol:
	ldy	course_type
	lda	bg_scenery_floor_tiles, y
bg_scenery_get_col:
	pha

	jsr	bg_scenery_attr

	pla
	ldx	bg_proc_metatile_id
	jmp	bg_scenery_render
