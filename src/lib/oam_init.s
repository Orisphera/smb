.include	"system/cpu.i"
.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/tunables.i"

SKIP_TO_oam_init_do	= BIT_ABS_OPCODE

	.export oam_init, oam_init_nmi
oam_init:
	ldy     #0
	.if	.defined(CONS)
		.byte	SKIP_TO_oam_init_do
	.elseif	.defined(VS)
		jmp	oam_init_do
	.endif

oam_init_nmi:
	ldy	#4

oam_init_do:
        lda     #ENG_OAM_CLEAR_SCANLINE
	: ; for (obj of OAM) {
		sta     OAM_DMA_BUFFER+OBJ_POS_V, y

		iny
		iny
		iny
		iny
		bne     :-
	; }

        rts
