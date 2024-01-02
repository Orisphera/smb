MEMORY {
	RAM1:	start = $0000, size $0100, file = "";
	STACK:	start = $0100, size $0100, file = "";
	RAM2:	start = $0200, size $0600, file = "";
	KYODAKU: start = $2800, size $00e0,                         file = "kyodaku_.bin";
	CHR1:	start = $0000, size $2000, fill = yes, fillval $FF, file = "nsmchar1.bin";
	CHR2:	start = $760,  size $18A0,                          file = "nsmchar2.bin";
	ROM1:	start = $6000, size $7FFA, fill = yes, fillval $FF, file = "nsmmain.bin";
	ROM2:	start = $DFFA, size $0006,                          file = "nsmmain.bin";
	DATA2:	start = $C470, size $E2F,                           file = "nsmdata2.bin";
	DATA3:	start = $C5D0, size $CCF,                           file = "nsmdata3.bin";
	DATA4:	start = $C2B4, size $FEB,                           file = "nsmdata4.bin";
	SAVE:	start = $D29F, size $0001,                          file = "nsmsave.bin";
}

SEGMENTS {
	ZEROPAGE:	load = RAM1, type = bss, define = yes;
	BSS:		load = RAM2, type = bss;
	KYODAKUDATA:	load = KYODAKU, type = ro;
	CHRDATA:	load = CHR1, type = ro;
	CHR2DATA:	load = CHR2, type = ro;
	DATA2:		load = DATA2, type = rw;
	DATA3:		load = DATA3, type = rw;
	DATA4:		load = DATA4, type = rw;
	CODE:		load = ROM1, type = rw;
	VECTORS:	load = ROM2, type = rw;
	SAVDATA:	load = SAVE, type = rw;
}
