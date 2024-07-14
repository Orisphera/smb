.include	"../../inc/system/ppu.i"
.include	"../../inc/system/palettes.i"

.include	"../../inc/engine/charmap.i"
.include	"../../inc/engine/chr.i"
.include	"../../inc/engine/tiles.i"

.include	"../../inc/engine/unk.i"

	.export gfx_render_area
gfx_render_area:
	lda	eng_pos_x
	and	#$01
	sta	zp_byte_05
	ldy	ppu_nmi_buffer+$40
	sty	zp_addr_00
	lda	eng_bg_addr_lo
	sta	ppu_nmi_buffer+$42, y
	lda	eng_bg_addr_hi
	sta	ppu_nmi_buffer+$41, y
	lda	#$9A
	sta	ppu_nmi_buffer+$43, y
	lda	#0
	sta	zp_byte_04
	tax
	: ; for (x = 0; x < 13; x++) {
		stx	zp_addr_00+$01
		lda	tbl_metatile_b, x
		and	#$C0
		sta	zp_byte_03
		asl	a
		rol	a
		rol	a
		tay
		lda	gfx_metatile_lo, y
		sta	zp_addr_06
		lda	gfx_metatile_hi, y
		sta	zp_addr_06+1
		lda	tbl_metatile_b, x
		asl	a
		asl	a
		sta	zp_byte_02
		lda	bg_proc_id
		and	#$01
		eor	#1
		asl	a
		adc	zp_byte_02
		tay
		ldx	zp_addr_00
		lda	(zp_addr_06), y
		sta	ppu_nmi_buffer+$44, x
		iny
		lda	(zp_addr_06), y
		sta	ppu_nmi_buffer+$45, x
		ldy	zp_byte_04
		lda	zp_byte_05
		bne	:+
		lda	zp_addr_00+$01
		lsr	a
		bcs	:++ ; if (!zp_byte_05 && !(zp_addr_00 % 1)) {
			rol	zp_byte_03
			rol	zp_byte_03
			rol	zp_byte_03
			jmp	:++++
		: lda	zp_addr_00+$01
		lsr	a
		bcs	:++ ; } else if (zp_byte_05 && !(zp_addr_00 % 1)) {
			lsr	zp_byte_03
			lsr	zp_byte_03
			lsr	zp_byte_03
			lsr	zp_byte_03
			jmp	:+++
		: ; } else if (!zp_byte_05 && zp_addr_00 % 1) {
			lsr	zp_byte_03
			lsr	zp_byte_03
		: ; } else if (zp_addr_00 % 1) {
			inc	zp_byte_04
		: ; }

		lda	ppu_nmi_buffer+$F9, y
		ora	zp_byte_03
		sta	ppu_nmi_buffer+$F9, y
		inc	zp_addr_00
		inc	zp_addr_00
		ldx	zp_addr_00+$01
		inx
		cpx	#13
		bcc	:-----
	; }

	ldy	zp_addr_00
	iny
	iny
	iny
	lda	#0
	sta	ppu_nmi_buffer+$41, y
	sty	ppu_nmi_buffer+$40
	inc	eng_bg_addr_lo
	lda	eng_bg_addr_lo
	and	#$1F
	bne	:+ ; if (!(eng_bg_addr_lo & 0x1F)) {
		lda	#$80
		sta	eng_bg_addr_lo
		lda	eng_bg_addr_hi
		eor	#$04
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
	sta	zp_addr_00+$01
	lda	eng_bg_addr_hi
	bcs	:+ ; if ((eng_bg_addr_lo & 0x1F) < 4) {
		eor	#$04
	: ; }

	and	#$04
	ora	#$23
	sta	zp_addr_00
	lda	zp_addr_00+$01
	lsr	a
	lsr	a
	adc	#$C0
	sta	zp_addr_00+$01

	ldx	#0
	ldy	ppu_nmi_buffer+$40
	: ; for (x = 0, y = ppu_nmi_buffer_b_entry; x < 7; x++, y += 4) {
		lda	zp_addr_00
		sta	ppu_nmi_buffer+$41, y
		lda	zp_addr_00+$01
		clc
		adc	#8
		sta	ppu_nmi_buffer+$42, y
		sta	zp_addr_00+$01
		lda	ppu_nmi_buffer+$F9, x
		sta	ppu_nmi_buffer+$44, y
		lda	#1
		sta	ppu_nmi_buffer+$43, y
		lsr	a
		sta	ppu_nmi_buffer+$F9, x

		iny
		iny
		iny
		iny
		inx
		cpx	#7
		bcc	:-
	; }

	sta	ppu_nmi_buffer+$41, y
	sty	ppu_nmi_buffer+$40

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
.if	.defined(CONS)
	GFX_COLOR_ROT_THRESH	= $31
.elseif	.defined(VS)
	GFX_COLOR_ROT_THRESH	= $21
.endif

	.export gfx_color_rotate
gfx_color_rotate:
	lda	frame_count
	and	#$07
	bne	:+++
	ldx	ppu_nmi_buffer+$00
	cpx	#GFX_COLOR_ROT_THRESH
	bcs	:+++ ; if ((frame_count % 8) || ppu_nmi_buffer_entry < GFX_COLOR_ROT_THRESH) {
		tay
		: ; for (x = ppu_nmi_buffer_entry, y = (frame_count % 8); y < 8; x++, y++) {
			lda	pal_null, y
			sta	ppu_nmi_buffer+$01, x

			inx
			iny
			cpy	#8
			bcc	:-
		; }

		ldx	ppu_nmi_buffer+$00
		lda	#3
		sta	zp_addr_00
		lda	course_type
		asl	a
		asl	a
		tay
		: ; for (i = 3, x = ppu_nmi_buffer_entry, y = (course_type * 4); i >= 0; i--, x++, y++) {
			lda	pal_page_3, y
			sta	ppu_nmi_buffer+$04, x

			iny
			inx
			dec	zp_addr_00
			bpl	:-
		; }

		ldx	ppu_nmi_buffer+$00
		ldy	gfx_color_rotate_off
		lda	pal_rotating, y
		sta	ppu_nmi_buffer+$05, x
		lda	ppu_nmi_buffer+$00
		clc
		adc	#7
		sta	ppu_nmi_buffer+$00

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
gfx_clear_blocks:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
; ---
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
; ---
	.byte	tile_bg::block_empty
	.byte	tile_bg::block_empty+1
	.byte	tile_bg::block_empty+2
	.byte	tile_bg::block_empty+3
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
; ----------------------------
	.export gfx_clear_small
gfx_clear_small:
	ldy	#$41
	lda	#3
	ldx	course_type
	bne	:+ ; if (course_type == water) {
		lda	#4
	: ; }

	jsr	gfx_clear_put
	lda	#nmi_addr::buffer_11_A
	sta	nmi_addrs_ctl
	rts
; ----------------------------
	.export gfx_meta_replace
gfx_meta_replace:
	jsr	gfx_meta_write
	inc	ppu_nmi_buffer+$F0
	dec	ppu_nmi_buffer+$EC, x
	rts
; ----------------------------
	.export gfx_meta_destroy
gfx_meta_destroy:
	lda	#0
gfx_meta_write:
	ldy	#3
	cmp	#0
	beq	:+ ; if (a != 0) {
		ldy	#0
		cmp	#BLOCK_TILE_A
		beq	:+
		cmp	#BRICK_TILE_B
		beq	:+ ; if (a.not_in(BLOCK_TILE_A, BRICK_TILE_B)) {
			iny
			cmp	#BLOCK_TILE_B
			beq	:+
			cmp	#FG_BASE_TILE_C
			beq	:+ ; if (a.not_in(BLOCK_TILE_B, FG_BASE_TILE_C)) {
				iny
			: ; }
		; }
	; }
	tya

	ldy	ppu_nmi_buffer+$00
	iny
	jsr	gfx_clear_put

gfx_meta_step:
	dey
	tya
	clc
	adc	#10
	jmp	screen_color_player_end
; ----------------------------
	.export gfx_clear_put, gfx_clear_put_do
gfx_clear_put:
	stx	zp_byte_00
	sty	zp_byte_01

	asl	a
	asl	a
	tax

	ldy	#>PPU_VRAM_BG1
	lda	zp_addr_06
	cmp	#$D0
	bcc	:+ ; if (zp_addr_06 >= 0xD0) {
		ldy	#>PPU_VRAM_BG2
	: ; }
	sty	zp_byte_03

	and	#$0F
	asl	a
	sta	zp_addr_04
	lda	#0
	sta	zp_addr_04+1
	lda	zp_byte_02
	clc
	adc	#>PPU_VRAM_BG1
	asl	a
	rol	zp_addr_04+1
	asl	a
	rol	zp_addr_04+1
	adc	zp_addr_04
	sta	zp_addr_04
	lda	zp_addr_04+1
	adc	#0
	clc
	adc	zp_byte_03
	sta	zp_addr_04+1

	ldy	zp_byte_01

gfx_clear_put_do:
	lda	gfx_clear_blocks, x
	sta	ppu_nmi_buffer+$03, y
	lda	gfx_clear_blocks+1, x
	sta	ppu_nmi_buffer+$04, y
	lda	gfx_clear_blocks+2, x
	sta	ppu_nmi_buffer+$08, y
	lda	gfx_clear_blocks+3, x
	sta	ppu_nmi_buffer+$09, y
	lda	zp_addr_04
	sta	ppu_nmi_buffer+$01, y
	clc
	adc	#>PPU_VRAM_BG1
	sta	ppu_nmi_buffer+$06, y
	lda	zp_addr_04+1
	sta	ppu_nmi_buffer+$00, y
	sta	ppu_nmi_buffer+$05, y
	lda	#2
	sta	ppu_nmi_buffer+$02, y
	sta	ppu_nmi_buffer+$07, y
	lda	#0
	sta	ppu_nmi_buffer+$0A, y

	ldx	zp_byte_00
	rts
; -----------------------------------------------------------
gfx_metatile_lo:
	.byte	<gfx_meta_block_0, <gfx_meta_block_1, <gfx_meta_block_2, <gfx_meta_block_3

gfx_metatile_hi:
	.byte	>gfx_meta_block_0, >gfx_meta_block_1, >gfx_meta_block_2, >gfx_meta_block_3

gfx_meta_block_0:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud

	.byte	tile_bg::cloud+1
	.byte	tile_bg::blanks+1
	.byte	tile_bg::cloud+2
	.byte	tile_bg::blanks+1

	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+3
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a
	.byte	tile_bg::hill_a
	.byte	tile_bg::blanks+2

	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::hill_a+4
	.byte	tile_bg::blanks+2

	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a+1
	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a+2

	.byte	tile_bg::hill_a+3
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a+3

	.byte	tile_bg::hill_a+4
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
; ---
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::bridge_parts
	.byte	tile_bg::blanks
	.byte	tile_bg::bridge_parts
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::chain
	.byte	tile_bg::chain
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::tree
	.byte	tile_bg::tree+2
	.byte	tile_bg::tree+1
	.byte	tile_bg::tree+3

	.byte	tile_bg::tree
	.byte	tile_bg::tree+4
	.byte	tile_bg::tree+1
	.byte	tile_bg::tree+5

	.byte	tile_bg::tree+2
	.byte	tile_bg::tree+4
	.byte	tile_bg::tree+3
	.byte	tile_bg::tree+5
; ---
	.byte	tile_bg::pipe_v
	.byte	tile_bg::pipe_v+4
	.byte	tile_bg::pipe_v+1
	.byte	tile_bg::pipe_v+5

	.byte	tile_bg::pipe_v+2
	.byte	tile_bg::pipe_v+6
	.byte	tile_bg::pipe_v+3
	.byte	tile_bg::pipe_v+7

	.byte	tile_bg::pipe_v
	.byte	tile_bg::pipe_v+4
	.byte	tile_bg::pipe_v+1
	.byte	tile_bg::pipe_v+5

	.byte	tile_bg::pipe_v+2
	.byte	tile_bg::pipe_v+6
	.byte	tile_bg::pipe_v+3
	.byte	tile_bg::pipe_v+7

	.byte	tile_bg::pipe_v+8
	.byte	tile_bg::pipe_v+8
	.byte	tile_bg::pipe_v+9
	.byte	tile_bg::pipe_v+9

	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::pipe_v+10
	.byte	tile_bg::pipe_v+10
; ---
	.byte	tile_bg::plat_b
	.byte	tile_bg::plat_b+1
	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+3

	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+4
	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+4

	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+3
	.byte	tile_bg::plat_b+5
	.byte	tile_bg::plat_b+6
; ---
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	tile_bg::plat_a
		.byte	tile_bg::plat_a+5
		.byte	tile_bg::plat_a_mid
		.byte	tile_bg::plat_a_mid+1

		.byte	tile_bg::plat_a+1
		.byte	tile_bg::plat_a+6
		.byte	tile_bg::plat_a+2
		.byte	tile_bg::plat_a+7

		.byte	tile_bg::plat_a+3
		.byte	tile_bg::plat_a+8
		.byte	tile_bg::plat_a+4
		.byte	tile_bg::plat_a+9
	.endif
; ---
; pipe_h
	.byte	tile_bg::pipe_h
	.byte	tile_bg::pipe_h+4
	.byte	tile_bg::pipe_h+1
	.byte	tile_bg::pipe_h+5

	.byte	tile_bg::pipe_h+2
	.byte	tile_bg::pipe_h+6
	.byte	tile_bg::pipe_h+2
	.byte	tile_bg::pipe_h+6

	.byte	tile_bg::pipe_h+3
	.byte	tile_bg::pipe_h+7
	.byte	tile_bg::pipe_v+9
	.byte	tile_bg::pipe_v+9

	.byte	tile_bg::pipe_h+8
	.byte	tile_bg::pipe_h+11
	.byte	tile_bg::pipe_h+9
	.byte	tile_bg::pipe_h+12

	.byte	tile_bg::blanks+2
	.byte	tile_bg::pipe_h+13
	.byte	tile_bg::blanks+2
	.byte	tile_bg::pipe_h+13

	.byte	tile_bg::pipe_h+10
	.byte	tile_bg::pipe_h+14
	.byte	tile_bg::pipe_v+9
	.byte	tile_bg::pipe_v+9
; ---
	.byte	tile_bg::coral_a
	.byte	tile_bg::coral_b
	.byte	tile_bg::coral_b+1
	.byte	tile_bg::coral_b+2
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_a
	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_b
; ---
	.byte	tile_bg::pole
	.byte	tile_bg::pole
	.byte	tile_bg::pole+1
	.byte	tile_bg::pole+1
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
gfx_meta_block_1:
	.byte	tile_bg::pole
	.byte	tile_bg::pole
	.byte	tile_bg::pole+1
	.byte	tile_bg::pole+1

	.byte	tile_bg::rope
	.byte	tile_bg::blanks
	.byte	tile_bg::rope
	.byte	tile_bg::blanks

	.byte	tile_bg::blanks
	.byte	tile_bg::pole
	.byte	tile_bg::pulley_a
	.byte	tile_bg::pulley_a+1

	.byte	tile_bg::pulley_b
	.byte	tile_bg::pulley_b+1
	.byte	tile_bg::blanks
	.byte	tile_bg::pole+1
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::castle_a+2
	.byte	tile_bg::brick_b
	.byte	tile_bg::castle_a+3
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::castle_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::castle_b+1
	.byte	tile_bg::brick_b

	.byte	tile_bg::castle_a
	.byte	tile_bg::blanks+3
	.byte	tile_bg::castle_a+1
	.byte	tile_bg::blanks+3

	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
; ---
	.byte	tile_bg::plat_b+7
	.byte	tile_bg::plat_b+7
	.byte	tile_bg::plat_b+7
	.byte	tile_bg::plat_b+7
; ---
	.byte	tile_bg::post_a
	.byte	tile_bg::post_b
	.byte	tile_bg::post_a+1
	.byte	tile_bg::post_b+1
; ---
	.byte	tile_bg::tree_trunk
	.byte	tile_bg::tree_trunk
	.byte	tile_bg::tree_trunk+1
	.byte	tile_bg::tree_trunk+1
; ---
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	tile_bg::edge_b
		.byte	tile_bg::tree+2
		.byte	tile_bg::edge_b+1
		.byte	tile_bg::tree+3

		.byte	tile_bg::tree+2
		.byte	tile_bg::tree+2
		.byte	tile_bg::tree+3
		.byte	tile_bg::tree+3
	.endif
; ---
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
; ---
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	tile_bg::floor_normal
		.byte	tile_bg::floor_normal+2
		.byte	tile_bg::floor_normal+1
		.byte	tile_bg::floor_normal+3
	.elseif	.defined(SMB2)
		.byte	tile_bg::brick_a
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_a
		.byte	tile_bg::brick_b
	.endif
; ---
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.if	.defined(SMB2)
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_b

		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
	.endif
	.if	.defined(SMB2M)
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
	.endif

	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks

	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::stair
	.byte	tile_bg::stair+1
	.byte	tile_bg::stair+2
	.byte	tile_bg::stair+3
; ---
	.byte	tile_bg::floor_castle
	.byte	tile_bg::floor_castle+1
	.byte	tile_bg::floor_castle
	.byte	tile_bg::floor_castle+1
; ---
	.byte	tile_bg::bridge_parts+1
	.byte	tile_bg::blanks
	.byte	tile_bg::bridge_parts+1
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::cannon
	.byte	tile_bg::cannon+2
	.byte	tile_bg::cannon+1
	.byte	tile_bg::cannon+3

	.byte	tile_bg::cannon+4
	.byte	tile_bg::cannon+6
	.byte	tile_bg::cannon+5
	.byte	tile_bg::cannon+7
; ---
	.byte	tile_bg::castle_door_left
	.byte	tile_bg::castle_door_left
	.byte	tile_bg::castle_door_right
	.byte	tile_bg::castle_door_right
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
; ---
	.byte	tile_bg::floor_underwater
	.byte	tile_bg::floor_underwater+1
	.byte	tile_bg::floor_underwater+2
	.byte	tile_bg::floor_underwater+3
; ---
	.if	.defined(SMB2M)
		.byte	tile_bg::floor_normal
		.byte	tile_bg::floor_normal+2
		.byte	tile_bg::floor_normal+1
		.byte	tile_bg::floor_normal+3
	.endif
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
; ---
	.byte	tile_bg::pipe_h
	.byte	tile_bg::pipe_h+4
	.byte	tile_bg::pipe_h+1
	.byte	tile_bg::pipe_h+5

	.byte	tile_bg::pipe_h+8
	.byte	tile_bg::pipe_h+11
	.byte	tile_bg::pipe_h+9
	.byte	tile_bg::pipe_h+12
; ---

	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_a
	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_b
; ---
gfx_meta_block_2:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud

	.byte	tile_bg::cloud+1
	.byte	tile_bg::blanks+1
	.byte	tile_bg::cloud+2
	.byte	tile_bg::blanks+1

	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+3
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks

	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+4
	.byte	tile_bg::blanks

	.byte	tile_bg::cloud+5
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+6
	.byte	tile_bg::blanks

	.byte	tile_bg::cloud+7
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.byte	tile_bg::water
	.byte	tile_bg::blanks+2
	.byte	tile_bg::water
	.byte	tile_bg::blanks+2
; ---
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
; ---
	.byte	tile_bg::cloud_small
	.byte	tile_bg::cloud_small+1
	.byte	tile_bg::cloud_small+2
	.byte	tile_bg::cloud_small+3
; ---
	.byte	tile_bg::bridge_a
	.byte	tile_bg::bridge_b
	.byte	tile_bg::bridge_a
	.byte	tile_bg::bridge_b
; ---
	.if	.defined(SMB2)
		.byte	tile_bg::plat_a
		.byte	tile_bg::plat_a+5
		.byte	tile_bg::plat_a_mid
		.byte	tile_bg::plat_a_mid+1

		.byte	tile_bg::plat_a+1
		.byte	tile_bg::plat_a+6
		.byte	tile_bg::plat_a+2
		.byte	tile_bg::plat_a+7

		.byte	tile_bg::plat_a+3
		.byte	tile_bg::plat_a+8
		.byte	tile_bg::plat_a+4
		.byte	tile_bg::plat_a+9
	.endif
; ---
gfx_meta_block_3:
	.if	.defined(SMB2)
		.byte	tile_bg::block_q
		.byte	tile_bg::block_q+2
		.byte	tile_bg::block_q+1
		.byte	tile_bg::block_q+3
	.endif

	.byte	tile_bg::block_q
	.byte	tile_bg::block_q+2
	.byte	tile_bg::block_q+1
	.byte	tile_bg::block_q+3

	.byte	tile_bg::block_q
	.byte	tile_bg::block_q+2
	.byte	tile_bg::block_q+1
	.byte	tile_bg::block_q+3
; ---
	.byte	tile_bg::coin_a
	.byte	tile_bg::coin_a+2
	.byte	tile_bg::coin_a+1
	.byte	tile_bg::coin_a+3
; ---
	.byte	tile_bg::coin_b
	.byte	tile_bg::coin_b+2
	.byte	tile_bg::coin_b+1
	.byte	tile_bg::coin_b+3
; ---
	.byte	tile_bg::block_empty
	.byte	tile_bg::block_empty+2
	.byte	tile_bg::block_empty+1
	.byte	tile_bg::block_empty+3
; ---
	.byte	tile_bg::axe
	.byte	tile_bg::axe+2
	.byte	tile_bg::axe+1
	.byte	tile_bg::axe+3
; -----------------------------------------------------------
	.export palette_underwater
palette_underwater:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_underwater_end-palette_underwater_start
palette_underwater_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ROSE1,   PPU_COLOR_BLUE1,   PPU_COLOR_ROSE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN3,  PPU_COLOR_GREEN1,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_BLUE1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_BLUE1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_BLUE2,  PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY1,   PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_GREY3,   PPU_COLOR_GREY1
palette_underwater_end:
	.byte	0

	.export palette_ground
palette_ground:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_ground_end-palette_ground_start
palette_ground_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_YGREEN2, PPU_COLOR_GREEN1,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED3,    PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_AZURE2,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN1,  PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
palette_ground_end:
	.byte	0

	.export palette_underground
palette_underground:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_underground_end-palette_underground_start
palette_underground_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_YGREEN2, PPU_COLOR_GREEN1,  PPU_COLOR_YGREEN0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN3,   PPU_COLOR_CYAN1,   PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_AZURE2,  PPU_COLOR_CYAN1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_CYAN1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN1,   PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN0,   PPU_COLOR_CYAN3,   PPU_COLOR_CYAN1
palette_underground_end:
	.byte	0

	.export palette_castle
palette_castle:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_castle_end-palette_castle_start
palette_castle_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_RED1,    PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_CYAN1,   PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY0,   PPU_COLOR_GREY3,   PPU_COLOR_GREY1
palette_castle_end:
	.byte	0

	.export palette_day_snow
palette_day_snow:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_day_snow_end-palette_day_snow_start
palette_day_snow_start:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_GREY3, PPU_COLOR_GREY0, PPU_COLOR_GREY1
palette_day_snow_end:
	.byte	0

	.export palette_night_snow
palette_night_snow:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_night_snow_end-palette_night_snow_start
palette_night_snow_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3, PPU_COLOR_GREY0, PPU_COLOR_GREY1
palette_night_snow_end:
	.byte	0

	.export palette_mushroom
palette_mushroom:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_mushroom_end-palette_mushroom_start
palette_mushroom_start:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_ORANGE2, PPU_COLOR_RED1, PPU_COLOR_PITCH0
palette_mushroom_end:
	.byte	0

	.export palette_bowser
palette_bowser:
	.dbyt	PPU_COLOR_PAGE_OBJ+(PPU_COLOR_LINE_SIZE*1)
	.byte	palette_bowser_end-palette_bowser_start
palette_bowser_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN1, PPU_COLOR_GREY3, PPU_COLOR_ORANGE2
palette_bowser_end:
	.byte	0

	.export msg_thankyou_mario
msg_thankyou_mario:
	.dbyt	PPU_VRAM_BG2+$148
	.byte	msg_thankyou_mario_end-msg_thankyou_mario_start
msg_thankyou_mario_start:
	.byte	"THANK YOU MARIO!"
msg_thankyou_mario_end:
	.byte	0

	.if	.defined(SMB)|.defined(VS_SMB)
		.export msg_thankyou_luigi
	msg_thankyou_luigi:
		.dbyt	PPU_VRAM_BG2+$148
		.byte	msg_thankyou_luigi_end-msg_thankyou_luigi_start
	msg_thankyou_luigi_start:
		.byte	"THANK YOU LUIGI!"
	msg_thankyou_luigi_end:
		.byte	0
	.endif

	.export msg_thankyou_toad
msg_thankyou_toad:
	.dbyt	PPU_VRAM_BG2+$1C5
	.byte	msg_thankyou_toad1_end-msg_thankyou_toad1_start
msg_thankyou_toad1_start:
	.byte	"BUT OUR PRINCESS IS IN"
msg_thankyou_toad1_end:
	.dbyt	PPU_VRAM_BG2+$205
	.byte	msg_thankyou_toad2_end-msg_thankyou_toad2_start
msg_thankyou_toad2_start:
	.byte	"ANOTHER CASTLE!"
msg_thankyou_toad2_end:
	.byte	0

	.if	.defined(SMB)
		.export msg_thankyou_princess1
	msg_thankyou_princess1:
		.dbyt	PPU_VRAM_BG2+$1A7
		.byte	msg_thankyou_princess1_end-msg_thankyou_princess1_start
	msg_thankyou_princess1_start:
		.byte	"YOUR QUEST IS OVER."
	msg_thankyou_princess1_end:
		.byte	0	

		.export msg_thankyou_princess2
	msg_thankyou_princess2:
		.dbyt	PPU_VRAM_BG2+$1E3
		.byte	msg_thankyou_princess2_end-msg_thankyou_princess2_start
	msg_thankyou_princess2_start:
		.byte	"WE PRESENT YOU A NEW QUEST."
	msg_thankyou_princess2_end:
		.byte	0

		.export msg_worldsel_1
	msg_worldsel_1:
		.dbyt	PPU_VRAM_BG2+$24A
		.byte	msg_worldsel_1_end-msg_worldsel_1_start
	msg_worldsel_1_start:
		.byte	"PUSH BUTTON B"
	msg_worldsel_1_end:
		.byte	0

		.export msg_worldsel_2
	msg_worldsel_2:
		.dbyt	PPU_VRAM_BG2+$288
		.byte	msg_worldsel_2_end-msg_worldsel_2_start
	msg_worldsel_2_start:
		.byte	"TO SELECT A WORLD"
	msg_worldsel_2_end:
		.byte	0
	.elseif	.defined(VS_SMB)
		.export nmi_addr_0F
	nmi_addr_0F:
		.dbyt	PPU_VRAM_BG1+PPU_VRAM_BG_VIS
		.byte	$48, $55, $23, $C2, $01, $D5
		.byte	0

		.export	nmi_addr_10
	nmi_addr_10:
		.dbyt	PPU_COLOR_PAGE_BG
		.byte	nmi_addr_10_end-nmi_addr_10_start
	nmi_addr_10_start:
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_AZURE2,  PPU_COLOR_BLUE1,   PPU_COLOR_BLUE0
		.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0
	nmi_addr_10_end:
		.byte	0

		.export msg_thankyou_mario_2
	msg_thankyou_mario_2:
		.dbyt	PPU_VRAM_BG2+$E8
		.byte	msg_thankyou_mario_2_end-msg_thankyou_mario_2_start
	msg_thankyou_mario_2_start:
		.byte	"THANK YOU MARIO!"
	msg_thankyou_mario_2_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$8
		.byte	$48, $05
		.byte	0

		.export msg_thankyou_luigi_2
	msg_thankyou_luigi_2:
		.dbyt	PPU_VRAM_BG2+$E8
		.byte	msg_thankyou_luigi_2_end-msg_thankyou_luigi_2_start
	msg_thankyou_luigi_2_start:
		.byte	"THANK YOU LUIGI!"
	msg_thankyou_luigi_2_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$8
		.byte	$48, $05
		.byte	0

		.export msg_vsend_1
	msg_vsend_1:
		.dbyt	PPU_VRAM_BG2+$109
		.byte	msg_vsend_1_end-msg_vsend_1_start
	msg_vsend_1_start:
		.byte	"PEACE IS PAVED"
	msg_vsend_1_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$10
		.byte	$58, $AA
		.byte	0

		.export msg_vsend_2
	msg_vsend_2:
		.dbyt	PPU_VRAM_BG2+$147
		.byte	msg_vsend_2_end-msg_vsend_2_start
	msg_vsend_2_start:
		.byte	"WITH KINGDOM SAVED"
	msg_vsend_2_end:
		.byte	0

		.export	msg_vsend_3_mario
	msg_vsend_3_mario:
		.dbyt	PPU_VRAM_BG2+$189
		.byte	msg_vsend_3_mario_end-msg_vsend_3_mario_start
	msg_vsend_3_mario_start:
		.byte	"HURRAH TO  MARIO"
	msg_vsend_3_mario_end:
		.byte	0

		.export msg_vsend_3_luigi
	msg_vsend_3_luigi:
		.dbyt	PPU_VRAM_BG2+$189
		.byte	msg_vsend_3_luigi_end-msg_vsend_3_luigi_start
	msg_vsend_3_luigi_start:
		.byte	"HURRAH TO  LUIGI"
	msg_vsend_3_luigi_end:
		.byte	0

		.export msg_vsend_4
	msg_vsend_4:
		.dbyt	PPU_VRAM_BG2+$1CA
		.byte	msg_vsend_4_end-msg_vsend_4_start
	msg_vsend_4_start:
		.byte	"OUR ONLY HERO"
	msg_vsend_4_end:
		.byte	0

		.export msg_vsend_5
	msg_vsend_5:
		.dbyt	PPU_VRAM_BG2+$207
		.byte	msg_vsend_5_end-msg_vsend_5_start
	msg_vsend_5_start:
		.byte	"THIS ENDS YOUR TRIP"
	msg_vsend_5_end:
		.byte	0

		.export msg_vsend_6
	msg_vsend_6:
		.dbyt	PPU_VRAM_BG2+$246
		.byte	msg_vsend_6_end-msg_vsend_6_start
	msg_vsend_6_start:
		.byte	"OF A LONG FRIENDSHIP"
	msg_vsend_6_end:
		.byte	0

		.export msg_vsend_7
	msg_vsend_7:
		.dbyt	PPU_VRAM_BG2+$288
		.byte	msg_vsend_7_end-msg_vsend_7_start
	msg_vsend_7_start:
		.byte	"100000 PTS.ADDED"
	msg_vsend_7_end:
		.dbyt	PPU_VRAM_BG2+PPU_VRAM_BG_VIS+$28
		.byte	$48, $FF
		.byte	0

		.export msg_vsend_8
	msg_vsend_8:
		.dbyt	PPU_VRAM_BG2+$2A6
		.byte	msg_vsend_8_end-msg_vsend_8_start
	msg_vsend_8_start:
		.byte	"FOR EACH PLAYER LEFT."
	msg_vsend_8_end:
		.byte	0
	.endif
