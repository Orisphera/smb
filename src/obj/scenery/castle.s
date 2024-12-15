.include	"mem.i"
.include	"misc.i"
.include	"tiles.i"

CASTLE_ROW_SIZE		= 5

scenery_castle_tiles:
	.byte	metatile_0::blank_a
	.byte	metatile_1::castle_a
	.byte	metatile_1::castle_a
	.byte	metatile_1::castle_a
	.byte	metatile_0::blank_a

	.byte	metatile_0::blank_a
	.byte	metatile_1::castle_d
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_b
	.byte	metatile_0::blank_a

	.byte	metatile_1::castle_a
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_a

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f

	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
scenery_castle_tiles_end:
; --------------
scenery_castle_tile_remain	= zp_byte_06
scenery_castle_height	= zp_byte_07

	.export	scenery_castle
scenery_castle:
	jsr	scenery_attr
	sty	scenery_castle_height
	ldy	#4
	jsr	scenery_len_b
	txa
	pha

	ldy	scenery_length, x
	ldx	scenery_castle_height
	lda	#((scenery_castle_tiles_end-scenery_castle_tiles)/CASTLE_ROW_SIZE)
	sta	scenery_castle_tile_remain
	: ; for (row of castle) {
		lda	scenery_castle_tiles, y
		sta	scenery_metatile, x

		inx
		lda	scenery_castle_tile_remain
		beq	:+ ; if (scenery_castle_tile_remain) {
			iny
			iny
			iny
			iny
			iny
			dec	scenery_castle_tile_remain
		: ; }
		cpx	#((scenery_castle_tiles_end-scenery_castle_tiles)/CASTLE_ROW_SIZE)
		bne	:--
	; }

	pla
	tax
	lda	pos_x_hi_game
	beq	:+++ ; if (pos_x_hi_game > 0) {
		lda	scenery_length, x
		cmp	#1
		beq	:++
		ldy	scenery_proc_metatile_id
		bne	:+
		cmp	#3
		beq	:++
		: cmp	#2
		bne	:++ ; if (this.length == 2) {
			jsr	scenery_pos_x_get
			pha

			jsr	scenery_alloc

			pla
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_game
			sta	pos_x_hi_actor, x
			lda	#proc_id_actors::active
			sta	pos_y_hi_actor, x
			sta	proc_id_actor, x
			lda	#144
			sta	pos_y_lo_actor, x
			lda	#actor::flag_victory
			sta	obj_id_actor, x
			rts
		: ; } else if (scenery_length == 1 || (tile_id && scenery_length != 2) || scenery_length == 3) {
			ldy	#metatile_1::brick_b
			sty	scenery_metatile+10
		; }
	: ; }

	rts
