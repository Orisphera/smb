.if	.defined(VS)
	.segment "COURSEDATA"
.endif
	.export course_data_head
course_data_head:
	.byte	$12, $36, $0E, $0E
	.byte	$0E, $32, $32, $32
	.byte	$0A, $26, $40

