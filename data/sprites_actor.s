.include	"system/ppu.i"

.include	"engine/math.i"
.include	"engine/misc.i"
.include	"engine/chr.i"

; ------------------------------------------------------------
	.export render_actor_tile_data
render_actor_tile_data:
render_actor_tiles_buzzy:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::buzzy_a+0, tile_obj::buzzy_a+1
	.byte	tile_obj::buzzy_a+2, tile_obj::buzzy_a+3
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::buzzy_a+4, tile_obj::buzzy_a+5
	.byte	tile_obj::buzzy_a+6, tile_obj::buzzy_a+7
; -----------------------------
render_actor_tiles_koopa:
	.byte	tile_obj::empty, tile_obj::koopa_b+5
	.byte	tile_obj::koopa_b+6, tile_obj::koopa_b+7
	.byte	tile_obj::koopa_b+8, tile_obj::koopa_b+9
; --------------
	.byte	tile_obj::empty, tile_obj::koopa_b+0
	.byte	tile_obj::koopa_b+1, tile_obj::koopa_b+2
	.byte	tile_obj::koopa_b+3, tile_obj::koopa_b+4
; --------------
render_actor_tiles_koopa_para:
	.byte	tile_obj::koopa_a+0, tile_obj::koopa_b+5
	.byte	tile_obj::koopa_a+1, tile_obj::koopa_b+7
	.byte	tile_obj::koopa_b+8, tile_obj::koopa_b+9
; --------------
	.byte	tile_obj::koopa_a+2, tile_obj::koopa_b+0
	.byte	tile_obj::koopa_a+3, tile_obj::koopa_b+2
	.byte	tile_obj::koopa_b+3, tile_obj::koopa_b+4
; -----------------------------
	.export render_actor_tiles_spiny
render_actor_tiles_spiny:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::spiny+0, tile_obj::spiny+1
	.byte	tile_obj::spiny+2, tile_obj::spiny+3
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::spiny+4, tile_obj::spiny+5
	.byte	tile_obj::spiny+6, tile_obj::spiny+7
; -----------------------------
	.export render_actor_tiles_spiny_egg
render_actor_tiles_spiny_egg:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::spiny_egg_a+1, tile_obj::spiny_egg_a+0
	.byte	tile_obj::spiny_egg_a+0, tile_obj::spiny_egg_a+1
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::spiny_egg_b+1, tile_obj::spiny_egg_b+0
	.byte	tile_obj::spiny_egg_b+0, tile_obj::spiny_egg_b+1
; -----------------------------
	.export render_actor_tiles_blooper
render_actor_tiles_blooper:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::blooper+0, tile_obj::blooper+0
	.byte	tile_obj::blooper+3, tile_obj::blooper+3
; --------------
	.byte	tile_obj::blooper+0, tile_obj::blooper+0
	.byte	tile_obj::blooper+1, tile_obj::blooper+1
	.byte	tile_obj::blooper+2, tile_obj::blooper+2
; -----------------------------
	.export render_actor_tiles_cheep
render_actor_tiles_cheep:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::cheep+0, tile_obj::cheep+1
	.byte	tile_obj::cheep+2, tile_obj::cheep+3
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::cheep+4, tile_obj::cheep+1
	.byte	tile_obj::cheep+5, tile_obj::cheep+3
; -----------------------------
	.export render_actor_tiles_goomba
render_actor_tiles_goomba:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::goomba+0, tile_obj::goomba+1
	.byte	tile_obj::goomba+2, tile_obj::goomba+3
; -----------------------------
	.export render_actor_tiles_koopa_stun_flip
render_actor_tiles_koopa_stun_flip:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::koopa_a+5, tile_obj::koopa_a+5
	.byte	tile_obj::koopa_a+6, tile_obj::koopa_a+6
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::koopa_a+4, tile_obj::koopa_a+4
	.byte	tile_obj::koopa_a+6, tile_obj::koopa_a+6
; --------------
	.export render_actor_tiles_koopa_stun
