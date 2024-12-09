
.if	.defined(OG_PAD)
.if	.defined(SMB2)
	.res	83, $FF
.elseif	.defined(ANN)
	.res	37, $FF
.endif
.endif

	.export	save_b
save_b:
	.include	"./save.fds.data.s"
