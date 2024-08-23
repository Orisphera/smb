.include	"engine/course_flags.i"

.if	.defined(VS)
	.segment	"COURSEDATA"
.endif

	.export	courses_actor_castle_1, courses_actor_castle_2
	.export courses_actor_castle_3, courses_actor_castle_4
	.export courses_actor_castle_5, courses_actor_castle_6
.if	.defined(VS_SMB)
	.export courses_actor_castle_7, courses_actor_castle_8
.endif
courses_actor_castle_1:
	.if	.defined(SMB)
		.include	"./courses/smb/castle_1_actor.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/castle_1_actor.s"
	.endif

courses_actor_castle_2:
	.include	"./courses/smb/castle_2_actor.s"

courses_actor_castle_3:
	.if	.defined(SMB)
		.include	"./courses/smb/castle_3_actor.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/smb/castle_1_actor.s"
	.endif

courses_actor_castle_4:
	.include	"./courses/smb/castle_4_actor.s"

courses_actor_castle_5:
	.include	"./courses/smb/castle_5_actor.s"

courses_actor_castle_6:
	.include	"./courses/smb/castle_6_actor.s"

.if	.defined(VS_SMB)
courses_actor_castle_7:
	.include	"./courses/vs/castle_7_actor.s"

courses_actor_castle_8:
	.include	"./courses/smb/castle_3_actor.s"
.endif

	.export courses_actor_overworld_1, courses_actor_overworld_2
	.export courses_actor_overworld_3, courses_actor_overworld_4
	.export courses_actor_overworld_5, courses_actor_overworld_6
	.export courses_actor_overworld_7, courses_actor_overworld_8
	.export courses_actor_overworld_9, courses_actor_overworld_10
	.export courses_actor_overworld_11, courses_actor_overworld_12
	.export courses_actor_overworld_13, courses_actor_overworld_14
	.export courses_actor_overworld_15, courses_actor_overworld_16
	.export courses_actor_overworld_17, courses_actor_overworld_18
	.export courses_actor_overworld_19, courses_actor_overworld_20
	.export courses_actor_overworld_21, courses_actor_overworld_22
.if	.defined(VS_SMB)
	.export courses_actor_overworld_23, courses_actor_overworld_24
.endif
courses_actor_overworld_1:
	.include	"./courses/smb/overworld_1_actor.s"

courses_actor_overworld_2:
	.include	"./courses/smb/overworld_2_actor.s"

courses_actor_overworld_3:
	.include	"./courses/smb/overworld_3_actor.s"

courses_actor_overworld_4:
	.include	"./courses/smb/overworld_4_actor.s"

courses_actor_overworld_5:
	.include	"./courses/smb/overworld_5_actor.s"

courses_actor_overworld_6:
	.include	"./courses/smb/overworld_6_actor.s"

courses_actor_overworld_7:
	.if	.defined(SMB)
		.include	"./courses/smb/overworld_7_actor.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/overworld_7_actor.s"
	.endif

courses_actor_overworld_8:
	.if	.defined(SMB)
		.include	"./courses/smb/overworld_8_actor.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/overworld_8_actor.s"
	.endif

courses_actor_overworld_9:
	.include	"./courses/smb/overworld_9_actor.s"

courses_actor_overworld_10:
	.include	"./courses/smb/overworld_10_actor.s"

courses_actor_overworld_11:
	.include	"./courses/smb/overworld_11_actor.s"

courses_actor_overworld_12:
	.include	"./courses/smb/overworld_12_actor.s"

courses_actor_overworld_13:
	.include	"./courses/smb/overworld_13_actor.s"

courses_actor_overworld_14:
	.include	"./courses/smb/overworld_14_actor.s"

courses_actor_overworld_15:
	.include	"./courses/smb/overworld_15_actor.s"

courses_actor_overworld_16:
	.include	"./courses/smb/overworld_16_actor.s"

courses_actor_overworld_17:
	.include	"./courses/smb/overworld_17_actor.s"

