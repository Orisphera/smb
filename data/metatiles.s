.include	"chr.i"

        .export scenery_metatile_lo, scenery_metatile_hi
scenery_metatile_lo:
	.byte	<bg_meta_block_0, <bg_meta_block_1, <bg_meta_block_2, <bg_meta_block_3

scenery_metatile_hi:
	.byte	>bg_meta_block_0, >bg_meta_block_1, >bg_meta_block_2, >bg_meta_block_3
; ---
	.export bg_meta_block_0
bg_meta_block_0:
; ---
	.export bg_meta_block_0_blank_a
bg_meta_block_0_blank_a:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
; ---
	.export bg_meta_block_0_blank_b
bg_meta_block_0_blank_b:
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3
; ---
	.export bg_meta_block_0_bush_a
	.export bg_meta_block_0_bush_b
	.export bg_meta_block_0_bush_c
bg_meta_block_0_bush_a:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::cloud

bg_meta_block_0_bush_b:
	.byte	chr_bg::cloud+1
	.byte	chr_bg::blanks+1
	.byte	chr_bg::cloud+2
	.byte	chr_bg::blanks+1

bg_meta_block_0_bush_c:
	.byte	chr_bg::blanks
	.byte	chr_bg::cloud+3
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
; ---
	.export bg_meta_block_0_hill_a, bg_meta_block_0_hill_b
	.export bg_meta_block_0_hill_c, bg_meta_block_0_hill_d
	.export bg_meta_block_0_hill_e, bg_meta_block_0_hill_f
bg_meta_block_0_hill_a:
	.byte	chr_bg::blanks
	.byte	chr_bg::hill_a
	.byte	chr_bg::hill_a
	.byte	chr_bg::blanks+2

bg_meta_block_0_hill_b:
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::hill_a+4
	.byte	chr_bg::blanks+2

bg_meta_block_0_hill_c:
	.byte	chr_bg::blanks
	.byte	chr_bg::hill_a+1
	.byte	chr_bg::blanks
	.byte	chr_bg::hill_a+2

bg_meta_block_0_hill_d:
	.byte	chr_bg::hill_a+3
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks
	.byte	chr_bg::hill_a+3

bg_meta_block_0_hill_e:
	.byte	chr_bg::hill_a+4
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2

bg_meta_block_0_hill_f:
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
; ---
	.export bg_meta_block_0_bridge_rope
bg_meta_block_0_bridge_rope:
	.byte	chr_bg::blanks
	.byte	chr_bg::bridge_parts
	.byte	chr_bg::blanks
	.byte	chr_bg::bridge_parts
; ---
	.export bg_meta_block_0_chain
bg_meta_block_0_chain:
	.byte	chr_bg::blanks
	.byte	chr_bg::chain
	.byte	chr_bg::chain
	.byte	chr_bg::blanks
; ---
	.export bg_meta_block_0_tree_a
	.export bg_meta_block_0_tree_b
	.export bg_meta_block_0_tree_c
bg_meta_block_0_tree_a:
	.byte	chr_bg::tree
	.byte	chr_bg::tree+2
	.byte	chr_bg::tree+1
	.byte	chr_bg::tree+3

bg_meta_block_0_tree_b:
	.byte	chr_bg::tree
	.byte	chr_bg::tree+4
	.byte	chr_bg::tree+1
	.byte	chr_bg::tree+5

bg_meta_block_0_tree_c:
	.byte	chr_bg::tree+2
	.byte	chr_bg::tree+4
	.byte	chr_bg::tree+3
	.byte	chr_bg::tree+5
; ---
	.export bg_meta_block_0_bumpable
bg_meta_block_0_bumpable:
	.export bg_meta_block_0_solid
bg_meta_block_0_solid:
; ---
	.export bg_meta_block_0_pipe_v_a, bg_meta_block_0_pipe_v_b
	.export bg_meta_block_0_pipe_v_c, bg_meta_block_0_pipe_v_d
	.export	bg_meta_block_0_pipe_v_e, bg_meta_block_0_pipe_v_f
bg_meta_block_0_pipe_v_a:
	.byte	chr_bg::pipe_v
	.byte	chr_bg::pipe_v+4
	.byte	chr_bg::pipe_v+1
	.byte	chr_bg::pipe_v+5

