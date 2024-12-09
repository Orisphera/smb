.include	"system/ppu.i"

.include	"mem.i"
.include	"macros.i"

ppu_displist_write_do:
	sta	PPU_VRAM_AR
	iny
	lda	(ppu_displist_write_addr), y
	sta	PPU_VRAM_AR

	iny
	lda	(ppu_displist_write_addr), y
	asl	a
	pha

	lda	ppu_ctlr0_b
	ora	#ppu_ctlr0::inc_32
	bcs	:+ ; if (!(this.length & NMI_INC_ROW)) {
		and	#<~ppu_ctlr0::inc_32
	: ; }
	jsr	ppu_displist_write_ctlr0

	pla
	asl	a
	bcc	:+ ; if ((this.length & NMI_REPEAT)) {
		ora	#1<<1
		iny
	: ; }

	lsr	a
	lsr	a
	tax
	: ; for (x = (this.length & ~(NMI_INC_ROW|NMI_REPEAT)); x > 0; x--) {
		bcs	:+ ; if (!(this.length & NMI_REPEAT)) {
			iny
		: ; }

		lda	(ppu_displist_write_addr), y
		sta	PPU_VRAM_IO

		dex
		bne	:--
	; }

	sec
	tya
	adc	ppu_displist_write_addr
	sta	ppu_displist_write_addr
	lda	#0
	adc	ppu_displist_write_addr+1
	sta	ppu_displist_write_addr+1

	ppuaddr_m	PPU_VRAM_COLOR
	sta	PPU_VRAM_AR
	sta	PPU_VRAM_AR
; ----------------------------
	.export ppu_displist_write, ppu_displist_write_scc_h_v
ppu_displist_write:
	ldx	PPU_SR
	ldy	#0
	lda	(ppu_displist_write_addr), y
	bne	ppu_displist_write_do ; if (ppu_displist_write_addr[y] == 0) {
		.export ppu_displist_write_scc_h_v
	ppu_displist_write_scc_h_v:
		sta	PPU_SCC_H_V
		sta	PPU_SCC_H_V
		rts
	; } else ppu_displist_write_do();
; -----------------------------------------------------------
	.export ppu_displist_write_ctlr0
ppu_displist_write_ctlr0:
	sta	PPU_CTLR0
	sta	ppu_ctlr0_b
	rts