courses_actor_overworld_18:
	.include	"./courses/smb/overworld_18_actor.s"

courses_actor_overworld_19:
	.include	"./courses/smb/overworld_19_actor.s"

courses_actor_overworld_20:
	.include	"./courses/smb/overworld_20_actor.s"

courses_actor_overworld_21:
	.include	"./courses/smb/overworld_21_actor.s"

courses_actor_overworld_22:
	.if	.defined(SMB)
		.include	"./courses/smb/overworld_22_actor.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/overworld_22_actor.s"
	.endif

.if	.defined(VS_SMB)
courses_actor_overworld_23:
	.include	"./courses/smb/overworld_7_actor.s"

courses_actor_overworld_24:
	.include	"./courses/smb/overworld_8_actor.s"
.endif

	.export	courses_actor_underground_1
	.export courses_actor_underground_2
	.export courses_actor_underground_3
courses_actor_underground_1:
	.include	"./courses/smb/underground_1_actor.s"

courses_actor_underground_2:
	.include	"./courses/smb/underground_2_actor.s"

courses_actor_underground_3:
	.include	"./courses/smb/underground_3_actor.s"

	.export courses_actor_water_1
	.export courses_actor_water_2
	.export courses_actor_water_3
.if	.defined(VS_SMB)
	.export courses_actor_water_4
.endif
courses_actor_water_1:
	.include	"./courses/smb/water_1_actor.s"

courses_actor_water_2:
	.if	.defined(SMB)
		.include	"./courses/smb/water_2_actor.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/water_2_actor.s"
	.endif

courses_actor_water_3:
	.include	"./courses/smb/water_3_actor.s"

.if	.defined(VS_SMB)
courses_actor_water_4:
	.include	"./courses/smb/water_2_actor.s"
.endif
; ------------------------------
	.export	courses_scenery_castle_1, courses_scenery_castle_2
	.export courses_scenery_castle_3, courses_scenery_castle_4
	.export courses_scenery_castle_5, courses_scenery_castle_6
.if	.defined(VS_SMB)
	.export courses_scenery_castle_7, courses_scenery_castle_8
.endif
courses_scenery_castle_1:
	.if	.defined(SMB)
		.include	"./courses/smb/castle_1_scenery.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/castle_1_scenery.s"
	.endif

courses_scenery_castle_2:
	.include	"./courses/smb/castle_2_scenery.s"

courses_scenery_castle_3:
	.if	.defined(SMB)
		.include	"./courses/smb/castle_3_scenery.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/smb/castle_1_scenery.s"
	.endif

courses_scenery_castle_4:
	.include	"./courses/smb/castle_4_scenery.s"

courses_scenery_castle_5:
	.include	"./courses/smb/castle_5_scenery.s"

courses_scenery_castle_6:
	.include	"./courses/smb/castle_6_scenery.s"

.if	.defined(VS_SMB)
courses_scenery_castle_7:
	.include	"./courses/vs/castle_7_scenery.s"

courses_scenery_castle_8:
	.include	"./courses/smb/castle_3_scenery.s"
.endif

	.export courses_scenery_overworld_1, courses_scenery_overworld_2
	.export courses_scenery_overworld_3, courses_scenery_overworld_4
	.export courses_scenery_overworld_5, courses_scenery_overworld_6
	.export courses_scenery_overworld_7, courses_scenery_overworld_8
	.export courses_scenery_overworld_9, courses_scenery_overworld_10
	.export courses_scenery_overworld_11, courses_scenery_overworld_12
	.export courses_scenery_overworld_13, courses_scenery_overworld_14
	.export courses_scenery_overworld_15, courses_scenery_overworld_16
	.export courses_scenery_overworld_17, courses_scenery_overworld_18
	.export courses_scenery_overworld_19, courses_scenery_overworld_20
	.export courses_scenery_overworld_21, courses_scenery_overworld_22
.if	.defined(VS_SMB)
	.export courses_scenery_overworld_23, courses_scenery_overworld_24
