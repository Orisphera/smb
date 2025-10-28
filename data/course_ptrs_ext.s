.include	"sys/cpu.i"

COURSE_OFFSET_INC_SIZE	= WORD_SIZE

.segment	"DATA4"

	.export	course_ext_actor_pages
course_ext_actor_pages:
	.byte	(course_ext_actor_addr_lo_water-course_ext_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_ext_actor_addr_lo_overworld-course_ext_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_ext_actor_addr_lo_underground-course_ext_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_ext_actor_addr_lo_castle-course_ext_actor_addr_lo)/COURSE_OFFSET_INC_SIZE

	.export	course_ext_actor_addr_lo
course_ext_actor_addr_lo:
course_ext_actor_addr_lo_castle:
	.addr	course_ext_actor_castle_1, course_ext_actor_castle_2
	.addr	course_ext_actor_castle_3, course_ext_actor_castle_4

course_ext_actor_addr_lo_overworld:
	.addr	course_ext_actor_overworld_1, course_ext_actor_overworld_2
	.if	.defined(SMB2)
		.addr	course_ext_actor_overworld_3, course_ext_actor_overworld_4
	.elseif	.defined(ANN)
		.addr	course_actor_overworld_12_smb2, course_actor_overworld_7_smb2
	.endif
	.addr	course_ext_actor_overworld_5, course_ext_actor_overworld_6
	.addr	course_ext_actor_overworld_7
	.if	.defined(SMB2)
		.addr	course_ext_actor_overworld_8
	.elseif	.defined(ANN)
		.addr	course_actor_overworld_19_smb2
	.endif
	.addr	course_ext_actor_overworld_9, course_ext_actor_overworld_10
	.addr	course_ext_actor_overworld_11, course_ext_actor_overworld_12
	.addr	course_actor_overworld_10, course_actor_overworld_10

course_ext_actor_addr_lo_underground:
	.addr	course_ext_actor_underground_1, course_ext_actor_underground_2

course_ext_actor_addr_lo_water:
	.addr	course_ext_actor_water_1
; --------------
	.export	course_ext_scenery_pages
course_ext_scenery_pages:
	.byte	(course_ext_scenery_addr_lo_water-course_ext_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_ext_scenery_addr_lo_overworld-course_ext_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_ext_scenery_addr_lo_underground-course_ext_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_ext_scenery_addr_lo_castle-course_ext_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE

	.export	course_ext_scenery_addr_lo
course_ext_scenery_addr_lo:
course_ext_scenery_addr_lo_castle:
	.addr	course_ext_scenery_castle_1, course_ext_scenery_castle_2
	.addr	course_ext_scenery_castle_3, course_ext_scenery_castle_4

course_ext_scenery_addr_lo_overworld:
	.addr	course_ext_scenery_overworld_1, course_ext_scenery_overworld_2
	.if	.defined(SMB2)
		.addr	course_ext_scenery_overworld_3, course_ext_scenery_overworld_4
	.elseif	.defined(ANN)
		.addr	course_scenery_overworld_12_smb2, course_scenery_overworld_7_smb2
	.endif
	.addr	course_ext_scenery_overworld_5, course_ext_scenery_overworld_6
	.addr	course_ext_scenery_overworld_7
	.if	.defined(SMB2)
		.addr	course_ext_scenery_overworld_8
	.elseif	.defined(ANN)
		.addr	course_scenery_overworld_19_smb2
	.endif
	.addr	course_ext_scenery_overworld_9, course_ext_scenery_overworld_10
	.addr	course_ext_scenery_overworld_11, course_ext_scenery_overworld_12
	.addr	course_scenery_overworld_10, course_scenery_overworld_28_smb2

course_ext_scenery_addr_lo_underground:
	.addr	course_ext_scenery_underground_1, course_ext_scenery_underground_2

course_ext_scenery_addr_lo_water:
	.addr	course_ext_scenery_water_1

