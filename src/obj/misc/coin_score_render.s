.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/math.i"
.include	"engine/chr.i"

; ------------------------------------------------------------
	: ; if (this.state > coin_01) {
		lda	frame_count
		lsr	a

		bcs	:+ ; if (!(frame_count % 2)) {
			dec	pos_y_lo_misc, x
		: ; }

		lda	pos_y_lo_misc, x
		jsr	render_set_two_sprites_v

		lda	pos_x_rel_misc
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y

		clc
		adc	#PPU_TILE_WIDTH_PX

		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y

		lda	#obj_attr::priority_high|obj_attr::color2
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y

		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y

		lda	#tile_obj::digits_20
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, y
		lda	#tile_obj::digits_0
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, y

		jmp	:+
	; }
; -----------------------------
render_coin_tiles:
	.byte	tile_obj::coin+0
	.byte	tile_obj::coin+1
	.byte	tile_obj::coin+2
	.byte	tile_obj::coin+3
; -----------------------------
	.export render_coin_score
render_coin_score:
	ldy	obj_data_offset_misc, x
	lda	state_misc, x
	cmp	#misc_states::coin_01+1
	bcs	:-- ; if (misc.state == coin_01) {
		lda	pos_y_lo_misc, x

		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
		clc
		adc	#PPU_TILE_HEIGHT_PX
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y

		lda	pos_x_rel_misc
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y

		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y

		lda	frame_count
		lsr	a
		and	#MOD_8_2_UP>>1
		tax
		lda	render_coin_tiles, x
		iny
		jsr	render_set_two_sprites_v
		dey

		lda	#obj_attr::priority_high|obj_attr::color2
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
		lda	#obj_attr::priority_high|obj_attr::color2|obj_attr::v_flip
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y

		ldx	actor_index
	: ; } else --();

	rts
