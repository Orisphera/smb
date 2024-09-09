.include	"system/ppu.i"
.include	"system/palettes.i"

.include	"mem.i"
.include	"chr.i"
.include	"tiles.i"
.include	"tunables.i"
.include	"misc.i"
.include	"math.i"

gfx_render_area_offset		= zp_byte_00
gfx_render_area_index		= zp_byte_01
gfx_metatile_id_offset		= zp_byte_02
gfx_metatile_id_page		= zp_byte_03
gfx_render_area_attr_index	= zp_byte_04
gfx_render_area_pos_x_parity	= zp_byte_05

	.export gfx_render_area
gfx_render_area:
	lda	pos_x_lo_game
	and	#1
	sta	gfx_render_area_pos_x_parity

	ldy	nmi_list_1_offset
	sty	gfx_render_area_offset

	lda	eng_bg_addr_lo
	sta	nmi_list_1_addr_dbyt+1, y
	lda	eng_bg_addr_hi
	sta	nmi_list_1_addr_dbyt, y
	lda	#$9A
	sta	nmi_list_1_byte, y

	lda	#0
	sta	gfx_render_area_attr_index
	tax
	: ; for (tile in gfx_metatile) {
		stx	gfx_render_area_index

		lda	gfx_metatile, x
		and	#TILE_PAGE_BITS
		sta	gfx_metatile_id_page
		asl	a
		rol	a
		rol	a
		tay
		lda	gfx_metatile_lo, y
		sta	eng_buffer_ptr
		lda	gfx_metatile_hi, y
		sta	eng_buffer_ptr+1

		lda	gfx_metatile, x
		asl	a
		asl	a
		sta	gfx_metatile_id_offset
		lda	bg_proc_id
		and	#1
		eor	#1
		asl	a
		adc	gfx_metatile_id_offset
		tay
		ldx	gfx_render_area_offset
		lda	(eng_buffer_ptr), y
		sta	nmi_list_1_addr_dbyt+(1*NMI_BUFFER_ENTRY_SIZE), x
		iny
		lda	(eng_buffer_ptr), y
		sta	nmi_list_1_addr_dbyt+1+(1*NMI_BUFFER_ENTRY_SIZE), x

		ldy	gfx_render_area_attr_index
		lda	gfx_render_area_pos_x_parity
		bne	:+
		lda	gfx_render_area_index
		lsr	a
		bcs	:++ ; if (gfx_render_area_pos_x_parity == even && gfx_render_area_index_parity == even) {
			rol	gfx_metatile_id_page
			rol	gfx_metatile_id_page
			rol	gfx_metatile_id_page
			jmp	:++++
		: lda	gfx_render_area_index
		lsr	a
		bcs	:++ ; } else if (gfx_render_area_pos_x_parity == odd && gfx_render_area_index_parity == even) {
			lsr	gfx_metatile_id_page
			lsr	gfx_metatile_id_page
			lsr	gfx_metatile_id_page
			lsr	gfx_metatile_id_page
			jmp	:+++
		: ; } else if (gfx_render_area_pos_x_parity == even && gfx_render_area_index_parity == odd) {
			lsr	gfx_metatile_id_page
			lsr	gfx_metatile_id_page
		: ; }
		; if (gfx_render_area_index_parity == odd) {
			inc	gfx_render_area_attr_index
		: ; }

		lda	eng_attr_buffer, y
		ora	gfx_metatile_id_page
		sta	eng_attr_buffer, y

		inc	gfx_render_area_offset
		inc	gfx_render_area_offset

		ldx	gfx_render_area_index
		inx
		cpx	#METATILE_MAX
		bcc	:-----
	; }

	ldy	gfx_render_area_offset
	iny
	iny
	iny
	lda	#0
	sta	nmi_list_1_data, y
	sty	nmi_list_1_offset

	inc	eng_bg_addr_lo
	lda	eng_bg_addr_lo
	and	#$1F
	bne	:+ ; if (!(eng_bg_addr_lo & 0x1F)) {
		lda	#$80
		sta	eng_bg_addr_lo
		lda	eng_bg_addr_hi
		eor	#%00000100
		sta	eng_bg_addr_hi
	: ; }

	jmp	gfx_render_attr_end
; ----------------------------
	.export gfx_render_attr
