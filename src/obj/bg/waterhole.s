.include	"mem.i"
.include	"tiles.i"

	.export	bg_scenery_waterhole
bg_scenery_waterhole:
	jsr	bg_scenery_len
	lda	#metatile_2::water_a
	sta	gfx_metatile+10
	ldx	#11
	ldy	#1
	lda	#metatile_2::water_b
	jmp	bg_scenery_render
