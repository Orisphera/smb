.include	"system/cpu.i"

.include	"mem.i"
.include	"tiles.i"

	.export	scenery_block_qhi, scenery_block_qlo
scenery_block_qhi:
	lda	#3
.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	scenery_block_q_row
.endif

scenery_block_qlo:
	lda	#7

scenery_block_q_row:
	pha

	jsr	scenery_len

	pla
	tax
	lda	#metatile_3::block_q_set
	sta	scenery_metatile, x
	rts
