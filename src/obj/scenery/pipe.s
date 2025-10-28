.include	"mem.i"
.include	"mem_low.i"
.include	"tiles.i"
.include	"const.i"

	.export	scenery_pipe_water
scenery_pipe_water:
	jsr	scenery_attr
	ldy	scenery_length, x
	ldx	scenery_proc_metatile_id
	lda	#metatile_1::pipe_water_a
	sta	scenery_metatile+0, x
	lda	#metatile_1::pipe_water_b
	sta	scenery_metatile+1, x
	rts
; ----------------------------------
BG_SCENERY_PIPE_SIZE	= 7

scenery_pipe_horiz_len	= zp_byte_05

	.export	scenery_pipe_intro
scenery_pipe_intro:
	ldy	#3
	jsr	scenery_len_b
	ldy	#10
	jsr	scenery_pipe_horiz
	bcs	:++ ; if (!scenery_pipe_horiz()) {
		ldx	#BG_SCENERY_PIPE_SIZE-1
		: ; for (tile of scenery_pipe) {
			lda	#metatile_0::blank_a
			sta	scenery_metatile, x

			dex
			bpl	:-
		; }

		lda	scenery_pipe_v_tiles, y
		sta	scenery_metatile+BG_SCENERY_PIPE_SIZE
	: ; }

	rts
; ----------------
scenery_pipe_horiz_m:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_v_e
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
scenery_pipe_horiz_t:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_h_c
	.byte	metatile_0::pipe_h_b
	.byte	metatile_0::pipe_h_a
scenery_pipe_horiz_b:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_h_f
	.byte	metatile_0::pipe_h_e
	.byte	metatile_0::pipe_h_d
; ----------------
scenery_pipe_length	= zp_byte_06

	.export	scenery_pipe_exit
scenery_pipe_exit:
	ldy	#3
	jsr	scenery_len_b
	jsr	scenery_attr

scenery_pipe_horiz:
	dey
	dey
	sty	scenery_pipe_horiz_len
	ldy	scenery_length, x
	sty	scenery_pipe_length
	ldx	scenery_pipe_horiz_len
	inx
	lda	scenery_pipe_horiz_m, y
	cmp	#0
	beq	:+ ; if (bg_reaobj_pipe_horiz_m[scenery_length]) {
		ldx	#0
		ldy	scenery_pipe_horiz_len
		jsr	scenery_render
		clc
	: ; }

	ldy	scenery_pipe_length
	lda	scenery_pipe_horiz_t, y
	sta	scenery_metatile, x
	lda	scenery_pipe_horiz_b, y
	sta	scenery_metatile+1, x
	rts
; ----------------
	.export	scenery_pipe_v_tiles
scenery_pipe_v_tiles:
	.byte	metatile_0::pipe_v_b, metatile_0::pipe_v_a
	.byte	metatile_0::pipe_v_f, metatile_0::pipe_v_e
	.byte	metatile_0::pipe_v_d, metatile_0::pipe_v_c
	.byte	metatile_0::pipe_v_f, metatile_0::pipe_v_e
; ----------------
	.export	scenery_pipe_vert
scenery_pipe_vert:
	jsr	scenery_pipe_h
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
	jsr	scenery_alloc
	bcs	:+ ; if ((course_sub|course_no) && this.length > 0 && !this.alloc()) {
		.if	.defined(SMBV1)
			jsr	scenery_pos_x_get
			clc
			adc	#8
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_game
			adc	#0
			sta	pos_x_hi_actor, x
			lda	#proc_id_actors::active
			sta	pos_y_hi_actor, x
			sta	proc_id_actor, x
			jsr	scenery_pos_y_get
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
			jsr	scenery_pipe_vert_plant
		.endif
	: ; }

	pla
	tay
	ldx	scenery_proc_metatile_id
	lda	scenery_pipe_v_tiles, y
	sta	scenery_metatile, x
	inx
	lda	scenery_pipe_v_tiles+2, y
	ldy	scenery_pipe_length
	dey
	jmp	scenery_render
; ----------------
	.export	scenery_pipe_h
scenery_pipe_h:
	ldy	#1
	jsr	scenery_len_b
	jsr	scenery_attr
	tya
	and	#%00000111
	sta	scenery_pipe_length
	ldy	scenery_length, x
	rts
; ----------------
.if	.defined(SMBV2)
	.export	scenery_pipe_vert_plant
scenery_pipe_vert_plant:
	sta	obj_id_actor, x
	jsr	scenery_pos_x_get
	clc
	adc	#8
	sta	pos_x_lo_actor, x
	lda	pos_x_hi_game
	adc	#0
	sta	pos_x_hi_actor, x
	lda	#proc_id_actors::active
	sta	pos_y_hi_actor, x
	sta	proc_id_actor, x
	jsr	scenery_pos_y_get
	sta	pos_y_lo_actor, x
	jmp	actor_init_piranha_plant
.endif
