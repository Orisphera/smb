.if	.defined(VS)
	.segment "CHR1DATA"
.endif

.if	.defined(OG_PAD)
.if	.defined(FC_SMB)
	.ifndef	PAL
		.res	2, $FF
	.endif
.endif
.endif
; ------------------------------------------------------------
	.export course_scenery_loop_offsets 
course_scenery_loop_offsets:
	.byte	18, 54, 14, 14
	.byte	14, 50, 50, 50
	.if	.defined(SMBV1)
		.byte	10, 38, 64
	.elseif	.defined(ANN)
		.byte	12, 84
	.endif
