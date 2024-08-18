.include	"engine/chr.i"

; ------------------------------------------------------------
	.export	render_player_tile_offsets
render_player_tile_offsets:

	.export render_player_tile_offset_large
render_player_tile_offset_large:
	.byte	render_player_tile_jump_large-render_player_tile_data
	.byte	render_player_tile_swim_large-render_player_tile_data
	.byte	render_player_tile_stand_large-render_player_tile_data
	.byte	render_player_tile_skid_large-render_player_tile_data
	.byte	render_player_tile_walk_large-render_player_tile_data
	.byte	render_player_tile_climb_large-render_player_tile_data

	.export render_player_tile_offset_crouch
render_player_tile_offset_crouch:
	.byte	render_player_tile_crouch_large-render_player_tile_data

	.export render_player_tile_offset_proj
render_player_tile_offset_proj:
	.byte	render_player_tile_proj_large-render_player_tile_data

	.export render_player_tile_offset_small
render_player_tile_offset_small:
	.byte	render_player_tile_jump_small-render_player_tile_data
	.byte	render_player_tile_swim_small-render_player_tile_data
	.byte	render_player_tile_stand_small-render_player_tile_data
	.byte	render_player_tile_skid_small-render_player_tile_data
	.byte	render_player_tile_walk_small-render_player_tile_data
	.byte	render_player_tile_climb_small-render_player_tile_data

	.export render_player_tile_offset_death
render_player_tile_offset_death:
	.byte	render_player_tile_death_small-render_player_tile_data

	.export render_player_tile_offset_stand_small_b
render_player_tile_offset_stand_small_b:
	.byte	render_player_tile_stand_small-render_player_tile_data
; -----------------------------
	.export	render_player_tile_data
render_player_tile_data:
render_player_tile_walk_large:
	.byte	tile_obj::player_walk_large+00, tile_obj::player_walk_large+01

	.byte	tile_obj::player_walk_large+02, tile_obj::player_walk_large+03
	.byte	tile_obj::player_walk_large+04, tile_obj::player_walk_large+05
	.byte	tile_obj::player_walk_large+06, tile_obj::player_walk_large+07
; --------------
	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_walk_large+10, tile_obj::player_walk_large+11

	.byte	tile_obj::player_walk_large+12

	.byte					tile_obj::player_walk_large+13

	.byte	tile_obj::player_walk_large+14, tile_obj::player_walk_large+15
; --------------
	.byte	tile_obj::player_walk_large+16, tile_obj::player_walk_large+17
	.byte	tile_obj::player_walk_large+18, tile_obj::player_walk_large+19
	.byte	tile_obj::player_walk_large+20, tile_obj::player_walk_large+21
	.byte	tile_obj::player_walk_large+22, tile_obj::player_walk_large+23
; -----------------------------
render_player_tile_skid_large:
	.byte	tile_obj::player_skid_large+00, tile_obj::player_skid_large+01
	.byte	tile_obj::player_skid_large+02, tile_obj::player_skid_large+03
	.byte	tile_obj::player_skid_large+04, tile_obj::player_skid_large+05
	.byte	tile_obj::player_skid_large+06, tile_obj::player_skid_large+07
; -----------------------------
render_player_tile_jump_large:
	.byte	tile_obj::player_jump_large+00, tile_obj::player_jump_large+01
	.byte	tile_obj::player_jump_large+02, tile_obj::player_jump_large+03
	.byte	tile_obj::player_jump_large+04, tile_obj::player_jump_large+05
	.byte	tile_obj::player_jump_large+06, tile_obj::player_jump_large+07
; -----------------------------
render_player_tile_swim_large:
	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_swim_large+00, tile_obj::player_swim_large+01
	.byte	tile_obj::player_swim_large+02, tile_obj::player_swim_large+03

	.byte	tile_obj::player_swim_large+04, tile_obj::player_swim_large+05
; --------------
	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_walk_large+10, tile_obj::player_walk_large+11

	.byte	tile_obj::player_walk_large+12

	.byte					tile_obj::player_swim_large+08

	.byte	tile_obj::player_swim_large+04, tile_obj::player_swim_large+05
; --------------
	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_walk_large+10, tile_obj::player_walk_large+11

	.byte	tile_obj::player_swim_large+06, tile_obj::player_swim_large+07

	.byte	tile_obj::player_swim_large+04, tile_obj::player_swim_large+05
