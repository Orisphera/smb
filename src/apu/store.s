.include	"sys/apu.i"

.include	"sound.i"

.macro	APU_STORE_BASE
	1
.endmacro
.include	"./common/store.s"
.delmac	APU_STORE_BASE
