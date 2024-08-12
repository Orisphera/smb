.include	"engine/chr.i"

        .export gfx_metatile_lo, gfx_metatile_hi
gfx_metatile_lo:
	.byte	<gfx_meta_block_0, <gfx_meta_block_1, <gfx_meta_block_2, <gfx_meta_block_3

gfx_metatile_hi:
	.byte	>gfx_meta_block_0, >gfx_meta_block_1, >gfx_meta_block_2, >gfx_meta_block_3
; ---
	.export gfx_meta_block_0
gfx_meta_block_0:
; ---
	.export gfx_meta_block_0_blank_a
gfx_meta_block_0_blank_a:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_0_blank_b
gfx_meta_block_0_blank_b:
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
; ---
	.export gfx_meta_block_0_bush_a
	.export gfx_meta_block_0_bush_b
	.export gfx_meta_block_0_bush_c
gfx_meta_block_0_bush_a:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud

gfx_meta_block_0_bush_b:
	.byte	tile_bg::cloud+1
	.byte	tile_bg::blanks+1
	.byte	tile_bg::cloud+2
	.byte	tile_bg::blanks+1

gfx_meta_block_0_bush_c:
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+3
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_0_hill_a, gfx_meta_block_0_hill_b
	.export gfx_meta_block_0_hill_c, gfx_meta_block_0_hill_d
	.export gfx_meta_block_0_hill_e, gfx_meta_block_0_hill_f
gfx_meta_block_0_hill_a:
	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a
	.byte	tile_bg::hill_a
	.byte	tile_bg::blanks+2

gfx_meta_block_0_hill_b:
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::hill_a+4
	.byte	tile_bg::blanks+2

gfx_meta_block_0_hill_c:
	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a+1
	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a+2

gfx_meta_block_0_hill_d:
	.byte	tile_bg::hill_a+3
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks
	.byte	tile_bg::hill_a+3

gfx_meta_block_0_hill_e:
	.byte	tile_bg::hill_a+4
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2

gfx_meta_block_0_hill_f:
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
; ---
	.export gfx_meta_block_0_bridge_rope
gfx_meta_block_0_bridge_rope:
	.byte	tile_bg::blanks
	.byte	tile_bg::bridge_parts
	.byte	tile_bg::blanks
	.byte	tile_bg::bridge_parts
; ---
	.export gfx_meta_block_0_chain
gfx_meta_block_0_chain:
	.byte	tile_bg::blanks
	.byte	tile_bg::chain
	.byte	tile_bg::chain
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_0_tree_a
	.export gfx_meta_block_0_tree_b
	.export gfx_meta_block_0_tree_c
gfx_meta_block_0_tree_a:
	.byte	tile_bg::tree
	.byte	tile_bg::tree+2
	.byte	tile_bg::tree+1
	.byte	tile_bg::tree+3

gfx_meta_block_0_tree_b:
	.byte	tile_bg::tree
	.byte	tile_bg::tree+4
	.byte	tile_bg::tree+1
	.byte	tile_bg::tree+5

gfx_meta_block_0_tree_c:
	.byte	tile_bg::tree+2
	.byte	tile_bg::tree+4
	.byte	tile_bg::tree+3
	.byte	tile_bg::tree+5
; ---
	.export gfx_meta_block_0_cutoff
gfx_meta_block_0_cutoff:
; ---
	.export gfx_meta_block_0_pipe_v_a, gfx_meta_block_0_pipe_v_b
	.export gfx_meta_block_0_pipe_v_c, gfx_meta_block_0_pipe_v_d
	.export	gfx_meta_block_0_pipe_v_e, gfx_meta_block_0_pipe_v_f
gfx_meta_block_0_pipe_v_a:
	.byte	tile_bg::pipe_v
	.byte	tile_bg::pipe_v+4
	.byte	tile_bg::pipe_v+1
	.byte	tile_bg::pipe_v+5