gfx_render_attr:
	lda	eng_bg_addr_lo
	and	#$1F
	sec
	sbc	#4
	and	#$1F
	sta	zp_byte_01
	lda	eng_bg_addr_hi
	bcs	:+ ; if ((eng_bg_addr_lo & 0x1F) < 4) {
		eor	#%00000100
	: ; }

	and	#%00000100
	ora	#%00100011
	sta	zp_byte_00
	lda	zp_byte_01
	lsr	a
	lsr	a
	adc	#$C0
	sta	zp_byte_01

	ldx	#0
	ldy	nmi_list_1_offset
	: ; for (x = 0, y = nmi_list_b_entry; x < 7; x++, y += 4) {
		lda	zp_byte_00
		sta	nmi_list_1_addr_dbyt, y
		lda	zp_byte_01
		clc
		adc	#8
		sta	nmi_list_1_addr_dbyt+1, y
		sta	zp_byte_01
		lda	eng_attr_buffer, x
		sta	nmi_list_1_byte+1, y
		lda	#1
		sta	nmi_list_1_byte, y
		lsr	a
		sta	eng_attr_buffer, x

		iny
		iny
		iny
		iny
		inx
		cpx	#7
		bcc	:-
	; }

	sta	nmi_list_1_data, y
	sty	nmi_list_1_offset

gfx_render_attr_end:
	lda	#nmi_addr::buffer_11_A
	sta	nmi_addrs_ctl
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
gfx_color_rotate_pal_entry	= zp_byte_00

.if	.defined(CONS)
	GFX_COLOR_ROT_THRESH	= $31
.elseif	.defined(VS)
	GFX_COLOR_ROT_THRESH	= $21
.endif

	.export gfx_color_rotate
gfx_color_rotate:
	lda	frame_count
	and	#MOD_8
	bne	:+++
	ldx	nmi_list_0_offset
	cpx	#GFX_COLOR_ROT_THRESH
	bcs	:+++ ; if ((frame_count % 8) || nmi_list_0_offset < GFX_COLOR_ROT_THRESH) {
		tay
		: ; for (x = nmi_list_entry, y = (frame_count % 8); y < 8; x++, y++) {
			lda	pal_null, y
			sta	nmi_list_0_data, x

			inx
			iny
			cpy	#2*PPU_COLOR_ROW_SIZE
			bcc	:-
		; }

		ldx	nmi_list_0_offset
		lda	#PPU_COLOR_ROW_SIZE-1
		sta	gfx_color_rotate_pal_entry
		lda	course_type
		asl	a
		asl	a
		tay
		: ; for (i = 3, x = nmi_list_entry, y = (course_type * 4); i >= 0; i--, x++, y++) {
			lda	pal_page_3, y
			sta	nmi_list_0_data+(PPU_COLOR_ROW_SIZE-1), x

			iny
			inx
			dec	gfx_color_rotate_pal_entry
			bpl	:-
		; }

		ldx	nmi_list_0_offset
		ldy	gfx_color_rotate_off
		lda	pal_rotating, y
		sta	nmi_list+(NMI_BUFFER_ENTRY_OFFSET_SIZE+(1*PPU_COLOR_ROW_SIZE)), x
		lda	nmi_list_0_offset
		clc
		adc	#7
		sta	nmi_list_0_offset

		inc	gfx_color_rotate_off
		lda	gfx_color_rotate_off
		cmp	#6
		bcc	:+ ; if (++gfx_color_rotate_off >= 6) {
			lda	#0
			sta	gfx_color_rotate_off
		; }
	: ; }

	rts
; -----------------------------------------------------------
	.export gfx_clear_blocks
	.export gfx_clear_blocks_brick_a, gfx_clear_blocks_brick_b
	.export gfx_clear_blocks_block_empty
	.export gfx_clear_blocks_blank_a, gfx_clear_blocks_blank_b
gfx_clear_blocks:
gfx_clear_blocks_brick_a:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_clear_blocks_brick_b:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_clear_blocks_block_empty:
	.byte	tile_bg::block_empty
	.byte	tile_bg::block_empty+1
	.byte	tile_bg::block_empty+2
	.byte	tile_bg::block_empty+3

gfx_clear_blocks_blank_a:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks

gfx_clear_blocks_blank_b:
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
; ----------------------------
	.export gfx_clear_small
