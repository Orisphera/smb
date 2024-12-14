.include	"system/cpu.i"

.include	"mem.i"
.include	"tiles.i"

	.export	bg_scenery_bridge_hi
	.export	bg_scenery_bridge_mid
	.export	bg_scenery_bridge_lo
bg_scenery_bridge_hi:
	lda	#6
.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	bg_scenery_bridge
.endif

bg_scenery_bridge_mid:
	lda	#7
.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	bg_scenery_bridge
.endif

bg_scenery_bridge_lo:
	lda	#9

bg_scenery_bridge:
	pha

	jsr	bg_scenery_len

	pla
	tax
	lda	#metatile_0::bridge_rope
	sta	gfx_metatile, x
	inx
	ldy	#0
	lda	#metatile_1::bridge_base
	jmp	bg_scenery_render