.endif
courses_scenery_overworld_1:
	.include	"./courses/smb/overworld_1_scenery.s"

courses_scenery_overworld_2:
	.include	"./courses/smb/overworld_2_scenery.s"

courses_scenery_overworld_3:
	.include	"./courses/smb/overworld_3_scenery.s"

courses_scenery_overworld_4:
	.include	"./courses/smb/overworld_4_scenery.s"

courses_scenery_overworld_5:
	.include	"./courses/smb/overworld_5_scenery.s"

courses_scenery_overworld_6:
	.include	"./courses/smb/overworld_6_scenery.s"

courses_scenery_overworld_7:
	.if	.defined(SMB)
		.include	"./courses/smb/overworld_7_scenery.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/overworld_7_scenery.s"
	.endif

courses_scenery_overworld_8:
	.if	.defined(SMB)
		.include	"./courses/smb/overworld_8_scenery.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/overworld_8_scenery.s"
	.endif

courses_scenery_overworld_9:
	.include	"./courses/smb/overworld_9_scenery.s"

courses_scenery_overworld_10:
	.include	"./courses/smb/overworld_10_scenery.s"

courses_scenery_overworld_11:
	.include	"./courses/smb/overworld_11_scenery.s"

courses_scenery_overworld_12:
	.include	"./courses/smb/overworld_12_scenery.s"

courses_scenery_overworld_13:
	.include	"./courses/smb/overworld_13_scenery.s"

courses_scenery_overworld_14:
	.include	"./courses/smb/overworld_14_scenery.s"

courses_scenery_overworld_15:
	.include	"./courses/smb/overworld_15_scenery.s"

courses_scenery_overworld_16:
	.include	"./courses/smb/overworld_16_scenery.s"

.if	.defined(VS_SMB)
	.res	4, $EA
.endif

courses_scenery_overworld_17:
	.include	"./courses/smb/overworld_17_scenery.s"

courses_scenery_overworld_18:
	.include	"./courses/smb/overworld_18_scenery.s"

courses_scenery_overworld_19:
	.include	"./courses/smb/overworld_19_scenery.s"

courses_scenery_overworld_20:
	.include	"./courses/smb/overworld_20_scenery.s"

courses_scenery_overworld_21:
	.include	"./courses/smb/overworld_21_scenery.s"

courses_scenery_overworld_22:
	.if	.defined(SMB)
		.include	"./courses/smb/overworld_22_scenery.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/overworld_22_scenery.s"
	.endif

.if	.defined(VS_SMB)
courses_scenery_overworld_23:
	.include	"./courses/smb/overworld_7_scenery.s"

courses_scenery_overworld_24:
	.include	"./courses/smb/overworld_8_scenery.s"
.endif

	.export courses_scenery_underground_1
	.export courses_scenery_underground_2
	.export courses_scenery_underground_3
courses_scenery_underground_1:
	.include	"./courses/smb/underground_1_scenery.s"

courses_scenery_underground_2:
	.include	"./courses/smb/underground_2_scenery.s"

courses_scenery_underground_3:
	.include	"./courses/smb/underground_3_scenery.s"

	.export courses_scenery_water_1
	.export courses_scenery_water_2
	.export courses_scenery_water_3
.if	.defined(VS_SMB)
	.export courses_scenery_water_4
.endif
courses_scenery_water_1:
	.include	"./courses/smb/water_1_scenery.s"

courses_scenery_water_2:
	.if	.defined(SMB)
		.include	"./courses/smb/water_2_scenery.s"
	.elseif	.defined(VS_SMB)
		.include	"./courses/vs/water_2_scenery.s"
	.endif

courses_scenery_water_3:
	.include	"./courses/smb/water_3_scenery.s"

.if	.defined(VS_SMB)
courses_scenery_water_4:
	.include	"./courses/smb/water_2_scenery.s"

.endif

.if	.defined(SMB)
	.res	1, $FF
.elseif	.defined(VS_SMB)
	.res	9, $FF
.endif