render_actor_tiles_koopa_stun:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::koopa_a+6, tile_obj::koopa_a+6
	.byte	tile_obj::koopa_a+5, tile_obj::koopa_a+5
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::koopa_a+6, tile_obj::koopa_a+6
	.byte	tile_obj::koopa_a+4, tile_obj::koopa_a+4
; -----------------------------
	.export render_actor_tiles_buzzy_stun_flip
render_actor_tiles_buzzy_stun_flip:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::buzzy_b+0, tile_obj::buzzy_b+0
	.byte	tile_obj::buzzy_b+1, tile_obj::buzzy_b+1
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::buzzy_b+0, tile_obj::buzzy_b+0
	.byte	tile_obj::buzzy_b+1, tile_obj::buzzy_b+1
; --------------
	.export render_actor_tiles_buzzy_stun
render_actor_tiles_buzzy_stun:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::buzzy_b+1, tile_obj::buzzy_b+1
	.byte	tile_obj::buzzy_b+0, tile_obj::buzzy_b+0
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::buzzy_b+1, tile_obj::buzzy_b+1
	.byte	tile_obj::buzzy_b+0, tile_obj::buzzy_b+0
; -----------------------------
	.export render_actor_tiles_goomba_stomped
render_actor_tiles_goomba_stomped:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::goomba_stomped, tile_obj::goomba_stomped
; -----------------------------
	.export render_actor_tiles_lakitu
render_actor_tiles_lakitu:
	.byte	tile_obj::lakitu+1, tile_obj::lakitu+0
	.byte	tile_obj::lakitu+3, tile_obj::lakitu+2
	.byte	tile_obj::lakitu+4, tile_obj::lakitu+4
; --------------
	.export render_actor_tiles_lakitu_duck
render_actor_tiles_lakitu_duck:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::lakitu+5, tile_obj::lakitu+5
	.byte	tile_obj::lakitu+4, tile_obj::lakitu+4
; -----------------------------
render_actor_tiles_princess:
	.byte	tile_obj::princess_a+0

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte				tile_obj::princess_a+1
	.elseif	.defined(SMB2M)
		.byte				tile_obj::princess_c+0
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	tile_obj::princess_c+0, tile_obj::princess_c+1
	.elseif	.defined(SMB2M)
		.byte	tile_obj::princess_a+1, tile_obj::princess_a+1
	.endif

	.byte	tile_obj::princess_b+0, tile_obj::princess_b+0
; -----------------------------
	.export render_actor_tiles_toad
render_actor_tiles_toad:
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_obj::toad+0, tile_obj::toad+0
		.byte	tile_obj::toad+1, tile_obj::toad+1
		.byte	tile_obj::toad+2, tile_obj::toad+2
	.elseif	.defined(ANN)
		.byte	tile_obj::toad+0, tile_obj::toad_ext+0
		.byte	tile_obj::toad+1, tile_obj::toad_ext+1
		.byte	tile_obj::toad+2, tile_obj::piranha_b+3
	.endif
; -----------------------------
render_actor_tiles_hammer_bro_a:
	.byte	tile_obj::hammer_bro_a+1, tile_obj::hammer_bro_a+0
	.byte	tile_obj::hammer_bro_c+0, tile_obj::hammer_bro_b+4
	.byte	tile_obj::hammer_bro_c+2, tile_obj::hammer_bro_c+1
; --------------
	.byte	tile_obj::hammer_bro_a+1, tile_obj::hammer_bro_a+0
	.byte	tile_obj::hammer_bro_b+1, tile_obj::hammer_bro_b+0
	.byte	tile_obj::hammer_bro_b+3, tile_obj::hammer_bro_b+2
; --------------
	.export render_actor_tiles_hammer_bro_b
render_actor_tiles_hammer_bro_b:
	.byte	tile_obj::hammer_bro_c+4, tile_obj::hammer_bro_c+3
	.byte	tile_obj::hammer_bro_d+1, tile_obj::hammer_bro_d+0
	.byte	tile_obj::hammer_bro_c+2, tile_obj::hammer_bro_c+1

	.byte	tile_obj::hammer_bro_c+4, tile_obj::hammer_bro_c+3
	.byte	tile_obj::hammer_bro_d+1, tile_obj::hammer_bro_d+0
	.byte	tile_obj::hammer_bro_b+3, tile_obj::hammer_bro_b+2
