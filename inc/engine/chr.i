.ifndef	CHR_I
CHR_I = 1

.include	"../system/ppu.i"

	.enum	tile_bg
		blanks		= <((tile_bg_blanks-chr_bg)/PPU_TILE_SIZE)
		cannon_base_left = <((tile_bg_cannon_base_left-chr_bg)/PPU_TILE_SIZE)
		plat_a_mid	= <((tile_bg_plat_a_mid-chr_bg)/PPU_TILE_SIZE)
		flag_ball_a	= <((tile_bg_flag_ball_a-chr_bg)/PPU_TILE_SIZE)
		hill_a		= <((tile_bg_hill_a-chr_bg)/PPU_TILE_SIZE)
		hill_b		= <((tile_bg_hill_b-chr_bg)/PPU_TILE_SIZE)
		cloud		= <((tile_bg_cloud-chr_bg)/PPU_TILE_SIZE)
		flag_ball_b	= <((tile_bg_flag_ball_b-chr_bg)/PPU_TILE_SIZE)
		pulley_a	= <((tile_bg_pulley_a-chr_bg)/PPU_TILE_SIZE)
		cannon_base_right = <((tile_bg_cannon_base_right-chr_bg)/PPU_TILE_SIZE)
		water		= <((tile_bg_water-chr_bg)/PPU_TILE_SIZE)
		brick_a		= <((tile_bg_brick_a-chr_bg)/PPU_TILE_SIZE)
		brick_b		= <((tile_bg_brick_b-chr_bg)/PPU_TILE_SIZE)
		plat_b		= <((tile_bg_plat_b-chr_bg)/PPU_TILE_SIZE)
		block_q		= <((tile_bg_block_q-chr_bg)/PPU_TILE_SIZE)
		block_empty	= <((tile_bg_block_empty-chr_bg)/PPU_TILE_SIZE)
		pulley_b	= <((tile_bg_pulley_b-chr_bg)/PPU_TILE_SIZE)
		floor_castle	= <((tile_bg_floor_castle-chr_bg)/PPU_TILE_SIZE)
		pipe_v		= <((tile_bg_pipe_v-chr_bg)/PPU_TILE_SIZE)
		plat_a		= <((tile_bg_plat_a-chr_bg)/PPU_TILE_SIZE)
		.if	.defined(SMBM)|.defined(VS_SMB)
			edge_b		= <((tile_bg_edge_b-chr_bg)/PPU_TILE_SIZE)
		.endif
		.if	.defined(SMB2M)
			quotes	= <((tile_bg_quotes-chr_bg)/PPU_TILE_SIZE)
		.endif
		bridge_a	= <((tile_bg_bridge_a-chr_bg)/PPU_TILE_SIZE)
		bridge_b	= <((tile_bg_bridge_b-chr_bg)/PPU_TILE_SIZE)
		axe		= <((tile_bg_axe-chr_bg)/PPU_TILE_SIZE)
		chain		= <((tile_bg_chain-chr_bg)/PPU_TILE_SIZE)
		post_a		= <((tile_bg_post_a-chr_bg)/PPU_TILE_SIZE)
		floor_underwater = <((tile_bg_floor_underwater-chr_bg)/PPU_TILE_SIZE)
		pipe_h		= <((tile_bg_pipe_h-chr_bg)/PPU_TILE_SIZE)
		rope		= <((tile_bg_rope-chr_bg)/PPU_TILE_SIZE)
		castle_a	= <((tile_bg_castle_a-chr_bg)/PPU_TILE_SIZE)
		post_b		= <((tile_bg_post_b-chr_bg)/PPU_TILE_SIZE)
		pole		= <((tile_bg_pole-chr_bg)/PPU_TILE_SIZE)
		coral_a		= <((tile_bg_coral_a-chr_bg)/PPU_TILE_SIZE)
		coin_a		= <((tile_bg_coin_a-chr_bg)/PPU_TILE_SIZE)
		castle_b	= <((tile_bg_castle_b-chr_bg)/PPU_TILE_SIZE)
		stair		= <((tile_bg_stair-chr_bg)/PPU_TILE_SIZE)
		cloud_small	= <((tile_bg_cloud_small-chr_bg)/PPU_TILE_SIZE)
		floor_normal	= <((tile_bg_floor_normal-chr_bg)/PPU_TILE_SIZE)
		tree		= <((tile_bg_tree-chr_bg)/PPU_TILE_SIZE)
		tree_trunk	= <((tile_bg_tree_trunk-chr_bg)/PPU_TILE_SIZE)
		bridge_parts	= <((tile_bg_bridge_parts-chr_bg)/PPU_TILE_SIZE)
		coin_b		= <((tile_bg_coin_b-chr_bg)/PPU_TILE_SIZE)
		cannon		= <((tile_bg_cannon-chr_bg)/PPU_TILE_SIZE)
		coral_b		= <((tile_bg_coral_b-chr_bg)/PPU_TILE_SIZE)
	.endenum

.endif	; CHR_I
