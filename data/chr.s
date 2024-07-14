.segment	"CHR0DATA"

	.export chr_obj, chr_bg
chr_obj:
	.include	"chr/obj/mario_a.s"
	.include	"chr/obj/digits_a.s"
	.include	"chr/obj/fire_koopa.s"

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.include	"chr/obj/flag_victory.s"
	.elseif	.defined(ANN)
		.include	"chr/obj/flag_victory_nsm.s"
	.endif

	.include	"chr/obj/mario_b.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/obj/plat_a.s"
	.elseif	.defined(SMB2M)
		.include	"chr/obj/plat_c.s"
	.endif

	.include	"chr/obj/mario_c.s"
	.include	"chr/obj/coin.s"
	.include	"chr/obj/fire_ball.s"
	.include	"chr/obj/fire_hit.s"
	.include	"chr/obj/troopa_a.s"

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.include	"chr/obj/goomba_a.s"
	.elseif	.defined(ANN)
		.include	"chr/obj/goomba_nsm_a.s"
	.endif

	.include	"chr/obj/bubble.s"
	.include	"chr/obj/plat_b.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/obj/mushroom.s"
	.elseif	.defined(SMB2M)
		.include	"chr/obj/door.s"
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/obj/princess_a.s"
	.elseif	.defined(SMB2)
		.include	"chr/obj/leaf.s"
	.elseif	.defined(ANN)
		.include	"chr/obj/nsm_guy_a.s"
	.endif

	.include	"chr/obj/hammer_bro_a.s"
	.include	"chr/obj/flag_enemy.s"
	.include	"chr/obj/hammer.s"
	.include	"chr/obj/brick_piece.s"

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/obj/brick.s"
	.elseif	.defined(SMB2)
		.include	"chr/obj/brick_new.s"
	.endif

	.include	"chr/obj/block.s"
	.include	"chr/obj/hammer_bro_b.s"

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.include	"chr/obj/star_a.s"
	.elseif	.defined(ANN)
		.include	"chr/obj/star_nsm_a.s"
	.endif

	.include	"chr/obj/spiny_egg_a.s"
	.include	"chr/obj/mario_d.s"
	.include	"chr/obj/spiny_egg_b.s"
	.include	"chr/obj/spiny.s"
	.include	"chr/obj/mario_e.s"
	.include	"chr/obj/troopa_b.s"
	.include	"chr/obj/buzzy_a.s"
	.include	"chr/obj/cheep.s"
	.include	"chr/obj/lakitu.s"
	.include	"chr/obj/koopa.s"

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.include	"chr/obj/toad.s"
	.elseif	.defined(ANN)
		.include	"chr/obj/nsm_guy_b.s"
	.endif

	.include	"chr/obj/podobo_a.s"
	.include	"chr/obj/hammer_bro_c.s"
	.include	"chr/obj/firefl_a.s"
	.include	"chr/obj/podobo_b.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/obj/princess_b.s"
	.elseif	.defined(SMB2M)
		.include	"chr/obj/mushroom_new_a.s"
	.endif

	.include	"chr/obj/firefl_b.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/obj/princess_c.s"
	.elseif	.defined(SMB2M)
		.include	"chr/obj/mushroom_new_b.s"
	.endif

	.include	"chr/obj/blooper.s"
	.include	"chr/obj/vine.s"
	.include	"chr/obj/hammer_bro_d.s"

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.include	"chr/obj/star_b.s"
		.include	"chr/obj/piranha_a.s"
	.elseif	.defined(ANN)
		.include	"chr/obj/star_nsm_b.s"
		.include	"chr/obj/piranha_nsm_a.s"
	.endif

	.include	"chr/obj/bullet.s"

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.include	"chr/obj/piranha_b.s"
		.include	"chr/obj/goomba_b.s"
	.elseif	.defined(ANN)
		.include	"chr/obj/piranha_nsm_b.s"
		.include	"chr/obj/goomba_nsm_b.s"
	.endif

	.include	"chr/obj/spring.s"
	.include	"chr/obj/buzzy_b.s"
	.include	"chr/obj/digits_b.s"
	.include	"chr/obj/empty.s"

	.if	.defined(SMB)
		.include	"chr/obj/oneup.s"
	.elseif	.defined(VS_SMB)
		.include	"chr/obj/oneup_new_a.s"
	.elseif	.defined(SMB2M)
		.include	"chr/obj/oneup_new_b.s"
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/obj/unk_a.s"
	.elseif	.defined(SMB2M)
		.include	"chr/obj/mushroom_new_c.s"
	.endif

