.ifndef	FIRE_KOOPA
FIRE_KOOPA = 1

	.export chr_obj_bowser_flame, chr_obj_bowser_flame_end
chr_obj_bowser_flame:
	.incbin	"../../chr.smb/chr_obj_51.bin"
	.incbin	"../../chr.smb/chr_obj_52.bin"
	.incbin	"../../chr.smb/chr_obj_53.bin"
chr_obj_bowser_flame_end:

.endif	; FIRE_KOOPA
