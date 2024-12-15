.segment	"DATA4"

.if     .defined(OG_PAD)
.if     .defined(SMB2)
        .res    142, $FF
.elseif .defined(ANN)
        .res    173, $FF
.endif
.endif

.macro	PIPE_FLIPPED_EXT
	1
.endmacro
.include	"./common/pipe_flipped.s"
.delmac	PIPE_FLIPPED_EXT

