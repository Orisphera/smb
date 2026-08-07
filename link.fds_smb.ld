MEMORY {
	RAM1:		start = $0000, size $0100, file = "";
	STACK:		start = $0100, size $0100, file = "";
	RAM2:		start = $0200, size $0600, file = "";
	CHR:		start = $0000, size $2000, fill = yes, fillval $FF, file = "smchar.fds.bin";
	ROM1:		start = $6000, size $7FFA, fill = yes, fillval $FF, file = "smmain.fds.bin";
	ROM2:		start = $DFFA, size $0006, fill = yes, fillval $FF, file = "smmain.fds.bin";
}

SEGMENTS {
	ZEROPAGE:	load = RAM1,    type = bss, define = yes;
	BSS:		load = RAM2,    type = bss;
	CHR0DATA:	load = CHR,     type = ro;
	CODE:		load = ROM1,    type = rw;
	VECTORS:	load = ROM2,    type = rw;
}
