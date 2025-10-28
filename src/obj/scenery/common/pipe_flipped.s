.include	"mem.i"
.include	"misc.i"

; ----------------------------------------------------------------------
PIRANHA_HEIGHT		= 24
PIRANHA_PIPE_OFFSET	= 10

scenery_pipe_v_flip_len	= zp_byte_06
scenery_pipe_v_flip_pos_y	= zp_byte_07

.if	.definedmacro(PIPE_FLIPPED_BASE)
	.export	scenery_pipe_v_flip_a, scenery_pipe_v_flip_b
.endif
scenery_pipe_v_flip_a:
	lda	#1
	pha

	bne	:+

scenery_pipe_v_flip_b:
	lda	#4
	pha
; ----------------
	: jsr	scenery_pipe_h

	pla
	sta	scenery_pipe_v_flip_pos_y
	tya
	pha

	ldy	scenery_length, x
	beq	:+
	jsr	scenery_alloc
	bcs	:+ ; if (this.length != 0 && this.alloc()) {
		lda	#actor::piranha_plant_b
		jsr	scenery_pipe_vert_plant
		lda	scenery_pipe_v_flip_len
		asl	a
		asl	a
		asl	a
		asl	a
		clc
		adc	pos_y_lo_actor, x
		sec
		sbc	#PIRANHA_PIPE_OFFSET
		sta	pos_y_lo_actor, x
		sta	pos_y_top_piranha, x
		clc
		adc	#PIRANHA_HEIGHT
		sta	pos_y_bottom_piranha, x
		inc	neg_y_piranha, x
	: ; }

	pla
	tay
	pha

	ldx	scenery_pipe_v_flip_pos_y
	lda	scenery_pipe_v_tiles+2, y
	ldy	scenery_pipe_v_flip_len
	dey
	jsr	scenery_render

	pla
	tay
	lda	scenery_pipe_v_tiles, y
	sta	scenery_metatile, x
	rts
; ----------------------------------------------------------------------
	rts