gfx_meta_block_0_pipe_v_b:
	.byte	tile_bg::pipe_v+2
	.byte	tile_bg::pipe_v+6
	.byte	tile_bg::pipe_v+3
	.byte	tile_bg::pipe_v+7

gfx_meta_block_0_pipe_v_c:
	.byte	tile_bg::pipe_v
	.byte	tile_bg::pipe_v+4
	.byte	tile_bg::pipe_v+1
	.byte	tile_bg::pipe_v+5

gfx_meta_block_0_pipe_v_d:
	.byte	tile_bg::pipe_v+2
	.byte	tile_bg::pipe_v+6
	.byte	tile_bg::pipe_v+3
	.byte	tile_bg::pipe_v+7

gfx_meta_block_0_pipe_v_e:
	.byte	tile_bg::pipe_v+8
	.byte	tile_bg::pipe_v+8
	.byte	tile_bg::pipe_v+9
	.byte	tile_bg::pipe_v+9

gfx_meta_block_0_pipe_v_f:
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::pipe_v+10
	.byte	tile_bg::pipe_v+10
; ---
	.export gfx_meta_block_0_plat_b_a
	.export gfx_meta_block_0_plat_b_b
	.export gfx_meta_block_0_plat_b_c
gfx_meta_block_0_plat_b_a:
	.byte	tile_bg::plat_b
	.byte	tile_bg::plat_b+1
	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+3

gfx_meta_block_0_plat_b_b:
	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+4
	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+4

gfx_meta_block_0_plat_b_c:
	.byte	tile_bg::plat_b+2
	.byte	tile_bg::plat_b+3
	.byte	tile_bg::plat_b+5
	.byte	tile_bg::plat_b+6
; ---
	.if	.defined(SMBM)|.defined(VS_SMB)
		.export gfx_meta_block_0_plat_a_a
		.export gfx_meta_block_0_plat_a_b
		.export gfx_meta_block_0_plat_a_c
	gfx_meta_block_0_plat_a_a:
		.byte	tile_bg::plat_a
		.byte	tile_bg::plat_a+5
		.byte	tile_bg::plat_a_mid
		.byte	tile_bg::plat_a_mid+1

	gfx_meta_block_0_plat_a_b:
		.byte	tile_bg::plat_a+1
		.byte	tile_bg::plat_a+6
		.byte	tile_bg::plat_a+2
		.byte	tile_bg::plat_a+7

	gfx_meta_block_0_plat_a_c:
		.byte	tile_bg::plat_a+3
		.byte	tile_bg::plat_a+8
		.byte	tile_bg::plat_a+4
		.byte	tile_bg::plat_a+9
	.endif
; ---
	.export gfx_meta_block_0_pipe_h_a, gfx_meta_block_0_pipe_h_b
	.export gfx_meta_block_0_pipe_h_c, gfx_meta_block_0_pipe_h_d
	.export gfx_meta_block_0_pipe_h_e, gfx_meta_block_0_pipe_h_f
gfx_meta_block_0_pipe_h_a:
	.byte	tile_bg::pipe_h
	.byte	tile_bg::pipe_h+4
	.byte	tile_bg::pipe_h+1
	.byte	tile_bg::pipe_h+5

gfx_meta_block_0_pipe_h_b:
	.byte	tile_bg::pipe_h+2
	.byte	tile_bg::pipe_h+6
	.byte	tile_bg::pipe_h+2
	.byte	tile_bg::pipe_h+6

gfx_meta_block_0_pipe_h_c:
	.byte	tile_bg::pipe_h+3
	.byte	tile_bg::pipe_h+7
	.byte	tile_bg::pipe_v+9
	.byte	tile_bg::pipe_v+9

gfx_meta_block_0_pipe_h_d:
	.byte	tile_bg::pipe_h+8
	.byte	tile_bg::pipe_h+11
	.byte	tile_bg::pipe_h+9
	.byte	tile_bg::pipe_h+12