chr_bg:
	.if	.defined(SMB)
		.include	"chr/bg/font_a.s"
	.elseif	.defined(VS_SMB)|.defined(SMB2M)
		.include	"chr/bg/font_a.vs.s"
	.endif

	.if	.defined(SMB)
		.include	"chr/bg/font_b.s"
	.elseif	.defined(VS_SMB)
		.include	"chr/bg/font_b.vs.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/font_b.smb2.s"
	.endif

	.if	.defined(SMB)
		.include	"chr/bg/font_c.s"
	.elseif	.defined(VS_SMB)|.defined(SMB2M)
		.include	"chr/bg/font_c.vs.s"
	.endif

	.if	.defined(SMB)
		.include	"chr/bg/font_d.s"
	.elseif	.defined(VS_SMB)
		.include	"chr/bg/font_d.vs.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/font_d.smb2.s"
	.endif

	.if	.defined(SMB)
		.include	"chr/bg/font_e.s"
	.elseif	.defined(VS_SMB)|.defined(SMB2M)
		.include	"chr/bg/font_e.vs.s"
	.endif

	.include	"chr/bg/blanks.s"

	.if	.defined(SMB)
		.include	"chr/bg/font_f.s"
	.elseif	.defined(VS_SMB)|.defined(SMB2M)
		.include	"chr/bg/font_f.vs.s"
	.endif

	.include	"chr/bg/castle_door_left.s"

	.if	.defined(SMB)
		.include	"chr/bg/font_g.s"
	.elseif	.defined(VS_SMB)|.defined(SMB2M)
		.include	"chr/bg/font_g.vs.s"
	.endif

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/bg/plat_a_mid.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/plat_a_mid_new.s"
	.endif

	.include	"chr/bg/hud.s"
	.include	"chr/bg/flag_ball_a.s"

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/bg/hill_a.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/hill_a_new.s"
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/hill_b.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/hill_b_new.s"
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/cloud.s"
	.elseif	.defined(SMB2M)	
		.include	"chr/bg/cloud_new.s"
	.endif

	.include	"chr/bg/flag_ball_b.s"
	.include	"chr/bg/pulley_a.s"
	.include	"chr/bg/castle_door_right.s"
	.include	"chr/bg/water.s"
	.include	"chr/bg/edge_a.s"
	.include	"chr/bg/sign_nw.s"

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/bg/brick_a.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/brick_a_new.s"
	.endif

	.include	"chr/bg/sign_w.s"

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/bg/brick_b.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/brick_b_new.s"
	.endif

	.include	"chr/bg/sign_n_ne_e.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/plat_b.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/plat_b_new.s"
	.endif

	.include	"chr/bg/block.s"
	.include	"chr/bg/pulley_b.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/floor_castle.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/floor_castle_new.s"
	.endif

	.include	"chr/bg/sign_sw.s"
	.include	"chr/bg/pipe_v.s"

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/bg/plat_a.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/plat_a_new.s"
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/edge_b.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/quotes.s"
	.elseif	.defined(ANN)
		.include	"chr/bg/edge_b_nsm.s"
	.endif

	.include	"chr/bg/bridge_a.s"
	.include	"chr/bg/sign_s.s"
	.include	"chr/bg/bridge_b.s"
	.include	"chr/bg/sign_se.s"

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.include	"chr/bg/axe.s"
	.elseif	.defined(ANN)
		.include	"chr/bg/axe_nsm.s"
	.endif

	.include	"chr/bg/chain.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/post_a.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/post_a_new.s"
	.elseif	.defined(ANN)
		.include	"chr/bg/post_a_nsm.s"
	.endif

	.include	"chr/bg/floor_underwater.s"
	.include	"chr/bg/pipe_h.s"
	.include	"chr/bg/sign_text_a.s"
	.include	"chr/bg/rope.s"

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/bg/castle_a.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/castle_a_new.s"
	.endif

	.include	"chr/bg/crown.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/post_b.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/post_b_new.s"
	.elseif	.defined(ANN)
		.include	"chr/bg/post_b_nsm.s"
	.endif

	.include	"chr/bg/pole.s"
	.include	"chr/bg/coral_a.s"
	.include	"chr/bg/coin_a.s"

	.if	.defined(SMBM)|.defined(VS_SMB)
		.include	"chr/bg/castle_b.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/castle_b_new.s"
	.endif

	.include	"chr/bg/stair.s"

	.if	.defined(SMB)
		.include	"chr/bg/font_h.s"
	.elseif	.defined(VS_SMB)|.defined(SMB2M)
		.include	"chr/bg/font_h.vs.s"
	.endif

	.include	"chr/bg/cloud_small.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/floor_normal.s"
		.include	"chr/bg/tree.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/floor_normal_new.s"
		.include	"chr/bg/tree_new.s"
	.endif

	.include	"chr/bg/tree_trunk.s"

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/bridge_parts.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/bridge_parts_new.s"
	.endif

	.include	"chr/bg/coin_b.s"
	.include	"chr/bg/cannon.s"

	.if	.defined(CONS)
		.include	"chr/bg/cursor.s"
	.elseif	.defined(VS)
		.include	"chr/bg/cursor_vs.s"
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.include	"chr/bg/font_i.s"
	.elseif	.defined(SMB2M)
		.include	"chr/bg/font_i.smb2.s"
	.endif

	.include	"chr/bg/sign_text_b.s"
	.include	"chr/bg/coral_b.s"

	.if	.defined(SMB)
		.include	"chr/bg/padding.s"
	.elseif	.defined(VS_SMB)
		.include	"chr/bg/sign_text_g.s"
		.include	"chr/bg/window.s"
	.elseif	.defined(SMB2)
		.include	"chr/bg/sign_text_c.s"
		.include	"chr/bg/line_b.s"
		.include	"chr/bg/star_smb2.s"
		.include	"chr/bg/font_j.smb2.s"
		.include	"chr/bg/floor_un0.s"
		.include	"chr/bg/cactus.s"
		.include	"chr/bg/floor_un1.s"
	.elseif	.defined(ANN)
		.include	"chr/bg/sign_text_d.s"
		.include	"chr/bg/line_b.s"
		.include	"chr/bg/star_smb2.s"
		.include	"chr/bg/font_j.smb2.s"
		.include	"chr/bg/sign_text_e.s"
		.include	"chr/bg/quotes.s"
		.include	"chr/bg/sign_text_f.s"
	.endif

	.include	"chr/bg/line_c.s"

