.ifndef	COURSE_IDS_I
COURSE_IDS_I = 1

	.enum	course_water
		no_01
		.if	.defined(SMBM)
			no_02
		.elseif	.defined(VS_SMB)
			no_02_vs
		.endif
		.if	.defined(SMB)|.defined(VS_SMB)
			no_03
		.elseif	.defined(ANN)
			no_04_smb2
		.endif

		.if	.defined(VS_SMB)
			no_02
		.elseif	.defined(ANN)
			no_02_vs
		.endif

		.if	.defined(ANN)
			no_05_ann
		.endif
	.endenum

	.enum	course_water_smb2
		no_01
		no_02_vs
		no_03
		no_04
		no_05
		no_06
		no_07
		no_08
	.endenum

	.enum	course_water_ext
		no_01
	.endenum

	.enum	course_overworld
		no_01
		no_02
		no_03
		no_04
		no_05
		no_06
		.if	.defined(SMBM)
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
		.if	.defined(SMBM)
			no_22
		.elseif	.defined(VS_SMB)
			no_22_vs
		.endif

		.if	.defined(VS_SMB)
			no_07
			no_08
		.elseif	.defined(ANN)
			no_07_vs
			no_08_vs
		.endif

		.if	.defined(ANN)
			no_28_smb2
			no_26_ann
			no_27_ann
			no_10_b
		.endif
	.endenum

	.enum	course_overworld_smb2
		no_01
		no_02
		no_03
		no_22_vs
		no_05
		no_06
		no_07
		no_08
		no_09
		no_10_smb
		no_07_vs
		no_12
		no_13
		no_14
		no_08_vs
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
		no_29
	.endenum

	.enum	course_overworld_ext
		no_01
		no_02
		.if	.defined(SMB2)
			no_03
			no_04
		.elseif	.defined(ANN)
			no_12_smb2
			no_07_smb2
		.endif
		no_05
		no_06
		no_07
		.if	.defined(SMB2)
			no_08
		.elseif	.defined(ANN)
			no_19_smb2
		.endif
		no_09
		no_10
		no_11
		no_12
		no_13
		no_14
	.endenum

	.enum	course_underground
		no_01
		no_02
		no_03

		.if	.defined(ANN)
			no_04_ann
		.endif
	.endenum

	.enum	course_underground_smb2
		no_01
		no_02
		no_03
		no_04
		no_05
	.endenum

	.enum	course_underground_ext
		no_01
		no_02
	.endenum

	.enum	course_castle
		.if	.defined(SMBM)
			no_01
		.elseif	.defined(VS_SMB)
			no_01_vs
		.endif
		no_02
		.if	.defined(SMBM)
			no_03
		.elseif	.defined(VS_SMB)
			no_01
		.endif
		no_04
		no_05
		.if	.defined(SMB)|.defined(VS_SMB)
			no_06
		.elseif	.defined(ANN)
			no_08_smb2
		.endif

		.if	.defined(VS_SMB)
			no_07_vs
			no_03
		.elseif	.defined(ANN)
			no_04_smb2
			no_02_smb2
		.endif
	.endenum

	.enum	course_castle_smb2
		no_07_vs
		no_02
		no_03
		no_04
		no_01_vs
		no_06
		no_07
		no_08
		no_09
		no_10
	.endenum

	.enum	course_castle_ext
		no_01
		no_02
		no_03
		no_04
	.endenum

.endif	; COURSE_IDS_I
