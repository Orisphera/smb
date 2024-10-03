MEMORY {
	RAM1:	start = $0000, size $0100, file = "";
	STACK:	start = $0100, size $0100, file = "";
	RAM2:	start = $0200, size $0600, file = "";
	KYODAKU: start = $2800, size $00e0,                         file = "kyodaku_.bin";
	CHR0:	start = $0000, size $2000, fill = yes, fillval $FF, file = "sm2char1.bin";
	CHR1:	start = $760,  size $18A0,                          file = "sm2char2.bin";
	ROM1:	start = $6000, size $7FFA, fill = yes, fillval $FF, file = "sm2main.bin";
	ROM2:	start = $DFFA, size $0006,                          file = "sm2main.bin";
	DATA2:	start = $C470, size $E2F, fill = yes, fillval $FF,  file = "sm2data2.bin";
	DATA3:	start = $C5D0, size $CCF,                           file = "sm2data3.bin";
	DATA4:	start = $C2B4, size $FEB,                           file = "sm2data4.bin";
	SAVE:	start = $D29F, size $0001,                          file = "sm2save.bin";
}

SEGMENTS {
	ZEROPAGE:	load = RAM1, type = bss, define = yes;
	BSS:		load = RAM2, type = bss;
	KYODAKUDATA:	load = KYODAKU, type = ro;
	CHR0DATA:	load = CHR0, type = ro;
	CHR1DATA:	load = CHR1, type = ro;
	DATA2:		load = DATA2, type = rw;
	DATA3:		load = DATA3, type = rw;
	DATA4:		load = DATA4, type = rw;
	CODE:		load = ROM1, type = rw;
	VECTORS:	load = ROM2, type = rw;
	SAVDATA:	load = SAVE, type = rw;
}
