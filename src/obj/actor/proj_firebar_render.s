.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/math.i"
.include	"engine/chr.i"

; ------------------------------------------------------------
EXPLOSION_BASE_ATTR	= (obj_attr::priority_high|obj_attr::color2)
EXPLOSION_TILE_OFFSET	= 4
; ------------------------------------------------------------
	.export render_proj, render_firebar
render_proj:
	ldy	obj_data_offset_proj, x
	lda	pos_y_rel_proj
	sta	OAM_DMA_BUFFER+OBJ_POS_V, y
	lda	pos_x_rel_proj
	sta	OAM_DMA_BUFFER+OBJ_POS_H, y

render_firebar:
	lda	frame_count
	lsr	a
	lsr	a
	pha
	and	#MOD_8_4_UP>>2
	eor	#tile_obj::fire_ball
	sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
	pla
	lsr	a
	lsr	a
	lda	#obj_attr::priority_high|obj_attr::color2
	bcc	:+ ; if ((frame_count % 4) >= 2) {
		ora	#obj_attr::v_flip|obj_attr::h_flip
	: ; }

	sta	OAM_DMA_BUFFER+OBJ_ATTR, y
	rts
; ------------------------------------------------------------
render_proj_hit_tiles:
	.byte	tile_obj::fire_hit+2
	.byte	tile_obj::fire_hit+1
	.byte	tile_obj::fire_hit+0
; ------------------------------
	.export render_proj_hit, render_fireworks
render_proj_hit:
	ldy	obj_data_offset_block, x
	lda	state_proj, x
	inc	state_proj, x
	lsr
	and	#proj_states::state_mask
	cmp	#proj_states::state_3
	bcs	:+ ; if (this.state < state_3) {
	render_fireworks:
		tax
		lda	render_proj_hit_tiles, x
		iny
		jsr	render_set_four_sprites_v
		dey
		ldx	actor_index
		lda	pos_y_rel_proj
		sec
		sbc	#1*EXPLOSION_TILE_OFFSET
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V, y
		clc
		adc	#2*EXPLOSION_TILE_OFFSET
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V, y
		lda	pos_x_rel_proj
		sec
		sbc	#1*EXPLOSION_TILE_OFFSET
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
		clc
		adc	#2*EXPLOSION_TILE_OFFSET
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_H, y
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_H, y
		lda	#EXPLOSION_BASE_ATTR
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
		lda	#EXPLOSION_BASE_ATTR|obj_attr::v_flip
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
		lda	#EXPLOSION_BASE_ATTR|obj_attr::h_flip
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
		lda	#EXPLOSION_BASE_ATTR|obj_attr::v_flip|obj_attr::h_flip
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR, y
		rts
	: ; } else {
		lda	#proj_states::inactive
		sta	state_proj, x
		rts
	; }
