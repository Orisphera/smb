.ifndef UNK_I
UNK_I = 1

	.if	.defined(FC_SMB)
		apu_cycle		= $F2D0
		irq			= $FFF0
	.endif

	.if	.defined(VS_SMB)
		apu_cycle		= $F236
	.endif	

	.if	.defined(FDS_SMB)
		apu_cycle		= $D2D0
		irq			= $FFF0
	.endif

	.if	.defined(SMB2)
		course_actor_castle_1_smb2	= $C790
		course_actor_castle_2_smb2	= $C7AF
		course_actor_castle_3_smb2	= $C7D6
		course_actor_castle_4_smb2	= $C7E9
		course_actor_overworld_1_smb2	= $C81E
		course_actor_overworld_2_smb2	= $C844
		course_actor_overworld_3_smb2	= $C867
		course_actor_overworld_4_smb2	= $C890
		course_actor_overworld_5_smb2	= $C8C6
		course_actor_overworld_6_smb2	= $C8DD
		course_actor_overworld_7_smb2	= $C907
		course_actor_overworld_8_smb2	= $C92C
		course_actor_overworld_9_smb2	= $C943
		course_actor_overworld_11_smb2	= $C965
		course_actor_overworld_20_smb2	= $C988
		course_actor_underground_1_smb2	= $C994
		course_actor_underground_2_smb2	= $C9BA
		course_actor_underground_3_smb2	= $C9C4
		course_actor_water_1_smb2	= $C9DE
		course_actor_water_3_smb2	= $CA04
		course_scenery_castle_1_smb2	= $CA14
		course_scenery_castle_2_smb2	= $CA73
		course_scenery_castle_3_smb2	= $CAFE
		course_scenery_castle_4_smb2	= $CB95
		course_scenery_overworld_1_smb2	= $CC0A
		course_scenery_overworld_2_smb2	= $CC65
		course_scenery_overworld_3_smb2	= $CCB4
		course_scenery_overworld_4_smb2	= $CD2D
		course_scenery_overworld_5_smb2	= $CDAA
		course_scenery_overworld_6_smb2	= $CE09
		course_scenery_overworld_7_smb2	= $CE88
		course_scenery_overworld_8_smb2	= $CEE7
		course_scenery_overworld_9_smb2	= $CF5E
		course_scenery_overworld_11_smb2	= $CFBF
		course_scenery_overworld_20_smb2	= $D008
		course_scenery_underground_1_smb2	= $D021
		course_scenery_underground_2_smb2	= $D0E2
		course_scenery_underground_3_smb2	= $D11D
		course_scenery_water_1_smb2	= $D168
		course_scenery_water_3_smb2	= $D21B
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
		data_C97D		= $C97D
		data_C9C0		= $C9C0

		data4_end		= $D200

		data2_end		= $D29F
		data3_end		= $D29F
	.endif

	.if	.defined(ANN)
		course_actor_castle_1	= $C745
		course_actor_castle_2	= $C762
		course_actor_castle_3	= $C77B
		course_actor_castle_4	= $C79E
		course_actor_overworld_1 = $C7C7
		course_actor_overworld_3 = $C7E8
		course_actor_overworld_5 = $C7F8
		course_actor_overworld_6 = $C829
		course_actor_overworld_7 = $C847
		course_actor_overworld_8 = $C860
		course_actor_overworld_9 = $C867
		course_actor_overworld_12 = $C896
		course_actor_overworld_13 = $C89C
		course_actor_overworld_16 = $C8C0
		course_actor_overworld_21 = $C8C1
		course_actor_overworld_22 = $C8C7
		course_actor_overworld_22_end = $C8EB
		course_actor_underground_1 = $C8EC
		course_actor_underground_2 = $C919
		course_actor_underground_3 = $C947
		course_actor_water_2 = $C962
		course_scenery_castle_1	= $C97B
		course_scenery_castle_2	= $C9D2
		course_scenery_castle_3	= $CA53
		course_scenery_castle_4	= $CAC2
		course_scenery_overworld_1 = $CB2D
		course_scenery_overworld_3 = $CB8A
		course_scenery_overworld_5 = $CBDD
		course_scenery_overworld_6 = $CC4E
		course_scenery_overworld_7 = $CCB3
		course_scenery_overworld_8 = $CD08
		course_scenery_overworld_9 = $CD85
		course_scenery_overworld_12 = $CDE8
		course_scenery_overworld_13 = $CDFD
		course_scenery_overworld_16 = $CE54
		course_scenery_overworld_21 = $CE85
		course_scenery_overworld_22 = $CEB0
		course_scenery_overworld_28_ann = $CEE7
		course_scenery_underground_1 = $CEF0
		course_scenery_underground_2 = $CF91
		course_scenery_underground_3 = $D036
		course_scenery_water_2 = $D0C3
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

		data_D13E		= $D13E
		data_D14F		= $D14F
		data_D19E		= $D19E
		data_D1AF		= $D1AF
		data_D1FE		= $D1FE
		data_D20F		= $D20F
		data_D25E		= $D25E
	.endif

.endif	; UNK_I
