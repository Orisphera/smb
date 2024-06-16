MEMORY {
	RAM1:	start = $0000, size $0100, file = "";
	STACK:	start = $0100, size $0100, file = "";
	RAM2:	start = $0200, size $0600, file = "";
	CHR0:	start = $0000, size $2000, fill = yes, fillval $FF, file = "vschar0.vs.bin";
	CHR1_COURSE: start=$0000, size $1A00, fill = yes, fillval $FF, file = "vschar1.vs.bin";
	CHR1:	start = $1A00, size $0600, fill = yes, fillval $FF, file = "vschar1.vs.bin";
	ROM1:	start = $8000, size $7FFA, fill = yes, fillval $FF, file = "vsmain.vs.bin";
	ROM2:	start = $FFFA, size $0006, file = "vsmain.vs.bin";
}

SEGMENTS {
	ZEROPAGE:	load = RAM1, type = bss, define = yes;
	BSS:		load = RAM2, type = bss;
	CHR0DATA:	load = CHR0, type = ro;
	COURSEDATA:	load = CHR1_COURSE, type = ro;
	CHR1DATA:	load = CHR1, type = ro;
	CODE:		load = ROM1, type = ro;
	VECTORS:	load = ROM2, type = ro;
}
