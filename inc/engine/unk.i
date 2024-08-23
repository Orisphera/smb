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
		data4_start		= $C2B4
		course_descriptor_get	= $C2B4
		course_load		= $C2C3
		courses_world_offsets	= $C357
		courses_area_offsets	= $C360
		course_scenery_loop_offsets = $C388
		sub_C3D6		= $C3D6
		sub_C46E		= $C46E

		data2_start		= $C470
		bg_scenery_C470		= $C470
		bg_scenery_C475		= $C475
		sub_C4C0		= $C4C0
		sub_C4FE		= $C4FE
		data_C511		= $C511
		sub_C550		= $C550
		screen_title_cursor	= $C573
		screen_title_score	= $C58A
		sub_C592		= $C592
		bg_scenery_C5BE		= $C5BE
		bg_scenery_C5C2		= $C5C2

		data3_start		= $C5D0
		sub_C5D0		= $C5D0
		sub_C5DB		= $C5DB
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

		apu_cycle		= $D2A0
	.endif

	.if	.defined(ANN)
		data4_start		= $C296
		course_descriptor_get	= $C296
		course_load		= $C2A5
		courses_world_offsets	= $C339
		courses_area_offsets	= $C341
		course_scenery_loop_offsets = $C365
		sub_C3D6		= $C3B7
		sub_C46E		= $C42B

		data2_start		= $C470
		bg_scenery_C470		= $C470
		bg_scenery_C475		= $C475
		sub_C4C0		= $C4C0
		data_C511		= $C4CB
		sub_C4FE_b		= $C4FE
		sub_C50C		= $C50C
		screen_title_cursor	= $C531
		screen_title_score	= $C548
		sub_C592		= $C550
		sub_C5DB		= $C596

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

		apu_cycle		= $D2E5
	.endif

.endif	; UNK_I
