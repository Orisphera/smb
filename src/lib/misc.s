.include	"../../inc/system/cpu.i"
.include	"../../inc/system/ppu.i"
.include	"../../inc/system/ctrl.i"
.if	.defined(VS)
	.include	"../../inc/system/vs.i"
.endif

.include	"../../inc/engine/joypad.i"

.include	"../../inc/engine/unk.i"

	.export eng_farjump
eng_farjump:
	asl	a
	tay
	pla
	sta	zp_addr_04
	pla
	sta	zp_addr_04+1
	iny
	lda	(zp_addr_04), y
	sta	zp_addr_06
	iny
	lda	(zp_addr_04), y
	sta	zp_addr_06+1
	jmp	(zp_addr_06)
; -----------------------------------------------------------
	.export	nt_init
nt_init:
	lda	PPU_SR
	lda	ppu_ctlr0_b
	ora	#ppu_ctlr0::bg_seg1
	and	#<~(ppu_ctlr0::obj_seg1|ppu_ctlr0::inc_bit|ppu_ctlr0::bg_bits)
	jsr	eng_sta_ppu_ctlr0
	lda	#>PPU_VRAM_BG2
	jsr	nt_init_do
	lda	#>PPU_VRAM_BG1
; ----------------------------
nt_init_do:
	sta	PPU_VRAM_AR
	lda	#0
	sta	PPU_VRAM_AR

	ldx	#4
	ldy	#$C0
	lda	#$24
	: ; for (x = 4, y = 0xC0; x > 0 && y > 0; x--, y--) {
		sta	PPU_VRAM_IO

		dey
		bne	:-
		dex
		bne	:-
	; }

	ldy	#64
	txa
	sta	ppu_nmi_buffer+$00
	sta	ppu_nmi_buffer+$01
	: ; for (y = 64, y > 0; y--) {
		sta	PPU_VRAM_IO

		dey
		bne	:-
	; }

	sta	eng_scc_h_b
	sta	eng_scc_v_b
	jmp	eng_sta_ppu_scc_h_v
; -----------------------------------------------------------
	.export joypad_read
joypad_read:
	.if	.defined(CONS)
		lda	#1
		sta	CTRL0
		lsr	a
		tax
		sta	CTRL0
	.elseif	.defined(VS)
		lda	#vs_req::irq_rel|vs_req::ctrl_raise
		sta	VS_REQ
		lda	#vs_req::irq_rel|vs_req::ctrl_rel
		ldx	#0
		sta	VS_REQ
		lda	#0
	.endif

	jsr	joypad_read_do
	inx
; ----------------------------
joypad_read_do:
	ldy	#8
	: ; for (y = 8; y > 0; y--) {
		pha
		lda	CTRL0, x
		sta	zp_byte_00

		.if	.defined(CONS)
			lsr	a
			ora	zp_byte_00
		.endif

		lsr	a
		pla
		rol	a

		dey
		bne	:-
	; }

	sta	joypad_bits, x
	pha
	and	#joypad_button::select|joypad_button::start
	and	joypad_mask, x
	beq	:+ ; if (!(joypad_val[x] & (select|start) & joypad_mask[x])) {
		pla
		and	#<~(joypad_button::select|joypad_button::start)
		sta	joypad_bits, x
		rts
	: ; } else {
		pla
		sta	joypad_mask, x
		rts
	; }
; -----------------------------------------------------------
eng_screen_update_buf:
	sta	PPU_VRAM_AR
	iny
	lda	(zp_addr_00), y
	sta	PPU_VRAM_AR
	iny
	lda	(zp_addr_00), y
	asl	a
	pha
	lda	ppu_ctlr0_b
	ora	#ppu_ctlr0::inc_32
	bcs	:+ ; if (zp_addr_00[y] & 0x80) {
		and	#<~ppu_ctlr0::inc_32
	: ; }

	jsr	eng_sta_ppu_ctlr0
	pla
	asl	a
	bcc	:+ ; if (!(zp_addr_00[y] & 0x80)) {
		ora	#$02
		iny
	: ; }

	lsr	a
	lsr	a
	tax
	: ; for (x = (zp_addr_00[y] / 2); x > 0; x--) {
		bcs	:+ ; if (!(zp_addr_00 % 2)) {
			iny
		: ; }

		lda	(zp_addr_00), y
		sta	PPU_VRAM_IO

		dex
		bne	:--
	; }

	sec
	tya
	adc	zp_addr_00
	sta	zp_addr_00
	lda	#0
	adc	zp_addr_00+1
	sta	zp_addr_00+1
	lda	#>PPU_VRAM_COLOR
	sta	PPU_VRAM_AR
	lda	#<PPU_VRAM_COLOR
	sta	PPU_VRAM_AR
	sta	PPU_VRAM_AR
	sta	PPU_VRAM_AR
