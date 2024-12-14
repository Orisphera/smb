.include	"tiles.i"

	.export	bg_scenery_rope_norm, bg_scenery_rope_plat
bg_scenery_rope_norm:
	ldx	#0
	ldy	#$0F
	jmp	bg_scenery_rope_draw

bg_scenery_rope_plat:
	txa
	pha

	ldx	#1
	ldy	#$0F
	lda	#metatile_1::pulley_e
	jsr	bg_scenery_render

	pla
	tax
	jsr	bg_scenery_attr
	ldx	#1

bg_scenery_rope_draw:
	lda	#metatile_1::pulley_a
	jmp	bg_scenery_render

