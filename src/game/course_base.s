.include	"mem.i"
.include	"misc.i"
.include	"course_flags.i"

.if	.defined(OG_PAD)
.if	.defined(VS)
	.res	55, $FF
.elseif	.defined(SMB2)
	.res	2, $FF
.endif
.endif

.if	.defined(SMB2M)
	.include	"../../data/courses/smb/overworld_10_actor.s"

.if	.defined(SMB2)
	.include	"../../data/courses/smb2/overworld_28_scenery.s"
.endif

	.macro	OVERWORLD_10_SCENERY_A
		1
	.endmacro
	.include	"../../data/courses/smb/overworld_10_scenery.s"
	.delmac	OVERWORLD_10_SCENERY_A	

.if	.defined(SMB2)
	.include	"../../data/courses/smb2/overworld_21_scenery.s"
.elseif	.defined(ANN)
	.include	"../../data/courses/smb2/overworld_28_scenery.s"
.endif

.endif
; -----------------------------------------------------------
	.export	course_descriptor_load, course_type_get
course_descriptor_load:
	jsr	course_descriptor_get
	sta	course_descriptor
; -----------------------------
course_type_get:
	and	#(course_types::MAX<<COURSE_DESC_TYPE_BIT)
	asl	a
	rol	a
	rol	a
	rol	a
	sta	course_type
	rts
; -----------------------------------------------------------
