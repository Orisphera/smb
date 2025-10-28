.ifndef	VS_I
VS_I	= 1

VS_SR   	= $4016
        .enum   vs_sr
		svc		= %00000100

		dip_1		= %00001000
		dip_2		= %00010000
		dips		= (dip_1|dip_2)

		coin_bits	= %00110000
		coin_0		= %00010000
		coin_1		= %00100000

		mem_bit		= %10000000
                game_sub        = mem_bit
                game_main       = 0
        .endenum

VS_REQ  	= $4016
        .enum   vs_req
		ctrl_bit	= %00000001
                ctrl_raise      = ctrl_bit
                ctrl_rel        = 0

		irq_bit		= %00000010
                irq_rel         = irq_bit
                irq_raise       = 0

		chr_bit		= %00000100
                chr_high        = chr_bit
                chr_low         = 0
        .endenum

VS_SR2		= $4017
	.enum	vs_sr2
		dip_3	= %00000100
		dip_4	= %00001000
		dip_5	= %00010000
		dip_6	= %00100000
		dip_7	= %01000000
		dip_8	= %10000000
		dips	= (dip_3|dip_4|dip_5|dip_6|dip_7|dip_8)
	.endenum

VS_COINS	= $4020

VS_RAM  	= $6000

.endif	; VS_I

