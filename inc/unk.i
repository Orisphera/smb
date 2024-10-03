.ifndef UNK_I
UNK_I = 1

	.if	.defined(SMB2)
		data3_start		= $C5D0
		sub_C5D0		= $C5D0
		sub_C5FE		= $C5FE
		data_C62B		= $C62B
		sub_C642		= $C642
		sub_C686		= $C686
		sub_C6CA		= $C6CA
		sub_C710		= $C710
		sub_C727		= $C727
		sub_C738		= $C738
		sub_C858		= $C858
		data_C876		= $C876
		data_C87F		= $C87F
		data_C893		= $C893
		data_C8AB		= $C8AB
		data_C8C1		= $C8C1
		data_C8D7		= $C8D7
		data_C8EB		= $C8EB
		data_C8FC		= $C8FC
		data_C913		= $C913
		data_C92B		= $C92B
		data_C943		= $C943
		data_C95C		= $C95C
		ann_toad_pal_common	= $C97D
		data_C9C0		= $C9C0
		course_actor_castle_9_smb2	= $CA80
		course_actor_castle_10_smb2	= $CA8A
		course_actor_overworld_25_smb2	= $CA90
		course_actor_overworld_26_smb2	= $CA94
		course_actor_overworld_27_smb2	= $CA94
		course_actor_water_6_smb2	= $CA94
		course_actor_water_7_smb2	= $CAB5
		course_actor_water_8_smb2	= $CABA
		course_scenery_castle_9_smb2	= $CACB
		course_scenery_castle_10_smb2	= $CB2E
		course_scenery_overworld_25_smb2	= $CB3F
		course_scenery_overworld_26_smb2	= $CB4E
		course_scenery_overworld_27_smb2	= $CB4F
		course_scenery_water_6_smb2	= $CB50
		course_scenery_water_7_smb2	= $CB97
		course_scenery_water_8_smb2	= $CBDA

		data4_start		= $C2B4
		sub_C3D6		= $C3D6
	.endif

	.if	.defined(ANN)
		data3_start		= $C5D0
		sub_C5FE		= $C5D0
		data_C62B		= $C5E6
		sub_C642		= $C61F
		sub_C686		= $C663
		sub_C6CA		= $C6B1
		sub_C710		= $C6F7
		sub_C727		= $C713
		sub_C738		= $C72E
		sub_C858		= $C86F
		data_C876		= $C88D
		data_C87F		= $C896
		data_C893		= $C8AA
		data_C8AB		= $C8C2
		data_C8C1		= $C8D8
		data_C8D7		= $C8EE
		data_C8EB		= $C902
		data_C8FC		= $C913
		data_C913		= $C92A
		data_C92B		= $C942
		data_C943		= $C95A
		data_C9C0		= $C973
		data_C95C		= $C983

		data4_start		= $C296
		sub_C3D6		= $C3B7
	.endif

.endif	; UNK_I
