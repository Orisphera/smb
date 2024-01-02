MEMORY {
	RAM1:	start = $0000, size $0100, file = "";
	STACK:	start = $0100, size $0100, file = "";
	RAM2:	start = $0200, size $0600, file = "";
	CHR:	start = $0000, size $2000, fill = yes, fillval $FF, file = "smchar.fc.bin";
	ROM1:	start = $8000, size $7FFA, fill = yes, fillval $FF, file = "smmain.fc.bin";
	ROM2:	start = $FFFA, size $0006, file = "smmain.fc.bin";
}

SEGMENTS {
	ZEROPAGE:	load = RAM1, type = bss, define = yes;
	BSS:		load = RAM2, type = bss;
	CHRDATA:	load = CHR, type = ro;
	CODE:		load = ROM1, type = ro;
	VECTORS:	load = ROM2, type = ro;
}
