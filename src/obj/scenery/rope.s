.include	"tiles.i"

	.export	scenery_rope_norm, scenery_rope_plat
scenery_rope_norm:
	ldx	#0
	ldy	#$0F
	jmp	scenery_rope_draw

scenery_rope_plat:
	txa
	pha

	ldx	#1
	ldy	#$0F
	lda	#metatile_1::pulley_e
	jsr	scenery_render

	pla
	tax
	jsr	scenery_attr
	ldx	#1

scenery_rope_draw:
	lda	#metatile_1::pulley_a
	jmp	scenery_render

