.ifndef	TILES_I
TILES_I = 1

TILE_PAGE_0	= %00000000
TILE_PAGE_1	= %01000000
TILE_PAGE_2	= %10000000
TILE_PAGE_3	= %11000000
TILE_PAGE_BITS	= %11000000
TILE_ENTRY_BITS	= %00111111
METATILE_SIZE	= 4

	.enum	metatile_0
		blank_a		= <((gfx_meta_block_0_blank_a-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		blank_b		= <((gfx_meta_block_0_blank_b-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_e	= <((gfx_meta_block_0_pipe_v_e-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
		pipe_v_f	= <((gfx_meta_block_0_pipe_v_f-gfx_meta_block_0)/METATILE_SIZE)|TILE_PAGE_0
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
	.endenum

.if	.defined(SMB)|.defined(VS_SMB)
	LEDGE_MUSHROOM_TILE_A	= $19
	LEDGE_MUSHROOM_TILE_B	= $1A
	LEDGE_MUSHROOM_TILE_C	= $1B

	BRICK_TILE_B		= $51
	FG_BASE_TILE_C		= $52
	FG_BASE_TILE_B		= $54
	BLOCK_TILE_H		= $55
	BLOCK_TILE_I		= $56
	BLOCK_TILE_J		= $57
	BLOCK_TILE_A		= $58
	BLOCK_TILE_K		= $59
	BLOCK_TILE_L		= $5A
	BLOCK_TILE_M		= $5B
	BLOCK_TILE_N		= $5C
	BLOCK_TILE_B		= $5D
	BLOCK_TILE_O		= $5E
	BLOCK_TILE_F		= $5F
	BLOCK_TILE_G		= $60
	POLE_TILE_C		= $61
	FG_BASE_TILE_D		= $62
	BRIDGE_TILE		= $63
	CANNON_TILE_A		= $64
	CANNON_TILE_B		= $65
	CANNON_TILE_C		= $66
	SPRING_TILE_A		= $67
	SPRING_TILE_B		= $68
	FG_BASE_TILE_A		= $69
	PIPE_WATER_TILE_A	= $6B
	PIPE_WATER_TILE_B	= $6C
	POLE_TIP_TILE		= $6D

	BLOCK_TILE_D		= $C0
	BLOCK_TILE_E		= $C1
	COINROW_TILE_A		= $C2
	COINROW_TILE_B		= $C3
	CASTLE_BRIDGE_TILE_A	= $C4
	CASTLE_BRIDGE_TILE_B	= $C5

	BLOCK_TILE_OFFSET	= $5
.elseif	.defined(SMB2)
	BRICK_TILE_B		= $4F
	FG_BASE_TILE_C		= $50
	BLOCK_TILE_S		= $52
	BLOCK_TILE_H		= $53
	BLOCK_TILE_I		= $54
	BLOCK_TILE_J		= $55
	BLOCK_TILE_A		= $56
	BLOCK_TILE_K		= $57
	BLOCK_TILE_T		= $58
	BLOCK_TILE_L		= $59
	BLOCK_TILE_M		= $5A
	BLOCK_TILE_N		= $5B
	BLOCK_TILE_B		= $5C
	BLOCK_TILE_O		= $5D
	BLOCK_TILE_Q		= $5E
	BLOCK_TILE_R		= $5F
	BLOCK_TILE_F		= $60
	BLOCK_TILE_G		= $61
	POLE_TILE_C		= $62
	FG_BASE_TILE_D		= $63
	BRIDGE_TILE		= $64
	CANNON_TILE_A		= $65
	CANNON_TILE_B		= $66
	CANNON_TILE_C		= $67
	SPRING_TILE_A		= $68
	SPRING_TILE_B		= $69
	FG_BASE_TILE_A		= $6A
	FG_BASE_TILE_B		= $6B
	PIPE_WATER_TILE_A	= $6D
	PIPE_WATER_TILE_B	= $6E
	POLE_TIP_TILE		= $6F

	LEDGE_MUSHROOM_TILE_A	= $8A
	LEDGE_MUSHROOM_TILE_B	= $8B
	LEDGE_MUSHROOM_TILE_C	= $8C

	BLOCK_TILE_P		= $C0
	BLOCK_TILE_D		= $C1
	BLOCK_TILE_E		= $C2
	COINROW_TILE_A		= $C3
	COINROW_TILE_B		= $C4
	CASTLE_BRIDGE_TILE_A	= $C5
	CASTLE_BRIDGE_TILE_B	= $C6

	BLOCK_TILE_OFFSET	= $6
.elseif	.defined(ANN)
	LEDGE_MUSHROOM_TILE_A	= $19
	LEDGE_MUSHROOM_TILE_B	= $1A
	LEDGE_MUSHROOM_TILE_C	= $1B

	BRICK_TILE_B		= $51
	FG_BASE_TILE_C		= $52
	BLOCK_TILE_H		= $54
	BLOCK_TILE_I		= $55
	BLOCK_TILE_J		= $56
	BLOCK_TILE_A		= $57
	BLOCK_TILE_K		= $58
	BLOCK_TILE_L		= $59
	BLOCK_TILE_M		= $5A
	BLOCK_TILE_N		= $5B
	BLOCK_TILE_B		= $5C
	BLOCK_TILE_O		= $5D
	BLOCK_TILE_R		= $5E
	BLOCK_TILE_F		= $5F
	BLOCK_TILE_G		= $60
	POLE_TILE_C		= $61
	FG_BASE_TILE_D		= $62
	BRIDGE_TILE		= $63
	CANNON_TILE_A		= $64
	CANNON_TILE_B		= $65
	CANNON_TILE_C		= $66
	SPRING_TILE_A		= $67
	SPRING_TILE_B		= $68
	FG_BASE_TILE_A		= $69
	FG_BASE_TILE_B		= $6A
	PIPE_WATER_TILE_A	= $6C
	PIPE_WATER_TILE_B	= $6D
	POLE_TIP_TILE		= $6E

	BLOCK_TILE_P		= $BF

	BLOCK_TILE_D		= $C0
	BLOCK_TILE_E		= $C1
	COINROW_TILE_A		= $C2
	COINROW_TILE_B		= $C3
	CASTLE_BRIDGE_TILE_A	= $C4
	CASTLE_BRIDGE_TILE_B	= $C5
	BLOCK_TILE_OFFSET	= $5
.endif

.endif	; TILES_I