; -----------------------------
render_actor_tiles_piranha:
	.byte	tile_obj::piranha_a+0, tile_obj::piranha_a+0
	.byte	tile_obj::piranha_a+1, tile_obj::piranha_a+1

	.byte	tile_obj::piranha_b+0, tile_obj::piranha_b+0
; --------------
	.byte	tile_obj::piranha_b+1, tile_obj::piranha_b+1
	.byte	tile_obj::piranha_b+2, tile_obj::piranha_b+2

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		.byte	tile_obj::piranha_b+3, tile_obj::piranha_b+3
	.elseif	.defined(ANN)
		.byte	tile_obj::piranha_b+0, tile_obj::piranha_b+0
	.endif
; -----------------------------
render_actor_tiles_podoboo:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::podoboo_a+0, tile_obj::podoboo_a+0
	.byte	tile_obj::podoboo_b+0, tile_obj::podoboo_b+0
; -----------------------------
render_actor_tiles_bowser_a:
	.byte	tile_obj::bowser+1, tile_obj::bowser+0
	.byte	tile_obj::bowser+3, tile_obj::bowser+2
	.byte	tile_obj::bowser+4, tile_obj::empty
; --------------
render_actor_tiles_bowser_b:
	.byte	tile_obj::bowser+6, tile_obj::bowser+5
	.byte	tile_obj::bowser+8, tile_obj::bowser+7
	.byte	tile_obj::bowser+10, tile_obj::bowser+9
; --------------
	.export render_actor_tiles_bowser_c
render_actor_tiles_bowser_c:
	.byte	tile_obj::bowser+1, tile_obj::bowser+0
	.byte	tile_obj::bowser+12, tile_obj::bowser+11
	.byte	tile_obj::bowser+4, tile_obj::empty
; --------------
	.export render_actor_tiles_bowser_d
render_actor_tiles_bowser_d:
	.byte	tile_obj::bowser+6, tile_obj::bowser+5
	.byte	tile_obj::bowser+8, tile_obj::bowser+7
	.byte	tile_obj::bowser+14, tile_obj::bowser+13
; -----------------------------
render_actor_tiles_bullet:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::bullet+1, tile_obj::bullet+0
	.byte	tile_obj::bullet+3, tile_obj::bullet+2
; -----------------------------
render_actor_tiles_spring_a:
	.byte	tile_obj::spring+2, tile_obj::spring+2
	.byte	tile_obj::spring+3, tile_obj::spring+3
	.byte	tile_obj::spring+2, tile_obj::spring+2
; --------------
render_actor_tiles_spring_b:
	.byte	tile_obj::spring+1, tile_obj::spring+1
	.byte	tile_obj::spring+1, tile_obj::spring+1
	.byte	tile_obj::empty, tile_obj::empty
; --------------
render_actor_tiles_spring_c:
	.byte	tile_obj::spring+0, tile_obj::spring+0
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty
; -----------------------------
	.export render_actor_tile_offsets
render_actor_tile_offsets:
	.byte	render_actor_tiles_koopa-render_actor_tile_data
	.byte	render_actor_tiles_koopa-render_actor_tile_data
	.byte	render_actor_tiles_buzzy-render_actor_tile_data
	.byte	render_actor_tiles_koopa-render_actor_tile_data

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	render_actor_tiles_koopa-render_actor_tile_data
	.elseif	.defined(SMB2M)
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
	.byte	render_actor_tiles_bowser_a-render_actor_tile_data
	.byte	render_actor_tiles_bowser_b-render_actor_tile_data
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

	.if	.defined(SMB)|.defined(VS_SMB)
		.byte	obj_attr::priority_high|obj_attr::color1
	.elseif	.defined(SMB2M)
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
