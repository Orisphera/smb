.include	"sys/cpu.i"

.include	"mem.i"
.include	"tiles.i"

	.export	scenery_bridge_hi
	.export	scenery_bridge_mid
	.export	scenery_bridge_lo
scenery_bridge_hi:
	lda	#6
.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	scenery_bridge
.endif

scenery_bridge_mid:
	lda	#7
.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	scenery_bridge
.endif

scenery_bridge_lo:
	lda	#9

scenery_bridge:
	pha

	jsr	scenery_len

	pla
	tax
	lda	#metatile_0::bridge_rope
	sta	scenery_metatile, x
	inx
	ldy	#0
	lda	#metatile_1::bridge_base
	jmp	scenery_render