bg_meta_block_0_pipe_v_b:
	.byte	chr_bg::pipe_v+2
	.byte	chr_bg::pipe_v+6
	.byte	chr_bg::pipe_v+3
	.byte	chr_bg::pipe_v+7

bg_meta_block_0_pipe_v_c:
	.byte	chr_bg::pipe_v
	.byte	chr_bg::pipe_v+4
	.byte	chr_bg::pipe_v+1
	.byte	chr_bg::pipe_v+5

bg_meta_block_0_pipe_v_d:
	.byte	chr_bg::pipe_v+2
	.byte	chr_bg::pipe_v+6
	.byte	chr_bg::pipe_v+3
	.byte	chr_bg::pipe_v+7

bg_meta_block_0_pipe_v_e:
	.byte	chr_bg::pipe_v+8
	.byte	chr_bg::pipe_v+8
	.byte	chr_bg::pipe_v+9
	.byte	chr_bg::pipe_v+9

bg_meta_block_0_pipe_v_f:
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::pipe_v+10
	.byte	chr_bg::pipe_v+10
; ---
	.export bg_meta_block_0_plat_b_a
	.export bg_meta_block_0_plat_b_b
	.export bg_meta_block_0_plat_b_c
bg_meta_block_0_plat_b_a:
	.byte	chr_bg::plat_b
	.byte	chr_bg::plat_b+1
	.byte	chr_bg::plat_b+2
	.byte	chr_bg::plat_b+3

bg_meta_block_0_plat_b_b:
	.byte	chr_bg::plat_b+2
	.byte	chr_bg::plat_b+4
	.byte	chr_bg::plat_b+2
	.byte	chr_bg::plat_b+4

bg_meta_block_0_plat_b_c:
	.byte	chr_bg::plat_b+2
	.byte	chr_bg::plat_b+3
	.byte	chr_bg::plat_b+5
	.byte	chr_bg::plat_b+6
; ---
	.if	.defined(SMBM)|.defined(VS_SMB)
		.export bg_meta_block_0_plat_a_a
		.export bg_meta_block_0_plat_a_b
		.export bg_meta_block_0_plat_a_c
	bg_meta_block_0_plat_a_a:
		.byte	chr_bg::plat_a
		.byte	chr_bg::plat_a+5
		.byte	chr_bg::plat_a_mid
		.byte	chr_bg::plat_a_mid+1

	bg_meta_block_0_plat_a_b:
		.byte	chr_bg::plat_a+1
		.byte	chr_bg::plat_a+6
		.byte	chr_bg::plat_a+2
		.byte	chr_bg::plat_a+7

	bg_meta_block_0_plat_a_c:
		.byte	chr_bg::plat_a+3
		.byte	chr_bg::plat_a+8
		.byte	chr_bg::plat_a+4
		.byte	chr_bg::plat_a+9
	.endif
; ---
	.export bg_meta_block_0_pipe_h_a, bg_meta_block_0_pipe_h_b
	.export bg_meta_block_0_pipe_h_c, bg_meta_block_0_pipe_h_d
	.export bg_meta_block_0_pipe_h_e, bg_meta_block_0_pipe_h_f
bg_meta_block_0_pipe_h_a:
	.byte	chr_bg::pipe_h
	.byte	chr_bg::pipe_h+4
	.byte	chr_bg::pipe_h+1
	.byte	chr_bg::pipe_h+5

bg_meta_block_0_pipe_h_b:
	.byte	chr_bg::pipe_h+2
	.byte	chr_bg::pipe_h+6
	.byte	chr_bg::pipe_h+2
	.byte	chr_bg::pipe_h+6

bg_meta_block_0_pipe_h_c:
	.byte	chr_bg::pipe_h+3
	.byte	chr_bg::pipe_h+7
	.byte	chr_bg::pipe_v+9
	.byte	chr_bg::pipe_v+9

bg_meta_block_0_pipe_h_d:
	.byte	chr_bg::pipe_h+8
	.byte	chr_bg::pipe_h+11
	.byte	chr_bg::pipe_h+9
	.byte	chr_bg::pipe_h+12

bg_meta_block_0_pipe_h_e:
	.byte	chr_bg::blanks+2
	.byte	chr_bg::pipe_h+13
	.byte	chr_bg::blanks+2
	.byte	chr_bg::pipe_h+13

