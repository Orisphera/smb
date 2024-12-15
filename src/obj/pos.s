.include	"mem.i"
.include	"tunables.i"

; --------------------------------------------------------------
pos_calc_object_x_offset	= zp_byte_00
pos_bits_buffer			= zp_byte_00
; --------------------------------------------------------------
	.export pos_calc_x_rel_player, pos_calc_x_rel_bubble
	.export pos_calc_x_rel_proj, pos_calc_x_rel_misc
pos_calc_x_rel_player:
	ldx	#ENG_PLAYER_OBJ_OFF
	ldy	#ENG_PLAYER_OBJ_REL_OFF
	jmp	pos_calc_x_rel_a
; -----------------------------
pos_calc_x_rel_bubble:
	ldy	#pos_calc_x_offset_bubble-pos_calc_x_offsets
	jsr	pos_calc_x_offset_get
	ldy	#ENG_BUBBLE_REL_OFF
	jmp	pos_calc_x_rel_a
; -----------------------------
pos_calc_x_rel_proj:
	ldy	#pos_calc_x_offset_proj-pos_calc_x_offsets
	jsr	pos_calc_x_offset_get
	ldy	#ENG_PROJ_REL_OFF
; -----------------------------
pos_calc_x_rel_a:
	jsr	pos_calc_x_rel_do
	ldx	actor_index
	rts
; -------------------------------
pos_calc_x_rel_misc:
	ldy	#pos_calc_x_offset_misc-pos_calc_x_offsets
	jsr	pos_calc_x_offset_get
	ldy	#ENG_MISC_REL_OFF
	jmp	pos_calc_x_rel_a
; --------------------------------------------------------------
	.export pos_calc_x_rel_actor, pos_calc_x_rel_block
pos_calc_x_rel_actor:
	lda	#ENG_ACTOR_OFF
	ldy	#ENG_ACTOR_REL_OFF
	jmp	pos_calc_x_rel_b
; -------------------------------
pos_calc_x_rel_block:
	lda	#ENG_BLOCK_OFF
	ldy	#ENG_BLOCK_REL_OFF
	jsr	pos_calc_x_rel_b
	inx
	inx
	lda	#ENG_BLOCK_OFF
	iny
; -------------------------------
pos_calc_x_rel_b:
	stx	pos_calc_object_x_offset
	clc
	adc	pos_calc_object_x_offset
	tax
	jsr	pos_calc_x_rel_do
	ldx	actor_index
	rts
; --------------------------------------------------------------
pos_calc_x_rel_do:
	lda	pos_y_lo, x
	sta	pos_y_rel_player, y
	lda	pos_x_lo, x
	sec
	sbc	pos_x_lo_screen_left
	sta	pos_x_rel_player, y
	rts
; --------------------------------------------------------------
	.export pos_bits_get_player, pos_bits_get_proj
	.export pos_bits_get_bubble, pos_bits_get_misc
pos_bits_get_player:
	ldx	#ENG_PLAYER_OBJ_OFF
	ldy	#ENG_PLAYER_OBJ_REL_OFF
	jmp	pos_bits_get
; -------------------------------
pos_bits_get_proj:
	ldy	#pos_calc_x_offset_proj-pos_calc_x_offsets
	jsr	pos_calc_x_offset_get
	ldy	#ENG_PROJ_REL_OFF
	jmp	pos_bits_get
; -------------------------------
pos_bits_get_bubble:
	ldy	#pos_calc_x_offset_bubble-pos_calc_x_offsets
	jsr	pos_calc_x_offset_get
	ldy	#ENG_BUBBLE_REL_OFF
	jmp	pos_bits_get
; -------------------------------
pos_bits_get_misc:
	ldy	#pos_calc_x_offset_misc-pos_calc_x_offsets
	jsr	pos_calc_x_offset_get
	ldy	#ENG_MISC_REL_OFF
	jmp	pos_bits_get
; --------------------------------------------------------------
pos_calc_x_offsets:
pos_calc_x_offset_proj:
	.byte	ENG_PROJ_OFF
pos_calc_x_offset_bubble:
	.byte	ENG_BUBBLE_OFF
pos_calc_x_offset_misc:
	.byte	ENG_MISC_OFF
; -------------------------------
pos_calc_x_offset_get:
	txa
	clc
	adc	pos_calc_x_offsets, y
	tax
	rts
; --------------------------------------------------------------
	.export pos_bits_get_actor, pos_bits_get_block
pos_bits_get_actor:
	lda	#ENG_ACTOR_OFF
	ldy	#ENG_ACTOR_REL_OFF
	jmp	pos_bits_get_offset
; -------------------------------
pos_bits_get_block:
	lda	#ENG_BLOCK_OFF
	ldy	#ENG_BLOCK_REL_OFF
; -------------------------------
pos_bits_get_offset:
	stx	pos_calc_object_x_offset
	clc
	adc	pos_calc_object_x_offset
	tax
; -------------------------------
pos_bits_get:
	tya
	pha
	jsr	pos_bits_proc
	asl	a
	asl	a
	asl	a
	asl	a
	ora	pos_bits_buffer
	sta	pos_bits_buffer
	pla
	tay
	lda	pos_bits_buffer
	sta	bits_offscr_player, y
	ldx	actor_index
	rts
; --------------------------------------------------------------
pos_bits_proc:
	jsr	pos_bits_get_do_x
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	sta	pos_bits_buffer
	jmp	pos_bits_get_do_y
; --------------------------------------------------------------
pos_bits_get_do_object_idx	= zp_byte_04
pos_bits_diff_current		= zp_byte_05
pos_bits_diff_offset		= zp_byte_06
pos_bits_diff_screen_player_off	= zp_byte_07

