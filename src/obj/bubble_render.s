.include	"system/ppu.i"

.include	"mem.i"
.include	"chr.i"

	.export bubble_render
bubble_render:
	ldy	pos_y_hi_player
	dey
	bne	:+
	lda	bits_offscr_bubble
	and	#%00001000
	bne	:+ ; if (!(this.bits_offscr & 0x08)) {
		ldy	obj_data_offset_bubble, x
		lda	pos_x_rel_bubble
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
		lda	pos_y_rel_bubble
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
		lda	#chr_obj::bubble
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, y
		lda	#obj_attr::priority_high|obj_attr::color2
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
	: ; }

	rts
