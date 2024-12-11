.include	"system/ppu.i"

.include	"math.i"
.include	"misc.i"
.include	"chr.i"

; ------------------------------------------------------------
	.export render_actor_tile_data
render_actor_tile_data:
render_actor_tiles_buzzy:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::buzzy_a+0, chr_obj::buzzy_a+1
	.byte	chr_obj::buzzy_a+2, chr_obj::buzzy_a+3
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::buzzy_a+4, chr_obj::buzzy_a+5
	.byte	chr_obj::buzzy_a+6, chr_obj::buzzy_a+7
; -----------------------------
render_actor_tiles_koopa:
	.byte	chr_obj::empty, chr_obj::koopa_b+5
	.byte	chr_obj::koopa_b+6, chr_obj::koopa_b+7
	.byte	chr_obj::koopa_b+8, chr_obj::koopa_b+9
; --------------
	.byte	chr_obj::empty, chr_obj::koopa_b+0
	.byte	chr_obj::koopa_b+1, chr_obj::koopa_b+2
	.byte	chr_obj::koopa_b+3, chr_obj::koopa_b+4
; --------------
render_actor_tiles_koopa_para:
	.byte	chr_obj::koopa_a+0, chr_obj::koopa_b+5
	.byte	chr_obj::koopa_a+1, chr_obj::koopa_b+7
	.byte	chr_obj::koopa_b+8, chr_obj::koopa_b+9
; --------------
	.byte	chr_obj::koopa_a+2, chr_obj::koopa_b+0
	.byte	chr_obj::koopa_a+3, chr_obj::koopa_b+2
	.byte	chr_obj::koopa_b+3, chr_obj::koopa_b+4
; -----------------------------
	.export render_actor_tiles_spiny
render_actor_tiles_spiny:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::spiny+0, chr_obj::spiny+1
	.byte	chr_obj::spiny+2, chr_obj::spiny+3
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::spiny+4, chr_obj::spiny+5
	.byte	chr_obj::spiny+6, chr_obj::spiny+7
; -----------------------------
	.export render_actor_tiles_spiny_egg
render_actor_tiles_spiny_egg:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::spiny_egg_a+1, chr_obj::spiny_egg_a+0
	.byte	chr_obj::spiny_egg_a+0, chr_obj::spiny_egg_a+1
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::spiny_egg_b+1, chr_obj::spiny_egg_b+0
	.byte	chr_obj::spiny_egg_b+0, chr_obj::spiny_egg_b+1
; -----------------------------
	.export render_actor_tiles_blooper
render_actor_tiles_blooper:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::blooper+0, chr_obj::blooper+0
	.byte	chr_obj::blooper+3, chr_obj::blooper+3
; --------------
	.byte	chr_obj::blooper+0, chr_obj::blooper+0
	.byte	chr_obj::blooper+1, chr_obj::blooper+1
	.byte	chr_obj::blooper+2, chr_obj::blooper+2
; -----------------------------
	.export render_actor_tiles_cheep
render_actor_tiles_cheep:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::cheep+0, chr_obj::cheep+1
	.byte	chr_obj::cheep+2, chr_obj::cheep+3
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::cheep+4, chr_obj::cheep+1
	.byte	chr_obj::cheep+5, chr_obj::cheep+3
; -----------------------------
	.export render_actor_tiles_goomba
render_actor_tiles_goomba:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::goomba+0, chr_obj::goomba+1
	.byte	chr_obj::goomba+2, chr_obj::goomba+3
; -----------------------------
	.export render_actor_tiles_koopa_stun_flip
render_actor_tiles_koopa_stun_flip:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::koopa_a+5, chr_obj::koopa_a+5
	.byte	chr_obj::koopa_a+6, chr_obj::koopa_a+6
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::koopa_a+4, chr_obj::koopa_a+4
	.byte	chr_obj::koopa_a+6, chr_obj::koopa_a+6
; --------------
	.export render_actor_tiles_koopa_stun
render_actor_tiles_koopa_stun:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::koopa_a+6, chr_obj::koopa_a+6
	.byte	chr_obj::koopa_a+5, chr_obj::koopa_a+5
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::koopa_a+6, chr_obj::koopa_a+6
	.byte	chr_obj::koopa_a+4, chr_obj::koopa_a+4
; -----------------------------
	.export render_actor_tiles_buzzy_stun_flip
render_actor_tiles_buzzy_stun_flip:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::buzzy_b+0, chr_obj::buzzy_b+0
	.byte	chr_obj::buzzy_b+1, chr_obj::buzzy_b+1
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::buzzy_b+0, chr_obj::buzzy_b+0
	.byte	chr_obj::buzzy_b+1, chr_obj::buzzy_b+1
; --------------
	.export render_actor_tiles_buzzy_stun
render_actor_tiles_buzzy_stun:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::buzzy_b+1, chr_obj::buzzy_b+1
	.byte	chr_obj::buzzy_b+0, chr_obj::buzzy_b+0
; --------------
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::buzzy_b+1, chr_obj::buzzy_b+1
	.byte	chr_obj::buzzy_b+0, chr_obj::buzzy_b+0
