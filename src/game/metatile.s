.include	"sys/ppu.i"
.include	"sys/palette.i"

.include	"mem.i"
.include	"chr.i"
.include	"tiles.i"
.include	"tunables.i"
.include	"misc.i"
.include	"math.i"

meta_render_area_offset		= zp_byte_00
meta_render_area_index		= zp_byte_01
scenery_metatile_id_offset		= zp_byte_02
scenery_metatile_id_page		= zp_byte_03
meta_render_area_attr_index	= zp_byte_04
meta_render_area_pos_x_parity	= zp_byte_05

	.export meta_render_area
meta_render_area:
	lda	pos_x_lo_game
	and	#1
	sta	meta_render_area_pos_x_parity

	ldy	ppu_displist_meta_offset
	sty	meta_render_area_offset

	lda	bg_addr+1
	sta	ppu_displist_meta_addr_dbyt+1, y
	lda	bg_addr
	sta	ppu_displist_meta_addr_dbyt, y
	lda	#$9A
	sta	ppu_displist_meta_special, y

	lda	#0
	sta	meta_render_area_attr_index
	tax
	: ; for (tile in scenery_metatile) {
		stx	meta_render_area_index

		lda	scenery_metatile, x
		and	#TILE_PAGE_BITS
		sta	scenery_metatile_id_page
		asl	a
		rol	a
		rol	a
		tay
		lda	scenery_metatile_lo, y
		sta	game_buffer
		lda	scenery_metatile_hi, y
		sta	game_buffer+1

		lda	scenery_metatile, x
		asl	a
		asl	a
		sta	scenery_metatile_id_offset
		lda	bg_scenery_proc_id
		and	#1
		eor	#1
		asl	a
		adc	scenery_metatile_id_offset
		tay
		ldx	meta_render_area_offset
		lda	(game_buffer), y
		sta	ppu_displist_meta_addr_dbyt+(1*NMI_BUFFER_ENTRY_SIZE), x
		iny
		lda	(game_buffer), y
		sta	ppu_displist_meta_addr_dbyt+1+(1*NMI_BUFFER_ENTRY_SIZE), x

		ldy	meta_render_area_attr_index
		lda	meta_render_area_pos_x_parity
		bne	:+
		lda	meta_render_area_index
		lsr	a
		bcs	:++ ; if (meta_render_area_pos_x_parity == even && meta_render_area_index_parity == even) {
			rol	scenery_metatile_id_page
			rol	scenery_metatile_id_page
			rol	scenery_metatile_id_page
			jmp	:++++
		: lda	meta_render_area_index
		lsr	a
		bcs	:++ ; } else if (meta_render_area_pos_x_parity == odd && meta_render_area_index_parity == even) {
			lsr	scenery_metatile_id_page
			lsr	scenery_metatile_id_page
			lsr	scenery_metatile_id_page
			lsr	scenery_metatile_id_page
			jmp	:+++
		: ; } else if (meta_render_area_pos_x_parity == even && meta_render_area_index_parity == odd) {
			lsr	scenery_metatile_id_page
			lsr	scenery_metatile_id_page
		: ; }
		; if (meta_render_area_index_parity == odd) {
			inc	meta_render_area_attr_index
		: ; }

		lda	bg_attr_buffer, y
		ora	scenery_metatile_id_page
		sta	bg_attr_buffer, y

		inc	meta_render_area_offset
		inc	meta_render_area_offset

		ldx	meta_render_area_index
		inx
		cpx	#METATILE_MAX
		bcc	:-----
	; }

	ldy	meta_render_area_offset
	iny
	iny
	iny
	lda	#0
	sta	ppu_displist_meta_data, y
	sty	ppu_displist_meta_offset

	inc	bg_addr+1
	lda	bg_addr+1
	and	#$1F
	bne	:+ ; if (!(bg_addr & 0x1F)) {
		lda	#$80
		sta	bg_addr+1
		lda	bg_addr
		eor	#>PPU_VRAM_BG_SIZE
		sta	bg_addr
	: ; }

	jmp	meta_render_attr_end
; ----------------------------
meta_render_attr_addr_dbyt	= zp_addr_00

	.export meta_render_attr
