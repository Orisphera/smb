.include	"misc.i"
.include	"course_flags.i"
.include	"course_ids.i"

.segment	"DATA4"

	.export	courses_ext_world_offsets, courses_ext_area_offsets
courses_ext_world_offsets:
	.byte	course_ext_01_areas-courses_ext_area_offsets
	.byte	course_ext_02_areas-courses_ext_area_offsets
	.byte	course_ext_03_areas-courses_ext_area_offsets
	.byte	course_ext_04_areas-courses_ext_area_offsets
	.byte	course_ext_01_areas-courses_ext_area_offsets
	.byte	course_ext_01_areas-courses_ext_area_offsets
	.byte	course_ext_01_areas-courses_ext_area_offsets
	.byte	course_ext_01_areas-courses_ext_area_offsets
.if	.defined(SMB2)
	.byte	course_ext_01_areas-courses_ext_area_offsets
.endif
; ----------------
courses_ext_area_offsets:
course_ext_01_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_01
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_13
		.byte	COURSE_TYPE_UNDERGROUND_B|course_underground_ext::no_01
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_02
	.byte	COURSE_TYPE_CASTLE_B|course_castle_ext::no_01

course_ext_02_areas:
	.if	.defined(SMB2)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_03
	.elseif	.defined(ANN)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_12_smb2
	.endif
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_13
		.byte	COURSE_TYPE_WATER_B|course_water_ext::no_01
	.if	.defined(SMB2)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_04
	.elseif	.defined(ANN)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_07_smb2
	.endif
	.byte	COURSE_TYPE_CASTLE_B|course_castle_ext::no_02

course_ext_03_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_05
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_06
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_07
	.byte	COURSE_TYPE_CASTLE_B|course_castle_ext::no_03

course_ext_04_areas:
	.if	.defined(SMB2)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_08
	.elseif	.defined(ANN)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_19_smb2
	.endif
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_09
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_ext::no_10
	.byte	COURSE_TYPE_CASTLE_B|course_castle_ext::no_04

