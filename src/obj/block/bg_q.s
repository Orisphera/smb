.include	"system/cpu.i"

.include	"mem.i"
.include	"tiles.i"

	.export	bg_scenery_block_qhi, bg_scenery_block_qlo
bg_scenery_block_qhi:
	lda	#3
.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	bg_scenery_block_q_row
.endif

bg_scenery_block_qlo:
	lda	#7

bg_scenery_block_q_row:
	pha

	jsr	bg_scenery_len

	pla
	tax
	lda	#metatile_3::block_q_set
	sta	gfx_metatile, x
	rts