gfx_meta_block_0_pipe_h_e:
	.byte	tile_bg::blanks+2
	.byte	tile_bg::pipe_h+13
	.byte	tile_bg::blanks+2
	.byte	tile_bg::pipe_h+13

gfx_meta_block_0_pipe_h_f:
	.byte	tile_bg::pipe_h+10
	.byte	tile_bg::pipe_h+14
	.byte	tile_bg::pipe_v+9
	.byte	tile_bg::pipe_v+9
; ---
	.export gfx_meta_block_0_coral
gfx_meta_block_0_coral:
	.byte	tile_bg::coral_a
	.byte	tile_bg::coral_b
	.byte	tile_bg::coral_b+1
	.byte	tile_bg::coral_b+2
; ---
	.export gfx_meta_block_0_blank_d
gfx_meta_block_0_blank_d:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_0_flag_ball
gfx_meta_block_0_flag_ball:
	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_a
	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_b
; ---
	.export gfx_meta_block_0_pole
gfx_meta_block_0_pole:
	.byte	tile_bg::pole
	.byte	tile_bg::pole
	.byte	tile_bg::pole+1
	.byte	tile_bg::pole+1
; ---
	.export gfx_meta_block_0_climb_blank
gfx_meta_block_0_climb_blank:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_1
gfx_meta_block_1:
; ---
	.export gfx_meta_block_1_pulley_a, gfx_meta_block_1_pulley_b
	.export gfx_meta_block_1_pulley_c, gfx_meta_block_1_pulley_d
	.export gfx_meta_block_1_pulley_e
gfx_meta_block_1_pulley_a:
	.byte	tile_bg::pole
	.byte	tile_bg::pole
	.byte	tile_bg::pole+1
	.byte	tile_bg::pole+1

gfx_meta_block_1_pulley_b:
	.byte	tile_bg::rope
	.byte	tile_bg::blanks
	.byte	tile_bg::rope
	.byte	tile_bg::blanks

gfx_meta_block_1_pulley_c:
	.byte	tile_bg::blanks
	.byte	tile_bg::pole
	.byte	tile_bg::pulley_a
	.byte	tile_bg::pulley_a+1

gfx_meta_block_1_pulley_d:
	.byte	tile_bg::pulley_b
	.byte	tile_bg::pulley_b+1
	.byte	tile_bg::blanks
	.byte	tile_bg::pole+1

gfx_meta_block_1_pulley_e:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_1_castle_a
	.export gfx_meta_block_1_castle_b
	.export gfx_meta_block_1_castle_c
	.export gfx_meta_block_1_castle_d
	.export gfx_meta_block_1_castle_e
	.export gfx_meta_block_1_castle_f
	.export gfx_meta_block_1_castle_g
gfx_meta_block_1_castle_a:
	.byte	tile_bg::castle_a+2
	.byte	tile_bg::brick_b
	.byte	tile_bg::castle_a+3
	.byte	tile_bg::brick_b

gfx_meta_block_1_castle_b:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3

gfx_meta_block_1_castle_c:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_meta_block_1_castle_d:
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_meta_block_1_castle_e:
	.byte	tile_bg::castle_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::castle_b+1
	.byte	tile_bg::brick_b

gfx_meta_block_1_castle_f:
	.byte	tile_bg::castle_a
	.byte	tile_bg::blanks+3
	.byte	tile_bg::castle_a+1
	.byte	tile_bg::blanks+3

gfx_meta_block_1_castle_g:
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
	.byte	tile_bg::blanks+3
; ---
	.export gfx_meta_block_1_plat_b
gfx_meta_block_1_plat_b:
	.byte	tile_bg::plat_b+7
	.byte	tile_bg::plat_b+7
	.byte	tile_bg::plat_b+7
	.byte	tile_bg::plat_b+7
; ---
	.export gfx_meta_block_1_post
gfx_meta_block_1_post:
	.byte	tile_bg::post_a
	.byte	tile_bg::post_b
	.byte	tile_bg::post_a+1
	.byte	tile_bg::post_b+1
