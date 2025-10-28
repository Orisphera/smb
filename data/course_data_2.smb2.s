.include	"course_flags.i"

.segment	"DATA2"

.if	.defined(OG_PAD)
	.res	8, $FF
.endif

	.include	"./courses/vs/castle_1_actor.s"
	.include	"./courses/smb2/castle_6_actor.s"
	.include	"./courses/smb2/castle_7_actor.s"
	.include	"./courses/smb2/castle_8_actor.s"
; ----------------
	.include	"./courses/smb2/overworld_12_actor.s"
	.include	"./courses/smb2/overworld_13_actor.s"
	.include	"./courses/smb2/overworld_14_actor.s"
	.include	"./courses/vs/overworld_8_actor.s"
	.include	"./courses/smb2/overworld_16_actor.s"
	.include	"./courses/smb2/overworld_17_actor.s"
	.include	"./courses/smb2/overworld_18_actor.s"
	.include	"./courses/smb2/overworld_19_actor.s"
	.include	"./courses/smb2/overworld_22_actor.s"
	.include	"./courses/smb2/overworld_23_actor.s"
	.include	"./courses/smb2/overworld_29_actor.s"
; ----------------
	.include	"./courses/smb2/underground_4_actor.s"
	.include	"./courses/smb2/underground_5_actor.s"
; ----------------
	.include	"./courses/vs/water_2_actor.s"
	.include	"./courses/smb2/water_4_actor.s"
	.include	"./courses/smb2/water_5_actor.s"
; ----------------------------------
	.include	"./courses/vs/castle_1_scenery.s"
	.include	"./courses/smb2/castle_6_scenery.s"
	.include	"./courses/smb2/castle_7_scenery.s"
	.include	"./courses/smb2/castle_8_scenery.s"
; ----------------
	.include	"./courses/smb2/overworld_12_scenery.s"
	.include	"./courses/smb2/overworld_13_scenery.s"
	.include	"./courses/smb2/overworld_14_scenery.s"
	.include	"./courses/vs/overworld_8_scenery.s"
	.include	"./courses/smb2/overworld_16_scenery.s"
	.include	"./courses/smb2/overworld_17_scenery.s"
	.include	"./courses/smb2/overworld_18_scenery.s"
	.include	"./courses/smb2/overworld_19_scenery.s"
	.include	"./courses/smb2/overworld_22_scenery.s"
	.include	"./courses/smb2/overworld_23_scenery.s"
	.include	"./courses/smb2/overworld_29_scenery.s"
; ----------------
	.include	"./courses/smb2/underground_4_scenery.s"
	.include	"./courses/smb2/underground_5_scenery.s"
; ----------------
	.include	"./courses/vs/water_2_scenery.s"
	.include	"./courses/smb2/water_4_scenery.s"
	.include	"./courses/smb2/water_5_scenery.s"
