.include	"mem.i"
.include	"sound.i"

.segment	"DATA3"

.macro	APU_LOAD_FDS
	1
.endmacro
.include	"./common/load.s"
.delmac	APU_LOAD_FDS