; ---
	.export gfx_meta_block_1_tree_trunk
gfx_meta_block_1_tree_trunk:
	.byte	tile_bg::tree_trunk
	.byte	tile_bg::tree_trunk
	.byte	tile_bg::tree_trunk+1
	.byte	tile_bg::tree_trunk+1
; ---
	.if	.defined(SMBM)|.defined(VS_SMB)
		.export gfx_meta_block_1_tree_a, gfx_meta_block_1_tree_b
	gfx_meta_block_1_tree_a:
		.byte	tile_bg::edge_b
		.byte	tile_bg::tree+2
		.byte	tile_bg::edge_b+1
		.byte	tile_bg::tree+3

	gfx_meta_block_1_tree_b:
		.byte	tile_bg::tree+2
		.byte	tile_bg::tree+2
		.byte	tile_bg::tree+3
		.byte	tile_bg::tree+3
	.endif
; ---
	.export gfx_meta_block_1_cutoff
gfx_meta_block_1_cutoff:
; ---
	.export gfx_meta_block_1_brick_a
	.export gfx_meta_block_1_brick_b
gfx_meta_block_1_brick_a:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_b:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
; ---
	.if	.defined(SMB)|.defined(VS_SMB)
		.export gfx_meta_block_1_floor_normal
	gfx_meta_block_1_floor_normal:
		.byte	tile_bg::floor_normal
		.byte	tile_bg::floor_normal+2
		.byte	tile_bg::floor_normal+1
		.byte	tile_bg::floor_normal+3
	.endif
; ---
	.if	.defined(SMB2)
		.export gfx_meta_block_1_brick_n
	gfx_meta_block_1_brick_n:
		.byte	tile_bg::brick_a
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_a
		.byte	tile_bg::brick_b
	.endif
; ---
	.export gfx_meta_block_1_brick_d, gfx_meta_block_1_brick_e
	.export gfx_meta_block_1_brick_f, gfx_meta_block_1_brick_g
	.export gfx_meta_block_1_brick_h, gfx_meta_block_1_brick_i
	.export gfx_meta_block_1_brick_j, gfx_meta_block_1_brick_k
	.export gfx_meta_block_1_brick_l, gfx_meta_block_1_brick_m
gfx_meta_block_1_brick_d:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_e:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_f:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_g:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_h:
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_a
	.byte	tile_bg::brick_b

	.if	.defined(SMB2)
		.export gfx_meta_block_1_brick_o
	gfx_meta_block_1_brick_o:
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_b
		.byte	tile_bg::brick_b
	.endif

gfx_meta_block_1_brick_i:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_j:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_k:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_l:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

gfx_meta_block_1_brick_m:
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b
	.byte	tile_bg::brick_b

	.if	.defined(SMB2)
		.export gfx_meta_block_1_blank_e
	gfx_meta_block_1_blank_e:
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
	.endif

	.if	.defined(SMB2M)
		.export gfx_meta_block_1_blank_d
	gfx_meta_block_1_blank_d:
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
		.byte	tile_bg::blanks
	.endif

	.export gfx_meta_block_1_blank_b, gfx_meta_block_1_blank_c
gfx_meta_block_1_blank_b:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks

gfx_meta_block_1_blank_c:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_1_stair
gfx_meta_block_1_stair:
	.byte	tile_bg::stair
	.byte	tile_bg::stair+1
	.byte	tile_bg::stair+2
	.byte	tile_bg::stair+3
; ---
	.export gfx_meta_block_1_floor_castle
gfx_meta_block_1_floor_castle:
	.byte	tile_bg::floor_castle
	.byte	tile_bg::floor_castle+1
	.byte	tile_bg::floor_castle
	.byte	tile_bg::floor_castle+1
; ---
	.export gfx_meta_block_1_bridge_base
