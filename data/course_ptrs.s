.include	"system/cpu.i"

.if	.defined(CONS)
	COURSE_OFFSET_INC_SIZE	= 1
.elseif	.defined(VS)
	COURSE_OFFSET_INC_SIZE	= WORD_SIZE
.endif
	.export course_actor_pages
course_actor_pages:
	.byte	(course_actor_addr_lo_water-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_overworld-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_underground-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_castle-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE

.if	.defined(CONS)
		.export course_actor_addr_lo
	course_actor_addr_lo:
	course_actor_addr_lo_castle:
		.if	.defined(SMB)
			.byte	<course_actor_castle_1
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_castle_1_vs
		.endif
		.byte	<course_actor_castle_2
		.if	.defined(SMB)
			.byte	<course_actor_castle_3
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_castle_1
		.endif
		.byte	<course_actor_castle_4
		.byte	<course_actor_castle_5, <course_actor_castle_6

		.if	.defined(VS_SMB)
			.byte	<course_actor_castle_7_vs, <course_actor_castle_3
		.endif
	
	course_actor_addr_lo_overworld:
		.byte	<course_actor_overworld_1, <course_actor_overworld_2
		.byte	<course_actor_overworld_3, <course_actor_overworld_4
		.byte	<course_actor_overworld_5, <course_actor_overworld_6
		.if	.defined(SMB)
			.byte	<course_actor_overworld_7, <course_actor_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_overworld_7_vs, <course_actor_overworld_8_vs
		.endif
		.byte	<course_actor_overworld_9, <course_actor_overworld_10
		.byte	<course_actor_overworld_11, <course_actor_overworld_12
		.byte	<course_actor_overworld_13, <course_actor_overworld_14
		.byte	<course_actor_overworld_15, <course_actor_overworld_16
		.byte	<course_actor_overworld_17, <course_actor_overworld_18
		.byte	<course_actor_overworld_19, <course_actor_overworld_20
		.byte	<course_actor_overworld_21
		.if	.defined(SMB)
			.byte	<course_actor_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	<course_actor_overworld_7, <course_actor_overworld_8
		.endif
	
	course_actor_addr_lo_underground:
		.byte	<course_actor_underground_1
		.byte	<course_actor_underground_2
		.byte	<course_actor_underground_3
	
	course_actor_addr_lo_water:
		.byte	<course_actor_water_1
		.if	.defined(SMB)
			.byte	<course_actor_water_2
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_water_2_vs
		.endif
		.byte	<course_actor_water_3

		.if	.defined(VS_SMB)
			.byte	<course_actor_water_2
		.endif
	
		.export course_actor_addr_hi
	course_actor_addr_hi:
	course_actor_addr_hi_castle:
		.if	.defined(SMB)
			.byte	>course_actor_castle_1
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_castle_1_vs
		.endif
		.byte	>course_actor_castle_2
		.if	.defined(SMB)
			.byte	>course_actor_castle_3
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_castle_1
		.endif
		.byte	>course_actor_castle_4
		.byte	>course_actor_castle_5, >course_actor_castle_6

		.if	.defined(VS_SMB)
			.byte	>course_actor_castle_7_vs, >course_actor_castle_3
		.endif
	
	course_actor_addr_hi_overworld:
		.byte	>course_actor_overworld_1, >course_actor_overworld_2
		.byte	>course_actor_overworld_3, >course_actor_overworld_4
		.byte	>course_actor_overworld_5, >course_actor_overworld_6
		.if	.defined(SMB)
			.byte	>course_actor_overworld_7, >course_actor_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_overworld_7_vs, >course_actor_overworld_8_vs
		.endif
		.byte	>course_actor_overworld_9, >course_actor_overworld_10
		.byte	>course_actor_overworld_11, >course_actor_overworld_12
		.byte	>course_actor_overworld_13, >course_actor_overworld_14
		.byte	>course_actor_overworld_15, >course_actor_overworld_16
		.byte	>course_actor_overworld_17, >course_actor_overworld_18
		.byte	>course_actor_overworld_19, >course_actor_overworld_20
		.byte	>course_actor_overworld_21
		.if	.defined(SMB)
			.byte	>course_actor_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	>course_actor_overworld_7, >course_actor_overworld_8
		.endif
	
	course_actor_addr_hi_underground:
		.byte	>course_actor_underground_1
		.byte	>course_actor_underground_2
		.byte	>course_actor_underground_3
	
	course_actor_addr_hi_water:
		.byte	>course_actor_water_1
		.if	.defined(SMB)
			.byte	>course_actor_water_2
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_water_2_vs
		.endif
		.byte	>course_actor_water_3

		.if	.defined(VS_SMB)
			.byte	>course_actor_water_2
		.endif
.elseif	.defined(VS)
		.export course_actor_addr_lo
	course_actor_addr_lo:
	course_actor_addr_lo_castle:
		.if	.defined(SMB)
			.addr	course_actor_castle_1
		.elseif	.defined(VS_SMB)
			.addr	course_actor_castle_1_vs
		.endif
		.addr	course_actor_castle_2
		.if	.defined(SMB)
			.addr	course_actor_castle_3
		.elseif	.defined(VS_SMB)
			.addr	course_actor_castle_1
		.endif
		.addr	course_actor_castle_4
		.addr	course_actor_castle_5, course_actor_castle_6

		.if	.defined(VS_SMB)
			.addr	course_actor_castle_7_vs, course_actor_castle_3
		.endif

	course_actor_addr_lo_overworld:
		.addr	course_actor_overworld_1, course_actor_overworld_2
		.addr	course_actor_overworld_3, course_actor_overworld_4
		.addr	course_actor_overworld_5, course_actor_overworld_6
		.if	.defined(SMB)
			.addr	course_actor_overworld_7, course_actor_overworld_8
		.elseif	.defined(VS_SMB)
			.addr	course_actor_overworld_7_vs, course_actor_overworld_8_vs
		.endif
		.addr	course_actor_overworld_9, course_actor_overworld_10
		.addr	course_actor_overworld_11, course_actor_overworld_12
		.addr	course_actor_overworld_13, course_actor_overworld_14
		.addr	course_actor_overworld_15, course_actor_overworld_16
		.addr	course_actor_overworld_17, course_actor_overworld_18
		.addr	course_actor_overworld_19, course_actor_overworld_20
		.addr	course_actor_overworld_21
		.if	.defined(SMB)
			.addr	course_actor_overworld_22
		.elseif	.defined(VS_SMB)
			.addr	course_actor_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.addr	course_actor_overworld_7, course_actor_overworld_8
		.endif

	course_actor_addr_lo_underground:
		.addr	course_actor_underground_1
		.addr	course_actor_underground_2
		.addr	course_actor_underground_3

	course_actor_addr_lo_water:
		.addr	course_actor_water_1
		.if	.defined(SMB)
			.addr	course_actor_water_2
		.elseif	.defined(VS_SMB)
			.addr	course_actor_water_2_vs
		.endif
		.addr	course_actor_water_3

		.if	.defined(VS_SMB)
			.addr	course_actor_water_2
		.endif
.endif
; --------------
	.export course_scenery_pages
course_scenery_pages:
	.byte	(course_scenery_addr_lo_water-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_overworld-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_underground-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_castle-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE

.if	.defined(CONS)
		.export course_scenery_addr_lo
	course_scenery_addr_lo:
	course_scenery_addr_lo_water:
		.byte	<course_scenery_water_1
		.if	.defined(SMB)
			.byte	<course_scenery_water_2
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_water_2_vs
		.endif
		.byte	<course_scenery_water_3

		.if	.defined(VS_SMB)
			.byte	<course_scenery_water_2
		.endif
	
	course_scenery_addr_lo_overworld:
		.byte	<course_scenery_overworld_1, <course_scenery_overworld_2
		.byte	<course_scenery_overworld_3, <course_scenery_overworld_4
		.byte	<course_scenery_overworld_5, <course_scenery_overworld_6
		.if	.defined(SMB)
			.byte	<course_scenery_overworld_7, <course_scenery_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_overworld_7_vs, <course_scenery_overworld_8_vs
		.endif
		.byte	<course_scenery_overworld_9, <course_scenery_overworld_10
		.byte	<course_scenery_overworld_11, <course_scenery_overworld_12
		.byte	<course_scenery_overworld_13, <course_scenery_overworld_14
		.byte	<course_scenery_overworld_15, <course_scenery_overworld_16
		.byte	<course_scenery_overworld_17, <course_scenery_overworld_18
		.byte	<course_scenery_overworld_19, <course_scenery_overworld_20
		.byte	<course_scenery_overworld_21
		.if	.defined(SMB)
			.byte	<course_scenery_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	<course_scenery_overworld_7, <course_scenery_overworld_8
		.endif
	
	course_scenery_addr_lo_underground:
		.byte	<course_scenery_underground_1
		.byte	<course_scenery_underground_2
		.byte	<course_scenery_underground_3
	
	course_scenery_addr_lo_castle:
		.if	.defined(SMB)
			.byte	<course_scenery_castle_1
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_castle_1_vs
		.endif
		.byte	<course_scenery_castle_2
		.if	.defined(SMB)
			.byte	<course_scenery_castle_3
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_castle_1
		.endif
		.byte	<course_scenery_castle_4
		.byte	<course_scenery_castle_5, <course_scenery_castle_6

		.if	.defined(VS_SMB)
			.byte	<course_scenery_castle_7_vs, <course_scenery_castle_3
		.endif
	
		.export course_scenery_addr_hi
	course_scenery_addr_hi:
	course_scenery_addr_hi_water:
		.byte	>course_scenery_water_1
		.if	.defined(SMB)
			.byte	>course_scenery_water_2
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_water_2_vs
		.endif
		.byte	>course_scenery_water_3

		.if	.defined(VS_SMB)
			.byte	>course_scenery_water_2
		.endif
	
	course_scenery_addr_hi_overworld:
		.byte	>course_scenery_overworld_1, >course_scenery_overworld_2
		.byte	>course_scenery_overworld_3, >course_scenery_overworld_4
		.byte	>course_scenery_overworld_5, >course_scenery_overworld_6
		.if	.defined(SMB)
			.byte	>course_scenery_overworld_7, >course_scenery_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_overworld_7_vs, >course_scenery_overworld_8_vs
		.endif
		.byte	>course_scenery_overworld_9, >course_scenery_overworld_10
		.byte	>course_scenery_overworld_11, >course_scenery_overworld_12
		.byte	>course_scenery_overworld_13, >course_scenery_overworld_14
		.byte	>course_scenery_overworld_15, >course_scenery_overworld_16
		.byte	>course_scenery_overworld_17, >course_scenery_overworld_18
		.byte	>course_scenery_overworld_19, >course_scenery_overworld_20
		.byte	>course_scenery_overworld_21

		.if	.defined(SMB)
			.byte	>course_scenery_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	>course_scenery_overworld_7, >course_scenery_overworld_8
		.endif
	
	course_scenery_addr_hi_underground:
		.byte	>course_scenery_underground_1
		.byte	>course_scenery_underground_2
		.byte	>course_scenery_underground_3
	
	course_scenery_addr_hi_castle:
		.if	.defined(SMB)
			.byte	>course_scenery_castle_1
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_castle_1_vs
		.endif
		.byte	>course_scenery_castle_2
		.if	.defined(SMB)
			.byte	>course_scenery_castle_3
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_castle_1
		.endif
		.byte	>course_scenery_castle_4
		.byte	>course_scenery_castle_5, >course_scenery_castle_6

		.if	.defined(VS_SMB)
			.byte	>course_scenery_castle_7_vs, >course_scenery_castle_3
		.endif
.elseif	.defined(VS)
		.export course_scenery_addr_lo
	course_scenery_addr_lo:
	course_scenery_addr_lo_water:
		.addr	course_scenery_water_1
		.if	.defined(SMB)
			.addr	course_scenery_water_2
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_water_2_vs
		.endif
		.addr	course_scenery_water_3

		.if	.defined(VS_SMB)
			.addr	course_scenery_water_2
		.endif

	course_scenery_addr_lo_overworld:
		.addr	course_scenery_overworld_1, course_scenery_overworld_2
		.addr	course_scenery_overworld_3, course_scenery_overworld_4
		.addr	course_scenery_overworld_5, course_scenery_overworld_6
		.if	.defined(SMB)
			.addr	course_scenery_overworld_7, course_scenery_overworld_8
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_overworld_7_vs, course_scenery_overworld_8_vs
		.endif
		.addr	course_scenery_overworld_9, course_scenery_overworld_10
		.addr	course_scenery_overworld_11, course_scenery_overworld_12
		.addr	course_scenery_overworld_13, course_scenery_overworld_14
		.addr	course_scenery_overworld_15, course_scenery_overworld_16
		.addr	course_scenery_overworld_17, course_scenery_overworld_18
		.addr	course_scenery_overworld_19, course_scenery_overworld_20
		.addr	course_scenery_overworld_21
		.if	.defined(SMB)
			.addr	course_scenery_overworld_22
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.addr	course_scenery_overworld_7, course_scenery_overworld_8
		.endif

	course_scenery_addr_lo_underground:
		.addr	course_scenery_underground_1
		.addr	course_scenery_underground_2
		.addr	course_scenery_underground_3

	course_scenery_addr_lo_castle:
		.if	.defined(SMB)
			.addr	course_scenery_castle_1
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_castle_1_vs
		.endif
		.addr	course_scenery_castle_2
		.if	.defined(SMB)
			.addr	course_scenery_castle_3
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_castle_1
		.endif
		.addr	course_scenery_castle_4
		.addr	course_scenery_castle_5, course_scenery_castle_6

		.if	.defined(VS_SMB)
			.addr	course_scenery_castle_7_vs, course_scenery_castle_3
		.endif
.endif

.if	.defined(VS_SMB)
	.res	9, $FF
.endif