bg_meta_block_0_pipe_h_f:
	.byte	chr_bg::pipe_h+10
	.byte	chr_bg::pipe_h+14
	.byte	chr_bg::pipe_v+9
	.byte	chr_bg::pipe_v+9
; ---
	.export bg_meta_block_0_coral
bg_meta_block_0_coral:
	.byte	chr_bg::coral_a
	.byte	chr_bg::coral_b
	.byte	chr_bg::coral_b+1
	.byte	chr_bg::coral_b+2
; ---
	.export bg_meta_block_0_blank_d
bg_meta_block_0_blank_d:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
; ---
	.export	bg_meta_block_0_climbable
bg_meta_block_0_climbable:
; ---
	.export bg_meta_block_0_flag_ball
bg_meta_block_0_flag_ball:
	.byte	chr_bg::blanks
	.byte	chr_bg::flag_ball_a
	.byte	chr_bg::blanks
	.byte	chr_bg::flag_ball_b
; ---
	.export bg_meta_block_0_pole
bg_meta_block_0_pole:
	.byte	chr_bg::pole
	.byte	chr_bg::pole
	.byte	chr_bg::pole+1
	.byte	chr_bg::pole+1
; ---
	.export bg_meta_block_0_climb_blank
bg_meta_block_0_climb_blank:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
; ---
	.export bg_meta_block_1
bg_meta_block_1:
; ---
	.export bg_meta_block_1_pulley_a, bg_meta_block_1_pulley_b
	.export bg_meta_block_1_pulley_c, bg_meta_block_1_pulley_d
	.export bg_meta_block_1_pulley_e
bg_meta_block_1_pulley_a:
	.byte	chr_bg::pole
	.byte	chr_bg::pole
	.byte	chr_bg::pole+1
	.byte	chr_bg::pole+1

bg_meta_block_1_pulley_b:
	.byte	chr_bg::rope
	.byte	chr_bg::blanks
	.byte	chr_bg::rope
	.byte	chr_bg::blanks

bg_meta_block_1_pulley_c:
	.byte	chr_bg::blanks
	.byte	chr_bg::pole
	.byte	chr_bg::pulley_a
	.byte	chr_bg::pulley_a+1

bg_meta_block_1_pulley_d:
	.byte	chr_bg::pulley_b
	.byte	chr_bg::pulley_b+1
	.byte	chr_bg::blanks
	.byte	chr_bg::pole+1

bg_meta_block_1_pulley_e:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
; ---
	.export bg_meta_block_1_castle_a
	.export bg_meta_block_1_castle_b
	.export bg_meta_block_1_castle_c
	.export bg_meta_block_1_castle_d
	.export bg_meta_block_1_castle_e
	.export bg_meta_block_1_castle_f
	.export bg_meta_block_1_castle_g
bg_meta_block_1_castle_a:
	.byte	chr_bg::castle_a+2
	.byte	chr_bg::brick_b
	.byte	chr_bg::castle_a+3
	.byte	chr_bg::brick_b

bg_meta_block_1_castle_b:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3

bg_meta_block_1_castle_c:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

bg_meta_block_1_castle_d:
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

bg_meta_block_1_castle_e:
	.byte	chr_bg::castle_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::castle_b+1
	.byte	chr_bg::brick_b

bg_meta_block_1_castle_f:
	.byte	chr_bg::castle_a
	.byte	chr_bg::blanks+3
	.byte	chr_bg::castle_a+1
	.byte	chr_bg::blanks+3

bg_meta_block_1_castle_g:
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3
	.byte	chr_bg::blanks+3
; ---
	.export bg_meta_block_1_plat_b
bg_meta_block_1_plat_b:
	.byte	chr_bg::plat_b+7
	.byte	chr_bg::plat_b+7
	.byte	chr_bg::plat_b+7
	.byte	chr_bg::plat_b+7
; ---
	.export bg_meta_block_1_post
bg_meta_block_1_post:
	.byte	chr_bg::post_a
	.byte	chr_bg::post_b
	.byte	chr_bg::post_a+1
	.byte	chr_bg::post_b+1
; ---
	.export bg_meta_block_1_tree_trunk