pos_bits_x:
	.byte	%01111111
	.byte	%00111111
	.byte	%00011111
	.byte	%00001111
	.byte	%00000111
	.byte	%00000011
	.byte	%00000001
	.byte	%00000000

	.byte	%10000000
	.byte	%11000000
	.byte	%11100000
	.byte	%11110000
	.byte	%11111000
	.byte	%11111100
	.byte	%11111110
	.byte	%11111111

pos_bits_off_x:
	.byte	7, 15, 7
; -------------------------------
	.export pos_bits_get_do_x
pos_bits_get_do_x:
	stx	pos_bits_get_do_object_idx
	ldy	#2-1
	: ; for (y = 2-1; x == 0 && y >= 0; y--) {
		lda	pos_x_lo_screen_left, y
		sec
		sbc	pos_x_lo, x
		sta	pos_bits_diff_screen_player_off
		lda	pos_x_hi_screen_left, y
		sbc	pos_x_hi, x

		ldx	pos_bits_off_x, y
		cmp	#0
		bmi	:+
		ldx	pos_bits_off_x+1, y
		cmp	#1
		bpl	:+ ; if () {
			lda	#56
			sta	pos_bits_diff_offset
			lda	#%00001000
			jsr	pos_bits_diff
		: ; }

		lda	pos_bits_x, x

		ldx	pos_bits_get_do_object_idx
		cmp	#0
		bne	:+
		dey
		bpl	:--
	: ; }
	rts
; --------------------------------------------------------------
pos_bits_y:
	.if	.defined(SMBV1)
		.byte	%00000000
		.byte	%00001000
		.byte	%00001100
		.byte	%00001110
		.byte	%00001111
		.byte	%00000111
		.byte	%00000011
		.byte	%00000001
		.byte	%00000000
	.elseif	.defined(SMBV2)
		.byte	%00001111
		.byte	%00000111
		.byte	%00000011
		.byte	%00000001
		.byte	%00000000
		.byte	%00001000
		.byte	%00001100
		.byte	%00001110
		.byte	%00000000
	.endif

pos_bits_off_y:
	.byte	4, 0, 4

pos_bits_y_hi:
	.if	.defined(SMBV1)
		.byte	<-1, 0
	.elseif	.defined(SMBV2)
		.byte	0, <-1
	.endif
; -------------------------------
pos_bits_get_do_y:
	stx	pos_bits_get_do_object_idx
	ldy	#2-1
	: ; for (y = 2-1; x == 0 && y >= 0; y--) {
		lda	pos_bits_y_hi, y
		sec
		sbc	pos_y_lo, x
		sta	pos_bits_diff_screen_player_off
		lda	#1
		sbc	pos_y_hi, x
		ldx	pos_bits_off_y, y
		cmp	#0
		bmi	:+
		ldx	pos_bits_off_y+1, y
		cmp	#1
		bpl	:+ ; if () {
			lda	#32
			sta	pos_bits_diff_offset
			lda	#%00000100
			jsr	pos_bits_diff
		: ; }
	
		lda	pos_bits_y, x

		ldx	pos_bits_get_do_object_idx
		cmp	#0
		bne	:+
		dey
		bpl	:--
	: ; }

	rts
; --------------------------------------------------------------
pos_bits_diff:
	sta	pos_bits_diff_current
	lda	pos_bits_diff_screen_player_off
	cmp	pos_bits_diff_offset
	bcs	:++ ; if (pos_bits_diff_screen_player_off < pos_bits_diff_offset) {
		lsr	a
		lsr	a
		lsr	a
		and	#%00000111
		cpy	#1
		bcs	:+ ; if () {
			adc	pos_bits_diff_current
		: ; }
		tax
	: ; }

	rts
; --------------------------------------------------------------
	.export render_chr_pair_do
render_chr_pair_do:
	lda	render_chr_pair_color_mod_2
	lsr	a
	lsr	a
	lda	render_chr_pair_tile_left
	bcc	:+ ; if (render_chr_pair_color_mod_2) {
		sta	oam_buffer+(OBJ_SIZE*1)+OBJ_CHR_NO, y
		lda	render_chr_pair_tile_right
		sta	oam_buffer+(OBJ_SIZE*0)+OBJ_CHR_NO, y
		lda	#obj_attr::h_flip

		bne	:++
	: ; } else {
		sta	oam_buffer+(OBJ_SIZE*0)+OBJ_CHR_NO, y
		lda	render_chr_pair_tile_right
		sta	oam_buffer+(OBJ_SIZE*1)+OBJ_CHR_NO, y
		lda	#obj_attr::no_flip
	: ; }

	ora	render_chr_pair_attr
	sta	oam_buffer+(OBJ_SIZE*0)+OBJ_ATTR, y
	sta	oam_buffer+(OBJ_SIZE*1)+OBJ_ATTR, y
	lda	render_chr_pair_pos_y
	sta	oam_buffer+(OBJ_SIZE*0)+OBJ_POS_V, y
	sta	oam_buffer+(OBJ_SIZE*1)+OBJ_POS_V, y
	lda	render_chr_pair_pos_x
	sta	oam_buffer+(OBJ_SIZE*0)+OBJ_POS_H, y
	clc
	adc	#PPU_CHR_WIDTH_PX
	sta	oam_buffer+(OBJ_SIZE*1)+OBJ_POS_H, y
	lda	render_chr_pair_pos_y
	clc
	adc	#PPU_CHR_HEIGHT_PX
	sta	render_chr_pair_pos_y
	tya
	clc
	adc	#(2*OBJ_SIZE)
	tay
	inx
	inx
	rts