meta_render_attr:
	lda	bg_addr+1
	and	#$1F
	sec
	sbc	#4
	and	#$1F
	sta	zp_byte_01
	lda	bg_addr
	bcs	:+ ; if ((bg_addr & 0x1F) < 4) {
		eor	#%00000100
	: ; }

	and	#%00000100
	ora	#%00100011
	sta	meta_render_attr_addr_dbyt
	lda	zp_byte_01
	lsr	a
	lsr	a
	adc	#$C0
	sta	meta_render_attr_addr_dbyt+1

	ldx	#0
	ldy	ppu_displist_meta_offset
	: ; for (attr of attrs) {
		lda	meta_render_attr_addr_dbyt
		sta	ppu_displist_meta_addr_dbyt, y
		lda	meta_render_attr_addr_dbyt+1
		clc
		adc	#8
		sta	ppu_displist_meta_addr_dbyt+1, y
		sta	meta_render_attr_addr_dbyt+1
		lda	bg_attr_buffer, x
		sta	ppu_displist_meta_payload, y
		lda	#1
		sta	ppu_displist_meta_count, y
		lsr	a
		sta	bg_attr_buffer, x

		iny
		iny
		iny
		iny
		inx
		cpx	#BG_ATTR_COUNT
		bcc	:-
	; }

	sta	ppu_displist_meta_data, y
	sty	ppu_displist_meta_offset

meta_render_attr_end:
	lda	#nmi_addr::buffer_11_A
	sta	nmi_buffer_ptr
	rts
; -----------------------------------------------------------
pal_rotating:
	.byte	PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_ORANGE1
	.byte	PPU_COLOR_ORANGE0
	.byte	PPU_COLOR_ORANGE1

pal_null:
	.dbyt	PPU_COLOR_PAGE_BG+(PPU_COLOR_LINE_SIZE*3)
	.byte	pal_null_end-pal_null_start
pal_null_start:
	.byte	$FF, $FF, $FF, $FF
pal_null_end:
	.byte	0

pal_page_3:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE0, PPU_COLOR_BLUE1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE0, PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE0, PPU_COLOR_ORANGE1, PPU_COLOR_CYAN1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE0, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
; ----------------------------
meta_color_rotate_pal_entry	= zp_byte_00

.if	.defined(CONS)
	META_COLOR_ROT_THRESH	= $31
.elseif	.defined(VS)
	META_COLOR_ROT_THRESH	= $21
.endif

	.export meta_color_rotate
meta_color_rotate:
	lda	frame_count
	and	#MOD_8
	bne	:+++
	ldx	ppu_displist_offset
	cpx	#META_COLOR_ROT_THRESH
	bcs	:+++ ; if ((frame_count % 8) || ppu_displist_offset < META_COLOR_ROT_THRESH) {
		tay
		: ; for (x = ppu_displist_entry, y = (frame_count % 8); y < 8; x++, y++) {
			lda	pal_null, y
			sta	ppu_displist_data, x

			inx
			iny
			cpy	#2*PPU_COLOR_ROW_SIZE
			bcc	:-
		; }

		ldx	ppu_displist_offset
		lda	#PPU_COLOR_ROW_SIZE-1
		sta	meta_color_rotate_pal_entry
		lda	course_type
		asl	a
		asl	a
		tay
		: ; for (i = 3, x = ppu_displist_entry, y = (course_type * 4); i >= 0; i--, x++, y++) {
			lda	pal_page_3, y
			sta	ppu_displist_data+(PPU_COLOR_ROW_SIZE-1), x

			iny
			inx
			dec	meta_color_rotate_pal_entry
			bpl	:-
		; }

		ldx	ppu_displist_offset
		ldy	meta_color_rotate_off
		lda	pal_rotating, y
		sta	ppu_displist+(NMI_BUFFER_ENTRY_OFFSET_SIZE+(1*PPU_COLOR_ROW_SIZE)), x
		lda	ppu_displist_offset
		clc
		adc	#7
		sta	ppu_displist_offset

		inc	meta_color_rotate_off
		lda	meta_color_rotate_off
		cmp	#6
		bcc	:+ ; if (++meta_color_rotate_off >= 6) {
			lda	#0
			sta	meta_color_rotate_off
		; }
	: ; }

	rts
; -----------------------------------------------------------
	.export meta_clear_blocks
	.export meta_clear_blocks_brick_a, meta_clear_blocks_brick_b
	.export meta_clear_blocks_block_empty
	.export meta_clear_blocks_blank_a, meta_clear_blocks_blank_b
meta_clear_blocks:
meta_clear_blocks_brick_a:
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

meta_clear_blocks_brick_b:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

meta_clear_blocks_block_empty:
	.byte	chr_bg::block_empty
	.byte	chr_bg::block_empty+1
	.byte	chr_bg::block_empty+2
	.byte	chr_bg::block_empty+3

meta_clear_blocks_blank_a:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks

meta_clear_blocks_blank_b:
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
; ----------------------------
	.export meta_put_blank