; -----------------------------
	.export render_actor_tiles_goomba_stomped
render_actor_tiles_goomba_stomped:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::goomba_stomped, chr_obj::goomba_stomped
; -----------------------------
	.export render_actor_tiles_lakitu
render_actor_tiles_lakitu:
	.byte	chr_obj::lakitu+1, chr_obj::lakitu+0
	.byte	chr_obj::lakitu+3, chr_obj::lakitu+2
	.byte	chr_obj::lakitu+4, chr_obj::lakitu+4
; --------------
	.export render_actor_tiles_lakitu_duck
render_actor_tiles_lakitu_duck:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::lakitu+5, chr_obj::lakitu+5
	.byte	chr_obj::lakitu+4, chr_obj::lakitu+4
; -----------------------------
render_actor_tiles_princess:
	.byte	chr_obj::princess_a+0

	.if	.defined(SMBV1)
		.byte				chr_obj::princess_a+1
	.elseif	.defined(SMBV2)
		.byte				chr_obj::princess_c+0
	.endif

	.if	.defined(SMBV1)
		.byte	chr_obj::princess_c+0, chr_obj::princess_c+1
	.elseif	.defined(SMBV2)
		.byte	chr_obj::princess_a+1, chr_obj::princess_a+1
	.endif

	.byte	chr_obj::princess_b+0, chr_obj::princess_b+0
; -----------------------------
	.export render_actor_tiles_toad
render_actor_tiles_toad:
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_obj::toad+0, chr_obj::toad+0
		.byte	chr_obj::toad+1, chr_obj::toad+1
		.byte	chr_obj::toad+2, chr_obj::toad+2
	.elseif	.defined(ANN)
		.byte	chr_obj::toad+0, chr_obj::toad_ext+0
		.byte	chr_obj::toad+1, chr_obj::toad_ext+1
		.byte	chr_obj::toad+2, chr_obj::piranha_b+3
	.endif
; -----------------------------
render_actor_tiles_hammer_bro_a:
	.byte	chr_obj::hammer_bro_a+1, chr_obj::hammer_bro_a+0
	.byte	chr_obj::hammer_bro_c+0, chr_obj::hammer_bro_b+4
	.byte	chr_obj::hammer_bro_c+2, chr_obj::hammer_bro_c+1
; --------------
	.byte	chr_obj::hammer_bro_a+1, chr_obj::hammer_bro_a+0
	.byte	chr_obj::hammer_bro_b+1, chr_obj::hammer_bro_b+0
	.byte	chr_obj::hammer_bro_b+3, chr_obj::hammer_bro_b+2
; --------------
	.export render_actor_tiles_hammer_bro_b
render_actor_tiles_hammer_bro_b:
	.byte	chr_obj::hammer_bro_c+4, chr_obj::hammer_bro_c+3
	.byte	chr_obj::hammer_bro_d+1, chr_obj::hammer_bro_d+0
	.byte	chr_obj::hammer_bro_c+2, chr_obj::hammer_bro_c+1

	.byte	chr_obj::hammer_bro_c+4, chr_obj::hammer_bro_c+3
	.byte	chr_obj::hammer_bro_d+1, chr_obj::hammer_bro_d+0
	.byte	chr_obj::hammer_bro_b+3, chr_obj::hammer_bro_b+2
; -----------------------------
render_actor_tiles_piranha:
	.byte	chr_obj::piranha_a+0, chr_obj::piranha_a+0
	.byte	chr_obj::piranha_a+1, chr_obj::piranha_a+1

	.byte	chr_obj::piranha_b+0, chr_obj::piranha_b+0
; --------------
	.byte	chr_obj::piranha_b+1, chr_obj::piranha_b+1
	.byte	chr_obj::piranha_b+2, chr_obj::piranha_b+2

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	chr_obj::piranha_b+3, chr_obj::piranha_b+3
	.elseif	.defined(ANN)
		.byte	chr_obj::piranha_b+0, chr_obj::piranha_b+0
	.endif
; -----------------------------
render_actor_tiles_podoboo:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::podoboo_a+0, chr_obj::podoboo_a+0
	.byte	chr_obj::podoboo_b+0, chr_obj::podoboo_b+0
; -----------------------------
render_actor_tiles_bowser_mouth_opened:
	.byte	chr_obj::bowser+1, chr_obj::bowser+0
	.byte	chr_obj::bowser+3, chr_obj::bowser+2
	.byte	chr_obj::bowser+4, chr_obj::empty
; --------------
render_actor_tiles_bowser_step_right:
	.byte	chr_obj::bowser+6, chr_obj::bowser+5
	.byte	chr_obj::bowser+8, chr_obj::bowser+7
	.byte	chr_obj::bowser+10, chr_obj::bowser+9
; --------------
	.export render_actor_tiles_bowser_mouth_closed
render_actor_tiles_bowser_mouth_closed:
	.byte	chr_obj::bowser+1, chr_obj::bowser+0
	.byte	chr_obj::bowser+12, chr_obj::bowser+11
	.byte	chr_obj::bowser+4, chr_obj::empty
