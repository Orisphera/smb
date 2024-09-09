.ifndef	MUSHROOM_NEW_B
MUSHROOM_NEW_B = 1

	.export chr_obj_mushroom_ne
chr_obj_mushroom_ne:
	.incbin	"../../chr.smb2/chr_obj_DA.bin"

	.export chr_obj_mushroom_sw
chr_obj_mushroom_sw:
	.incbin	"../../chr.smb2/chr_obj_DB.bin"

.endif	; MUSHROOM_NEW_B
