.if	.defined(VS)
	.segment "COURSEDATA"
.endif
	.export course_data_loop_offsets 
course_data_loop_offsets:
	.byte	18, 54, 14, 14
	.byte	14, 50, 50, 50
	.byte	10, 38, 64

