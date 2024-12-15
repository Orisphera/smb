.ifndef	TILES_I
TILES_I = 1

.include	"./misc.i"

TILE_PAGE_BIT_OFFSET = 6
TILE_PAGE_0	= (0<<TILE_PAGE_BIT_OFFSET)
TILE_PAGE_1	= (1<<TILE_PAGE_BIT_OFFSET)
TILE_PAGE_2	= (2<<TILE_PAGE_BIT_OFFSET)
TILE_PAGE_3	= (3<<TILE_PAGE_BIT_OFFSET)
TILE_PAGE_BITS	= %11000000
TILE_ENTRY_BITS	= %00111111

	.enum	metatile_0
		blank_a		= <((bg_meta_block_0_blank_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		blank_b		= <((bg_meta_block_0_blank_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bush_a		= <((bg_meta_block_0_bush_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bush_b		= <((bg_meta_block_0_bush_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bush_c		= <((bg_meta_block_0_bush_c-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_a		= <((bg_meta_block_0_hill_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_b		= <((bg_meta_block_0_hill_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_c		= <((bg_meta_block_0_hill_c-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_d		= <((bg_meta_block_0_hill_d-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_e		= <((bg_meta_block_0_hill_e-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_f		= <((bg_meta_block_0_hill_f-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bridge_rope	= <((bg_meta_block_0_bridge_rope-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		chain		= <((bg_meta_block_0_chain-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		tree_a		= <((bg_meta_block_0_tree_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		tree_b		= <((bg_meta_block_0_tree_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		tree_c		= <((bg_meta_block_0_tree_c-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0

		cutoff		= <((bg_meta_block_0_cutoff-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0

		pipe_v_a	= <((bg_meta_block_0_pipe_v_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_b	= <((bg_meta_block_0_pipe_v_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_c	= <((bg_meta_block_0_pipe_v_c-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_d	= <((bg_meta_block_0_pipe_v_d-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_e	= <((bg_meta_block_0_pipe_v_e-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_f	= <((bg_meta_block_0_pipe_v_f-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		plat_b_a	= <((bg_meta_block_0_plat_b_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		plat_b_b	= <((bg_meta_block_0_plat_b_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		plat_b_c	= <((bg_meta_block_0_plat_b_c-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_a	= <((bg_meta_block_0_pipe_h_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_b	= <((bg_meta_block_0_pipe_h_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_c	= <((bg_meta_block_0_pipe_h_c-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_d	= <((bg_meta_block_0_pipe_h_d-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_e	= <((bg_meta_block_0_pipe_h_e-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_f	= <((bg_meta_block_0_pipe_h_f-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		coral		= <((bg_meta_block_0_coral-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		blank_d		= <((bg_meta_block_0_blank_d-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0

		flag_ball	= <((bg_meta_block_0_flag_ball-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pole		= <((bg_meta_block_0_pole-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		climb_blank	= <((bg_meta_block_0_climb_blank-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		.if	.defined(SMBM)|.defined(VS_SMB)
			plat_a_a	= <((bg_meta_block_0_plat_a_a-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
			plat_a_b	= <((bg_meta_block_0_plat_a_b-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
			plat_a_c	= <((bg_meta_block_0_plat_a_c-bg_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		.endif
	.endenum

	.enum	metatile_1
		pulley_a	= <((bg_meta_block_1_pulley_a-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_b	= <((bg_meta_block_1_pulley_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_c	= <((bg_meta_block_1_pulley_c-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_d	= <((bg_meta_block_1_pulley_d-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_e	= <((bg_meta_block_1_pulley_e-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_a	= <((bg_meta_block_1_castle_a-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_b	= <((bg_meta_block_1_castle_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_c	= <((bg_meta_block_1_castle_c-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_d	= <((bg_meta_block_1_castle_d-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_e	= <((bg_meta_block_1_castle_e-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_f	= <((bg_meta_block_1_castle_f-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_g	= <((bg_meta_block_1_castle_g-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		plat_b		= <((bg_meta_block_1_plat_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		post		= <((bg_meta_block_1_post-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		tree_trunk	= <((bg_meta_block_1_tree_trunk-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.if	.defined(SMBM)|.defined(VS_SMB)
			tree_a		= <((bg_meta_block_1_tree_a-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
			tree_b		= <((bg_meta_block_1_tree_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.endif
		cutoff		= <((bg_meta_block_1_cutoff-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1	

		brick_a		= <((bg_meta_block_1_brick_a-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_b		= <((bg_meta_block_1_brick_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1	
		floor_normal	= <((bg_meta_block_1_floor_normal-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_d		= <((bg_meta_block_1_brick_d-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_e		= <((bg_meta_block_1_brick_e-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_f		= <((bg_meta_block_1_brick_f-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_g		= <((bg_meta_block_1_brick_g-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_h		= <((bg_meta_block_1_brick_h-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_i		= <((bg_meta_block_1_brick_i-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_j		= <((bg_meta_block_1_brick_j-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_k		= <((bg_meta_block_1_brick_k-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_l		= <((bg_meta_block_1_brick_l-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_m		= <((bg_meta_block_1_brick_m-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		blank_b		= <((bg_meta_block_1_blank_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		blank_c		= <((bg_meta_block_1_blank_c-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1

		stair		= <((bg_meta_block_1_stair-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		floor_castle	= <((bg_meta_block_1_floor_castle-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		bridge_base	= <((bg_meta_block_1_bridge_base-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		cannon_a	= <((bg_meta_block_1_cannon_a-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		cannon_b	= <((bg_meta_block_1_cannon_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		cannon_c	= <((bg_meta_block_1_cannon_c-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		spring_bg_a	= <((bg_meta_block_1_spring_bg_a-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		spring_bg_b	= <((bg_meta_block_1_spring_bg_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		floor_underwater = <((bg_meta_block_1_floor_underwater-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pipe_water_a	= <((bg_meta_block_1_pipe_water_a-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pipe_water_b	= <((bg_meta_block_1_pipe_water_b-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		flag_ball	= <((bg_meta_block_1_flag_ball-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.if	.defined(SMBV2)
			blank_d		= <((bg_meta_block_1_blank_d-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.endif
		.if	.defined(SMB2)
			brick_n		= <((bg_meta_block_1_brick_n-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
			brick_o		= <((bg_meta_block_1_brick_o-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
			blank_e		= <((bg_meta_block_1_blank_e-bg_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.endif
	.endenum

	.enum	metatile_2
		cloud_a		= <((bg_meta_block_2_cloud_a-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_b		= <((bg_meta_block_2_cloud_b-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_c		= <((bg_meta_block_2_cloud_c-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_d		= <((bg_meta_block_2_cloud_d-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_e		= <((bg_meta_block_2_cloud_e-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_f		= <((bg_meta_block_2_cloud_f-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		water_a		= <((bg_meta_block_2_water_a-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		water_b		= <((bg_meta_block_2_water_b-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2

		cutoff		= <((bg_meta_block_2_cutoff-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2

		cloud_small	= <((bg_meta_block_2_cloud_small-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		bridge_castle	= <((bg_meta_block_2_bridge_castle-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		.if	.defined(SMB2)
			plat_a_a	= <((bg_meta_block_2_plat_a_a-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
			plat_a_b	= <((bg_meta_block_2_plat_a_b-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
			plat_a_c	= <((bg_meta_block_2_plat_a_c-bg_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		.endif

		.if	.defined(SMBM)|.defined(VS_SMB)|.defined(ANN)
			end	= bridge_castle+1
		.elseif	.defined(SMB2)
			end = plat_a_c+1
		.endif
	.endenum

	.enum	metatile_3
		cutoff		= <((bg_meta_block_3_cutoff-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3

		block_q_set	= <((bg_meta_block_3_block_q_set-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		block_q_a	= <((bg_meta_block_3_block_q_a-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		block_q_b	= <((bg_meta_block_3_block_q_b-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		.if	.defined(SMB2)
			block_q_c	= <((bg_meta_block_3_block_q_c-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		.endif
		coin_a		= <((bg_meta_block_3_coin_a-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		coin_b		= <((bg_meta_block_3_coin_b-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3

		block_invis	= <((bg_meta_block_3_block_invis-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		axe	= <((bg_meta_block_3_axe-bg_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3

		end	= axe+1
	.endenum

.if	.defined(SMBM)|.defined(VS_SMB)
	METATILE_PLAT_A_A	= metatile_0::plat_a_a
	METATILE_PLAT_A_B	= metatile_0::plat_a_b
	METATILE_PLAT_A_C	= metatile_0::plat_a_c

	BLOCK_TILE_OFFSET	= $5
.elseif	.defined(SMB2)
	METATILE_PLAT_A_A	= metatile_2::plat_a_a
	METATILE_PLAT_A_B	= metatile_2::plat_a_b
	METATILE_PLAT_A_C	= metatile_2::plat_a_c

	BLOCK_TILE_OFFSET	= $6
.endif

.endif	; TILES_I