; -----------------------------
render_player_tile_climb_large:
	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_swim_large+00, tile_obj::player_swim_large+01
	.byte	tile_obj::player_swim_large+02, tile_obj::player_swim_large+03

	.byte	tile_obj::player_climb_large+00, tile_obj::player_climb_large+01
; --------------
	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_walk_large+10, tile_obj::player_walk_large+11

	.byte	tile_obj::player_walk_large+12

	.byte					tile_obj::player_walk_large+13

	.byte	tile_obj::player_climb_large+02, tile_obj::player_climb_large+03
; -----------------------------
	.export render_player_tile_crouch_large
render_player_tile_crouch_large:
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_crouch+00, tile_obj::player_crouch+01
	.byte	tile_obj::player_crouch+02, tile_obj::player_crouch+02
; -----------------------------
render_player_tile_proj_large:
	.byte	tile_obj::player_walk_large+08, tile_obj::player_walk_large+09

	.byte	tile_obj::player_swim_large+00, tile_obj::player_swim_large+01
	.byte	tile_obj::player_swim_large+02, tile_obj::player_swim_large+03

	.byte	tile_obj::player_walk_large+14, tile_obj::player_walk_large+15
; -----------------------------
render_player_tile_walk_small:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+00
	
	.byte					tile_obj::player_walk_small+01

	.byte	tile_obj::player_walk_small+02, tile_obj::player_walk_small+03
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+04

	.byte					tile_obj::player_walk_small+05

	.byte	tile_obj::player_walk_small+06, tile_obj::player_walk_small+07
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+08

	.byte					tile_obj::player_walk_small+05

	.byte	tile_obj::player_walk_small+09, tile_obj::player_walk_small+10
; -----------------------------
render_player_tile_skid_small:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_skid_small+00, tile_obj::player_skid_small+01
	.byte	tile_obj::player_skid_small+02, tile_obj::player_skid_small+03
; -----------------------------
render_player_tile_jump_small:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+00

	.byte					tile_obj::player_jump_small+00
	.byte	tile_obj::player_jump_small+01, tile_obj::player_jump_small+02
; -----------------------------
	.export render_player_tile_swim_small
render_player_tile_swim_small:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+00
	
	.byte					tile_obj::player_walk_small+01

	.byte	tile_obj::player_swim_small+00
	
	.byte					tile_obj::player_swim_small+01
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+00
	
	.byte					tile_obj::player_walk_small+01

	.byte	tile_obj::player_swim_small+00
	
	.byte					tile_obj::player_swim_small+03
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+00
	
	.byte					tile_obj::player_walk_small+01

	.byte	tile_obj::player_swim_small+04, tile_obj::player_swim_small+05
; -----------------------------
render_player_tile_climb_small:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+00
	
	.byte					tile_obj::player_walk_small+01

	.byte	tile_obj::player_climb_small+00, tile_obj::player_climb_small+01
; --------------
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+08

	.byte					tile_obj::player_walk_small+05

	.byte	tile_obj::player_climb_small+02, tile_obj::player_climb_small+03
; -----------------------------
render_player_tile_death_small:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_death+00, tile_obj::player_death+00
	.byte	tile_obj::player_death+01, tile_obj::player_death+01
; -----------------------------
	.export render_player_tile_stand
render_player_tile_stand:

	.export render_player_tile_stand_small
render_player_tile_stand_small:
	.byte	tile_obj::empty, tile_obj::empty
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_small+08
	
	.byte					tile_obj::player_walk_small+05

	.byte	tile_obj::player_resize+05, tile_obj::player_resize+05
; -----------------------------
	.export render_player_tile_stand_medium
render_player_tile_stand_medium:
	.byte	tile_obj::empty, tile_obj::empty

	.byte	tile_obj::player_walk_large+00, tile_obj::player_walk_large+01

	.byte	tile_obj::player_resize+02, tile_obj::player_resize+03

	.byte	tile_obj::player_resize+04, tile_obj::player_resize+04
; -----------------------------
	.export render_player_tile_stand_large
render_player_tile_stand_large:
	.byte	tile_obj::player_walk_large+00, tile_obj::player_walk_large+01

	.byte	tile_obj::player_resize+02, tile_obj::player_resize+03

	.byte	tile_obj::player_resize+00, tile_obj::player_resize+00
	.byte	tile_obj::player_resize+01, tile_obj::player_resize+01
; -----------------------------
	.export render_player_swim_foot_left
render_player_swim_foot_left:
	.byte	tile_obj::player_swim_large+09, tile_obj::player_swim_small+02
; -----------------------------
