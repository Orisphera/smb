.ifndef UNK_I
UNK_I = 1

nmi			= $8082
oam_init		= $8220
nt_init			= $8E19
eng_sta_ppu_ctlr0	= $8EED
sub_clearram		= $90CC
irq			= $FFF0

eng_game_mode		= $770
eng_disp_disable	= $774
ppu_ctlr0_b		= $778
eng_rand_seed		= $7A7
eng_score		= $7D7
eng_score_end		= $7DD
eng_boot_flag		= $7FF

START_WARMBOOT_FLAG	= $A5

START_WARMBOOT_VAL	= $D6
START_COLDBOOT_VAL	= $FE

.endif	; UNK_I