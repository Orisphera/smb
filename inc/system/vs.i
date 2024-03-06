.ifndef	VS_I
VS_I	= 1

VS_SR   = $4016
        .enum   vs_sr
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

VS_RAM  = $6000

.endif	; VS_I