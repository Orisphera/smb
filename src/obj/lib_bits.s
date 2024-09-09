.include	"mem.i"
.include	"tunables.i"

; --------------------------------------------------------------
lib_calc_object_offset	= zp_byte_00
lib_bits_buffer		= zp_byte_00
; --------------------------------------------------------------
	.export lib_calc_player_pos, lib_calc_bubble_pos
	.export lib_calc_proj_pos, lib_calc_misc_pos
lib_calc_player_pos:
	ldx	#ENG_PLAYER_OBJ_OFF
	ldy	#ENG_PLAYER_OBJ_REL_OFF
	jmp	lib_calc_pos_do
; -----------------------------
lib_calc_bubble_pos:
	ldy	#lib_calc_offset_bubble-lib_calc_offsets
	jsr	lib_calc_get_offset
	ldy	#ENG_BUBBLE_REL_OFF
	jmp	lib_calc_pos_do
; -----------------------------
lib_calc_proj_pos:
	ldy	#lib_calc_offset_proj-lib_calc_offsets
	jsr	lib_calc_get_offset
	ldy	#ENG_PROJ_REL_OFF
; -----------------------------
lib_calc_pos_do:
	jsr	lib_calc_pos_x_rel
	ldx	actor_index
	rts
; -------------------------------
lib_calc_misc_pos:
	ldy	#lib_calc_offset_misc-lib_calc_offsets
	jsr	lib_calc_get_offset
	ldy	#ENG_MISC_REL_OFF
	jmp	lib_calc_pos_do
; --------------------------------------------------------------
	.export lib_calc_actor_pos, lib_calc_block_pos
lib_calc_actor_pos:
	lda	#ENG_ACTOR_OFF
	ldy	#ENG_ACTOR_REL_OFF
	jmp	lib_calc_pos_do_b
; -------------------------------
lib_calc_block_pos:
	lda	#ENG_BLOCK_OFF
	ldy	#ENG_BLOCK_REL_OFF
	jsr	lib_calc_pos_do_b
	inx
	inx
	lda	#ENG_BLOCK_OFF
	iny
; -------------------------------
lib_calc_pos_do_b:
	stx	lib_calc_object_offset
	clc
	adc	lib_calc_object_offset
	tax
	jsr	lib_calc_pos_x_rel
	ldx	actor_index
	rts
; --------------------------------------------------------------
lib_calc_pos_x_rel:
	lda	pos_y_lo_player, x
	sta	pos_y_rel_player, y
	lda	pos_x_lo_player, x
	sec
	sbc	pos_x_lo_screen_left
	sta	pos_x_rel_player, y
	rts
; --------------------------------------------------------------
	.export lib_player_bits_get, lib_proj_bits_get
	.export lib_bubble_bits_get, lib_misc_bits_get
lib_player_bits_get:
	ldx	#ENG_PLAYER_OBJ_OFF
	ldy	#ENG_PLAYER_OBJ_REL_OFF
	jmp	lib_bits_get
; -------------------------------
lib_proj_bits_get:
	ldy	#lib_calc_offset_proj-lib_calc_offsets
	jsr	lib_calc_get_offset
	ldy	#ENG_PROJ_REL_OFF
	jmp	lib_bits_get
; -------------------------------
lib_bubble_bits_get:
	ldy	#lib_calc_offset_bubble-lib_calc_offsets
	jsr	lib_calc_get_offset
	ldy	#ENG_BUBBLE_REL_OFF
	jmp	lib_bits_get
; -------------------------------
lib_misc_bits_get:
	ldy	#lib_calc_offset_misc-lib_calc_offsets
	jsr	lib_calc_get_offset
	ldy	#ENG_MISC_REL_OFF
	jmp	lib_bits_get
; --------------------------------------------------------------
lib_calc_offsets:
lib_calc_offset_proj:
	.byte	ENG_PROJ_OFF
lib_calc_offset_bubble:
	.byte	ENG_BUBBLE_OFF
lib_calc_offset_misc:
	.byte	ENG_MISC_OFF
; -------------------------------
lib_calc_get_offset:
	txa
	clc
	adc	lib_calc_offsets, y
	tax
	rts
; --------------------------------------------------------------
	.export lib_actor_bits_get, lib_block_bits_get
lib_actor_bits_get:
	lda	#ENG_ACTOR_OFF
	ldy	#ENG_ACTOR_REL_OFF
	jmp	lib_bits_get_offset
; -------------------------------
lib_block_bits_get:
	lda	#ENG_BLOCK_OFF
	ldy	#ENG_BLOCK_REL_OFF
; -------------------------------
lib_bits_get_offset:
	stx	lib_calc_object_offset
	clc
	adc	lib_calc_object_offset
	tax
