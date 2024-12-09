.include	"course_flags.i"

.segment	"DATA2"

.if	.defined(OG_PAD)
	.res	183, $FF
.endif

	.include	"./courses/smb2/castle_4_actor.s"
	.include	"./courses/smb2/castle_2_actor.s"
	.include	"./courses/smb/castle_5_actor.s"
	.include	"./courses/smb2/castle_8_actor.s"
; --------------
	.include	"./courses/smb/overworld_2_actor.s"
	.include	"./courses/smb/overworld_4_actor.s"
	.include	"./courses/vs/overworld_7_actor.s"
	.include	"./courses/vs/overworld_8_actor.s"
	.include	"./courses/smb/overworld_11_actor.s"
	.include	"./courses/ann/overworld_26_actor.s"
	.include	"./courses/smb/overworld_14_actor.s"
	.include	"./courses/smb/overworld_15_actor.s"
	.include	"./courses/smb/overworld_17_actor.s"
	.include	"./courses/smb/overworld_18_actor.s"
	.include	"./courses/smb/overworld_19_actor.s"
	.include	"./courses/smb/overworld_20_actor.s"
	.include	"./courses/ann/overworld_27_actor.s"
; --------------
	.include	"./courses/ann/underground_4_actor.s"
; --------------
	.include	"./courses/smb/water_1_actor.s"
	.include	"./courses/vs/water_2_actor.s"
	.include	"./courses/smb2/water_4_actor.s"
; ------------------------------
	.include	"./courses/smb2/castle_4_scenery.s"
	.include	"./courses/smb2/castle_2_scenery.s"
	.include	"./courses/smb/castle_5_scenery.s"
	.include	"./courses/smb2/castle_8_scenery.s"
; --------------
	.include	"./courses/smb/overworld_2_scenery.s"
	.include	"./courses/smb/overworld_4_scenery.s"
	.include	"./courses/vs/overworld_7_scenery.s"
	.include	"./courses/vs/overworld_8_scenery.s"
	.include	"./courses/smb/overworld_11_scenery.s"
	.include	"./courses/ann/overworld_26_scenery.s"
	.include	"./courses/smb/overworld_14_scenery.s"
	.include	"./courses/smb/overworld_15_scenery.s"
	.include	"./courses/smb/overworld_17_scenery.s"
	.include	"./courses/smb/overworld_18_scenery.s"
	.include	"./courses/smb/overworld_19_scenery.s"
	.include	"./courses/smb/overworld_20_scenery.s"
	.include	"./courses/ann/overworld_27_scenery.s"
; --------------
	.include	"./courses/ann/underground_4_scenery.s"
; --------------
	.include	"./courses/smb/water_1_scenery.s"
	.include	"./courses/vs/water_2_scenery.s"
	.include	"./courses/smb2/water_4_scenery.s"
