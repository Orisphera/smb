.ifndef	VS_I
VS_I	= 1

VS_SR   = $4016
        .enum   vs_sr
		svc		= 4
		dip_1		= 8
		dip_2		= 16
		dips		= $18
		coin_0		= 32
		coin_1		= 64
                game_main       = 0
                game_sub        = 128
        .endenum

VS_REQ  = $4016
        .enum   vs_req
                ctrl_raise      = 1
                ctrl_rel        = 0
                irq_rel         = 2
                irq_raise       = 0
                chr_high        = 4
                chr_low         = 0
        .endenum

VS_SR2	= $4017
	.enum	vs_sr2
		dip_3		= 4
		dip_4		= 8
		dip_5		= 16
		dip_6		= 32
		dip_7		= 64
		dip_8		= 128
		dips		= $FC
	.endenum

VS_COINS	= $4020

VS_RAM  = $6000

.endif	; VS_I

