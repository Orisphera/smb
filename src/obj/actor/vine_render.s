.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/chr.i"

; ------------------------------------------------------------
VINE_PART_COUNT		= 6
VINE_COLUMN_B_OFFSET	= 6
VINE_HEIGHT_CUTOFF	= 100
; ------------------------------------------------------------
render_vine_part_idx	= zp_byte_00
; ------------------------------------------------------------
render_vine_offset:
	.byte	0*PPU_TILE_HEIGHT_PX
	.byte	VINE_PART_COUNT*PPU_TILE_HEIGHT_PX
; -----------------------------
	.export render_vine
render_vine:
	sty	render_vine_part_idx
	lda	pos_y_rel_actor
	clc
	adc	render_vine_offset, y
	ldx	actor_vine_offset, y
	ldy	obj_data_offset_actor, x
	sty	render_oam_idx
	jsr	render_vine_column

	lda	pos_x_rel_actor
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_H, y
	clc
	adc	#VINE_COLUMN_B_OFFSET
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_POS_H, y

	lda	#obj_attr::priority_low|obj_attr::color1
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
	ora	#obj_attr::h_flip
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y

	ldx	#VINE_PART_COUNT-1
	: ; for (tile of vine) {
		lda	#tile_obj::vine+1
		sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y

		.repeat	OBJ_SIZE
		iny
		.endrep

		dex
		bpl	:-
	; }

	ldy	render_oam_idx
	lda	render_vine_part_idx
	bne	:+ ; if (render_vine_part_idx == 0) {
		lda	#tile_obj::vine+0
		sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
	: ; }

	ldx	#0
	: ; for (tile of vine) {
		lda	pos_y_vine
		sec
		sbc	OAM_DMA_BUFFER+OBJ_POS_V, y
		cmp	#VINE_HEIGHT_CUTOFF
		bcc	:+ ; if ((vine.pos_y - sprite.pos_y) >= VINE_HEIGHT_CUTOFF) {
			lda	#ENG_OAM_CLEAR_SCANLINE
			sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		: ; }

		.repeat	OBJ_SIZE
			iny
		.endrep

		inx
		cpx	#VINE_PART_COUNT
		bne	:--
	; }

	ldy	render_vine_part_idx
	rts
; -----------------------------
	.export render_vine_column
render_vine_column:
	ldx	#VINE_PART_COUNT
	: ; for (tile of vine) {
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y

		clc
		adc	#PPU_TILE_HEIGHT_PX

		.repeat	OBJ_SIZE
			iny
		.endrep

		dex
		bne	:-
	; }

	ldy	render_oam_idx
	rts
