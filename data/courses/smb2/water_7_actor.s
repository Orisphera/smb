.include	"course_flags.i"

.segment	"DATA3"

	.export	course_actor_water_7_smb2
course_actor_water_7_smb2:
	.word	(COURSE_ACTORS_TYPE_F|COURSE_ACTORS_POS_X_1|COURSE_ACTORS_PAGE_LOC_01)
	.word	(COURSE_ACTORS_POS_Y_6|COURSE_ACTORS_POS_X_E|COURSE_ACTORS_ID_LAKITU)
	.byte	COURSE_ACTORS_END
