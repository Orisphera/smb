.include	"misc.i"
.include	"course_flags.i"
.include	"course_ids.i"

	.export courses_world_offsets, courses_area_offsets
courses_world_offsets:
	.byte	course_01_areas-courses_area_offsets
	.byte	course_02_areas-courses_area_offsets
	.byte	course_03_areas-courses_area_offsets
	.byte	course_04_areas-courses_area_offsets
	.byte	course_05_areas-courses_area_offsets
	.byte	course_06_areas-courses_area_offsets
	.byte	course_07_areas-courses_area_offsets
	.byte	course_08_areas-courses_area_offsets
; ----------------
courses_area_offsets:
course_01_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_06
	.if	.defined(SMBV1)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
	.elseif	.defined(ANN)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10_b
	.endif
		.byte	COURSE_TYPE_UNDERGROUND_B|(%100)<<5|course_underground::no_01
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_07
	.if	.defined(SMBM)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_07_vs
	.endif

course_02_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_09
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
		.byte	COURSE_TYPE_WATER_B|course_water::no_02
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_08
	.if	.defined(SMBM)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_03
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01
	.endif

course_03_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_05
	.if	.defined(SMBM)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_22
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_22_vs
	.endif
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_01
	.byte	COURSE_TYPE_CASTLE_B|course_castle::no_04

course_04_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_03
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
		.byte	COURSE_TYPE_UNDERGROUND_B|course_underground::no_02
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_13
	.if	.defined(SMBM)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_02
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_03
	.endif

course_05_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_11
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_18
	.if	.defined(SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_07
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_03
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_14
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_02
	.elseif	.defined(ANN)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_07_vs
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_02_smb2
	.endif

course_06_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_15
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_04
	.if	.defined(SMBM)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_14
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_07_vs
	.endif
	.if	.defined(SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01_vs
	.elseif	.defined(ANN)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_04_smb2
	.endif

course_07_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_20
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
	.if	.defined(SMB)
			.byte	COURSE_TYPE_WATER_B|course_water::no_02
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_08
	.elseif	.defined(VS_SMB)|.defined(ANN)
			.byte	COURSE_TYPE_WATER_B|course_water::no_02_vs
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_08_vs
	.endif
	.byte	COURSE_TYPE_CASTLE_B|course_castle::no_05

course_08_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_17
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_19
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_02
	.if	.defined(SMBV1)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_06
	.elseif	.defined(ANN)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_08_smb2
	.endif
