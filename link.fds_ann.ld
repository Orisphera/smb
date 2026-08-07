MEMORY {
	RAM1:	 start = $0000, size $0100, file = "";
	STACK:	 start = $0100, size $0100, file = "";
	RAM2:	 start = $0200, size $0600, file = "";
	CHR0:	 start = $0000, size $2000, fill = yes, fillval $FF, file = "nsmchar1.bin";
	CHR1:	 start = $0760, size $0460, fill = yes, fillval $FF, file = "nsmchar2.bin";
	ROM1:	 start = $6000, size $7FFA, fill = yes, fillval $FF, file = "nsmmain.bin";
	ROM2:	 start = $DFFA, size $0006, fill = yes, fillval $FF, file = "nsmmain.bin";
	DATA2:	 start = $C470, size $0E00, fill = yes, fillval $FF, file = "nsmdata2.bin";
	DATA3:	 start = $C5D0, size $0D12, fill = yes, fillval $FF, file = "nsmdata3.bin";
	DATA4:	 start = $C296, size $0DF0, fill = yes, fillval $FF, file = "nsmdata4.bin";
	SAVE:	 start = $D2E3, size $0001, fill = yes, fillval $FF, file = "nsmsave.bin";
}

SEGMENTS {
	ZEROPAGE:	load = RAM1,    type = bss, define = yes;
	BSS:		load = RAM2,    type = bss;
	CHR0DATA:	load = CHR0,    type = ro;
	CHR1DATA:	load = CHR1,    type = ro;
	DATA2:		load = DATA2,   type = rw;
	DATA3:		load = DATA3,   type = rw;
	DATA4:		load = DATA4,   type = rw;
	CODE:		load = ROM1,    type = rw;
	VECTORS:	load = ROM2,    type = rw;
	SAVDATA:	load = SAVE,    type = rw;
}
