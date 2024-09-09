.include	"system/ppu.i"

.include	"mem.i"
.include	"chr.i"

.include	"unk.i"

	.export render_plat_large
render_plat_large:
	ldy	obj_data_offset_actor, x
	sty	render_oam_idx
	iny
	iny
	iny
	lda	pos_x_rel_actor
	jsr	render_vine_column

	ldx	actor_index
	lda	pos_y_lo_actor, x
	jsr	render_set_four_sprites_v
	ldy	course_type
	cpy	#course_types::castle
	beq	:+
	ldy	game_hard_mode_b
	beq	:++
	: ; if (course.type == castle || game_hard_mode_b) {
		lda	#ENG_OAM_CLEAR_SCANLINE
	: ; }
	ldy	obj_data_offset_actor, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_V, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_POS_V, y

	lda	#tile_obj::plat_norm
	ldx	course_type_cloud
	beq	:+ ; if (course.type == cloud) {
		lda	#tile_obj::plat_cloud
	: ; }
	ldx	actor_index
	iny
	jsr	render_set_six_sprites

	lda	#obj_attr::priority_high|obj_attr::color2
	iny
	jsr	render_set_six_sprites
	inx
	jsr	lib_bits_get_do_x
	dex
	ldy	obj_data_offset_actor, x
	asl	a
	pha

	bcc	:+ ; if (player.bits_h & 0x80) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
	: ; }

	pla
	asl	a
	pha

	bcc	:+ ; if (player.bits_h & 0x40) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
	: ; }

	pla
	asl	a
	pha

	bcc	:+ ; if (player.bits_h & 0x20) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V, y
	: ; }

	pla
	asl	a
	pha

	bcc	:+ ; if (player.bits_h & 0x10) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y
	: ; }

	pla
	asl	a
	pha

	bcc	:+ ; if (player.bits_h & 0x08) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_V, y
	: ; }

	pla
	asl	a
	bcc	:+ ; if (player.bits_h & 0x04) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_POS_V, y
	: ; }

	lda	bits_offscr_actor
	asl	a
	bcc	:+ ; if (actor.bits_offscr & 0x80) {
		jsr	render_clear_six_sprites
	: ; }

	rts
