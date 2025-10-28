.include	"sys/ppu.i"

.include	"mem.i"
.include	"charmap.i"

	.export	nt_init
nt_init:
	lda	PPU_SR
	lda	ppu_ctlr0_b
	ora	#ppu_ctlr0::bg_seg1
	and	#<~(ppu_ctlr0::obj_seg1|ppu_ctlr0::inc_bit|ppu_ctlr0::bg_bits)
	jsr	ppu_displist_write_ctlr0
; --------------
	lda	#>PPU_VRAM_BG2
	jsr	nt_init_do
; --------------
	lda	#>PPU_VRAM_BG1
; --------------
nt_init_do:
	sta	PPU_VRAM_AR
	lda	#0
	sta	PPU_VRAM_AR

	ldx	#>PPU_VRAM_BG_SIZE
	ldy	#<PPU_VRAM_BG_ATTR
	lda	#' '
	: ; for (byte of nametable) {
		sta	PPU_VRAM_IO
	
		dey
		bne	:-
		dex
		bne	:-
	; }

	ldy	#PPU_VRAM_ATTR_SIZE
	txa
	sta	ppu_displist_offset
	sta	ppu_displist_data+0
	: ; for (byte of attributes) {
		sta	PPU_VRAM_IO

		dey
		bne	:-
	; }

	sta	ppu_scc_h_b
	sta	ppu_scc_v_b
	jmp	ppu_displist_write_scc_h_v
