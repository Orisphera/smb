.segment	"CHR1DATA"

.include	"sys/ppu.i"

	.export chr_obj_princess_a
	.export chr_obj_princess_b
	.export chr_obj_princess_c
chr_obj_princess_a:
	.incbin	"data/chr2.ann/chr_obj_76.bin"
	.incbin	"data/chr2.ann/chr_obj_77.bin"

chr_obj_princess_b:
	.incbin	"data/chr2.ann/chr_obj_78.bin"

chr_obj_princess_c:
	.incbin	"data/chr2.ann/chr_obj_79.bin"

	.export chr_obj_toads_nsm
	.export	chr_obj_toads_nsm_a
	.export	chr_obj_toads_nsm_b
	.export	chr_obj_toads_nsm_c
	.export	chr_obj_toads_nsm_d
	.export	chr_obj_toads_nsm_e
	.export	chr_obj_toads_nsm_f
	.export	chr_obj_toads_nsm_g
chr_obj_toads_nsm:
chr_obj_toads_nsm_a:
	.incbin	"data/chr2.ann/chr_obj_7A.bin"
	.incbin	"data/chr2.ann/chr_obj_7B.bin"
	.incbin	"data/chr2.ann/chr_obj_7C.bin"
	.incbin	"data/chr2.ann/chr_obj_7D.bin"
	.incbin	"data/chr2.ann/chr_obj_7E.bin"
	.incbin	"data/chr2.ann/chr_obj_7F.bin"

chr_obj_toads_nsm_b:
	.incbin	"data/chr2.ann/chr_obj_80.bin"
	.incbin	"data/chr2.ann/chr_obj_81.bin"
	.incbin	"data/chr2.ann/chr_obj_82.bin"
	.incbin	"data/chr2.ann/chr_obj_83.bin"
	.incbin	"data/chr2.ann/chr_obj_84.bin"
	.incbin	"data/chr2.ann/chr_obj_85.bin"

chr_obj_toads_nsm_c:
	.incbin	"data/chr2.ann/chr_obj_86.bin"
	.incbin	"data/chr2.ann/chr_obj_87.bin"
	.incbin	"data/chr2.ann/chr_obj_88.bin"
	.incbin	"data/chr2.ann/chr_obj_89.bin"
	.incbin	"data/chr2.ann/chr_obj_8A.bin"
	.incbin	"data/chr2.ann/chr_obj_8B.bin"

chr_obj_toads_nsm_d:
	.incbin	"data/chr2.ann/chr_obj_8C.bin"
	.incbin	"data/chr2.ann/chr_obj_8D.bin"
	.incbin	"data/chr2.ann/chr_obj_8E.bin"
	.incbin	"data/chr2.ann/chr_obj_8F.bin"
	.incbin	"data/chr2.ann/chr_obj_90.bin"
	.incbin	"data/chr2.ann/chr_obj_91.bin"

chr_obj_toads_nsm_e:
	.incbin	"data/chr2.ann/chr_obj_92.bin"
	.incbin	"data/chr2.ann/chr_obj_93.bin"
	.incbin	"data/chr2.ann/chr_obj_94.bin"
	.incbin	"data/chr2.ann/chr_obj_95.bin"
	.incbin	"data/chr2.ann/chr_obj_96.bin"
	.incbin	"data/chr2.ann/chr_obj_97.bin"

chr_obj_toads_nsm_f:
	.incbin	"data/chr2.ann/chr_obj_98.bin"
	.incbin	"data/chr2.ann/chr_obj_99.bin"
	.incbin	"data/chr2.ann/chr_obj_9A.bin"
	.incbin	"data/chr2.ann/chr_obj_9B.bin"
	.incbin	"data/chr2.ann/chr_obj_9C.bin"
	.incbin	"data/chr2.ann/chr_obj_9D.bin"

chr_obj_toads_nsm_g:
	.incbin	"data/chr2.ann/chr_obj_9E.bin"
	.incbin	"data/chr2.ann/chr_obj_9F.bin"
	.incbin	"data/chr2.ann/chr_obj_A0.bin"
	.incbin	"data/chr2.ann/chr_obj_A1.bin"
	.incbin	"data/chr2.ann/chr_obj_A2.bin"
	.incbin	"data/chr2.ann/chr_obj_A3.bin"

	.res	24*PPU_CHR_SIZE, 0
