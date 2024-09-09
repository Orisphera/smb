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
	.byte	course_09_areas-courses_area_offsets
; --------------
courses_area_offsets:
course_01_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_01
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_10_smb
		.byte	COURSE_TYPE_UNDERGROUND_B|course_underground_smb2::no_01
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_02
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_07_vs

course_02_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_03
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_22_vs
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_05
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_02

course_03_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_06
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_10_smb
		.byte	COURSE_TYPE_WATER_B|course_water_smb2::no_01
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_07
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_03

course_04_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_08
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_09
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_07_vs
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_04

course_05_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_12
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_10_smb
		.byte	COURSE_TYPE_UNDERGROUND_B|course_underground_smb2::no_04
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_13
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_05

course_06_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_14
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_10_smb
		.byte	COURSE_TYPE_WATER_B|course_water_smb2::no_02
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_15
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_06

course_07_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_16
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_17
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_18
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_07

course_08_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_19
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_22
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_23
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_08

course_09_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld_smb2::no_25
	.byte	COURSE_TYPE_WATER_B|course_water_smb2::no_07
	.byte	COURSE_TYPE_CASTLE_B|course_castle_smb2::no_09
	.byte	COURSE_TYPE_WATER_B|course_water_smb2::no_08