bg_meta_block_1_tree_trunk:
	.byte	chr_bg::tree_trunk
	.byte	chr_bg::tree_trunk
	.byte	chr_bg::tree_trunk+1
	.byte	chr_bg::tree_trunk+1
; ---
	.if	.defined(SMBM)|.defined(VS_SMB)
		.export bg_meta_block_1_tree_a, bg_meta_block_1_tree_b
	bg_meta_block_1_tree_a:
		.byte	chr_bg::edge_b
		.byte	chr_bg::tree+2
		.byte	chr_bg::edge_b+1
		.byte	chr_bg::tree+3

	bg_meta_block_1_tree_b:
		.byte	chr_bg::tree+2
		.byte	chr_bg::tree+2
		.byte	chr_bg::tree+3
		.byte	chr_bg::tree+3
	.endif
; ---
	.export bg_meta_block_1_bumpable
bg_meta_block_1_bumpable:
; ---
	.export bg_meta_block_1_brick_a
	.export bg_meta_block_1_brick_b
bg_meta_block_1_brick_a:
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_b:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
; ---
	.if	.defined(SMBV1)
		.export bg_meta_block_1_floor_normal
	bg_meta_block_1_floor_normal:
		.byte	chr_bg::floor_normal
		.byte	chr_bg::floor_normal+2
		.byte	chr_bg::floor_normal+1
		.byte	chr_bg::floor_normal+3
	.endif
; ---
	.if	.defined(SMB2)
		.export bg_meta_block_1_brick_n
	bg_meta_block_1_brick_n:
		.byte	chr_bg::brick_a
		.byte	chr_bg::brick_b
		.byte	chr_bg::brick_a
		.byte	chr_bg::brick_b
	.endif
; ---
	.export bg_meta_block_1_brick_d, bg_meta_block_1_brick_e
	.export bg_meta_block_1_brick_f, bg_meta_block_1_brick_g
	.export bg_meta_block_1_brick_h, bg_meta_block_1_brick_i
	.export bg_meta_block_1_brick_j, bg_meta_block_1_brick_k
	.export bg_meta_block_1_brick_l, bg_meta_block_1_brick_m
bg_meta_block_1_brick_d:
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_e:
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_f:
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_g:
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_h:
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_a
	.byte	chr_bg::brick_b

	.if	.defined(SMB2)
		.export bg_meta_block_1_brick_o
	bg_meta_block_1_brick_o:
		.byte	chr_bg::brick_b
		.byte	chr_bg::brick_b
		.byte	chr_bg::brick_b
		.byte	chr_bg::brick_b
	.endif

bg_meta_block_1_brick_i:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_j:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_k:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_l:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

bg_meta_block_1_brick_m:
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b
	.byte	chr_bg::brick_b

	.if	.defined(SMB2)
		.export bg_meta_block_1_blank_e
	bg_meta_block_1_blank_e:
		.byte	chr_bg::blanks
		.byte	chr_bg::blanks
		.byte	chr_bg::blanks
		.byte	chr_bg::blanks
	.endif

	.if	.defined(SMBV2)
		.export bg_meta_block_1_blank_d
	bg_meta_block_1_blank_d:
		.byte	chr_bg::blanks
		.byte	chr_bg::blanks
		.byte	chr_bg::blanks
		.byte	chr_bg::blanks
	.endif

	.export bg_meta_block_1_blank_b, bg_meta_block_1_blank_c
bg_meta_block_1_blank_b:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks

bg_meta_block_1_blank_c:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
; ---
	.export	bg_meta_block_1_solid
bg_meta_block_1_solid:
; ---
	.export bg_meta_block_1_stair
bg_meta_block_1_stair:
	.byte	chr_bg::stair
	.byte	chr_bg::stair+1
	.byte	chr_bg::stair+2
	.byte	chr_bg::stair+3
; ---
	.export bg_meta_block_1_floor_castle
bg_meta_block_1_floor_castle:
	.byte	chr_bg::floor_castle
	.byte	chr_bg::floor_castle+1
	.byte	chr_bg::floor_castle
	.byte	chr_bg::floor_castle+1
; ---
	.export bg_meta_block_1_bridge_base
bg_meta_block_1_bridge_base:
	.byte	chr_bg::bridge_parts+1
	.byte	chr_bg::blanks
	.byte	chr_bg::bridge_parts+1
	.byte	chr_bg::blanks