; -------------------------------
lib_bits_get:
	tya
	pha
	jsr	lib_bits_proc
	asl	a
	asl	a
	asl	a
	asl	a
	ora	lib_bits_buffer
	sta	lib_bits_buffer
	pla
	tay
	lda	lib_bits_buffer
	sta	bits_offscr_player, y
	ldx	actor_index
	rts
; --------------------------------------------------------------
lib_bits_proc:
	jsr	lib_bits_get_do_x
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	sta	lib_bits_buffer
	jmp	lib_bits_get_do_y
; --------------------------------------------------------------
lib_bits_get_do_object_idx	= zp_byte_04
lib_bits_diff_current		= zp_byte_05
lib_bits_diff_offset		= zp_byte_06
lib_bits_diff_screen_player_off	= zp_byte_07

lib_bits_x:
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

lib_bits_off_x:
	.byte	7, 15, 7
; -------------------------------
	.export lib_bits_get_do_x
lib_bits_get_do_x:
	stx	lib_bits_get_do_object_idx
	ldy	#2-1
	: ; for (y = 2-1; x == 0 && y >= 0; y--) {
		lda	pos_x_lo_screen_left, y
		sec
		sbc	pos_x_lo_player, x
		sta	lib_bits_diff_screen_player_off
		lda	pos_x_hi_screen_left, y
		sbc	pos_x_hi_player, x

		ldx	lib_bits_off_x, y
		cmp	#0
		bmi	:+
		ldx	lib_bits_off_x+1, y
		cmp	#1
		bpl	:+ ; if () {
			lda	#56
			sta	lib_bits_diff_offset
			lda	#%00001000
			jsr	lib_bits_diff
		: ; }

		lda	lib_bits_x, x

		ldx	lib_bits_get_do_object_idx
		cmp	#0
		bne	:+
		dey
		bpl	:--
	: ; }
	rts
; --------------------------------------------------------------
lib_bits_y:
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	%00000000
		.byte	%00001000
		.byte	%00001100
		.byte	%00001110
		.byte	%00001111
		.byte	%00000111
		.byte	%00000011
		.byte	%00000001
		.byte	%00000000
	.elseif	.defined(SMB2M)
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

lib_bits_off_y:
	.byte	4, 0, 4

lib_bits_y_hi:
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	<-1, 0
	.elseif	.defined(SMB2M)
		.byte	0, <-1
	.endif
; -------------------------------
lib_bits_get_do_y:
	stx	lib_bits_get_do_object_idx
	ldy	#2-1
	: ; for (y = 2-1; x == 0 && y >= 0; y--) {
		lda	lib_bits_y_hi, y
		sec
		sbc	pos_y_lo_player, x
		sta	lib_bits_diff_screen_player_off
		lda	#1
		sbc	pos_y_hi_player, x
		ldx	lib_bits_off_y, y
		cmp	#0
		bmi	:+
		ldx	lib_bits_off_y+1, y
		cmp	#1
		bpl	:+ ; if () {
			lda	#32
			sta	lib_bits_diff_offset
			lda	#%00000100
			jsr	lib_bits_diff
		: ; }
	
		lda	lib_bits_y, x

		ldx	lib_bits_get_do_object_idx
		cmp	#0
		bne	:+
		dey
		bpl	:--
	: ; }

	rts
; --------------------------------------------------------------
lib_bits_diff:
	sta	lib_bits_diff_current
	lda	lib_bits_diff_screen_player_off
	cmp	lib_bits_diff_offset
	bcs	:++ ; if (lib_bits_diff_screen_player_off < lib_bits_diff_offset) {
		lsr	a
		lsr	a
		lsr	a
		and	#%00000111
		cpy	#1
		bcs	:+ ; if () {
			adc	lib_bits_diff_current
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
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, y
		lda	render_chr_pair_tile_right
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, y
		lda	#obj_attr::h_flip

		bne	:++
	: ; } else {
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, y
		lda	render_chr_pair_tile_right
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, y
		lda	#obj_attr::no_flip
	: ; }

	ora	render_chr_pair_attr
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
	lda	render_chr_pair_pos_y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V, y
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V, y
	lda	render_chr_pair_pos_x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H, y
	clc
	adc	#PPU_TILE_WIDTH_PX
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H, y
	lda	render_chr_pair_pos_y
	clc
	adc	#PPU_TILE_HEIGHT_PX
	sta	render_chr_pair_pos_y
	tya
	clc
	adc	#(2*OBJ_SIZE)
	tay
	inx
	inx
	rts
; --------------------------------------------------------------
	.if	.defined(FC_SMB)
		.ifndef	PAL
			.res	6, $FF
		.endif
	.elseif	.defined(FDS_SMB)
		.res	2, $FF
	.elseif	.defined(VS_SMB)
		.res	7, $FF
	.elseif	.defined(SMB2)
		.res	1, $FF
	.endif

