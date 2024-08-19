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
		sub_C04D		= $C04D
		sub_C081		= $C081
		sub_C088		= $C088
		sub_C08E		= $C08E
		data_C10B		= $C10B
		data_C149		= $C149
		sub_C1C2		= $C1C2
		sub_C241		= $C241
		sub_C24A		= $C24A
		course_descriptor_load	= $C2A4
		course_load		= $C2C3
		courses_world_offsets	= $C357
		courses_area_offsets	= $C360
		course_data_loop_offsets = $C388
		sub_C4C0		= $C4C0
		bg_areaobj_C470		= $C470
		bg_areaobj_C475		= $C475
		sub_C4FE		= $C4FE
		data_C511		= $C511
		sub_C550		= $C550
		screen_title_cursor	= $C573
		screen_title_score	= $C58A
		bg_areaobj_C5BE		= $C5BE
		bg_areaobj_C5C2		= $C5C2
		sub_C5D0		= $C5D0
		sub_C5FE		= $C5FE
		data_C62B		= $C62B
		sub_C642		= $C642
		sub_C686		= $C686
		sub_C6CA		= $C6CA
		sub_C710		= $C710
		sub_C727		= $C727
		sub_C738		= $C738
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
		sub_EFA4		= $BC7F
		eng_title		= $BFB0
		apu_cycle		= $D2A0
	.endif

	.if	.defined(ANN)
		eng_title		= $BFBF
		sub_C04D		= $C05E
		sub_C081		= $C092
		sub_C088		= $C099
		sub_C08E		= $C09F
		data_C10B		= $C121
		data_C149		= $C15F
		sub_C1C2		= $C1D8
		sub_C241		= $C252
		sub_C24A		= $C25B
		course_descriptor_load	= $C286
		course_load		= $C2A5
		courses_world_offsets	= $C339
		courses_area_offsets	= $C341
		course_data_loop_offsets = $C365
		bg_areaobj_C470		= $C470
		bg_areaobj_C475		= $C475
		sub_C4C0		= $C4C0
		data_C511		= $C4CB
		sub_C4FE_b		= $C4FE
		sub_C50C		= $C50C
		screen_title_cursor	= $C531
		screen_title_score	= $C548
		sub_C5FE		= $C5D0
		data_C62B		= $C5E6
		sub_C642		= $C61F
		sub_C686		= $C663
		sub_C6CA		= $C6B1
		sub_C710		= $C6F7
		sub_C727		= $C713
		sub_C738		= $C72E
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
