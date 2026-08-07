MEMORY {
	KYODAKU:	start = $2800, size $00E0, fill = yes, fillval $FF, file = "kyodaku_.bin";
}

SEGMENTS {
	KYODAKUDATA:	load = KYODAKU, type = ro;
}
