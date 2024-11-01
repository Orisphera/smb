.ifndef UNK_I
UNK_I = 1

	.if	.defined(SMB2)
		sub_C3D6		= $C3D6
		data_C62B		= $C62B
	.endif

	.if	.defined(ANN)
		sub_C3D6		= $C3B7
		data_C62B		= $C5E6
	.endif

.endif	; UNK_I
