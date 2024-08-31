.segment	"CHR1DATA"

.include	"system/ppu.i"

	.export tile_obj_princess_a
	.export tile_obj_princess_b
	.export tile_obj_princess_c
tile_obj_princess_a:
	.incbin	"data/chr2.ann/tile_obj_76.bin"
	.incbin	"data/chr2.ann/tile_obj_77.bin"

tile_obj_princess_b:
	.incbin	"data/chr2.ann/tile_obj_78.bin"

tile_obj_princess_c:
	.incbin	"data/chr2.ann/tile_obj_79.bin"

	.export tile_obj_toads_chr2
tile_obj_toads_chr2:
	.incbin	"data/chr2.ann/tile_obj_7A.bin"
	.incbin	"data/chr2.ann/tile_obj_7B.bin"
	.incbin	"data/chr2.ann/tile_obj_7C.bin"
	.incbin	"data/chr2.ann/tile_obj_7D.bin"
	.incbin	"data/chr2.ann/tile_obj_7E.bin"
	.incbin	"data/chr2.ann/tile_obj_7F.bin"
	.incbin	"data/chr2.ann/tile_obj_80.bin"
	.incbin	"data/chr2.ann/tile_obj_81.bin"
	.incbin	"data/chr2.ann/tile_obj_82.bin"
	.incbin	"data/chr2.ann/tile_obj_83.bin"
	.incbin	"data/chr2.ann/tile_obj_84.bin"
	.incbin	"data/chr2.ann/tile_obj_85.bin"
	.incbin	"data/chr2.ann/tile_obj_86.bin"
	.incbin	"data/chr2.ann/tile_obj_87.bin"
	.incbin	"data/chr2.ann/tile_obj_88.bin"
	.incbin	"data/chr2.ann/tile_obj_89.bin"
	.incbin	"data/chr2.ann/tile_obj_8A.bin"
	.incbin	"data/chr2.ann/tile_obj_8B.bin"
	.incbin	"data/chr2.ann/tile_obj_8C.bin"
	.incbin	"data/chr2.ann/tile_obj_8D.bin"
	.incbin	"data/chr2.ann/tile_obj_8E.bin"
	.incbin	"data/chr2.ann/tile_obj_8F.bin"
	.incbin	"data/chr2.ann/tile_obj_90.bin"
	.incbin	"data/chr2.ann/tile_obj_91.bin"
	.incbin	"data/chr2.ann/tile_obj_92.bin"
	.incbin	"data/chr2.ann/tile_obj_93.bin"
	.incbin	"data/chr2.ann/tile_obj_94.bin"
	.incbin	"data/chr2.ann/tile_obj_95.bin"
	.incbin	"data/chr2.ann/tile_obj_96.bin"
	.incbin	"data/chr2.ann/tile_obj_97.bin"
	.incbin	"data/chr2.ann/tile_obj_98.bin"
	.incbin	"data/chr2.ann/tile_obj_99.bin"
	.incbin	"data/chr2.ann/tile_obj_9A.bin"
	.incbin	"data/chr2.ann/tile_obj_9B.bin"
	.incbin	"data/chr2.ann/tile_obj_9C.bin"
	.incbin	"data/chr2.ann/tile_obj_9D.bin"
	.incbin	"data/chr2.ann/tile_obj_9E.bin"
	.incbin	"data/chr2.ann/tile_obj_9F.bin"
	.incbin	"data/chr2.ann/tile_obj_A0.bin"
	.incbin	"data/chr2.ann/tile_obj_A1.bin"
	.incbin	"data/chr2.ann/tile_obj_A2.bin"
	.incbin	"data/chr2.ann/tile_obj_A3.bin"

	.res	24*PPU_TILE_SIZE, 0
