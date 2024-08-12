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
		blank_a		= <((gfx_meta_block_0_blank_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		blank_b		= <((gfx_meta_block_0_blank_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bush_a		= <((gfx_meta_block_0_bush_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bush_b		= <((gfx_meta_block_0_bush_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bush_c		= <((gfx_meta_block_0_bush_c-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_a		= <((gfx_meta_block_0_hill_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_b		= <((gfx_meta_block_0_hill_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_c		= <((gfx_meta_block_0_hill_c-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_d		= <((gfx_meta_block_0_hill_d-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_e		= <((gfx_meta_block_0_hill_e-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		hill_f		= <((gfx_meta_block_0_hill_f-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		bridge_rope	= <((gfx_meta_block_0_bridge_rope-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		chain		= <((gfx_meta_block_0_chain-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		tree_a		= <((gfx_meta_block_0_tree_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		tree_b		= <((gfx_meta_block_0_tree_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		tree_c		= <((gfx_meta_block_0_tree_c-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0

		cutoff		= <((gfx_meta_block_0_cutoff-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0

		pipe_v_a	= <((gfx_meta_block_0_pipe_v_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_b	= <((gfx_meta_block_0_pipe_v_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_c	= <((gfx_meta_block_0_pipe_v_c-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_d	= <((gfx_meta_block_0_pipe_v_d-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_e	= <((gfx_meta_block_0_pipe_v_e-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_f	= <((gfx_meta_block_0_pipe_v_f-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		plat_b_a	= <((gfx_meta_block_0_plat_b_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		plat_b_b	= <((gfx_meta_block_0_plat_b_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		plat_b_c	= <((gfx_meta_block_0_plat_b_c-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_a	= <((gfx_meta_block_0_pipe_h_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_b	= <((gfx_meta_block_0_pipe_h_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_c	= <((gfx_meta_block_0_pipe_h_c-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_d	= <((gfx_meta_block_0_pipe_h_d-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_e	= <((gfx_meta_block_0_pipe_h_e-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_h_f	= <((gfx_meta_block_0_pipe_h_f-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		coral		= <((gfx_meta_block_0_coral-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		blank_d		= <((gfx_meta_block_0_blank_d-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0

		flag_ball	= <((gfx_meta_block_0_flag_ball-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pole		= <((gfx_meta_block_0_pole-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		climb_blank	= <((gfx_meta_block_0_climb_blank-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		.if	.defined(SMBM)|.defined(VS_SMB)
			plat_a_a	= <((gfx_meta_block_0_plat_a_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
			plat_a_b	= <((gfx_meta_block_0_plat_a_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
			plat_a_c	= <((gfx_meta_block_0_plat_a_c-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		.endif
	.endenum

	.enum	metatile_1
		pulley_a	= <((gfx_meta_block_1_pulley_a-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_b	= <((gfx_meta_block_1_pulley_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_c	= <((gfx_meta_block_1_pulley_c-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_d	= <((gfx_meta_block_1_pulley_d-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pulley_e	= <((gfx_meta_block_1_pulley_e-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_a	= <((gfx_meta_block_1_castle_a-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_b	= <((gfx_meta_block_1_castle_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_c	= <((gfx_meta_block_1_castle_c-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_d	= <((gfx_meta_block_1_castle_d-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_e	= <((gfx_meta_block_1_castle_e-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_f	= <((gfx_meta_block_1_castle_f-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		castle_g	= <((gfx_meta_block_1_castle_g-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		plat_b		= <((gfx_meta_block_1_plat_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		post		= <((gfx_meta_block_1_post-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		tree_trunk	= <((gfx_meta_block_1_tree_trunk-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.if	.defined(SMBM)|.defined(VS_SMB)
			tree_a		= <((gfx_meta_block_1_tree_a-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
			tree_b		= <((gfx_meta_block_1_tree_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.endif
		cutoff		= <((gfx_meta_block_1_cutoff-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1	

		brick_a		= <((gfx_meta_block_1_brick_a-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_b		= <((gfx_meta_block_1_brick_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1	
		floor_normal	= <((gfx_meta_block_1_floor_normal-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_d		= <((gfx_meta_block_1_brick_d-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_e		= <((gfx_meta_block_1_brick_e-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_f		= <((gfx_meta_block_1_brick_f-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_g		= <((gfx_meta_block_1_brick_g-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_h		= <((gfx_meta_block_1_brick_h-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_i		= <((gfx_meta_block_1_brick_i-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_j		= <((gfx_meta_block_1_brick_j-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_k		= <((gfx_meta_block_1_brick_k-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_l		= <((gfx_meta_block_1_brick_l-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		brick_m		= <((gfx_meta_block_1_brick_m-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		blank_b		= <((gfx_meta_block_1_blank_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		blank_c		= <((gfx_meta_block_1_blank_c-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1

		stair		= <((gfx_meta_block_1_stair-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		floor_castle	= <((gfx_meta_block_1_floor_castle-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		bridge_base	= <((gfx_meta_block_1_bridge_base-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		cannon_a	= <((gfx_meta_block_1_cannon_a-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		cannon_b	= <((gfx_meta_block_1_cannon_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		cannon_c	= <((gfx_meta_block_1_cannon_c-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		spring_bg_a	= <((gfx_meta_block_1_spring_bg_a-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		spring_bg_b	= <((gfx_meta_block_1_spring_bg_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		floor_underwater = <((gfx_meta_block_1_floor_underwater-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pipe_water_a	= <((gfx_meta_block_1_pipe_water_a-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		pipe_water_b	= <((gfx_meta_block_1_pipe_water_b-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		flag_ball	= <((gfx_meta_block_1_flag_ball-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.if	.defined(SMB2M)
			blank_d		= <((gfx_meta_block_1_blank_d-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.endif
		.if	.defined(SMB2)
			brick_n		= <((gfx_meta_block_1_brick_n-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
			brick_o		= <((gfx_meta_block_1_brick_o-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
			blank_e		= <((gfx_meta_block_1_blank_e-gfx_meta_block_1)/METATILE_SIZE)|TILE_PAGE_1
		.endif
	.endenum

	.enum	metatile_2
		cloud_a		= <((gfx_meta_block_2_cloud_a-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_b		= <((gfx_meta_block_2_cloud_b-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_c		= <((gfx_meta_block_2_cloud_c-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_d		= <((gfx_meta_block_2_cloud_d-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_e		= <((gfx_meta_block_2_cloud_e-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		cloud_f		= <((gfx_meta_block_2_cloud_f-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		water_a		= <((gfx_meta_block_2_water_a-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		water_b		= <((gfx_meta_block_2_water_b-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2

		cutoff		= <((gfx_meta_block_2_cutoff-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2

		cloud_small	= <((gfx_meta_block_2_cloud_small-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		bridge_castle	= <((gfx_meta_block_2_bridge_castle-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		.if	.defined(SMB2)
			plat_a_a	= <((gfx_meta_block_2_plat_a_a-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
			plat_a_b	= <((gfx_meta_block_2_plat_a_b-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
			plat_a_c	= <((gfx_meta_block_2_plat_a_c-gfx_meta_block_2)/METATILE_SIZE)|TILE_PAGE_2
		.endif

		.if	.defined(SMBM)|.defined(VS_SMB)|.defined(ANN)
			end	= bridge_castle+1
		.elseif	.defined(SMB2)
			end = plat_a_c+1
		.endif
	.endenum

	.enum	metatile_3
		cutoff		= <((gfx_meta_block_3_cutoff-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3

		block_q_set	= <((gfx_meta_block_3_block_q_set-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		block_q_a	= <((gfx_meta_block_3_block_q_a-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		block_q_b	= <((gfx_meta_block_3_block_q_b-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		.if	.defined(SMB2)
			block_q_c	= <((gfx_meta_block_3_block_q_c-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		.endif
		coin_a		= <((gfx_meta_block_3_coin_a-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		coin_b		= <((gfx_meta_block_3_coin_b-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3

		axe_block	= <((gfx_meta_block_3_axe_block-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3
		axe	= <((gfx_meta_block_3_axe-gfx_meta_block_3)/METATILE_SIZE)|TILE_PAGE_3

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

