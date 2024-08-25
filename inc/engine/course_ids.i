.ifndef	COURSE_IDS_I
COURSE_IDS_I = 1

	.enum	course_water
		no_01
		.if	.defined(SMB)|.defined(ANN)
			no_02
		.elseif	.defined(VS_SMB)
			no_02_vs
		.endif
		no_03

		.if	.defined(VS_SMB)
			no_02
		.elseif	.defined(ANN)
			no_04_ann
		.endif
	.endenum

	.enum	course_water_smb2
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		no_07
		no_08
	.endenum

	.enum	course_overworld
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		.if	.defined(SMB)|.defined(ANN)
			no_07
			no_08
		.elseif	.defined(VS_SMB)
			no_07_vs
			no_08_vs
		.endif
		no_09
		no_10
		no_11
		no_12
		no_13
		no_14
		no_15
		no_16
		no_17
		no_18
		no_19
		no_20
		no_21
		.if	.defined(SMB)
			no_22
		.elseif	.defined(VS_SMB)|.defined(ANN)
			no_22_vs
		.endif

		.if	.defined(VS_SMB)
			no_07
			no_08
		.elseif	.defined(ANN)
			no_23_ann
			no_24_ann
		.endif

		.if	.defined(ANN)
			no_25_ann
			no_26_ann
			no_27_ann
			no_28_ann
		.endif
	.endenum

	.enum	course_overworld_smb2
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		no_07
		no_08
		no_09
		no_10
		no_11
		no_12
		no_13
		no_14
		no_15
		no_16
		no_17
		no_18
		no_19
		no_20
		no_21
		no_22
		no_23
		no_24
		no_25
		no_26
		no_27
		no_28
	.endenum

	.enum	course_underground
		no_01
		no_02
		no_03
	.endenum

	.enum	course_underground_smb2
		no_01
		no_02
		no_03
		no_04
	.endenum

	.enum	course_castle
		.if	.defined(SMB)|.defined(ANN)
			no_01
		.elseif	.defined(VS_SMB)
			no_01_vs
		.endif
		no_02
		.if	.defined(SMB)|.defined(ANN)
			no_03
		.elseif	.defined(VS_SMB)
			no_01
		.endif
		no_04
		no_05
		no_06

		.if	.defined(VS_SMB)
			no_07_vs
			no_03
		.elseif	.defined(ANN)
			no_07_ann
			no_08_ann
		.endif
	.endenum

	.enum	course_castle_smb2
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		no_07
		no_08
		no_09
	.endenum

.endif	; COURSE_IDS_I