; ---
	.export bg_meta_block_1_cannon_a
	.export bg_meta_block_1_cannon_b
	.export bg_meta_block_1_cannon_c
bg_meta_block_1_cannon_a:
	.byte	chr_bg::cannon
	.byte	chr_bg::cannon+2
	.byte	chr_bg::cannon+1
	.byte	chr_bg::cannon+3

bg_meta_block_1_cannon_b:
	.byte	chr_bg::cannon+4
	.byte	chr_bg::cannon+6
	.byte	chr_bg::cannon+5
	.byte	chr_bg::cannon+7

bg_meta_block_1_cannon_c:
	.byte	chr_bg::cannon_base_left
	.byte	chr_bg::cannon_base_left
	.byte	chr_bg::cannon_base_right
	.byte	chr_bg::cannon_base_right
; ---
	.export bg_meta_block_1_spring_bg_a, bg_meta_block_1_spring_bg_b
bg_meta_block_1_spring_bg_a:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks

bg_meta_block_1_spring_bg_b:
	.byte	chr_bg::blanks
	.byte	chr_bg::brick_b
	.byte	chr_bg::blanks
	.byte	chr_bg::brick_b
; ---
	.export bg_meta_block_1_floor_underwater
bg_meta_block_1_floor_underwater:
	.byte	chr_bg::floor_underwater
	.byte	chr_bg::floor_underwater+1
	.byte	chr_bg::floor_underwater+2
	.byte	chr_bg::floor_underwater+3
; ---
	.if	.defined(SMBV2)
		.export bg_meta_block_1_floor_normal
	bg_meta_block_1_floor_normal:
		.byte	chr_bg::floor_normal
		.byte	chr_bg::floor_normal+2
		.byte	chr_bg::floor_normal+1
		.byte	chr_bg::floor_normal+3
	.endif
; ---
	.byte	chr_bg::blanks
	.byte	chr_bg::brick_b
	.byte	chr_bg::blanks
	.byte	chr_bg::brick_b
; ---
	.export bg_meta_block_1_pipe_water_a, bg_meta_block_1_pipe_water_b
bg_meta_block_1_pipe_water_a:
	.byte	chr_bg::pipe_h
	.byte	chr_bg::pipe_h+4
	.byte	chr_bg::pipe_h+1
	.byte	chr_bg::pipe_h+5

bg_meta_block_1_pipe_water_b:
	.byte	chr_bg::pipe_h+8
	.byte	chr_bg::pipe_h+11
	.byte	chr_bg::pipe_h+9
	.byte	chr_bg::pipe_h+12
; ---
	.export	bg_meta_block_1_climbable
bg_meta_block_1_climbable:
; ---
	.export bg_meta_block_1_flag_ball
bg_meta_block_1_flag_ball:
	.byte	chr_bg::blanks
	.byte	chr_bg::flag_ball_a
	.byte	chr_bg::blanks
	.byte	chr_bg::flag_ball_b
; ---
	.export bg_meta_block_2
bg_meta_block_2:
; ---
	.export bg_meta_block_2_cloud_a, bg_meta_block_2_cloud_b
	.export bg_meta_block_2_cloud_c, bg_meta_block_2_cloud_d
	.export bg_meta_block_2_cloud_e, bg_meta_block_2_cloud_f
bg_meta_block_2_cloud_a:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::cloud

bg_meta_block_2_cloud_b:
	.byte	chr_bg::cloud+1
	.byte	chr_bg::blanks+1
	.byte	chr_bg::cloud+2
	.byte	chr_bg::blanks+1

bg_meta_block_2_cloud_c:
	.byte	chr_bg::blanks
	.byte	chr_bg::cloud+3
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks

bg_meta_block_2_cloud_d:
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::cloud+4
	.byte	chr_bg::blanks

bg_meta_block_2_cloud_e:
	.byte	chr_bg::cloud+5
	.byte	chr_bg::blanks
	.byte	chr_bg::cloud+6
	.byte	chr_bg::blanks

bg_meta_block_2_cloud_f:
	.byte	chr_bg::cloud+7
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
	.byte	chr_bg::blanks
; ---
	.export bg_meta_block_2_water_a, bg_meta_block_2_water_b