gfx_meta_block_1_bridge_base:
	.byte	tile_bg::bridge_parts+1
	.byte	tile_bg::blanks
	.byte	tile_bg::bridge_parts+1
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_1_cannon_a
	.export gfx_meta_block_1_cannon_b
	.export gfx_meta_block_1_cannon_c
gfx_meta_block_1_cannon_a:
	.byte	tile_bg::cannon
	.byte	tile_bg::cannon+2
	.byte	tile_bg::cannon+1
	.byte	tile_bg::cannon+3

gfx_meta_block_1_cannon_b:
	.byte	tile_bg::cannon+4
	.byte	tile_bg::cannon+6
	.byte	tile_bg::cannon+5
	.byte	tile_bg::cannon+7

gfx_meta_block_1_cannon_c:
	.byte	tile_bg::cannon_base_left
	.byte	tile_bg::cannon_base_left
	.byte	tile_bg::cannon_base_right
	.byte	tile_bg::cannon_base_right
; ---
	.export gfx_meta_block_1_spring_bg_a, gfx_meta_block_1_spring_bg_b
gfx_meta_block_1_spring_bg_a:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks

gfx_meta_block_1_spring_bg_b:
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
; ---
	.export gfx_meta_block_1_floor_underwater
gfx_meta_block_1_floor_underwater:
	.byte	tile_bg::floor_underwater
	.byte	tile_bg::floor_underwater+1
	.byte	tile_bg::floor_underwater+2
	.byte	tile_bg::floor_underwater+3
; ---
	.if	.defined(SMB2M)
		.export gfx_meta_block_1_floor_normal
	gfx_meta_block_1_floor_normal:
		.byte	tile_bg::floor_normal
		.byte	tile_bg::floor_normal+2
		.byte	tile_bg::floor_normal+1
		.byte	tile_bg::floor_normal+3
	.endif
; ---
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
	.byte	tile_bg::blanks
	.byte	tile_bg::brick_b
; ---
	.export gfx_meta_block_1_pipe_water_a, gfx_meta_block_1_pipe_water_b
gfx_meta_block_1_pipe_water_a:
	.byte	tile_bg::pipe_h
	.byte	tile_bg::pipe_h+4
	.byte	tile_bg::pipe_h+1
	.byte	tile_bg::pipe_h+5

gfx_meta_block_1_pipe_water_b:
	.byte	tile_bg::pipe_h+8
	.byte	tile_bg::pipe_h+11
	.byte	tile_bg::pipe_h+9
	.byte	tile_bg::pipe_h+12
; ---
	.export gfx_meta_block_1_flag_ball
gfx_meta_block_1_flag_ball:
	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_a
	.byte	tile_bg::blanks
	.byte	tile_bg::flag_ball_b
; ---
	.export gfx_meta_block_2
gfx_meta_block_2:
; ---
	.export gfx_meta_block_2_cloud_a, gfx_meta_block_2_cloud_b
	.export gfx_meta_block_2_cloud_c, gfx_meta_block_2_cloud_d
	.export gfx_meta_block_2_cloud_e, gfx_meta_block_2_cloud_f
gfx_meta_block_2_cloud_a:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud

gfx_meta_block_2_cloud_b:
	.byte	tile_bg::cloud+1
	.byte	tile_bg::blanks+1
	.byte	tile_bg::cloud+2
	.byte	tile_bg::blanks+1

gfx_meta_block_2_cloud_c:
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+3
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks

gfx_meta_block_2_cloud_d:
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+4
	.byte	tile_bg::blanks

gfx_meta_block_2_cloud_e:
	.byte	tile_bg::cloud+5
	.byte	tile_bg::blanks
	.byte	tile_bg::cloud+6
	.byte	tile_bg::blanks

gfx_meta_block_2_cloud_f:
	.byte	tile_bg::cloud+7
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
	.byte	tile_bg::blanks
; ---
	.export gfx_meta_block_2_water_a, gfx_meta_block_2_water_b
