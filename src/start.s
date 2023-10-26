nmi	= $8082
irq	= $FFF0

.segment	"VECTORS"

	.addr	nmi
	.addr	start
	.addr	irq

.code

	.export start
start:
