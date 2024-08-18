.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/chr.i"
.include	"engine/tiles.i"

; ------------------------------------------------------------
BLOCK_BITS_OFFSET	= 6

render_block_bits_attr			= zp_byte_00
render_block_bits_pos_x_orig_rel	= zp_byte_00
; ------------------------------------------------------------
render_block_tile_data:
	.byte	tile_obj::brick+0
	.byte	tile_obj::brick+0
	.byte	tile_obj::brick+1
	.byte	tile_obj::brick+1
render_block_tile_data_end:
; ------------------------------
	.export render_block
render_block:
	lda	pos_y_rel_block
	sta	render_chr_pair_pos_y
	lda	pos_x_rel_block
	sta	render_chr_pair_pos_x
	lda	#obj_attr::priority_high|obj_attr::color3
	sta	render_chr_pair_attr
	lsr	a
	sta	render_chr_pair_color_mod_2
	ldy	obj_data_offset_block, x

	ldx	#0
	: ; for (pair of block_tiles) {
		lda	render_block_tile_data, x
		sta	render_chr_pair_tile_left
		lda	render_block_tile_data+1, x
		jsr	render_chr_pair

		cpx	#(render_block_tile_data_end-render_block_tile_data)
		bne	:-
	; }

	ldx	actor_index
	ldy	obj_data_offset_block, x
	lda	course_type
	cmp	#course_types::overworld
	beq	:+ ; if (course.type != overworld) {
		lda	#tile_obj::brick+1
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, y
	: ; }

	lda	block_tile, x
	cmp	#metatile_3::block_invis
	bne	:++ ; if (bg_tile == block_invis) {
		lda	#tile_obj::block_empty

		iny
		jsr	render_set_four_sprites_v
		dey

		lda	#obj_attr::color3
		ldx	course_type
		dex
		beq	:+ ; if (course.type != overworld) {
			lsr	a
		: ; }
		ldx	actor_index
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
		ora	#obj_attr::h_flip
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
		ora	#obj_attr::v_flip
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR, y
		and	#obj_attr::v_flip|obj_attr::color3
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
	: ; }

	lda	bits_offscr_block
	pha

	and	#%00000100
	beq	:+ ; if (this.bits_offscr & 0x04) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y
	: ; }

	pla
; ------------------------------
	.export	render_offscr_top_clear
render_offscr_check_top:
	and	#%00001000
	beq	:+ ; if (this.bits_offscr & 0x08) {
	render_offscr_top_clear:
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V, y
	: ; }

	rts
; ------------------------------------------------------------
	.export render_block_bits
render_block_bits:
	lda	#obj_attr::priority_high|obj_attr::color2
	sta	render_block_bits_attr
	lda	#tile_obj::plat_cloud
	ldy	game_proc_id
	cpy	#game_proc::victory
	beq	:+ ; if (game.proc_id != victory) {
		lda	#obj_attr::priority_high|obj_attr::color3
		sta	render_block_bits_attr
		lda	#tile_obj::brick_piece
	: ; }

	ldy	obj_data_offset_block, x
	iny
	jsr	render_set_four_sprites_v
	lda	frame_count
	asl	a
	asl	a
	asl	a
	asl	a
	and	#obj_attr::v_flip|obj_attr::h_flip
	ora	render_block_bits_attr
	iny
	jsr	render_set_four_sprites_v
	dey
	dey
	lda	pos_y_rel_block
	jsr	render_set_two_sprites_v
	lda	pos_x_rel_block
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
	lda	pos_x_orig_block, x
	sec
	sbc	pos_x_lo_screen_left
	sta	render_block_bits_pos_x_orig_rel
	sec
	sbc	pos_x_rel_block
	adc	render_block_bits_pos_x_orig_rel
	adc	#BLOCK_BITS_OFFSET
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
	lda	pos_y_rel_block+1
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y
	lda	pos_x_rel_block+1
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_H, y
	lda	render_block_bits_pos_x_orig_rel
	sec
	sbc	pos_x_rel_block+1
	adc	render_block_bits_pos_x_orig_rel
	adc	#BLOCK_BITS_OFFSET
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_H, y
	lda	bits_offscr_block
	jsr	render_offscr_check_top
	lda	bits_offscr_block
	asl	a
	bcc	:+ ; if (this.bits_offscr & 0x80) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		jsr	render_set_two_sprites_v
	: ; }

	lda	render_block_bits_pos_x_orig_rel
	bpl	:+
	lda	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
	cmp	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
	bcc	:+ ; if (this.pos_x_orig_rel >= 0x80 && this.obj[0].pos_x >= this.obj[1].pos_x) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y
	: ; }

	rts
