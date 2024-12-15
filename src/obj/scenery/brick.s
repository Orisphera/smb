.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
scenery_floor_tiles:
	.byte	metatile_1::floor_underwater
	.byte	metatile_1::stair
	.byte	metatile_1::stair
	.byte	metatile_1::floor_castle
scenery_brick_tiles:
	.byte	metatile_0::coral
	.byte	metatile_1::brick_a
	.byte	metatile_1::brick_b
	.byte	metatile_1::brick_b
	.byte	metatile_2::cloud_small
; --------------
        .export scenery_brickrow
        .export scenery_floorrow
        .export scenery_get_row
        .export scenery_brickcol
        .export scenery_floorcol
scenery_brickrow:
	ldy	course_type
	lda	course_type_cloud
	beq	:+ ; if (course_type == cloud) {
		ldy	#course_types::cloud
	: ; }
	lda	scenery_brick_tiles, y
	jmp	scenery_get_row

scenery_floorrow:
	ldy	course_type
	lda	scenery_floor_tiles, y
scenery_get_row:
	pha

	jsr	scenery_len

	.export	scenery_draw_row
scenery_draw_row:
	ldx	scenery_proc_metatile_id
	ldy	#0

	pla
	jmp	scenery_render

scenery_brickcol:
	ldy	course_type
	lda	scenery_brick_tiles, y
	jmp	scenery_get_col

scenery_floorcol:
	ldy	course_type
	lda	scenery_floor_tiles, y
scenery_get_col:
	pha

	jsr	scenery_attr

	pla
	ldx	scenery_proc_metatile_id
	jmp	scenery_render
