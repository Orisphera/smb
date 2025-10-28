.if     .defined(VS)
        .include        "sys/vs.i"
.endif

.include	"mem.i"
.include	"mem_low.i"
.include        "course_flags.i"
.include	"misc.i"
.include	"const.i"
.include	"tiles.i"
; ----------------------------------
SCENERY_HEIGHT_MAX	= $0D

	.export	scenery_render
scenery_render:
	: ; for (x = metatile_base_id, y = this.height; x >= 0xD && y >= 0; x++, y--) {
		sty	scenery_height
		ldy	scenery_metatile, x
		beq	:+
		cpy	#metatile_0::plat_b_b
		beq	:++
		cpy	#METATILE_PLAT_A_B
		beq	:++
		cpy	#TILE_PAGE_3
		beq	:+
		cpy	#TILE_PAGE_3
		bcs	:++
		.if	.defined(SMBM)|.defined(VS_SMB)
			cpy	#metatile_1::floor_normal
			bne	:+
			cmp	#$50
			beq	:++
		.endif
		: ; if (metatile == blank_a || (metatile.not_in(plat_b_b, plat_a_b) && (metatile == 0xC0 || (metatile < 0xC0 && (metatile != floor_normal || a != 0x50))))) {
			sta	scenery_metatile, x
		: ; }

		inx
		cpx	#SCENERY_HEIGHT_MAX
		bcs	:+
		ldy	scenery_height
		dey
		bpl	:---
	: ; }

	rts
; ----------------------------------
        .export scenery_len, scenery_len_b
scenery_len:
	jsr	scenery_attr

scenery_len_b:
	lda	scenery_length, x
	clc
	bpl	:+ ; if () {
		tya
		sta	scenery_length, x
		sec
	: ; }

	rts
; ----------------------------------
        .export scenery_attr
scenery_attr:
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif
	ldy	scenery_offset, x
	lda	(course_scenery_addr), y
	and	#%00001111
	sta	scenery_proc_metatile_id
	iny
	lda	(course_scenery_addr), y
	and	#%00001111
	tay
	rts
; ----------------------------------
        .export scenery_pos_x_get
scenery_pos_x_get:
	lda	pos_x_lo_game
	asl	a
	asl	a
	asl	a
	asl	a
	rts
; ----------------------------------
        .export scenery_pos_y_get
scenery_pos_y_get:
	lda	game_buffer+1
	asl	a
	asl	a
	asl	a
	asl	a
	clc
	adc	#(2<<4)
	rts
; ----------------------------------
	.export scenery_buffer_ptr_lo, scenery_buffer_ptr_hi
scenery_buffer_ptr_lo:
	.byte	<bg_buffer_0, <bg_buffer_1

scenery_buffer_ptr_hi:
	.byte	>bg_buffer_0, >bg_buffer_1
; ----------------
	.export scenery_get_buffer_ptr
scenery_get_buffer_ptr:
	pha
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	tay
	lda	scenery_buffer_ptr_hi, y
	sta	game_buffer+1
	pla
	and	#%00001111
	clc
	adc	scenery_buffer_ptr_lo, y
	sta	game_buffer
	rts