; ----------------------------
	.export eng_screen_update
eng_screen_update:
	ldx	PPU_SR
	ldy	#0
	lda	(zp_addr_00), y
	bne	eng_screen_update_buf
; ----------------------------
	.export eng_sta_ppu_scc_h_v
eng_sta_ppu_scc_h_v:
	sta	PPU_SCC_H_V
	sta	PPU_SCC_H_V
	rts
; -----------------------------------------------------------
	.export eng_sta_ppu_ctlr0
eng_sta_ppu_ctlr0:
	sta	PPU_CTLR0
	sta	ppu_ctlr0_b
	rts
; -----------------------------------------------------------
stats_data:
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	$F0, $06
	.elseif	.defined(SMB2)
		.byte	$EF, $06
	.elseif	.defined(ANN)
		.byte	$F1, $06
	.endif

	.byte	$62, $06

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	$62, $06
	.endif

	.if	.defined(CONS)
		.byte	$6D, $02
		.if	.defined(SMB)
			.byte	$6D, $02
		.endif
	.elseif	.defined(VS)
		.byte	$6D, $03
		.if	.defined(VS_SMB)
			.byte	$6D, $03
		.endif
	.endif

	.byte	$7A, $03

stats_offsets:
	.byte	$06, $0C, $12, $18
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	$1E, $24
	.endif
; ----------------------------
	.export	eng_stats_print_num
eng_stats_print_num:
	sta	zp_byte_00
	jsr	print_num
	lda	zp_byte_00
	lsr	a
	lsr	a
	lsr	a
	lsr	a
; ----------------------------
print_num:
	clc
	adc	#1
	and	#$0F
	cmp	#6
	bcs	:+++ ; if (++arg < 6) {
		pha
		asl	a
		tay
		ldx	ppu_nmi_buffer+$00
		lda	#$20
		cpy	#0
		bne	:+ ; if ((2*arg) == 0) {
			lda	#$22
		: ; }
		sta	ppu_nmi_buffer+$01, x

		lda	stats_data, y
		sta	ppu_nmi_buffer+$02, x
		lda	stats_data+1, y
		sta	ppu_nmi_buffer+$03, x
		sta	zp_byte_03
		stx	zp_byte_02
		pla
		tax
		lda	stats_offsets, x
		sec
		sbc	stats_data+1, y
		tay
		ldx	zp_byte_02
		: ; for (x = zp_byte_02, y = tbl_lo, zp_byte_03 = tbl_hi; zp_byte_03 > 0; x++, y++, zp_byte_03--) {
			lda	eng_score, y
			sta	ppu_nmi_buffer+$04, x

			inx
			iny
			dec	zp_byte_03
			bne	:-
		; }

		lda	#0
		sta	ppu_nmi_buffer+$04, x
		inx
		inx
		inx
		stx	ppu_nmi_buffer+$00
	: ; }

	rts
; -----------------------------------------------------------
	.export eng_stats_math
eng_stats_math:
	lda	eng_game_mode
	.if	.defined(SMB)|.defined(VS_SMB)
		cmp	#0
	.endif
	beq	:++ ; if (eng_game_mode != 0) {
		ldx	#5
		: ; for (x = 5; x >= 0; x--, y--) {
			lda	STACK_BASE+$34, x
			clc
			adc	eng_score, y
			bmi	stats_math_dec
			cmp	#10
			bcs	stats_math_inc

		eng_stats_math_store:
			sta	eng_score, y

			dey
			dex
			bpl	:-
		; }
	: ; }

	lda	#0
	ldx	#6
	: ; for (x = 6; x >= 0; x--) {
		sta	STACK_BASE+$33, x

		dex
		bpl	:-
	; }

	rts
; ----------------------------
stats_math_dec:
	dec	STACK_BASE+$33, x
	lda	#9
	bne	eng_stats_math_store

stats_math_inc:
	sec
	sbc	#10
	inc	STACK_BASE+$33, x
	jmp	eng_stats_math_store
; -----------------------------------------------------------
	.export eng_score_calc
eng_score_calc:
	ldx	#5
	.if	.defined(SMB)|.defined(VS_SMB)
		jsr	eng_score_calc_do
		ldx	#11
	.endif
; ----------------------------
eng_score_calc_do:
	ldy	#5
	sec
	: ; for (x, y = 5; y >= 0; x--, y--) {
		lda	eng_stats, x
		sbc	eng_score, y

		dex
		dey
		bpl	:-
	; }

	bcc	:++ ; if () {
		inx
		iny
		: ; for (x++, y++; y < 6; y++) {
			lda	eng_stats, x
			sta	eng_score, y

			inx
			iny
			cpy	#6
			bcc	:-
		; }
	: ; }

	rts
