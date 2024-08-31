.include	"system/cpu.i"

.include	"engine/unk.i"

COURSE_OFFSET_INC_SIZE	= WORD_SIZE

	.export course_actor_pages
course_actor_pages:
	.byte	(course_actor_addr_lo_water-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_overworld-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_underground-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_castle-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE

	.export course_actor_addr_lo
course_actor_addr_lo:
course_actor_addr_lo_castle:
	.addr	course_actor_castle_7_vs
	.addr	course_actor_castle_2_smb2
	.addr	course_actor_castle_3_smb2
	.addr	course_actor_castle_4_smb2
	.addr	course_actor_castle_5_smb2
	.addr	course_actor_castle_6_smb2
	.addr	course_actor_castle_7_smb2
	.addr	course_actor_castle_8_smb2
	.addr	course_actor_castle_9_smb2
	.addr	course_actor_castle_10_smb2

course_actor_addr_lo_overworld:
	.addr	course_actor_overworld_1_smb2, course_actor_overworld_2_smb2
	.addr	course_actor_overworld_3_smb2, course_actor_overworld_22_vs
	.addr	course_actor_overworld_5_smb2, course_actor_overworld_6_smb2
	.addr	course_actor_overworld_7_smb2, course_actor_overworld_8_smb2
	.addr	course_actor_overworld_9_smb2, course_actor_overworld_10
	.addr	course_actor_overworld_7_vs, course_actor_overworld_12_smb2
	.addr	course_actor_overworld_13_smb2, course_actor_overworld_14_smb2
	.addr	course_actor_overworld_15_smb2, course_actor_overworld_16_smb2
	.addr	course_actor_overworld_17_smb2, course_actor_overworld_18_smb2
	.addr	course_actor_overworld_19_smb2, course_actor_overworld_20_smb2
	.addr	course_actor_overworld_10, course_actor_overworld_22_smb2
	.addr	course_actor_overworld_23_smb2, course_actor_overworld_24_smb2
	.addr	course_actor_overworld_25_smb2, course_actor_overworld_26_smb2
	.addr	course_actor_overworld_27_smb2, course_actor_overworld_10
	.addr	course_actor_overworld_29_smb2

course_actor_addr_lo_underground:
	.addr	course_actor_underground_1_smb2
	.addr	course_actor_underground_2_smb2
	.addr	course_actor_underground_3_smb2
	.addr	course_actor_underground_4_smb2
	.addr	course_actor_underground_5_smb2

course_actor_addr_lo_water:
	.addr	course_actor_water_1_smb2
	.addr	course_actor_water_2_smb2
	.addr	course_actor_water_3_smb2
	.addr	course_actor_water_4_smb2
	.addr	course_actor_water_5_smb2
	.addr	course_actor_water_6_smb2
	.addr	course_actor_water_7_smb2
	.addr	course_actor_water_8_smb2
; --------------
	.export course_scenery_pages
course_scenery_pages:
	.byte	(course_scenery_addr_lo_water-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_overworld-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_underground-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_castle-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE

	.export course_scenery_addr_lo
course_scenery_addr_lo:
course_scenery_addr_lo_castle:
	.addr	course_scenery_castle_7_vs
	.addr	course_scenery_castle_2_smb2
	.addr	course_scenery_castle_3_smb2
	.addr	course_scenery_castle_4_smb2
	.addr	course_scenery_castle_5_smb2
	.addr	course_scenery_castle_6_smb2
	.addr	course_scenery_castle_7_smb2
	.addr	course_scenery_castle_8_smb2
	.addr	course_scenery_castle_9_smb2
	.addr	course_scenery_castle_10_smb2

course_scenery_addr_lo_overworld:
	.addr	course_scenery_overworld_1_smb2, course_scenery_overworld_2_smb2
	.addr	course_scenery_overworld_3_smb2, course_scenery_overworld_22_vs
	.addr	course_scenery_overworld_5_smb2, course_scenery_overworld_6_smb2
	.addr	course_scenery_overworld_7_smb2, course_scenery_overworld_8_smb2
	.addr	course_scenery_overworld_9_smb2, course_scenery_overworld_10
	.addr	course_scenery_overworld_7_vs, course_scenery_overworld_12_smb2
	.addr	course_scenery_overworld_13_smb2, course_scenery_overworld_14_smb2
	.addr	course_scenery_overworld_15_smb2, course_scenery_overworld_16_smb2
	.addr	course_scenery_overworld_17_smb2, course_scenery_overworld_18_smb2
	.addr	course_scenery_overworld_19_smb2, course_scenery_overworld_20_smb2
	.addr	course_scenery_overworld_21_smb2, course_scenery_overworld_22_smb2
	.addr	course_scenery_overworld_23_smb2, course_scenery_overworld_24_smb2
	.addr	course_scenery_overworld_25_smb2, course_scenery_overworld_26_smb2
	.addr	course_scenery_overworld_27_smb2, course_scenery_overworld_28_smb2
	.addr	course_scenery_overworld_29_smb2

course_scenery_addr_lo_underground:
	.addr	course_scenery_underground_1_smb2
	.addr	course_scenery_underground_2_smb2
	.addr	course_scenery_underground_3_smb2
	.addr	course_scenery_underground_4_smb2
	.addr	course_scenery_underground_5_smb2

course_scenery_addr_lo_water:
	.addr	course_scenery_water_1_smb2
	.addr	course_scenery_water_2_smb2
	.addr	course_scenery_water_3_smb2
	.addr	course_scenery_water_4_smb2
	.addr	course_scenery_water_5_smb2
	.addr	course_scenery_water_6_smb2
	.addr	course_scenery_water_7_smb2
	.addr	course_scenery_water_8_smb2

	.res	2, $FF
