.include	"mem.i"
.include	"tiles.i"
.include	"tunables.i"

	.export	bg_scenery_pipe_water
bg_scenery_pipe_water:
	jsr	bg_scenery_attr
	ldy	scenery_length, x
	ldx	bg_proc_metatile_id
	lda	#metatile_1::pipe_water_a
	sta	gfx_metatile+0, x
	lda	#metatile_1::pipe_water_b
	sta	gfx_metatile+1, x
	rts
; -----------------------------
BG_SCENERY_PIPE_SIZE	= 7

bg_scenery_pipe_horiz_len	= zp_byte_05

	.export	bg_scenery_pipe_intro
bg_scenery_pipe_intro:
	ldy	#3
	jsr	bg_scenery_len_b
	ldy	#10
	jsr	bg_scenery_pipe_horiz
	bcs	:++ ; if (!bg_scenery_pipe_horiz()) {
		ldx	#BG_SCENERY_PIPE_SIZE-1
		: ; for (tile of bg_scenery_pipe) {
			lda	#metatile_0::blank_a
			sta	gfx_metatile, x

			dex
			bpl	:-
		; }

		lda	bg_scenery_pipe_v_tiles, y
		sta	gfx_metatile+BG_SCENERY_PIPE_SIZE
	: ; }

	rts
; --------------
bg_scenery_pipe_horiz_m:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_v_e
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
bg_scenery_pipe_horiz_t:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_h_c
	.byte	metatile_0::pipe_h_b
	.byte	metatile_0::pipe_h_a
bg_scenery_pipe_horiz_b:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_h_f
	.byte	metatile_0::pipe_h_e
	.byte	metatile_0::pipe_h_d
; --------------
bg_scenery_pipe_length	= zp_byte_06

	.export	bg_scenery_pipe_exit
bg_scenery_pipe_exit:
	ldy	#3
	jsr	bg_scenery_len_b
	jsr	bg_scenery_attr

bg_scenery_pipe_horiz:
	dey
	dey
	sty	bg_scenery_pipe_horiz_len
	ldy	scenery_length, x
	sty	bg_scenery_pipe_length
	ldx	bg_scenery_pipe_horiz_len
	inx
	lda	bg_scenery_pipe_horiz_m, y
	cmp	#0
	beq	:+ ; if (bg_reaobj_pipe_horiz_m[scenery_length]) {
		ldx	#0
		ldy	bg_scenery_pipe_horiz_len
		jsr	bg_scenery_render
		clc
	: ; }

	ldy	bg_scenery_pipe_length
	lda	bg_scenery_pipe_horiz_t, y
	sta	gfx_metatile, x
	lda	bg_scenery_pipe_horiz_b, y
	sta	gfx_metatile+1, x
	rts
; --------------
	.export	bg_scenery_pipe_v_tiles
bg_scenery_pipe_v_tiles:
	.byte	metatile_0::pipe_v_b, metatile_0::pipe_v_a
	.byte	metatile_0::pipe_v_f, metatile_0::pipe_v_e
	.byte	metatile_0::pipe_v_d, metatile_0::pipe_v_c
	.byte	metatile_0::pipe_v_f, metatile_0::pipe_v_e
; --------------
	.export	bg_scenery_pipe_vert
bg_scenery_pipe_vert:
	jsr	bg_scenery_pipe_h
	lda	zp_byte_00
	beq	:+ ; if (zp_byte_00) {
		iny
		iny
		iny
		iny
	: ; }
	tya
	pha

	.if	.defined(SMBV1)
		lda	course_sub
		ora	course_no
		beq	:+
	.endif

	ldy	scenery_length, x
	beq	:+
	jsr	bg_obj_alloc
	bcs	:+ ; if ((course_sub|course_no) && scenery_length && !bg_obj_alloc()) {
		.if	.defined(SMBV1)
			jsr	bg_objpos_x_get
			clc
			adc	#8
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_game
			adc	#0
			sta	pos_x_hi_actor, x
			lda	#proc_id_actors::active
			sta	pos_y_hi_actor, x
			sta	proc_id_actor, x
			jsr	bg_objpos_y_get
			sta	pos_y_lo_actor, x
		.elseif	.defined(ANN)
			lda	course_no
			ora	course_sub
			ora	ENG_HARDMODE_VAR
			beq	:+
		.endif

		lda	#actor::piranha_plant

		.if	.defined(SMBV1)
			sta	obj_id_actor, x
			jsr	actor_init_piranha_plant
		.elseif	.defined(SMBV2)
			jsr	bg_scenery_pipe_vert_plant
		.endif
	: ; }

	pla
	tay
	ldx	bg_proc_metatile_id
	lda	bg_scenery_pipe_v_tiles, y
	sta	gfx_metatile, x
	inx
	lda	bg_scenery_pipe_v_tiles+2, y
	ldy	bg_scenery_pipe_length
	dey
	jmp	bg_scenery_render
; --------------
	.export	bg_scenery_pipe_h
bg_scenery_pipe_h:
	ldy	#1
	jsr	bg_scenery_len_b
	jsr	bg_scenery_attr
	tya
	and	#%00000111
	sta	bg_scenery_pipe_length
	ldy	scenery_length, x
	rts
; -------------
.if	.defined(SMBV2)
	.export	bg_scenery_pipe_vert_plant
bg_scenery_pipe_vert_plant:
	sta	obj_id_actor, x
	jsr	bg_objpos_x_get
	clc
	adc	#8
	sta	pos_x_lo_actor, x
	lda	pos_x_hi_game
	adc	#0
	sta	pos_x_hi_actor, x
	lda	#proc_id_actors::active
	sta	pos_y_hi_actor, x
	sta	proc_id_actor, x
	jsr	bg_objpos_y_get
	sta	pos_y_lo_actor, x
	jmp	actor_init_piranha_plant
.endif
