.include	"system/cpu.i"
.include	"system/ppu.i"

.include	"mem.i"
.include	"tunables.i"

SKIP_TO_oam_init_do	= BIT_ABS_OPCODE

	.export oam_init, oam_init_all
oam_init:
	ldy     #(OBJ_SIZE*0)
	.if	.defined(CONS)
		.byte	SKIP_TO_oam_init_do
	.elseif	.defined(VS)
		jmp	oam_init_do
	.endif
; --------------
oam_init_all:
	ldy	#(OBJ_SIZE*1)
; --------------
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
