.include	"engine/course_flags.i"

.if	.defined(VS)
	.segment	"CHR1DATA"
.endif

.if	.defined(SMB)
	.include	"./courses/smb/castle_1_actor.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/castle_1_actor.s"
.endif
	.include	"./courses/smb/castle_2_actor.s"
.if	.defined(SMB)
	.include	"./courses/smb/castle_3_actor.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/smb/castle_1_actor.s"
.endif
	.include	"./courses/smb/castle_4_actor.s"
	.include	"./courses/smb/castle_5_actor.s"
	.include	"./courses/smb/castle_6_actor.s"

.if	.defined(VS_SMB)
	.include	"./courses/vs/castle_7_actor.s"
	.include	"./courses/smb/castle_3_actor.s"
.endif
; --------------
	.include	"./courses/smb/overworld_1_actor.s"
	.include	"./courses/smb/overworld_2_actor.s"
	.include	"./courses/smb/overworld_3_actor.s"
	.include	"./courses/smb/overworld_4_actor.s"
	.include	"./courses/smb/overworld_5_actor.s"
	.include	"./courses/smb/overworld_6_actor.s"
.if	.defined(SMB)
	.include	"./courses/smb/overworld_7_actor.s"
	.include	"./courses/smb/overworld_8_actor.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/overworld_7_actor.s"
	.include	"./courses/vs/overworld_8_actor.s"
.endif
	.include	"./courses/smb/overworld_9_actor.s"
	.include	"./courses/smb/overworld_10_actor.s"
	.include	"./courses/smb/overworld_11_actor.s"
	.include	"./courses/smb/overworld_12_actor.s"
	.include	"./courses/smb/overworld_13_actor.s"
	.include	"./courses/smb/overworld_14_actor.s"
	.include	"./courses/smb/overworld_15_actor.s"
	.include	"./courses/smb/overworld_16_actor.s"
	.include	"./courses/smb/overworld_17_actor.s"
	.include	"./courses/smb/overworld_18_actor.s"
	.include	"./courses/smb/overworld_19_actor.s"
	.include	"./courses/smb/overworld_20_actor.s"
	.include	"./courses/smb/overworld_21_actor.s"
.if	.defined(SMB)
	.include	"./courses/smb/overworld_22_actor.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/overworld_22_actor.s"
.endif

.if	.defined(VS_SMB)
	.include	"./courses/smb/overworld_7_actor.s"
	.include	"./courses/smb/overworld_8_actor.s"
.endif
; --------------
	.include	"./courses/smb/underground_1_actor.s"
	.include	"./courses/smb/underground_2_actor.s"
	.include	"./courses/smb/underground_3_actor.s"
; --------------
	.include	"./courses/smb/water_1_actor.s"
.if	.defined(SMB)
	.include	"./courses/smb/water_2_actor.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/water_2_actor.s"
.endif
	.include	"./courses/smb/water_3_actor.s"

.if	.defined(VS_SMB)
	.include	"./courses/smb/water_2_actor.s"
.endif
; ------------------------------
.if	.defined(SMB)
	.include	"./courses/smb/castle_1_scenery.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/castle_1_scenery.s"
.endif
	.include	"./courses/smb/castle_2_scenery.s"
.if	.defined(SMB)
	.include	"./courses/smb/castle_3_scenery.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/smb/castle_1_scenery.s"
.endif
	.include	"./courses/smb/castle_4_scenery.s"
	.include	"./courses/smb/castle_5_scenery.s"
	.include	"./courses/smb/castle_6_scenery.s"

.if	.defined(VS_SMB)
	.include	"./courses/vs/castle_7_scenery.s"
	.include	"./courses/smb/castle_3_scenery.s"
.endif
; --------------
	.include	"./courses/smb/overworld_1_scenery.s"
	.include	"./courses/smb/overworld_2_scenery.s"
	.include	"./courses/smb/overworld_3_scenery.s"
	.include	"./courses/smb/overworld_4_scenery.s"
	.include	"./courses/smb/overworld_5_scenery.s"
	.include	"./courses/smb/overworld_6_scenery.s"
.if	.defined(SMB)
	.include	"./courses/smb/overworld_7_scenery.s"
	.include	"./courses/smb/overworld_8_scenery.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/overworld_7_scenery.s"
	.include	"./courses/vs/overworld_8_scenery.s"
.endif
	.include	"./courses/smb/overworld_9_scenery.s"
	.include	"./courses/smb/overworld_10_scenery.s"
	.include	"./courses/smb/overworld_11_scenery.s"
	.include	"./courses/smb/overworld_12_scenery.s"
	.include	"./courses/smb/overworld_13_scenery.s"
	.include	"./courses/smb/overworld_14_scenery.s"
	.include	"./courses/smb/overworld_15_scenery.s"
	.include	"./courses/smb/overworld_16_scenery.s"

.if	.defined(VS_SMB)
	.res	4, $EA
.endif

	.include	"./courses/smb/overworld_17_scenery.s"
	.include	"./courses/smb/overworld_18_scenery.s"
	.include	"./courses/smb/overworld_19_scenery.s"
	.include	"./courses/smb/overworld_20_scenery.s"
	.include	"./courses/smb/overworld_21_scenery.s"
.if	.defined(SMB)
	.include	"./courses/smb/overworld_22_scenery.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/overworld_22_scenery.s"
.endif

.if	.defined(VS_SMB)
	.include	"./courses/smb/overworld_7_scenery.s"
	.include	"./courses/smb/overworld_8_scenery.s"
.endif
; --------------
	.include	"./courses/smb/underground_1_scenery.s"
	.include	"./courses/smb/underground_2_scenery.s"
	.include	"./courses/smb/underground_3_scenery.s"
; --------------
	.include	"./courses/smb/water_1_scenery.s"
.if	.defined(SMB)
	.include	"./courses/smb/water_2_scenery.s"
.elseif	.defined(VS_SMB)
	.include	"./courses/vs/water_2_scenery.s"
.endif
	.include	"./courses/smb/water_3_scenery.s"

.if	.defined(VS_SMB)
	.include	"./courses/smb/water_2_scenery.s"
.endif
; ------------------------------
.if	.defined(SMB)
	.res	1, $FF
.elseif	.defined(VS_SMB)
	.res	836, $FF
.endif
