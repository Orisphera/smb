.include	"system/ppu.i"

.include	"mem.i"
.include	"chr.i"

; ------------------------------------------------------------
FLAG_SCORE_OFFSET_X	= 12
FLAG_SCORE_OFFSET_SPR	= (OBJ_SIZE*3)
; ------------------------------------------------------------
render_flag_score_tiles:
	.byte	chr_obj::digits_50, chr_obj::digits_00
	.byte	chr_obj::digits_20, chr_obj::digits_00
	.byte	chr_obj::digits_80, chr_obj::digits_0
	.byte	chr_obj::digits_40, chr_obj::digits_0
	.byte	chr_obj::digits_10, chr_obj::digits_0

	.if	.defined(SMB2M)
		.byte	chr_obj::oneup_left, chr_obj::oneup_right
	.endif
; -----------------------------
	.export render_flag_enemy
render_flag_enemy:
	ldy	obj_data_offset_actor, x
	lda	pos_x_rel_actor
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
	clc
	adc	#PPU_CHR_WIDTH_PX
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_H, y
	clc
	adc	#FLAG_SCORE_OFFSET_X
	sta	render_chr_pair_pos_x
	lda	pos_y_lo_actor, x
	jsr	render_set_two_sprites_v
	adc	#PPU_CHR_HEIGHT_PX
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V, y
	lda	render_flag_score_pos_y
	sta	render_chr_pair_pos_y
	lda	#obj_attr::priority_high|obj_attr::color1
	sta	render_chr_pair_color_mod_2
	sta	render_chr_pair_attr
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
	lda	#chr_obj::flag_enemy+0
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_CHR_NO, y
	lda	#chr_obj::flag_enemy+1
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, y

	lda	pos_y_goal
	beq	:+ ; if (goal.pos_y > 0) {
		tya
		clc
		adc	#FLAG_SCORE_OFFSET_SPR
		tay
		lda	render_flag_score_val
		asl	a
		tax
		lda	render_flag_score_tiles, x
		sta	render_chr_pair_tile_left
		lda	render_flag_score_tiles+1, x
		jsr	render_chr_pair
	: ; }

	ldx	actor_index
	ldy	obj_data_offset_actor, x

	lda	bits_offscr_actor
	and	#%00001110
	beq	:+ ; if (actor.bits_offscr & 0x0E) {
		.export	render_clear_six_sprites, render_set_six_sprites
		.export	render_set_four_sprites_v, render_set_three_sprites_v
		.export render_set_two_sprites_v
	render_clear_six_sprites:
		lda	#OAM_INIT_SCANLINE

	render_set_six_sprites:
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_V, y

	render_set_four_sprites_v:
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y

	render_set_three_sprites_v:
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V, y

	render_set_two_sprites_v:
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
	: ; }

	rts
