.include	"system/ppu.i"

.include	"mem.i"
.include	"math.i"
.include	"chr.i"

; ------------------------------------------------------------
HAMMER_A_OFFSET		= 4
HAMMER_B_OFFSET		= 8
; ------------------------------------------------------------
render_hammer_pos_x_a:
	.byte	HAMMER_A_OFFSET, 0, HAMMER_A_OFFSET, 0

render_hammer_pos_y_a:
	.byte	0, HAMMER_A_OFFSET, 0, HAMMER_A_OFFSET

render_hammer_pos_x_b:
	.byte	0, HAMMER_B_OFFSET, 0, HAMMER_B_OFFSET

render_hammer_pos_y_b:
	.byte	HAMMER_B_OFFSET, 0, HAMMER_B_OFFSET, 0

render_hammer_chr_no_a:
	.byte	chr_obj::hammer+0
	.byte	chr_obj::hammer+2
	.byte	chr_obj::hammer+1
	.byte	chr_obj::hammer+3

render_hammer_chr_no_b:
	.byte	chr_obj::hammer+1
	.byte	chr_obj::hammer+3
	.byte	chr_obj::hammer+0
	.byte	chr_obj::hammer+2

render_hammer_attr:
	.byte	obj_attr::priority_high|obj_attr::color3
	.byte	obj_attr::priority_high|obj_attr::color3
	.byte	obj_attr::priority_high|obj_attr::color3|obj_attr::v_flip|obj_attr::h_flip
	.byte	obj_attr::priority_high|obj_attr::color3|obj_attr::v_flip|obj_attr::h_flip
; -----------------------------
	.export render_hammer
render_hammer:
	ldy	obj_data_offset_misc, x
	lda	game_timer_stop
	bne	:+
	lda	state_misc, x
	and	#<~misc_states::hammer
	cmp	#misc_states::init
	beq	:++
	: ; if (game_timer_stop || misc.state != init) {
		ldx	#0
		beq	:++
	: ; } else if (!game_timer_stop && misc.state == init) {
		lda	frame_count
		lsr	a
		lsr	a
		and	#MOD_16_4_UP>>2
		tax
	: ; }

	lda	pos_y_rel_misc
	clc
	adc	render_hammer_pos_y_a, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
	clc
	adc	render_hammer_pos_y_b, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
	lda	pos_x_rel_misc
	clc
	adc	render_hammer_pos_x_a, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
	clc
	adc	render_hammer_pos_x_b, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
	lda	render_hammer_chr_no_a, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, y
	lda	render_hammer_chr_no_b, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, y
	lda	render_hammer_attr, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
	ldx	actor_index

	lda	bits_offscr_misc
	and	#%11111100
	beq	:+ ; if (misc.bits_offscr & 0xFC) {
		lda	#misc_states::inactive
		sta	state_misc, x

		lda	#ENG_OAM_CLEAR_SCANLINE
		jsr	render_set_two_sprites_v
	: ; }

	rts
