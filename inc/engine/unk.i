.ifndef UNK_I
UNK_I = 1

	.if	.defined(FC_SMB)
		apu_cycle		= $F2D0
	.endif

	.if	.defined(VS_SMB)
		apu_cycle		= $F236
	.endif	

	.if	.defined(FDS_SMB)
		apu_cycle		= $D2D0
	.endif

	.if	.defined(SMB2)
		apu_cycle		= $D2A0
		; ---
		data4_start		= $C2B4
		sub_C3D6		= $C3D6

		course_actor_castle_5_smb2	= $C5D0
		course_actor_castle_6_smb2	= $C609
		course_actor_castle_7_smb2	= $C630
		course_actor_castle_8_smb2	= $C66F
		course_actor_castle_9_smb2	= $CA80
		course_actor_castle_10_smb2	= $CA8A

		course_actor_overworld_12_smb2	= $C6AF
		course_actor_overworld_13_smb2	= $C6E0
		course_actor_overworld_14_smb2	= $C708
		course_actor_overworld_15_smb2	= $C72C
		course_actor_overworld_16_smb2	= $C749
		course_actor_overworld_17_smb2	= $C77A
		course_actor_overworld_18_smb2	= $C7A6
		course_actor_overworld_19_smb2	= $C7BF

		course_actor_overworld_22_smb2	= $C7E7
		course_actor_overworld_23_smb2	= $C80A
		course_actor_overworld_24_smb2	= $C831
		course_actor_overworld_25_smb2	= $CA90
		course_actor_overworld_26_smb2	= $CA94
		course_actor_overworld_27_smb2	= $CA94
		course_actor_overworld_29_smb2	= $C832

		course_actor_underground_4_smb2	= $C83B
		course_actor_underground_5_smb2	= $C85C

		course_actor_water_2_smb2	= $C876
		course_actor_water_4_smb2	= $C8A6
		course_actor_water_5_smb2	= $C8B4
		course_actor_water_6_smb2	= $CA94
		course_actor_water_7_smb2	= $CAB5
		course_actor_water_8_smb2	= $CABA

		course_scenery_castle_5_smb2	= $C8C9
		course_scenery_castle_6_smb2	= $C996
		course_scenery_castle_7_smb2	= $CA25
		course_scenery_castle_8_smb2	= $CAB8
		course_scenery_castle_9_smb2	= $CACB
		course_scenery_castle_10_smb2	= $CB2E

		course_scenery_overworld_12_smb2	= $CB8F
		course_scenery_overworld_13_smb2	= $CC30
		course_scenery_overworld_14_smb2	= $CC8F
		course_scenery_overworld_15_smb2	= $CD0E
		course_scenery_overworld_16_smb2	= $CD7B
		course_scenery_overworld_17_smb2	= $CDFE
		course_scenery_overworld_18_smb2	= $CE5B
		course_scenery_overworld_19_smb2	= $CED6

		course_scenery_overworld_22_smb2	= $CF4B
		course_scenery_overworld_23_smb2	= $CFB6
		course_scenery_overworld_24_smb2	= $D01A
		course_scenery_overworld_25_smb2	= $CB3F
		course_scenery_overworld_26_smb2	= $CB4E
		course_scenery_overworld_27_smb2	= $CB4F
		course_scenery_overworld_29_smb2	= $D01B

		course_scenery_underground_4_smb2	= $D052
		course_scenery_underground_5_smb2	= $D11F

		course_scenery_water_2_smb2	= $D160
		course_scenery_water_4_smb2	= $D229
		course_scenery_water_5_smb2	= $D242
		course_scenery_water_6_smb2	= $CB50
		course_scenery_water_7_smb2	= $CB97
		course_scenery_water_8_smb2	= $CBDA

		data2_start		= $C470
		bg_scenery_C470		= $C470
		bg_scenery_C475		= $C475
		sub_C4C0		= $C4C0
		sub_C4FE		= $C4FE
		sub_C550		= $C550
		bg_scenery_C5BE		= $C5BE
		bg_scenery_C5C2		= $C5C2

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

		data4_end		= $D200

		data2_end		= $D29F
		data3_end		= $D29F
	.endif

	.if	.defined(ANN)
		apu_cycle		= $D2E5
		; ---
		data4_start		= $C296
		sub_C3D6		= $C3B7

		course_actor_castle_7_ann = $C5D0
		course_actor_castle_8_ann = $C605
		course_actor_castle_5	= $C62C
		course_actor_castle_6	= $C641
		course_actor_overworld_2 = $C681
		course_actor_overworld_4 = $C69E
		course_actor_overworld_23_ann = $C6C5
		course_actor_overworld_24_ann = $C6E8
		course_actor_overworld_11 = $C705
		course_actor_overworld_26_ann = $C729
		course_actor_overworld_14 = $C72F
		course_actor_overworld_15 = $C752
		course_actor_overworld_17 = $C75B
		course_actor_overworld_18 = $C795
		course_actor_overworld_19 = $C7C0
		course_actor_overworld_20 = $C7F0
		course_actor_overworld_27_ann = $C80C
		course_actor_underground_4_ann = $C812
		course_actor_water_1 = $C82B
		course_actor_water_4_ann = $C83C
		course_actor_water_3 = $C86A
		course_scenery_castle_7_ann = $C878
		course_scenery_castle_8_ann = $C8ED
		course_scenery_castle_5	= $C97A
		course_scenery_castle_6	= $CA05
		course_scenery_overworld_2 = $CAD8
		course_scenery_overworld_4 = $CB45
		course_scenery_overworld_23_ann = $CBD6
		course_scenery_overworld_24_ann = $CC1F
		course_scenery_overworld_11 = $CC8C
		course_scenery_overworld_26_ann = $CCCD
		course_scenery_overworld_14 = $CCE2
		course_scenery_overworld_15 = $CD49
		course_scenery_overworld_17 = $CDBE
		course_scenery_overworld_18 = $CE53
		course_scenery_overworld_19 = $CECA
		course_scenery_overworld_20 = $CF47
		course_scenery_overworld_27_ann = $CFA8
		course_scenery_underground_4_ann = $CFD3
		course_scenery_water_1 = $D02C
		course_scenery_water_4_ann = $D06D
		course_scenery_water_3 = $D136
		ann_toad_5		= $D14F
		ann_toad_6		= $D1AF
		ann_toad_7		= $D20F

		data2_start		= $C470
		bg_scenery_C470		= $C470
		bg_scenery_C475		= $C475
		sub_C4C0		= $C4C0
		sub_C4FE_b		= $C4FE
		sub_C50C		= $C50C

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
	.endif

.endif	; UNK_I