; --------------
	.export render_actor_tiles_bowser_step_left
render_actor_tiles_bowser_step_left:
	.byte	chr_obj::bowser+6, chr_obj::bowser+5
	.byte	chr_obj::bowser+8, chr_obj::bowser+7
	.byte	chr_obj::bowser+14, chr_obj::bowser+13
; -----------------------------
render_actor_tiles_bullet:
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::bullet+1, chr_obj::bullet+0
	.byte	chr_obj::bullet+3, chr_obj::bullet+2
; -----------------------------
render_actor_tiles_spring_a:
	.byte	chr_obj::spring+2, chr_obj::spring+2
	.byte	chr_obj::spring+3, chr_obj::spring+3
	.byte	chr_obj::spring+2, chr_obj::spring+2
; --------------
render_actor_tiles_spring_b:
	.byte	chr_obj::spring+1, chr_obj::spring+1
	.byte	chr_obj::spring+1, chr_obj::spring+1
	.byte	chr_obj::empty, chr_obj::empty
; --------------
render_actor_tiles_spring_c:
	.byte	chr_obj::spring+0, chr_obj::spring+0
	.byte	chr_obj::empty, chr_obj::empty
	.byte	chr_obj::empty, chr_obj::empty
; -----------------------------
	.export render_actor_tile_offsets
render_actor_tile_offsets:
	.byte	render_actor_tiles_koopa-render_actor_tile_data
	.byte	render_actor_tiles_koopa-render_actor_tile_data
	.byte	render_actor_tiles_buzzy-render_actor_tile_data
	.byte	render_actor_tiles_koopa-render_actor_tile_data

	.if	.defined(SMBV1)
		.byte	render_actor_tiles_koopa-render_actor_tile_data
	.elseif	.defined(SMBV2)
		.byte	render_actor_tiles_piranha-render_actor_tile_data
	.endif

	.byte	render_actor_tiles_hammer_bro_a-render_actor_tile_data
	.byte	render_actor_tiles_goomba-render_actor_tile_data
	.byte	render_actor_tiles_blooper-render_actor_tile_data
	.byte	render_actor_tiles_bullet-render_actor_tile_data
	.byte	render_actor_tiles_koopa_para-render_actor_tile_data
	.byte	render_actor_tiles_cheep-render_actor_tile_data
	.byte	render_actor_tiles_cheep-render_actor_tile_data
	.byte	render_actor_tiles_podoboo-render_actor_tile_data
	.byte	render_actor_tiles_piranha-render_actor_tile_data
	.byte	render_actor_tiles_koopa_para-render_actor_tile_data
	.byte	render_actor_tiles_koopa_para-render_actor_tile_data
	.byte	render_actor_tiles_koopa_para-render_actor_tile_data
	.byte	render_actor_tiles_lakitu-render_actor_tile_data
	.byte	render_actor_tiles_spiny-render_actor_tile_data
	.byte	$FF
	.byte	render_actor_tiles_cheep-render_actor_tile_data

	.byte	render_actor_tiles_princess-render_actor_tile_data
	.byte	render_actor_tiles_bowser_mouth_opened-render_actor_tile_data
	.byte	render_actor_tiles_bowser_step_right-render_actor_tile_data
	.byte	render_actor_tiles_spring_a-render_actor_tile_data
	.byte	render_actor_tiles_spring_b-render_actor_tile_data
	.byte	render_actor_tiles_spring_c-render_actor_tile_data
; -----------------------------
	.export render_actor_attrs
render_actor_attrs:
	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	obj_attr::priority_high|obj_attr::color3
	.byte	obj_attr::priority_high|obj_attr::color2

	.if	.defined(SMBV1)
		.byte	obj_attr::priority_high|obj_attr::color1
	.elseif	.defined(SMBV2)
		.byte	obj_attr::priority_low|obj_attr::color2
	.endif

	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color3
	.byte	obj_attr::priority_high|obj_attr::color3
	.byte	obj_attr::priority_high|obj_attr::color3
	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	obj_attr::priority_high|obj_attr::color2

	.export render_actor_attrs_piranha_plant
render_actor_attrs_piranha_plant:
	.byte	obj_attr::priority_low|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	$FF
	.byte	obj_attr::priority_high|obj_attr::color2

	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	obj_attr::priority_high|obj_attr::color1
	.byte	obj_attr::priority_high|obj_attr::color1

	.export render_actor_attrs_spring
render_actor_attrs_spring:
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	obj_attr::priority_high|obj_attr::color2
; -----------------------------
	.export render_actor_frame_modulos
render_actor_frame_modulos:
	.byte	MOD_16_8_UP
	.byte	MOD_32_8_UP
; -----------------------------
	.export render_actor_spring_ani_ids
render_actor_spring_ani_ids:
	.byte	actor::spring_ani_a
	.byte	actor::spring_ani_b
	.byte	actor::spring_ani_c
	.byte	actor::spring_ani_b
	.byte	actor::spring_ani_a
