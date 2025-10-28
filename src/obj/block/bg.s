.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"const.i"
.include	"tiles.i"

scenery_block_item_tile_idx	= zp_byte_07

        .export scenery_hidden_one_up
        .export scenery_block_q
        .export scenery_block_coin
        .export scenery_block_item
scenery_hidden_one_up:
	lda	scenery_hidden_one_up_req
	beq	scenery_block_rts
	lda	#0
	sta	scenery_hidden_one_up_req
	jmp	scenery_block_item

scenery_block_q:
	jsr	scenery_block_id
	jmp	scenery_block_draw

scenery_block_coin:
	lda	#BLOCK_INVIS_REQ_VAL
	sta	block_invis_req

scenery_block_item:
	jsr	scenery_block_id
	sty	scenery_block_item_tile_idx
	lda	#0
	ldy	course_type
	dey
	beq	:+ ; if (course_type == overworld) {
		lda	#BLOCK_TILE_OFFSET
	: ; }
	clc
	adc	scenery_block_item_tile_idx
	tay

scenery_block_draw:
	lda	block_tiles, y
	pha
	jsr	scenery_attr
	jmp	scenery_draw_row
; ----------------
scenery_block_id:
	lda	zp_byte_00
	sec
	sbc	#0
	tay

scenery_block_rts:
	rts