bg_meta_block_2_water_a:
	.byte	chr_bg::water
	.byte	chr_bg::blanks+2
	.byte	chr_bg::water
	.byte	chr_bg::blanks+2

bg_meta_block_2_water_b:
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
	.byte	chr_bg::blanks+2
; ---
	.export bg_meta_block_2_bumpable
bg_meta_block_2_bumpable:
	.export	bg_meta_block_2_solid
bg_meta_block_2_solid:
; ---
	.export bg_meta_block_2_cloud_small
bg_meta_block_2_cloud_small:
	.byte	chr_bg::cloud_small
	.byte	chr_bg::cloud_small+1
	.byte	chr_bg::cloud_small+2
	.byte	chr_bg::cloud_small+3
; ---
	.export bg_meta_block_2_bridge_castle
bg_meta_block_2_bridge_castle:
	.byte	chr_bg::bridge_a
	.byte	chr_bg::bridge_b
	.byte	chr_bg::bridge_a
	.byte	chr_bg::bridge_b
; ---
	.if	.defined(SMB2)
		.export bg_meta_block_2_plat_a_a
		.export bg_meta_block_2_plat_a_b
		.export bg_meta_block_2_plat_a_c
	bg_meta_block_2_plat_a_a:
		.byte	chr_bg::plat_a
		.byte	chr_bg::plat_a+5
		.byte	chr_bg::plat_a_mid
		.byte	chr_bg::plat_a_mid+1

	bg_meta_block_2_plat_a_b:
		.byte	chr_bg::plat_a+1
		.byte	chr_bg::plat_a+6
		.byte	chr_bg::plat_a+2
		.byte	chr_bg::plat_a+7

	bg_meta_block_2_plat_a_c:
		.byte	chr_bg::plat_a+3
		.byte	chr_bg::plat_a+8
		.byte	chr_bg::plat_a+4
		.byte	chr_bg::plat_a+9
	.endif
; ---
	.export	bg_meta_block_2_climbable
bg_meta_block_2_climbable:
; ---
	.export bg_meta_block_3
bg_meta_block_3:
; ---
	.export bg_meta_block_3_bumpable
bg_meta_block_3_bumpable:
; ---
	.export bg_meta_block_3_block_q_set
bg_meta_block_3_block_q_set:
	.if	.defined(SMB2)
		.export bg_meta_block_3_block_q_c
	bg_meta_block_3_block_q_c:
		.byte	chr_bg::block_q
		.byte	chr_bg::block_q+2
		.byte	chr_bg::block_q+1
		.byte	chr_bg::block_q+3
	.endif

	.export bg_meta_block_3_block_q_a
bg_meta_block_3_block_q_a:
	.byte	chr_bg::block_q
	.byte	chr_bg::block_q+2
	.byte	chr_bg::block_q+1
	.byte	chr_bg::block_q+3

	.export bg_meta_block_3_block_q_b
bg_meta_block_3_block_q_b:
	.byte	chr_bg::block_q
	.byte	chr_bg::block_q+2
	.byte	chr_bg::block_q+1
	.byte	chr_bg::block_q+3
; ---
	.export bg_meta_block_3_coin_a, bg_meta_block_3_coin_b
bg_meta_block_3_coin_a:
	.byte	chr_bg::coin_a
	.byte	chr_bg::coin_a+2
	.byte	chr_bg::coin_a+1
	.byte	chr_bg::coin_a+3

bg_meta_block_3_coin_b:
	.byte	chr_bg::coin_b
	.byte	chr_bg::coin_b+2
	.byte	chr_bg::coin_b+1
	.byte	chr_bg::coin_b+3
; ---
	.export	bg_meta_block_3_block_solid
bg_meta_block_3_block_solid:
; ---
	.export bg_meta_block_3_block_invis
bg_meta_block_3_block_invis:
	.byte	chr_bg::block_empty
	.byte	chr_bg::block_empty+2
	.byte	chr_bg::block_empty+1
	.byte	chr_bg::block_empty+3
; ---
	.export bg_meta_block_3_axe
bg_meta_block_3_axe:
	.byte	chr_bg::axe
	.byte	chr_bg::axe+2
	.byte	chr_bg::axe+1
	.byte	chr_bg::axe+3
; ---
	.export	bg_meta_block_3_climbable
bg_meta_block_3_climbable: