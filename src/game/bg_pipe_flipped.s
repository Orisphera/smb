.include	"mem.i"
.include	"misc.i"

.segment	"DATA2"

; ------------------------------------------------------------
bg_scenery_pipe_v_flip_len	= zp_byte_06
bg_scenery_pipe_v_flip_pos_y	= zp_byte_07

	.export	bg_scenery_pipe_v_flip_a, bg_scenery_pipe_v_flip_b
bg_scenery_pipe_v_flip_a:
	lda	#1
	pha

	bne	:+

bg_scenery_pipe_v_flip_b:
	lda	#4
	pha
; --------------
	: jsr	bg_scenery_pipe_h

	pla
	sta	bg_scenery_pipe_v_flip_pos_y
	tya
	pha

	ldy	scenery_length, x
	beq	:+ ; if (this.length > 0) {
		jsr	bg_obj_alloc
		bcs	:+ ; if () {
			lda	#actor::piranha_plant_b
			jsr	bg_scenery_pipe_vert_plant
			lda	bg_scenery_pipe_v_flip_len
			asl	a
			asl	a
			asl	a
			asl	a
			clc
			adc	pos_y_lo_actor, x
			sec
			sbc	#10
			sta	pos_y_lo_actor, x
			sta	accel_y_actor_c, x
			clc
			adc	#24
			sta	pos_y_actor, x
			inc	veloc_y_actor, x
		; }
	: ; }

	pla
	tay
	pha

	ldx	bg_scenery_pipe_v_flip_pos_y
	lda	bg_scenery_pipe_v_tiles+2, y
	ldy	bg_scenery_pipe_v_flip_len
	dey
	jsr	bg_scenery_render

	pla
	tay
	lda	bg_scenery_pipe_v_tiles, y
	sta	gfx_metatile, x
	rts
; ------------------------------------------------------------
	rts
