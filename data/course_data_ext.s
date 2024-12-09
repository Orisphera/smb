.include	"course_flags.i"

.segment	"DATA4"

.if	.defined(OG_PAD)
.if	.defined(SMB2)
	.res	8, $FF
.elseif	.defined(ANN)
	.res	183, $FF
.endif
.endif

.include	"./courses/ext/castle_1_actor.s"
.include	"./courses/ext/castle_2_actor.s"
.include	"./courses/ext/castle_3_actor.s"
.include	"./courses/ext/castle_4_actor.s"
; --------------
.include	"./courses/ext/overworld_1_actor.s"
.include	"./courses/ext/overworld_2_actor.s"
.if	.defined(SMB2)
	.include	"./courses/ext/overworld_3_actor.s"
	.include	"./courses/ext/overworld_4_actor.s"
.elseif	.defined(ANN)
	.include	"./courses/smb2/overworld_12_actor.s"
	.include	"./courses/smb2/overworld_7_actor.s"
.endif
.include	"./courses/ext/overworld_5_actor.s"
.include	"./courses/ext/overworld_6_actor.s"
.include	"./courses/ext/overworld_7_actor.s"
.if	.defined(SMB2)
	.include	"./courses/ext/overworld_8_actor.s"
.elseif	.defined(ANN)
	.include	"./courses/smb2/overworld_19_actor.s"
.endif
.include	"./courses/ext/overworld_9_actor.s"
.include	"./courses/ext/overworld_10_actor.s"
.include	"./courses/ext/overworld_11_actor.s"
.include	"./courses/ext/overworld_12_actor.s"
; --------------
.include	"./courses/ext/underground_1_actor.s"
.include	"./courses/ext/underground_2_actor.s"
; --------------
.include	"./courses/ext/water_1_actor.s"
; -----------------------------
.include	"./courses/ext/castle_1_scenery.s"
.include	"./courses/ext/castle_2_scenery.s"
.include	"./courses/ext/castle_3_scenery.s"
.include	"./courses/ext/castle_4_scenery.s"
; --------------
.include	"./courses/ext/overworld_1_scenery.s"
.include	"./courses/ext/overworld_2_scenery.s"
.if	.defined(SMB2)
	.include	"./courses/ext/overworld_3_scenery.s"
	.include	"./courses/ext/overworld_4_scenery.s"
.elseif	.defined(ANN)
	.include	"./courses/smb2/overworld_12_scenery.s"
	.include	"./courses/smb2/overworld_7_scenery.s"
.endif
.include	"./courses/ext/overworld_5_scenery.s"
.include	"./courses/ext/overworld_6_scenery.s"
.include	"./courses/ext/overworld_7_scenery.s"
.if	.defined(SMB2)
	.include	"./courses/ext/overworld_8_scenery.s"
.elseif	.defined(ANN)
	.include	"./courses/smb2/overworld_19_scenery.s"
.endif
.include	"./courses/ext/overworld_9_scenery.s"
.include	"./courses/ext/overworld_10_scenery.s"
.include	"./courses/ext/overworld_11_scenery.s"
.include	"./courses/ext/overworld_12_scenery.s"
; --------------
.include	"./courses/ext/underground_1_scenery.s"
.include	"./courses/ext/underground_2_scenery.s"
; --------------
.include	"./courses/ext/water_1_scenery.s"
