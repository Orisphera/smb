.include	"engine/mem.i"
.include	"engine/misc.i"
.include	"engine/course_flags.i"

.include	"engine/unk.i"

.if	.defined(SMB2M)
.if	.defined(SMB2)
course_actor_overworld_28:
.endif
course_actor_overworld_10:
course_actor_overworld_21:
	.include	"../../data/courses/smb/overworld_10_actor.s"

.if	.defined(SMB2)
course_scenery_overworld_28:
	.include	"../../data/courses/smb2/overworld_28_scenery.s"
.endif

course_scenery_overworld_10:
	.include	"../../data/courses/smb/overworld_10_scenery.s"

course_scenery_overworld_21:
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
