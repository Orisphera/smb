.include	"../../inc/engine/tunables.i"

.include	"../../inc/engine/unk.i"

	.export oam_init, oam_init_nmi
oam_init:
	ldy     #0
	.byte	$2C

oam_init_nmi:
	ldy	#4
        lda     #ENG_OAM_CLEAR_SCANLINE
	: ; for (y = 0; y < 0x100; y += 4) {
		sta     OAM_DMA_BUFFER,y
		iny
		iny
		iny
		iny
		bne     :-
	; }

        rts