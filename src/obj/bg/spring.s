.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

        .export bg_scenery_spring
bg_scenery_spring:
	jsr	bg_scenery_attr
	jsr	bg_obj_alloc
		.if	.defined(VS_SMB)|.defined(SMBV2)|.defined(PAL)
		bcs	:+ ; if () {
		.endif
		jsr	bg_objpos_x_get
		sta	pos_x_lo_actor, x
		lda	pos_x_hi_game
		sta	pos_x_hi_actor, x
		jsr	bg_objpos_y_get
		sta	pos_y_lo_actor, x
		sta	veloc_x_actor, x
		lda	#actor::spring
		sta	obj_id_actor, x
		ldy	#1
		sty	pos_y_hi_actor, x
		inc	proc_id_actor, x
		ldx	bg_proc_metatile_id
		lda	#metatile_1::spring_bg_a
		sta	gfx_metatile, x
		lda	#metatile_1::spring_bg_b
		sta	gfx_metatile+1, x
		.if	.defined(VS_SMB)|.defined(SMBV2)|.defined(PAL)
		: ; }
		.endif
	rts
