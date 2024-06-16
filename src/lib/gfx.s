.include	"../../inc/system/ppu.i"
.include	"../../inc/system/palettes.i"

.include	"../../inc/engine/charmap.i"

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
	lda	#$06
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
	lda	eng_frame_count
	and	#$07
	bne	:+++
	ldx	ppu_nmi_buffer+$00
	cpx	#GFX_COLOR_ROT_THRESH
	bcs	:+++ ; if ((eng_frame_count % 8) || ppu_nmi_buffer_entry < GFX_COLOR_ROT_THRESH) {
		tay
		: ; for (x = ppu_nmi_buffer_entry, y = (eng_frame_count % 8); y < 8; x++, y++) {
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
	.byte	$45, $45, $47, $47
	.byte	$47, $47, $47, $47
	.byte	$57, $58, $59, $5A
	.byte	$24, $24, $24, $24
	.byte	$26, $26, $26, $26
; ----------------------------
gfx_clear_small:
	ldy	#$41
	lda	#3

	ldx	course_type
	bne	:+ ; if (course_type == water) {
		lda	#4
	: ; }

	jsr	gfx_clear_put
	lda	#$06
	sta	nmi_addrs_ctl
	rts
; ----------------------------
gfx_meta_replace:
	jsr	gfx_meta_write
	inc	ppu_nmi_buffer+$F0
	dec	ppu_nmi_buffer+$EC, x
	rts
; ----------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	GFX_META_DEST_BLK_0	= $58
	GFX_META_DEST_BLK_1	= $51
	GFX_META_DEST_BLK_2	= $5D
	GFX_META_DEST_BLK_3	= $52
.elseif	.defined(SMB2)
	GFX_META_DEST_BLK_0	= $56
	GFX_META_DEST_BLK_1	= $4F
	GFX_META_DEST_BLK_2	= $5C
	GFX_META_DEST_BLK_3	= $50
.elseif	.defined(ANN)
	GFX_META_DEST_BLK_0	= $57
	GFX_META_DEST_BLK_1	= $51
	GFX_META_DEST_BLK_2	= $5C
	GFX_META_DEST_BLK_3	= $52
.endif

gfx_meta_destroy:
	lda	#0
gfx_meta_write:
	ldy	#3
	cmp	#0
	beq	:+ ; if (a != 0) {
		ldy	#0
		cmp	#GFX_META_DEST_BLK_0
		beq	:+
		cmp	#GFX_META_DEST_BLK_1
		beq	:+ ; if (a.not_in(GFX_META_DEST_BLK_0, GFX_META_DEST_BLK_1)) {
			iny
			cmp	#GFX_META_DEST_BLK_2
			beq	:+
			cmp	#GFX_META_DEST_BLK_3
			beq	:+ ; if (a.not_in(GFX_META_DEST_BLK_2, GFX_META_DEST_BLK_3)) {
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
	.byte	$24, $24, $24, $24
	.byte	$27, $27, $27, $27
	.byte	$24, $24, $24, $35
	.byte	$36, $25, $37, $25
	.byte	$24, $38, $24, $24
	.byte	$24, $30, $30, $26
	.byte	$26, $26, $34, $26
	.byte	$24, $31, $24, $32
	.byte	$33, $26, $24, $33
	.byte	$34, $26, $26, $26
	.byte	$26, $26, $26, $26
	.byte	$24, $C0, $24, $C0
	.byte	$24, $7F, $7F, $24
	.byte	$B8, $BA, $B9, $BB
	.byte	$B8, $BC, $B9, $BD
	.byte	$BA, $BC, $BB, $BD
	.byte	$60, $64, $61, $65
	.byte	$62, $66, $63, $67
	.byte	$60, $64, $61, $65
	.byte	$62, $66, $63, $67
	.byte	$68, $68, $69, $69
	.byte	$26, $26, $6A, $6A
	.byte	$4B, $4C, $4D, $4E
	.byte	$4D, $4F, $4D, $4F
	.byte	$4D, $4E, $50, $51
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	$6B, $70, $2C, $2D
		.byte	$6C, $71, $6D, $72
		.byte	$6E, $73, $6F, $74
	.endif
	.byte	$86, $8A, $87, $8B
	.byte	$88, $8C, $88, $8C
	.byte	$89, $8D, $69, $69
	.byte	$8E, $91, $8F, $92
	.byte	$26, $93, $26, $93
	.byte	$90, $94, $69, $69
	.byte	$A4, $E9, $EA, $EB
	.byte	$24, $24, $24, $24
	.byte	$24, $2F, $24, $3D
	.byte	$A2, $A2, $A3, $A3
	.byte	$24, $24, $24, $24

gfx_meta_block_1:
	.byte	$A2, $A2, $A3, $A3
	.byte	$99, $24, $99, $24
	.byte	$24, $A2, $3E, $3F
	.byte	$5B, $5C, $24, $A3
	.byte	$24, $24, $24, $24
	.byte	$9D, $47, $9E, $47
	.byte	$47, $47, $27, $27
	.byte	$47, $47, $47, $47
	.byte	$27, $27, $47, $47
	.byte	$A9, $47, $AA, $47
	.byte	$9B, $27, $9C, $27
	.byte	$27, $27, $27, $27
	.byte	$52, $52, $52, $52
	.byte	$80, $A0, $81, $A1
	.byte	$BE, $BE, $BF, $BF
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	$75, $BA, $76, $BB
		.byte	$BA, $BA, $BB, $BB
	.endif
	.byte	$45, $47, $45, $47
	.byte	$47, $47, $47, $47
	.byte	$45, $47, $45, $47
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	$B4, $B6, $B5, $B7
	.elseif	.defined(SMB2)
		.byte	$45, $47, $45, $47
	.endif
	.byte	$45, $47, $45, $47
	.byte	$45, $47, $45, $47
	.byte	$45, $47, $45, $47
	.byte	$45, $47, $45, $47
	.byte	$45, $47, $45, $47
	.byte	$47, $47, $47, $47
	.byte	$47, $47, $47, $47
	.byte	$47, $47, $47, $47
	.byte	$47, $47, $47, $47
	.byte	$47, $47, $47, $47
	.if	.defined(SMB2)
		.byte	$47, $47, $47, $47
		.byte	$24, $24, $24, $24
	.endif
	.if	.defined(SMB2M)
		.byte	$24, $24, $24, $24
	.endif
	.byte	$24, $24, $24, $24
	.byte	$24, $24, $24, $24
	.byte	$AB, $AC, $AD, $AE
	.byte	$5D, $5E, $5D, $5E
	.byte	$C1, $24, $C1, $24
	.byte	$C6, $C8, $C7, $C9
	.byte	$CA, $CC, $CB, $CD
	.byte	$2A, $2A, $40, $40
	.byte	$24, $24, $24, $24
	.byte	$24, $47, $24, $47
	.byte	$82, $83, $84, $85
	.if	.defined(SMB2M)
		.byte	$B4, $B6, $B5, $B7
	.endif
	.byte	$24, $47, $24, $47
	.byte	$86, $8A, $87, $8B
	.byte	$8E, $91, $8F, $92
	.byte	$24, $2F, $24, $3D

gfx_meta_block_2:
	.byte	$24, $24, $24, $35
	.byte	$36, $25, $37, $25
	.byte	$24, $38, $24, $24
	.byte	$24, $24, $39, $24
	.byte	$3A, $24, $3B, $24
	.byte	$3C, $24, $24, $24
	.byte	$41, $26, $41, $26
	.byte	$26, $26, $26, $26
	.byte	$B0, $B1, $B2, $B3
	.byte	$77, $79, $77, $79
	.if	.defined(SMB2)
		.byte	$6B, $70, $2C, $2D
		.byte	$6C, $71, $6D, $72
		.byte	$6E, $73, $6F, $74
	.endif

gfx_meta_block_3:
	.if	.defined(SMB2)
		.byte	$53, $55, $54, $56
	.endif
	.byte	$53, $55, $54, $56
	.byte	$53, $55, $54, $56
	.byte	$A5, $A7, $A6, $A8
	.byte	$C2, $C4, $C3, $C5
	.byte	$57, $59, $58, $5A
	.byte	$7B, $7D, $7C, $7E
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

	.export palette_day
palette_day:
	.dbyt	PPU_COLOR_PAGE_BG
	.byte	palette_day_end-palette_day_start
palette_day_start:
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_YGREEN2, PPU_COLOR_GREEN1,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED3,    PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREY3,   PPU_COLOR_AZURE2,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_GREEN1,  PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_RED1,    PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2
	.byte	PPU_COLOR_PITCH0, PPU_COLOR_PITCH0,  PPU_COLOR_RED3,    PPU_COLOR_ORANGE1
palette_day_end:
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
