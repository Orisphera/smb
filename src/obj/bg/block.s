.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

bg_scenery_block_item_tile_idx	= zp_byte_07

        .export bg_scenery_hidden_one_up
        .export bg_scenery_block_q
        .export bg_scenery_block_coin
        .export bg_scenery_block_item
bg_scenery_hidden_one_up:
	lda	bg_hidden_one_up_req
	beq	bg_scenery_block_rts
	lda	#0
	sta	bg_hidden_one_up_req
	jmp	bg_scenery_block_item

bg_scenery_block_q:
	jsr	bg_scenery_block_id
	jmp	bg_scenery_block_draw

bg_scenery_block_coin:
	lda	#BLOCK_INVIS_REQ_VAL
	sta	block_invis_req

bg_scenery_block_item:
	jsr	bg_scenery_block_id
	sty	bg_scenery_block_item_tile_idx
	lda	#0
	ldy	course_type
	dey
	beq	:+ ; if (course_type == overworld) {
		lda	#BLOCK_TILE_OFFSET
	: ; }
	clc
	adc	bg_scenery_block_item_tile_idx
	tay

bg_scenery_block_draw:
	lda	block_tiles, y
	pha
	jsr	bg_scenery_attr
	jmp	bg_scenery_draw_row
; --------------
bg_scenery_block_id:
	lda	zp_byte_00
	sec
	sbc	#0
	tay

bg_scenery_block_rts:
	rts