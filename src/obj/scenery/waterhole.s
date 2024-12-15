.include	"mem.i"
.include	"tiles.i"

	.export	scenery_waterhole
scenery_waterhole:
	jsr	scenery_len
	lda	#metatile_2::water_a
	sta	scenery_metatile+10
	ldx	#11
	ldy	#1
	lda	#metatile_2::water_b
	jmp	scenery_render