meta_put_blank:
	ldy	#ppu_displist_meta_data-ppu_displist
	lda	#clear_blocks::blank_a
	ldx	course_type
	bne	:+ ; if (course_type == water) {
		lda	#clear_blocks::blank_b
	: ; }

	jsr	meta_clear_put
	lda	#nmi_addr::buffer_11_A
	sta	nmi_buffer_ptr
	rts
; ----------------------------
	.export meta_replace
meta_replace:
	jsr	meta_write
	inc	block_counter_res
	dec	block_rep_flag, x
	rts
; ----------------------------
	.export meta_destroy
	.export meta_step
meta_destroy:
	lda	#0
meta_write:
	ldy	#clear_blocks::blank_a
	cmp	#metatile_0::blank_a
	beq	:+ ; if (tile != metatile_0::blank_a) {
		ldy	#clear_blocks::brick_a
		cmp	#metatile_1::brick_g
		beq	:+
		cmp	#metatile_1::brick_a
		beq	:+ ; if (tile.not_in(metatile_1::brick_g, metatile_1::brick_a)) {
			iny
			cmp	#metatile_1::brick_l
			beq	:+
			cmp	#metatile_1::brick_b
			beq	:+ ; if (tile.not_in(metatile_1::brick_l, metatile_1::brick_b)) {
				iny
			: ; }
		; }
	; }
	tya

	ldy	ppu_displist_offset
	iny
	jsr	meta_clear_put

meta_step:
	dey
	tya
	clc
	adc	#10
	jmp	bg_color_player_end
; ----------------------------
META_CLEAR_PUT_WIDTH		= 2
META_CLEAR_PUT_ENTRY_SIZE	= (WORD_SIZE+1+META_CLEAR_PUT_WIDTH)

meta_clear_put_x_b			= zp_byte_00
meta_clear_put_ppu_displist_offset	= zp_byte_01
meta_clear_put_page_offset		= zp_byte_02
meta_clear_put_do_addr_hi_base		= zp_byte_03

	.export meta_clear_put_do
meta_clear_put:
	stx	meta_clear_put_x_b

	sty	meta_clear_put_ppu_displist_offset

	asl	a
	asl	a
	tax

	ldy	#>PPU_VRAM_BG1
	lda	game_buffer
	cmp	#$D0
	bcc	:+ ; if (game_buffer >= 0xD0) {
		ldy	#>PPU_VRAM_BG2
	: ; }
	sty	meta_clear_put_do_addr_hi_base

	and	#$0F
	asl	a
	sta	meta_clear_put_do_addr
	lda	#0
	sta	meta_clear_put_do_addr+1
	lda	meta_clear_put_page_offset
	clc
	adc	#>PPU_VRAM_BG1
	asl	a
	rol	meta_clear_put_do_addr+1
	asl	a
	rol	meta_clear_put_do_addr+1
	adc	meta_clear_put_do_addr
	sta	meta_clear_put_do_addr
	lda	meta_clear_put_do_addr+1
	adc	#0
	clc
	adc	meta_clear_put_do_addr_hi_base
	sta	meta_clear_put_do_addr+1

	ldy	meta_clear_put_ppu_displist_offset

meta_clear_put_do:
	lda	meta_clear_blocks, x
	sta	ppu_displist_payload-1, y
	lda	meta_clear_blocks+1, x
	sta	ppu_displist_payload+1-1, y
	lda	meta_clear_blocks+2, x
	sta	ppu_displist_payload+(META_CLEAR_PUT_ENTRY_SIZE)-1, y
	lda	meta_clear_blocks+3, x
	sta	ppu_displist_payload+(META_CLEAR_PUT_ENTRY_SIZE)+1-1, y

	lda	meta_clear_put_do_addr
	sta	ppu_displist_addr_dbyt+1-1, y
	clc
	adc	#>PPU_VRAM_BG1
	sta	ppu_displist_addr_dbyt+(META_CLEAR_PUT_ENTRY_SIZE)+1-1, y
	lda	meta_clear_put_do_addr+1
	sta	ppu_displist_addr_dbyt-1, y
	sta	ppu_displist_addr_dbyt+(META_CLEAR_PUT_ENTRY_SIZE)-1, y

	lda	#META_CLEAR_PUT_WIDTH
	sta	ppu_displist_count-1, y
	sta	ppu_displist_count+(META_CLEAR_PUT_ENTRY_SIZE)-1, y

	lda	#NMI_LIST_END
	sta	ppu_displist_data+(2*META_CLEAR_PUT_ENTRY_SIZE)-1, y

	ldx	meta_clear_put_x_b
	rts
