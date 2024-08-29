.if	.defined(VS)
	.segment "CHR1DATA"
.endif
	.export course_scenery_loop_offsets 
course_scenery_loop_offsets:
	.byte	18, 54, 14, 14
	.byte	14, 50, 50, 50
	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	10, 38, 64
	.elseif	.defined(ANN)
		.byte	12, 84
	.endif