gfx_clear_small:
	ldy	#nmi_list_1_data-nmi_list
	lda	#clear_blocks::blank_a
	ldx	course_type
	bne	:+ ; if (course_type == water) {
		lda	#clear_blocks::blank_b
	: ; }

	jsr	gfx_clear_put
	lda	#nmi_addr::buffer_11_A
	sta	nmi_addrs_ctl
	rts
; ----------------------------
	.export gfx_meta_replace
gfx_meta_replace:
	jsr	gfx_meta_write
	inc	block_counter_res
	dec	block_rep_flag, x
	rts
; ----------------------------
	.export gfx_meta_destroy
	.export gfx_meta_step
gfx_meta_destroy:
	lda	#0
gfx_meta_write:
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

	ldy	nmi_list_0_offset
	iny
	jsr	gfx_clear_put

gfx_meta_step:
	dey
	tya
	clc
	adc	#10
	jmp	screen_color_player_end
; ----------------------------
GFX_CLEAR_PUT_WIDTH		= 2
GFX_CLEAR_PUT_ENTRY_SIZE	= (WORD_SIZE+1+GFX_CLEAR_PUT_WIDTH)

gfx_clear_put_x_b		= zp_byte_00
gfx_clear_put_nmi_list_offset	= zp_byte_01
gfx_clear_put_page_offset	= zp_byte_02
gfx_clear_put_do_addr_hi_base	= zp_byte_03
gfx_clear_put_do_addr		= zp_addr_04

	.export gfx_clear_put, gfx_clear_put_do
gfx_clear_put:
	stx	gfx_clear_put_x_b

	sty	gfx_clear_put_nmi_list_offset

	asl	a
	asl	a
	tax

	ldy	#>PPU_VRAM_BG1
	lda	eng_buffer_ptr
	cmp	#$D0
	bcc	:+ ; if (eng_buffer_ptr >= 0xD0) {
		ldy	#>PPU_VRAM_BG2
	: ; }
	sty	gfx_clear_put_do_addr_hi_base

	and	#$0F
	asl	a
	sta	gfx_clear_put_do_addr
	lda	#0
	sta	gfx_clear_put_do_addr+1
	lda	gfx_clear_put_page_offset
	clc
	adc	#>PPU_VRAM_BG1
	asl	a
	rol	gfx_clear_put_do_addr+1
	asl	a
	rol	gfx_clear_put_do_addr+1
	adc	gfx_clear_put_do_addr
	sta	gfx_clear_put_do_addr
	lda	gfx_clear_put_do_addr+1
	adc	#0
	clc
	adc	gfx_clear_put_do_addr_hi_base
	sta	gfx_clear_put_do_addr+1

	ldy	gfx_clear_put_nmi_list_offset

gfx_clear_put_do:
	lda	gfx_clear_blocks, x
	sta	nmi_list_0_tile-1, y
	lda	gfx_clear_blocks+1, x
	sta	nmi_list_0_tile+1-1, y
	lda	gfx_clear_blocks+2, x
	sta	nmi_list_0_tile+(GFX_CLEAR_PUT_ENTRY_SIZE)-1, y
	lda	gfx_clear_blocks+3, x
	sta	nmi_list_0_tile+(GFX_CLEAR_PUT_ENTRY_SIZE)+1-1, y

	lda	gfx_clear_put_do_addr
	sta	nmi_list_0_addr_dbyt+1-1, y
	clc
	adc	#>PPU_VRAM_BG1
	sta	nmi_list_0_addr_dbyt+(GFX_CLEAR_PUT_ENTRY_SIZE)+1-1, y
	lda	gfx_clear_put_do_addr+1
	sta	nmi_list_0_addr_dbyt-1, y
	sta	nmi_list_0_addr_dbyt+(GFX_CLEAR_PUT_ENTRY_SIZE)-1, y

	lda	#GFX_CLEAR_PUT_WIDTH
	sta	nmi_list_0_count-1, y
	sta	nmi_list_0_count+(GFX_CLEAR_PUT_ENTRY_SIZE)-1, y

	lda	#NMI_LIST_END
	sta	nmi_list_0_data+(2*GFX_CLEAR_PUT_ENTRY_SIZE)-1, y

	ldx	gfx_clear_put_x_b
	rts
