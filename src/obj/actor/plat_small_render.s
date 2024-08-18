.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/chr.i"

	.export render_plat_small
render_plat_small:
	ldy	obj_data_offset_actor, x
	lda	#tile_obj::plat_norm
	iny
	jsr	render_set_six_sprites
	iny
	lda	#obj_attr::priority_high|obj_attr::color2
	jsr	render_set_six_sprites
	dey
	dey
	lda	pos_x_rel_actor
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_H, y
	clc
	adc	#PPU_TILE_WIDTH_PX
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_H, y
	clc
	adc	#PPU_TILE_HEIGHT_PX
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_POS_H, y
	lda	pos_y_lo_actor, x
	tax
	pha

	cpx	#32
	bcs	:+ ; if (this.pos_y < 32) {
		lda	#ENG_OAM_CLEAR_SCANLINE
	: ; }
	jsr	render_set_three_sprites_v

	pla
	clc
	adc	#<-128
	tax
	cpx	#32
	bcs	:+ ; if ((this.pos_y - 128) < 32) {
		lda	#ENG_OAM_CLEAR_SCANLINE
	: ; }

	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_V, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_POS_V, y
	lda	bits_offscr_actor
	pha

	and	#%00001000
	beq	:+ ; if (this.bits_offscr & 0x08) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y
	: ; }

	pla
	pha

	and	#%00000100
	beq	:+ ; if (this.bits_offscr & 0x04) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_V, y
	: ; }

	pla
	and	#%00000010
	beq	:+ ; if (this.bits_offscr & 0x02) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_POS_V, y
	: ; }

	ldx	actor_index
	rts