gfx_meta_block_2_water_a:
	.byte	tile_bg::water
	.byte	tile_bg::blanks+2
	.byte	tile_bg::water
	.byte	tile_bg::blanks+2

gfx_meta_block_2_water_b:
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
	.byte	tile_bg::blanks+2
; ---
	.export gfx_meta_block_2_cutoff
gfx_meta_block_2_cutoff:
; ---
	.export gfx_meta_block_2_cloud_small
gfx_meta_block_2_cloud_small:
	.byte	tile_bg::cloud_small
	.byte	tile_bg::cloud_small+1
	.byte	tile_bg::cloud_small+2
	.byte	tile_bg::cloud_small+3
; ---
	.export gfx_meta_block_2_bridge_castle
gfx_meta_block_2_bridge_castle:
	.byte	tile_bg::bridge_a
	.byte	tile_bg::bridge_b
	.byte	tile_bg::bridge_a
	.byte	tile_bg::bridge_b
; ---
	.if	.defined(SMB2)
		.export gfx_meta_block_2_plat_a_a
		.export gfx_meta_block_2_plat_a_b
		.export gfx_meta_block_2_plat_a_c
	gfx_meta_block_2_plat_a_a:
		.byte	tile_bg::plat_a
		.byte	tile_bg::plat_a+5
		.byte	tile_bg::plat_a_mid
		.byte	tile_bg::plat_a_mid+1

	gfx_meta_block_2_plat_a_b:
		.byte	tile_bg::plat_a+1
		.byte	tile_bg::plat_a+6
		.byte	tile_bg::plat_a+2
		.byte	tile_bg::plat_a+7

	gfx_meta_block_2_plat_a_c:
		.byte	tile_bg::plat_a+3
		.byte	tile_bg::plat_a+8
		.byte	tile_bg::plat_a+4
		.byte	tile_bg::plat_a+9
	.endif
; ---
	.export gfx_meta_block_3
gfx_meta_block_3:
; ---
	.export gfx_meta_block_3_cutoff
gfx_meta_block_3_cutoff:
; ---
	.export gfx_meta_block_3_block_q_set
gfx_meta_block_3_block_q_set:
	.if	.defined(SMB2)
		.export gfx_meta_block_3_block_q_c
	gfx_meta_block_3_block_q_c:
		.byte	tile_bg::block_q
		.byte	tile_bg::block_q+2
		.byte	tile_bg::block_q+1
		.byte	tile_bg::block_q+3
	.endif

	.export gfx_meta_block_3_block_q_a
gfx_meta_block_3_block_q_a:
	.byte	tile_bg::block_q
	.byte	tile_bg::block_q+2
	.byte	tile_bg::block_q+1
	.byte	tile_bg::block_q+3

	.export gfx_meta_block_3_block_q_b
gfx_meta_block_3_block_q_b:
	.byte	tile_bg::block_q
	.byte	tile_bg::block_q+2
	.byte	tile_bg::block_q+1
	.byte	tile_bg::block_q+3
; ---
	.export gfx_meta_block_3_coin_a, gfx_meta_block_3_coin_b
gfx_meta_block_3_coin_a:
	.byte	tile_bg::coin_a
	.byte	tile_bg::coin_a+2
	.byte	tile_bg::coin_a+1
	.byte	tile_bg::coin_a+3

gfx_meta_block_3_coin_b:
	.byte	tile_bg::coin_b
	.byte	tile_bg::coin_b+2
	.byte	tile_bg::coin_b+1
	.byte	tile_bg::coin_b+3
; ---
	.export gfx_meta_block_3_axe_block, gfx_meta_block_3_axe
gfx_meta_block_3_axe_block:
	.byte	tile_bg::block_empty
	.byte	tile_bg::block_empty+2
	.byte	tile_bg::block_empty+1
	.byte	tile_bg::block_empty+3

gfx_meta_block_3_axe:
	.byte	tile_bg::axe
	.byte	tile_bg::axe+2
	.byte	tile_bg::axe+1
	.byte	tile_bg::axe+3
