.include	"system/ppu.i"

.include	"mem.i"
.include	"chr.i"

; ------------------------------------------------------------
RENDER_POWERUP_HEIGHT	= 2
; ------------------------------------------------------------
render_powerup_type	= zp_byte_00
render_powerup_row	= zp_byte_07
; ------------------------------------------------------------
render_powerup_tiles:
	.byte	chr_obj::mushroom_nw, chr_obj::mushroom_ne
	.byte	chr_obj::mushroom_sw, chr_obj::mushroom_se

	.byte	chr_obj::firefl_top, chr_obj::firefl_top
	.byte	chr_obj::firefl_stem, chr_obj::firefl_stem

	.byte	chr_obj::star_top, chr_obj::star_top
	.byte	chr_obj::star_bottom, chr_obj::star_bottom

	.byte	chr_obj::mushroom_nw, chr_obj::mushroom_ne
	.byte	chr_obj::mushroom_sw, chr_obj::mushroom_se

	.if	.defined(SMBV2)
		.byte	chr_obj::mushroom_nw, chr_obj::mushroom_ne
		.byte	chr_obj::mushroom_sw, chr_obj::mushroom_se
	.endif

render_powerup_colors:
	.byte	obj_attr::color2
	.byte	obj_attr::color1
	.byte	obj_attr::color2
	.byte	obj_attr::color1

	.if	.defined(SMBV2)
		.byte	obj_attr::color3
	.endif
; -----------------------------
	.export render_powerup
render_powerup:
	ldy	obj_data_offset_actor+POWERUP_ACTOR_IDX
	lda	pos_y_rel_actor
	clc
	adc	#PPU_CHR_HEIGHT_PX
	sta	render_chr_pair_pos_y
	lda	pos_x_rel_actor
	sta	render_chr_pair_pos_x
	ldx	actor_powerup_type
	lda	render_powerup_colors, x
	ora	attr_actor+POWERUP_ACTOR_IDX
	sta	render_chr_pair_attr
	txa
	pha

	asl	a
	asl	a
	tax
	lda	#RENDER_POWERUP_HEIGHT-1
	sta	render_powerup_row
	sta	render_chr_pair_color_mod_2
	: ; for (row of sprite) {
		lda	render_powerup_tiles, x
		sta	render_chr_pair_tile_left
		lda	render_powerup_tiles+1, x
		jsr	render_chr_pair

		dec	render_powerup_row
		bpl	:-
	; }

	ldy	obj_data_offset_actor+POWERUP_ACTOR_IDX

	pla
	beq	:++
	cmp	#powerup_type::mushroom_oneup
	beq	:++

	.if	.defined(SMBV2)
		cmp	#powerup_type::mushroom_poison
		beq	:++
	.endif

	; if (this.type != mushroom) {
		sta	render_powerup_type

		lda	frame_count
		lsr	a
		and	#obj_attr::color_bits
		ora	attr_actor+POWERUP_ACTOR_IDX
		sta	oam_buffer+(OBJ_SIZE*0)+OBJ_ATTR, y
		sta	oam_buffer+(OBJ_SIZE*1)+OBJ_ATTR, y

		ldx	render_powerup_type
		dex
		beq	:+ ; if (this.type == firefl) {
			sta	oam_buffer+(OBJ_SIZE*2)+OBJ_ATTR, y
			sta	oam_buffer+(OBJ_SIZE*3)+OBJ_ATTR, y
		: ; }

		lda	oam_buffer+(OBJ_SIZE*1)+OBJ_ATTR, y
		ora	#obj_attr::h_flip
		sta	oam_buffer+(OBJ_SIZE*1)+OBJ_ATTR, y
		lda	oam_buffer+(OBJ_SIZE*3)+OBJ_ATTR, y
		ora	#obj_attr::h_flip
		sta	oam_buffer+(OBJ_SIZE*3)+OBJ_ATTR, y
	: ; }

	jmp	render_actor_clear_offscr
