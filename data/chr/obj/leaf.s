.ifndef	LEAF
LEAF = 1

	.export	chr_obj_leaf
chr_obj_leaf:
	.incbin	"data/chr.smb2/chr_obj_7A.bin"
	.incbin	"data/chr.smb2/chr_obj_7B.bin"

.endif	; LEAF
