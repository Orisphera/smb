.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

BG_PROC_METATILE_ID	= zp_byte_07

	.export bg_proc
bg_proc:
	ldy	bg_proc_id
	bne	:+ ; if (bg_proc_id == main_c) {
		ldy	#bg_procs::main_b
		sty	bg_proc_id
	: ; }

	dey
	tya
	jsr	bg_proc_do

	dec	bg_proc_id
	bne	:+ ; if (bg_proc_id == inc_col_a) {
		jsr	gfx_render_attr
	: ; }

	rts
; ------------------------------------------------------------
	.export bg_proc_tbl
	.export bg_proc_inc_col_a, bg_proc_inc_col_b
	.export bg_proc_gfx_render_area_a, bg_proc_gfx_render_area_b
	.export bg_proc_gfx_render_area_c, bg_proc_gfx_render_area_d
	.export bg_proc_main_a, bg_proc_main_b
bg_proc_do:
	jsr	tbljmp
bg_proc_tbl:
bg_proc_inc_col_a:
	.addr	bg_inc_col
bg_proc_gfx_render_area_a:
	.addr	gfx_render_area
bg_proc_gfx_render_area_b:
	.addr	gfx_render_area
bg_proc_main_a:
	.addr	bg_proc_main
bg_proc_inc_col_b:
	.addr	bg_inc_col
bg_proc_gfx_render_area_c:
	.addr	gfx_render_area
bg_proc_gfx_render_area_d:
	.addr	gfx_render_area
bg_proc_main_b:
	.addr	bg_proc_main
; ------------------------------------------------------------
bg_inc_col:
	inc	pos_x_lo_game
	lda	pos_x_lo_game
	and	#%00001111
	bne	:+ ; if (!(game.pos_x & 0xF)) {
		sta	pos_x_lo_game
		inc	pos_x_hi_game
	: ; }

	inc	disp_buff_col
	lda	disp_buff_col
	and	#%00011111
	sta	disp_buff_col
	rts
; ------------------------------------------------------------
	.export bg_scenery_static_tbl
	.export bg_scenery_static_tbl_cloud
	.export bg_scenery_static_tbl_mnt_bush
	.export bg_scenery_static_tbl_tree_fence
bg_scenery_static_tbl:
bg_scenery_static_tbl_cloud:
	.byte	bg_scenery_static_cloud-bg_scenery_static

bg_scenery_static_tbl_mnt_bush:
	.byte	bg_scenery_static_mnt_bush-bg_scenery_static

bg_scenery_static_tbl_tree_fence:
	.byte	bg_scenery_static_tree_fence-bg_scenery_static

bg_scenery_static:
bg_scenery_static_cloud:
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.res	2, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.res	2, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+5-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+5-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+5-gfx_metatile)<<4))
	.res	6, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.res	6, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.res	4, ENG_TILEOBJ_NULL
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+5-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+5-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+5-gfx_metatile)<<4))
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+4-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+4-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+4-gfx_metatile)<<4))
	.res	5, ENG_TILEOBJ_NULL
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))

bg_scenery_static_mnt_bush:
	.byte	<((((bg_tile_mnt_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_mnt_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+8-gfx_metatile)<<4))
	.byte	<((((bg_tile_mnt_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+8-gfx_metatile)<<4))
	.byte	<((((bg_tile_mnt_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+8-gfx_metatile)<<4))
	.byte	<((((bg_tile_mnt_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.res	3, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_mnt_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_mnt_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_mnt_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_bush_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.res	4, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_bush_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_bush_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.res	3, ENG_TILEOBJ_NULL

bg_scenery_static_tree_fence:
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.res	7, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_tree_tall-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+8-gfx_metatile)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_tree_tall-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+8-gfx_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.res	2, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+1-gfx_metatile)<<4))
	.res	4, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+9-gfx_metatile)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+10-gfx_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_tree_tall-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+8-gfx_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_TILEOBJ_SIZE)+1)|((gfx_metatile+0-gfx_metatile)<<4))

bg_tiles:
bg_tile_cloud_left:
	.byte	metatile_2::cloud_a
	.byte	metatile_2::cloud_d
	.byte	metatile_0::blank_a
bg_tile_cloud_middle:
	.byte	metatile_2::cloud_b
	.byte	metatile_2::cloud_e
	.byte	metatile_0::blank_a
bg_tile_cloud_right:
	.byte	metatile_2::cloud_c
	.byte	metatile_2::cloud_f
	.byte	metatile_0::blank_a

bg_tile_bush_left:
	.byte	metatile_0::bush_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
bg_tile_bush_middle:
	.byte	metatile_0::bush_b
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
bg_tile_bush_right:
	.byte	metatile_0::bush_c
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a

bg_tile_mnt_left:
	.byte	metatile_0::blank_a
	.byte	metatile_0::hill_a
	.byte	metatile_0::hill_b
bg_tile_mnt_middle:
	.byte	metatile_0::hill_c
	.byte	metatile_0::hill_b
	.byte	metatile_0::hill_f
bg_tile_mnt_right:
	.byte	metatile_0::blank_a
	.byte	metatile_0::hill_d
	.byte	metatile_0::hill_e

bg_tile_fence:
	.byte	metatile_1::post
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
bg_tile_tree_tall:
	.byte	metatile_0::tree_a
	.byte	metatile_0::tree_c
	.byte	metatile_1::tree_trunk
bg_tile_tree_short:
	.byte	metatile_0::tree_b
	.byte	metatile_1::tree_trunk
	.byte	metatile_1::tree_trunk
bg_tiles_end:

	.export fg_scenery_tbl
	.export fg_scenery_tbl_water
	.export fg_scenery_tbl_walls
	.export fg_scenery_tbl_surface
fg_scenery_tbl:
fg_scenery_tbl_water:
	.byte	fg_scenery_water-fg_scenery

fg_scenery_tbl_walls:
	.byte	fg_scenery_walls-fg_scenery

fg_scenery_tbl_surface:
	.byte	fg_scenery_surface-fg_scenery

fg_scenery:
fg_scenery_water:
	.byte	metatile_2::water_a
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_2::water_b
	.byte	metatile_1::floor_underwater
	.byte	metatile_1::floor_underwater

fg_scenery_walls:
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_1::castle_a
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a

fg_scenery_surface:
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_2::water_a
	.byte	metatile_2::water_b

fg_tiles:
	.byte	metatile_1::floor_underwater
	.byte	metatile_1::floor_normal
	.byte	metatile_1::brick_b
	.byte	metatile_1::floor_castle

	.export	fg_masks
	.export fg_mask_0, fg_mask_1
	.export fg_mask_2, fg_mask_3
	.export fg_mask_4, fg_mask_5
	.export fg_mask_6, fg_mask_7
	.export fg_mask_8, fg_mask_9
	.export fg_mask_10, fg_mask_11
	.export fg_mask_12, fg_mask_13
	.export fg_mask_14, fg_mask_15
fg_masks:
fg_mask_0:
	.byte	%00000000, %00000000
fg_mask_1:
	.byte	%00000000, %00011000
fg_mask_2:
	.byte	%00000001, %00011000
fg_mask_3:
	.byte	%00000111, %00011000
fg_mask_4:
	.byte	%00001111, %00011000
fg_mask_5:
	.byte	%11111111, %00011000
fg_mask_6:
	.byte	%00000001, %00011111
fg_mask_7:
	.byte	%00000111, %00011111
fg_mask_8:
	.byte	%00001111, %00011111
fg_mask_9:
	.byte	%10000001, %00011111
fg_mask_10:
	.byte	%00000001, %00000000
fg_mask_11:
	.byte	%10001111, %00011111
fg_mask_12:
	.byte	%11110001, %00011111
fg_mask_13:
	.byte	%11111001, %00011000
fg_mask_14:
	.byte	%11110001, %00011000
fg_mask_15:
	.byte	%11111111, %00011111
; ------------------------------------------------------------
bg_proc_main_tile_idx	= zp_byte_00
bg_proc_main_fg_mask	= zp_byte_00
bg_proc_main_fg_next	= zp_byte_01
bg_proc_main_buffer_ptr_idx = zp_byte_00

bg_proc_main:
	lda	eng_page_cached
	beq	:+ ; if (eng_page_cached) {
		jsr	bg_scenery
	: ; }

	ldx	#METATILE_MAX-1
	lda	#0
	: ; for (entry of gfx_metatile) {
		sta	gfx_metatile, x

		dex
		bpl	:-
	; }

	ldy	course_bg_id
	beq	:++++ ; if (course.bg_id != 0) {
		lda	pos_x_hi_game
		: ; while ((game.pos_x.hi -= ENG_TILEOBJ_SIZE) > ENG_TILEOBJ_SIZE) {
			cmp	#ENG_TILEOBJ_SIZE
			bmi	:+
			sec
			sbc	#ENG_TILEOBJ_SIZE
			bpl	:-
		: ; }
	
		asl	a
		asl	a
		asl	a
		asl	a
		adc	bg_scenery_static_tbl-1, y
		adc	pos_x_lo_game
		tax
		lda	bg_scenery_static, x
		beq	:++ ; if (bg_scenery_static[(game.pos_x.hi*16)+bg_scenery_static_tbl[course_bg_id-1]+pos_x_lo_game]) {
			pha

			and	#%00001111
			sec
			sbc	#1
			sta	bg_proc_main_tile_idx
			asl	a
			adc	bg_proc_main_tile_idx
			tax

			pla
			lsr	a
			lsr	a
			lsr	a
			lsr	a
			tay
			lda	#ENG_TILEOBJ_SIZE
			sta	bg_proc_main_tile_idx
			: ; for (
			;	x = bg_scenery_static_byte.bg_tiles_id, y = bg_scenery_static_byte.metatile_b_id, i = ENG_TILEOBJ_SIZE;
			;	y < (sizeof (bg_tiles)-1)/ENG_TILEOBJ_SIZE && i > 0;
			;	 x++, y++, i--
			; ) {
				lda	bg_tiles, x
				sta	gfx_metatile, y
		
				inx
				iny
				cpy	#((bg_tiles_end-bg_tiles)-1)/ENG_TILEOBJ_SIZE
				beq	:+
				dec	bg_proc_main_tile_idx
				bne	:-
			; }
		; }
	: ; }

	ldx	course_fg_id
	beq	:+++ ; if (course.fg_id != 0) {
		ldy	fg_scenery_tbl-1, x
		ldx	#0
		: ; for (byte of fg_scenery) {
			lda	fg_scenery, y
			beq	:+ ; if (fg_scenery_byte) {
				sta	gfx_metatile, x
			: ; }
		
			iny
			inx
			cpx	#METATILE_MAX
			bne	:--
		; }
	: ; }

	ldy	course_type
	bne	:+
	lda	course_no
	cmp	#course::no_08
	bne	:+ ; if (course.type == water && course.no == no_08) {
		lda	#metatile_1::floor_castle
		jmp	:++
	: ; } else {
		lda	fg_tiles, y
		ldy	course_type_cloud
		beq	:+ ; if (course.type == cloud) {
			lda	#metatile_2::cloud_small
		; }
	: ; }
	sta	BG_PROC_METATILE_ID

	ldx	#0
	lda	course_fg_mask_id
	asl	a
	tay
	: ; for (x = 0, y = 2*course.fg_mask_id; x < 0xD && y < 0x100; x += 8, y++) {
		lda	fg_masks, y
		sta	bg_proc_main_fg_mask
		iny
		sty	bg_proc_main_fg_next
		lda	course_type_cloud
		beq	:+	
		cpx	#0
		beq	:+ ; if (course.type == cloud && x != 0) {
			lda	bg_proc_main_fg_mask
			and	#%00001000
			sta	bg_proc_main_fg_mask
		: ; }
	
		ldy	#0
		: ; for (y = 0; x < 0xD && y < 8; x++, y++) {
			lda	actor_init_bullet_cheep_data_a, y
			bit	bg_proc_main_fg_mask
			beq	:+ ; if ((actor_init_bullet_cheep_data_a[y] & fg_mask)) {
				lda	BG_PROC_METATILE_ID
				sta	gfx_metatile, x
			: ; }
		
			inx
			cpx	#METATILE_MAX
			beq	:++
		
			lda	course_type
			cmp	#course_types::underground
			bne	:+
			cpx	#METATILE_MAX-2
			bne	:+ ; if (course.type == underground && tile == METATILE_MAX-2) {
				lda	#metatile_1::floor_normal
				sta	BG_PROC_METATILE_ID
			: ; }
		
			iny
			cpy	#8
			bne	:---
		; }
	
		ldy	bg_proc_main_fg_next
		bne	:-----
	: ; }

	jsr	bg_scenery
	lda	disp_buff_col
	jsr	bg_get_buffer_ptr
	ldx	#0
	ldy	#0
	: ; for (entry of gfx_metatile) {
		sty	bg_proc_main_buffer_ptr_idx
		lda	gfx_metatile, x
		and	#TILE_PAGE_BITS
		asl	a
		rol	a
		rol	a
		tay
		lda	gfx_metatile, x
		cmp	bg_buffer_cutoff, y
		bcs	:+ ; if (gfx_metatile_entry < bg_buffer_cutoff[gfx_metatile_entry>>6]) {
			lda	#0
		: ; }
		ldy	bg_proc_main_buffer_ptr_idx
		sta	(eng_buffer_ptr), y
		tya
		clc
		adc	#16
		tay

		inx
		cpx	#METATILE_MAX
		bcc	:--
	; }

	rts
; --------------
bg_buffer_cutoff:
	.byte	metatile_0::cutoff
	.byte	metatile_1::cutoff
	.byte	metatile_2::cutoff
	.byte	metatile_3::cutoff
; ------------------------------------------------------------
bg_scenery:
	.if	.defined(VS)
		jsr	vs_setbank_low
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	bg_scenery_outer_loop: ; while (eng_area_bg_flag || eng_page_cached) {
		ldx	#3-1
		bg_scenery_loop: ; for (actor_index = 3-1; actor_index >= 0; x--) {
			stx	actor_index
			lda	#0
			sta	eng_area_bg_flag
			ldy	scenery_offset

			.if	.defined(VS)
				lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
				sta	VS_REQ
			.endif

			lda	(course_scenery_addr), y
			cmp	#COURSE_SCENERY_END
			beq	:++++
			lda	scenery_length, x
			bpl	:++++ ; if (course_scenery_byte_0 != COURSE_SCENERY_END && (scenery_length & 0x80)) {
				iny
				lda	(course_scenery_addr), y
				asl	a
				bcc	:+
				lda	scenery_page_on
				bne	:+ ; if (scenery.next_page && !scenery.page_on) {
					inc	scenery_page_on
					inc	scenery_page_loc
				: ; }
			
				dey

				.if	.defined(VS)
					lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
					sta	VS_REQ
				.endif

				lda	(course_scenery_addr), y
				and	#<COURSE_SCENERY_TYPE_MASK
				cmp	#<COURSE_SCENERY_TYPE_D
				bne	:+
				iny
				lda	(course_scenery_addr), y
				dey
				and	#>COURSE_SCENERY_TYPE_D_MASK
				bne	:++
				lda	scenery_page_on
				bne	:++ ; if (scenery.type == 0xD && !scenery.is_D_object && !scenery.page_on) {
					iny

					.if	.defined(VS)
						lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
						sta	VS_REQ
					.endif

					lda	(course_scenery_addr), y
					and	#>COURSE_SCENERY_TYPE_D_LOC_MASK
					sta	scenery_page_loc
					inc	scenery_page_on
					jmp	:+++++
				: ; }
				cmp	#<COURSE_SCENERY_TYPE_E
				bne	:+
				lda	eng_page_cached
				bne	:++
				: lda	scenery_page_loc
				cmp	pos_x_hi_game
				bcc	:++
			; }
			: ; if (
			;	course_scenery_byte == COURSE_SCENERY_END
			;	|| !(scenery_length & 0x80)
			;	|| ((course_scenery_byte & 0xF) == 0xE && eng_page_cached)
			;	|| scenery_page_loc >= pos_x_hi_game) {
				jsr	bg_scenery_decode
				jmp	:+++
			: ; } else if (scenery_page_loc < pos_x_hi_game) {
				inc	eng_area_bg_flag
			: ; }
			; if (needs_increment) {
				jsr	bg_buffer_inc
			: ; }
		
			ldx	actor_index
			lda	scenery_length, x
			bmi	:+ ; if (!(scenery_length & 0x80)) {
				dec	scenery_length, x
			: ; }
		
			dex
			.if	.defined(CONS)
				bpl	bg_scenery_loop
			.elseif	.defined(VS)
				bmi	:+
					jmp	bg_scenery_loop
				:
			.endif
		; }

		lda	eng_area_bg_flag
		.if	.defined(CONS)
			bne	bg_scenery_outer_loop
		.elseif	.defined(VS)
			beq	:+
				jmp	bg_scenery_outer_loop
			:
		.endif

		lda	eng_page_cached
		.if	.defined(CONS)
			bne	bg_scenery_outer_loop
		.elseif	.defined(VS)
			beq	:+
				jmp	bg_scenery_outer_loop
			:
		.endif
	; }

bg_scenery_rts:
	.if	.defined(VS)
		jsr	vs_setbank_low
	.endif
	rts
; ------------------------------------------------------------
bg_buffer_inc:
	inc	scenery_offset
	inc	scenery_offset
	lda	#0
	sta	scenery_page_on
	rts
; ------------------------------------------------------------
BG_OBJ_TBL_BASE		= zp_byte_00
BG_OBJ_TBL_OFFSET	= zp_byte_07

bg_scenery_decode:
	lda	scenery_length, x
	bmi	:+ ; if (!(scenery_length & 0x80)) {
		ldy	scenery_offset+1, x
	: ; }

	ldx	#(bg_obj_spec_B-bg_obj_tbl)/WORD_SIZE

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	lda	(course_scenery_addr), y
	cmp	#COURSE_SCENERY_END
	beq	bg_scenery_rts
	and	#<COURSE_SCENERY_TYPE_MASK
	cmp	#<COURSE_SCENERY_TYPE_F
	beq	:+ ; if (course_scenery_type == 0xC) {
		ldx	#(bg_obj_spec_A-bg_obj_tbl)/WORD_SIZE
	cmp	#COURSE_SCENERY_TYPE_C
	beq	:+ ; } else if (course_scenery_type != 0xF) {
		ldx	#(bg_obj_norm-bg_obj_tbl)/WORD_SIZE
	: ; }
	stx	BG_OBJ_TBL_OFFSET
	ldx	actor_index
	cmp	#<COURSE_SCENERY_TYPE_E
	bne	:+ ; if (course_scenery_type == 0xE) {
		lda	#(bg_obj_norm-bg_obj_tbl)/WORD_SIZE
		sta	BG_OBJ_TBL_OFFSET

		lda	#(bg_obj_tbl_set_attr-bg_obj_tbl)/WORD_SIZE
		bne	bg_obj_set_base
	: cmp	#<COURSE_SCENERY_TYPE_D
	bne	:++ ; } else if (course_scenery_type == 0xD) {
		lda	#(bg_obj_spec_D-bg_obj_tbl)/WORD_SIZE
		sta	BG_OBJ_TBL_OFFSET

		iny

		.if	.defined(VS)
			lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			sta	VS_REQ
		.endif

		lda	(course_scenery_addr), y
		and	#>COURSE_SCENERY_TYPE_D_MASK
		beq	bg_scenery_decode_rts ; if (scenery.is_D_object) {
			lda	(course_scenery_addr), y
			and	#>(COURSE_SCENERY_TYPE_D_OBJ_MASK|COURSE_SCENERY_TYPE_D_MASK)
			cmp	#>(COURSE_OBJ_D_LOOP|COURSE_SCENERY_TYPE_D_MASK)
			bne	:+ ; if (scenery.type_D_type == loop) {
				inc	eng_loop_flag
			: ; }
			and	#>COURSE_SCENERY_TYPE_D_OBJ_MASK
			jmp	bg_obj_set_base
		; } else rts;
	: cmp	#<COURSE_SCENERY_TYPE_C
	bcs	:+++ ; } else if (course_scenery_type < 0xC) {
		iny

		.if	.defined(VS)
			lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			sta	VS_REQ
		.endif

		lda	(course_scenery_addr), y
		and	#>(COURSE_SCENERY_OBJ_MASK)
		bne	:+ ; if (!(course_scenery_byte_1 & COURSE_SCENERY_OBJ_MASK)) {
			lda	#(bg_obj_spec_C-bg_obj_tbl)/WORD_SIZE
			sta	BG_OBJ_TBL_OFFSET
	
			lda	(course_scenery_addr), y
			and	#%00001111
			jmp	bg_obj_set_base
		: ; } else {
			sta	BG_OBJ_TBL_BASE
			cmp	#>(COURSE_SCENERY_OBJ_MASK)
			bne	:+
	
			.if	.defined(VS)
				lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
				sta	VS_REQ
			.endif

			lda	(course_scenery_addr), y
			and	#%00001000
			beq	:+ ; if (BG_OBJ_TBL_BASE == 0x70 && (course_scenery_byte_1 & 0x08)) {
				lda	#(bg_obj_tbl_pipe_vert_a-bg_obj_tbl)/WORD_SIZE
				sta	BG_OBJ_TBL_BASE
			: ; }
		
			lda	BG_OBJ_TBL_BASE
			jmp	:++
		: ; }
	; }

	; if () {
		; if () {
			iny

			.if	.defined(VS)
				lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
				sta	VS_REQ
			.endif

			lda	(course_scenery_addr), y
			and	#>COURSE_SCENERY_OBJ_MASK
		: ; }

		lsr	a
		lsr	a
		lsr	a
		lsr	a
	: ; }

bg_obj_set_base:
	sta	BG_OBJ_TBL_BASE

	lda	scenery_length, x
	bpl	:++++
	lda	scenery_page_loc
	cmp	pos_x_hi_game
	beq	:+
	ldy	scenery_offset

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	lda	(course_scenery_addr), y
	and	#<COURSE_SCENERY_TYPE_MASK
	cmp	#<COURSE_SCENERY_TYPE_E
	bne	bg_scenery_decode_rts
	lda	eng_page_cached
	bne	:+++
bg_scenery_decode_rts:
	; if ((scenery_length & 0x80) && scenery_page_loc != pos_x_hi_game && (((course_scenery_byte_0 & 0xF) != 0xE) || !eng_page_cached)) {
		rts
	: lda	eng_page_cached
	beq	:+ ; } else if (eng_page_cached) {
		lda	#0
		sta	eng_page_cached
		sta	eng_area_bg_flag
		sta	actor_index
	bg_scenery_decode_rts2:
		rts
	: ; } else {
		ldy	scenery_offset
		.if	.defined(VS)
			lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			sta	VS_REQ
		.endif
		lda	(course_scenery_addr), y
		and	#<COURSE_SCENERY_POSX_MASK
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		cmp	pos_x_lo_game
		bne	bg_scenery_decode_rts
	: ; }
	; if () {
		lda	scenery_offset
		sta	scenery_offset+1, x
		jsr	bg_buffer_inc
	: ; }

	lda	BG_OBJ_TBL_BASE
	clc
	adc	BG_OBJ_TBL_OFFSET
	jsr	tbljmp
	.export bg_obj_tbl

	.export bg_obj_norm
	.export bg_obj_tbl_pipe_vert_a
	.export bg_obj_tbl_ledge
	.export	bg_obj_tbl_brickrow
	.export	bg_obj_tbl_floorrow
	.export	bg_obj_tbl_coinrow
	.export	bg_obj_tbl_brickcol
	.export	bg_obj_tbl_floorcol
	.export bg_obj_tbl_pipe_vert_b

	.export	bg_obj_spec_A
	.export	bg_obj_tbl_pit
	.export	bg_obj_tbl_pulley
	.export	bg_obj_tbl_bridge_hi
	.export	bg_obj_tbl_bridge_mid
	.export	bg_obj_tbl_bridge_lo
	.export	bg_obj_tbl_waterhole
	.export	bg_obj_tbl_block_qhi
	.export	bg_obj_tbl_block_qlo

	.export bg_obj_spec_B
	.export	bg_obj_tbl_rope_norm
	.export	bg_obj_tbl_rope_plat
	.export	bg_obj_tbl_castle
	.export	bg_obj_tbl_stairs
	.export	bg_obj_tbl_pipe_exit
	.export	bg_obj_tbl_pole_tip
	.if	.defined(SMB2M)
		.export	bg_obj_tbl_pipe_v_flip_a
		.export	bg_obj_tbl_pipe_v_flip_b
	.endif

	.export	bg_obj_spec_C
	.export	bg_obj_tbl_block_q_a
	.export	bg_obj_tbl_block_q_b
	.export	bg_obj_tbl_block_q_c
	.if	.defined(SMB2)
		.export bg_obj_tbl_block_q_d
		.export bg_obj_tbl_block_q_f
		.export bg_obj_tbl_block_item_e
	.endif
	.if	.defined(SMB2M)
		.export bg_obj_tbl_block_q_e
	.endif
	.export	bg_obj_tbl_hidden_one_up
	.export	bg_obj_tbl_block_item_a
	.export	bg_obj_tbl_block_item_b
	.export bg_obj_tbl_block_item_c
	.export	bg_obj_tbl_block_item_d
	.export bg_obj_tbl_block_coin
	.export bg_obj_tbl_pipe_water
	.export bg_obj_tbl_empty_draw
	.export bg_obj_tbl_spring

	.export bg_obj_spec_D
	.export	bg_obj_tbl_pipe_intro
	.export	bg_obj_tbl_pole
	.export	bg_obj_tbl_castle_bridge_axe
	.export	bg_obj_tbl_castle_bridge_draw
	.export	bg_obj_tbl_castle_bridge
	.export	bg_obj_tbl_lock_warp
	.export	bg_obj_tbl_lock_end
	.export	bg_obj_tbl_lock_start
	.export	bg_obj_tbl_swarm_a
	.export	bg_obj_tbl_swarm_b
	.export	bg_obj_tbl_swarm_c
	.export	bg_obj_tbl_decode_rts
	.if	.defined(SMB2)
		.export	bg_obj_tbl_wind_on
		.export	bg_obj_tbl_wind_off
	.endif
bg_obj_tbl:
bg_obj_norm:
bg_obj_tbl_pipe_vert_a:
	.addr	bg_scenery_pipe_vert

bg_obj_tbl_ledge:
	.addr	bg_scenery_ledge

bg_obj_tbl_brickrow:
	.addr	bg_scenery_brickrow

bg_obj_tbl_floorrow:
	.addr	bg_scenery_floorrow

bg_obj_tbl_coinrow:
	.addr	bg_scenery_coinrow

bg_obj_tbl_brickcol:
	.addr	bg_scenery_brickcol

bg_obj_tbl_floorcol:
	.addr	bg_scenery_floorcol

bg_obj_tbl_pipe_vert_b:
	.addr	bg_scenery_pipe_vert

bg_obj_spec_A:
bg_obj_tbl_pit:
	.addr	bg_scenery_pit

bg_obj_tbl_pulley:
	.addr	bg_scenery_pulley

bg_obj_tbl_bridge_hi:
	.addr	bg_scenery_bridge_hi

bg_obj_tbl_bridge_mid:
	.addr	bg_scenery_bridge_mid

bg_obj_tbl_bridge_lo:
	.addr	bg_scenery_bridge_lo

bg_obj_tbl_waterhole:
	.addr	bg_scenery_waterhole

bg_obj_tbl_block_qhi:
	.addr	bg_scenery_block_qhi

bg_obj_tbl_block_qlo:
	.addr	bg_scenery_block_qlo

bg_obj_spec_B:
bg_obj_tbl_rope_norm:
	.addr	bg_scenery_rope_norm

bg_obj_tbl_rope_plat:
	.addr	bg_scenery_rope_plat

bg_obj_tbl_castle:
	.addr	bg_scenery_castle

bg_obj_tbl_stairs:
	.addr	bg_scenery_stairs

bg_obj_tbl_pipe_exit:
	.addr	bg_scenery_pipe_exit

bg_obj_tbl_pole_tip:
	.addr	bg_scenery_pole_tip

	.if	.defined(SMB2M)
	bg_obj_tbl_pipe_v_flip_a:
		.addr	bg_scenery_pipe_v_flip_a
	bg_obj_tbl_pipe_v_flip_b:
		.addr	bg_scenery_pipe_v_flip_b
	.endif

bg_obj_spec_C:
bg_obj_tbl_block_q_a:
	.addr	bg_scenery_block_q

bg_obj_tbl_block_q_b:
	.addr	bg_scenery_block_q

bg_obj_tbl_block_q_c:
	.addr	bg_scenery_block_q

	.if	.defined(SMB2)
	bg_obj_tbl_block_q_d:
		.addr	bg_scenery_block_q
	.endif

bg_obj_tbl_hidden_one_up:
	.addr	bg_scenery_hidden_one_up

	.if	.defined(SMB2M)
	bg_obj_tbl_block_q_e:
		.addr	bg_scenery_block_q
	.endif

	.if	.defined(SMB2)
	bg_obj_tbl_block_q_f:
		.addr	bg_scenery_block_q

	bg_obj_tbl_block_item_e:
		.addr	bg_scenery_block_item
	.endif

bg_obj_tbl_block_item_a:
	.addr	bg_scenery_block_item

bg_obj_tbl_block_item_b:
	.addr	bg_scenery_block_item

bg_obj_tbl_block_item_c:
	.addr	bg_scenery_block_item

bg_obj_tbl_block_coin:
	.addr	bg_scenery_block_coin

bg_obj_tbl_block_item_d:
	.addr	bg_scenery_block_item

bg_obj_tbl_pipe_water:
	.addr	bg_scenery_pipe_water

bg_obj_tbl_empty_draw:
	.addr	bg_scenery_empty_draw

bg_obj_tbl_spring:
	.addr	bg_scenery_spring

bg_obj_spec_D:
bg_obj_tbl_pipe_intro:
	.addr	bg_scenery_pipe_intro
bg_obj_tbl_pole:
	.addr	bg_scenery_pole
bg_obj_tbl_castle_bridge_axe:
	.addr	bg_scenery_castle_bridge_axe
bg_obj_tbl_castle_bridge_draw:
	.addr	bg_scenery_castle_bridge_draw
bg_obj_tbl_castle_bridge:
	.addr	bg_scenery_castle_bridge
bg_obj_tbl_lock_warp:
	.addr	bg_scenery_lock_warp
bg_obj_tbl_lock_end:
	.addr	bg_scenery_lock
bg_obj_tbl_lock_start:
	.addr	bg_scenery_lock
bg_obj_tbl_swarm_a:
	.addr	bg_scenery_swarm
bg_obj_tbl_swarm_b:
	.addr	bg_scenery_swarm
bg_obj_tbl_swarm_c:
	.addr	bg_scenery_swarm
bg_obj_tbl_decode_rts:
	.addr	bg_scenery_decode_rts2

	.if	.defined(SMB2)
	bg_obj_tbl_wind_on:
		.addr	bg_scenery_wind_on
	bg_obj_tbl_wind_off:
		.addr	bg_scenery_wind_off
	.endif

bg_obj_tbl_set_attr:
	.addr	bg_scenery_set_attr
; ------------------------------------------------------------
bg_scenery_set_attr:
	ldy	scenery_offset+1, x
	iny
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif
	lda	(course_scenery_addr), y
	pha
	and	#%01000000
	bne	:+ ; if ((course_scenery_byte_1 & 0x40)) {
		pla
		pha
		and	#%00001111
		sta	course_fg_mask_id
		pla
		and	#%00110000
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		sta	course_bg_id
		rts
	: ; } else {
		pla
		and	#%00000111
		cmp	#4
		bcc	:+ ; if ((eng_area_data_byte_1 & 0x7) >= 4) {
			sta	course_bg_col
			lda	#COURSE_SCENERY_FG_NONE_VAL
		: ; }
		sta	course_fg_id
		rts
	; }
; -----------------------------
bg_scenery_lock_warp:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldx	#4
	.elseif	.defined(SMB2M)
		ldx	#$80
		lda	ENG_HARDMODE_VAR
		bne	bg_scenery_lock_warp_hard_mode
	.endif

	.if	.defined(SMBM)|.defined(VS_SMB)
		lda	course_no
		beq	:++ ; if (course_no > no_01) {
			inx

			ldy	course_type
			dey
			bne	:++ ; if (course_type == overworld) {

			.if	.defined(ANN)
				jmp	:+

			bg_scenery_lock_warp_hard_mode:
				ldx	#$84
				lda	course_no
				bne	:+ ; if (course_no == no_01) {
					dex
					ldy	player_goals
					dey
					beq	:++
				; }
			.endif

			:
				inx
			; }
		: ; }
		txa
	.elseif	.defined(SMB2)
		lda	course_no
		bne	:+++ ; if (!hard_mode && course_no == no_01) {
			ldy	course_type
			dey
			beq	:+
			lda	course_page_offset
			beq	:++ ; if (course_type == overworld || course_page_offset) {
				; if (course_type != overworld) {
					inx
				: ; }

				inx
			: ; }
			jmp	bg_scenery_lock_warp_load
		bg_scenery_lock_warp_hard_mode: ; } else if (hard_mode) {
			lda	#$87
			clc
			adc	player_goals
			bne	bg_scenery_lock_warp_do
		: ; } else {
			ldx	#$83
			lda	course_no
			cmp	#course::no_03
			beq	bg_scenery_lock_warp_load ; if (course != no_03) {
				inx
				cmp	#course::no_05
				bne	:+
				lda	course_page_offset
				cmp	#$0B
				beq	bg_scenery_lock_warp_load
				ldy	course_type
				dey
				beq	:++
				jmp	:+++
			: ; } if (course.not_in(no_03, no_05)) {
					inx
			: ; } if (course.not_in(no_03, no_05) || (course == no_05 && course_page_offset != 0x0B && course_type == overworld)) {
					inx
			: ; } if (course.not_in(no_03, no_05) || (course == no_05 && course_page_offset != 0x0B)) {
					inx
			; }
		; }

		bg_scenery_lock_warp_load: ; if (!hard_mode) {
			txa
		bg_scenery_lock_warp_do: ; }
	.endif
	sta	eng_warp_ctrl

	.if	.defined(SMB)|.defined(VS_SMB)
		jsr	screen_text_draw
	.elseif	.defined(SMB2M)
		jsr	screen_text_draw_over
	.endif

	lda	#actor::piranha_plant
	jsr	bg_actor_kill

bg_scenery_lock:
	lda	game_scroll_lock
	eor	#1
	sta	game_scroll_lock
	rts
; -----------------------------
bg_actor_kill_id	= zp_byte_00

	.export bg_actor_kill
bg_actor_kill:
	sta	bg_actor_kill_id
	lda	#actor_modes::free
	ldx	#ENG_ACTOR_MAX-2
	: ; for (entry of actor_id) {
		ldy	actor_id, x
		cpy	bg_actor_kill_id
		bne	:+ ; if (actor_id == bg_actor_kill_id) {
			sta	actor_mode, x
		: ; }
	
		dex
		bpl	:--
	; }

	rts
; -----------------------------
bg_swarm_ids:
	.byte	actor::cheep_fly
	.byte	actor::bullet_cheep_swarm
	.byte	actor::swarm_stop

bg_scenery_swarm:
	ldx	BG_OBJ_TBL_BASE
	lda	bg_swarm_ids-((bg_obj_tbl_swarm_a-bg_obj_spec_D)/WORD_SIZE), x
	ldy	#ENG_ACTOR_MAX-1
	: ; for (actor of applicable_actors) {
		dey
		bmi	:+

		cmp	actor_id, y
		bne	:-
	; }
	; if (actor_found) {
		lda	#0
	: ; }
	sta	eng_swarm_queue
	rts
; -----------------------------
	.export bg_scenery_ledge_tbl
	.export bg_scenery_ledge_tbl_tree
	.export bg_scenery_ledge_tbl_mushroom
	.export bg_scenery_ledge_tbl_cannon
bg_scenery_ledge:
	lda	course_ledge_type
	jsr	tbljmp

bg_scenery_ledge_tbl:
bg_scenery_ledge_tbl_tree:
	.addr	bg_scenery_ledge_tree

bg_scenery_ledge_tbl_mushroom:
	.addr	bg_scenery_ledge_mushroom

bg_scenery_ledge_tbl_cannon:
	.addr	bg_scenery_cannon
; --------------
bg_scenery_ledge_tree:
	jsr	bg_scenery_attr
	lda	scenery_length, x
	beq	:++	
	bpl	:+ ; if (scenery_length) {
		; if (scenery_length_bit_7) {
			tya
			sta	scenery_length, x
			lda	pos_x_hi_game
			ora	pos_x_lo_game
			beq	:+ ; if (game.pos_x > 0) {
				lda	#metatile_0::plat_b_a
				jmp	bg_scenery_ledge_no_base
			; }
		: ; }

		ldx	BG_PROC_METATILE_ID
		lda	#metatile_0::plat_b_b
		sta	gfx_metatile, x
		lda	#metatile_1::plat_b
		jmp	bg_scenery_ledge_base
	: ; } else {
		lda	#metatile_0::plat_b_c
		jmp	bg_scenery_ledge_no_base
	; }
; --------------
bg_scenery_ledge_mushroom:
	jsr	bg_scenery_len
	sty	zp_byte_06
	bcc	:+ ; if (bg_scenery_len()) {
		lda	scenery_length, x
		lsr	a
		sta	eng_ledge_dims, x
		lda	#METATILE_PLAT_A_A
		jmp	bg_scenery_ledge_no_base
	: ; } else {
		lda	#METATILE_PLAT_A_C
		ldy	scenery_length, x
		beq	bg_scenery_ledge_no_base ; if (scenery_length) {
			lda	eng_ledge_dims, x
			sta	zp_byte_06
			ldx	BG_PROC_METATILE_ID
			lda	#METATILE_PLAT_A_B
			sta	gfx_metatile, x
			.if	.defined(SMBM)|.defined(VS_SMB)
				cpy	zp_byte_06
				bne	bg_scenery_pulley_rts ; if (scenery_length == tbl_736_obj) {
					inx
					lda	#metatile_1::tree_a
					sta	gfx_metatile, x
					lda	#metatile_1::tree_b
			.elseif	.defined(SMB2)
				rts
			.endif

			bg_scenery_ledge_base:
				inx
				ldy	#15
				jmp	bg_scenery_render
			; } else rts;
		; }
	; }

bg_scenery_ledge_no_base:
	ldx	BG_PROC_METATILE_ID
	ldy	#0
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_pulley_tiles:
	.byte	metatile_1::pulley_c
	.byte	metatile_1::pulley_b
	.byte	metatile_1::pulley_d
; --------------
bg_scenery_pulley:
	jsr	bg_scenery_len
	ldy	#0
	bcs	:+ ; if (!bg_scenery_len()) {
		iny

		lda	scenery_length, x
		bne	:+ ; if (!scenery_length) {
			iny
		; }
	: ; }
	lda	bg_scenery_pulley_tiles, y
	sta	gfx_metatile

bg_scenery_pulley_rts:
	rts
; -----------------------------
CASTLE_ROW_SIZE		= 5

bg_scenery_castle_tiles:
	.byte	metatile_0::blank_a
	.byte	metatile_1::castle_a
	.byte	metatile_1::castle_a
	.byte	metatile_1::castle_a
	.byte	metatile_0::blank_a

	.byte	metatile_0::blank_a
	.byte	metatile_1::castle_d
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_b
	.byte	metatile_0::blank_a

	.byte	metatile_1::castle_a
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_a

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e
	.byte	metatile_1::castle_e

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_c

	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_f

	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
	.byte	metatile_1::castle_c
	.byte	metatile_1::castle_g
bg_scenery_castle_tiles_end:
; --------------
bg_scenery_castle:
	jsr	bg_scenery_attr
	sty	zp_byte_07
	ldy	#4
	jsr	bg_scenery_len_b
	txa
	pha

	ldy	scenery_length, x
	ldx	zp_byte_07
	lda	#((bg_scenery_castle_tiles_end-bg_scenery_castle_tiles)/CASTLE_ROW_SIZE)
	sta	zp_byte_06
	: ; for (x = zp_byte_07, i = 0x0B; x < 0x0B; x++, i--, y += 5) {
		lda	bg_scenery_castle_tiles, y
		sta	gfx_metatile, x

		inx
		lda	zp_byte_06
		beq	:+ ; if (zp_byte_06) {
			iny
			iny
			iny
			iny
			iny
			dec	zp_byte_06
		: ; }
		cpx	#((bg_scenery_castle_tiles_end-bg_scenery_castle_tiles)/CASTLE_ROW_SIZE)
		bne	:--
	; }

	pla
	tax
	lda	pos_x_hi_game
	beq	:+++ ; if (pos_x_hi_game > 0) {
		lda	scenery_length, x
		cmp	#1
		beq	:++
		ldy	BG_PROC_METATILE_ID
		bne	:+
		cmp	#3
		beq	:++
		: cmp	#2
		bne	:++ ; if (scenery_length == 2) {
			jsr	bg_objpos_x_get
			pha

			jsr	bg_obj_alloc

			pla
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_game
			sta	pos_x_hi_actor, x
			lda	#actor_modes::active
			sta	pos_y_hi_actor, x
			sta	actor_mode, x
			lda	#144
			sta	pos_y_lo_actor, x
			lda	#actor::flag_victory
			sta	actor_id, x
			rts
		: ; } else if (scenery_length == 1 || (tile_id && scenery_length != 2) || scenery_length == 3) {
			ldy	#metatile_1::brick_b
			sty	gfx_metatile+10
		; }
	: ; }

	rts
; -----------------------------
bg_scenery_pipe_water:
	jsr	bg_scenery_attr
	ldy	scenery_length, x
	ldx	BG_PROC_METATILE_ID
	lda	#metatile_1::pipe_water_a
	sta	gfx_metatile+0, x
	lda	#metatile_1::pipe_water_b
	sta	gfx_metatile+1, x
	rts
; -----------------------------
BG_SCENERY_PIPE_SIZE	= 7

bg_scenery_pipe_horiz_len	= zp_byte_05

bg_scenery_pipe_intro:
	ldy	#3
	jsr	bg_scenery_len_b
	ldy	#10
	jsr	bg_scenery_pipe_horiz
	bcs	:++ ; if (!bg_scenery_pipe_horiz()) {
		ldx	#BG_SCENERY_PIPE_SIZE-1
		: ; for (tile of bg_scenery_pipe) {
			lda	#metatile_0::blank_a
			sta	gfx_metatile, x

			dex
			bpl	:-
		; }

		lda	bg_scenery_pipe_v_tiles, y
		sta	gfx_metatile+BG_SCENERY_PIPE_SIZE
	: ; }

	rts
; --------------
bg_scenery_pipe_horiz_m:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_v_e
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
bg_scenery_pipe_horiz_t:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_h_c
	.byte	metatile_0::pipe_h_b
	.byte	metatile_0::pipe_h_a
bg_scenery_pipe_horiz_b:
	.byte	metatile_0::pipe_v_f
	.byte	metatile_0::pipe_h_f
	.byte	metatile_0::pipe_h_e
	.byte	metatile_0::pipe_h_d
; --------------
bg_scenery_pipe_exit:
	ldy	#3
	jsr	bg_scenery_len_b
	jsr	bg_scenery_attr

bg_scenery_pipe_horiz:
	dey
	dey
	sty	bg_scenery_pipe_horiz_len
	ldy	scenery_length, x
	sty	zp_byte_06
	ldx	bg_scenery_pipe_horiz_len
	inx
	lda	bg_scenery_pipe_horiz_m, y
	cmp	#0
	beq	:+ ; if (bg_reaobj_pipe_horiz_m[scenery_length]) {
		ldx	#0
		ldy	bg_scenery_pipe_horiz_len
		jsr	bg_scenery_render
		clc
	: ; }

	ldy	zp_byte_06
	lda	bg_scenery_pipe_horiz_t, y
	sta	gfx_metatile, x
	lda	bg_scenery_pipe_horiz_b, y
	sta	gfx_metatile+1, x
	rts
; --------------
	.export	bg_scenery_pipe_v_tiles
bg_scenery_pipe_v_tiles:
	.byte	metatile_0::pipe_v_b, metatile_0::pipe_v_a
	.byte	metatile_0::pipe_v_f, metatile_0::pipe_v_e
	.byte	metatile_0::pipe_v_d, metatile_0::pipe_v_c
	.byte	metatile_0::pipe_v_f, metatile_0::pipe_v_e
; --------------
bg_scenery_pipe_vert:
	jsr	bg_scenery_pipe_h
	lda	zp_byte_00
	beq	:+ ; if (zp_byte_00) {
		iny
		iny
		iny
		iny
	: ; }
	tya
	pha

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	course_sub
		ora	course_no
		beq	:+
	.endif

	ldy	scenery_length, x
	beq	:+
	jsr	bg_obj_alloc
	bcs	:+ ; if ((course_sub|course_no) && scenery_length && !bg_obj_alloc()) {
		.if	.defined(SMB)|.defined(VS_SMB)
			jsr	bg_objpos_x_get
			clc
			adc	#8
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_game
			adc	#0
			sta	pos_x_hi_actor, x
			lda	#actor_modes::active
			sta	pos_y_hi_actor, x
			sta	actor_mode, x
			jsr	bg_objpos_y_get
			sta	pos_y_lo_actor, x
		.elseif	.defined(ANN)
			lda	course_no
			ora	course_sub
			ora	ENG_HARDMODE_VAR
			beq	:+
		.endif

		lda	#actor::piranha_plant

		.if	.defined(SMB)|.defined(VS_SMB)
			sta	actor_id, x
			jsr	actor_init_piranha_plant
		.elseif	.defined(SMB2M)
			jsr	bg_scenery_pipe_vert_plant
		.endif
	: ; }

	pla
	tay
	ldx	BG_PROC_METATILE_ID
	lda	bg_scenery_pipe_v_tiles, y
	sta	gfx_metatile, x
	inx
	lda	bg_scenery_pipe_v_tiles+2, y
	ldy	zp_byte_06
	dey
	jmp	bg_scenery_render
; --------------
	.export	bg_scenery_pipe_h
bg_scenery_pipe_h:
	ldy	#1
	jsr	bg_scenery_len_b
	jsr	bg_scenery_attr
	tya
	and	#%00000111
	sta	zp_byte_06
	ldy	scenery_length, x
	rts
; -------------
.if	.defined(SMB2M)
	.export	bg_scenery_pipe_vert_plant
bg_scenery_pipe_vert_plant:
	sta	actor_id, x
	jsr	bg_objpos_x_get
	clc
	adc	#8
	sta	pos_x_lo_actor, x
	lda	pos_x_hi_game
	adc	#0
	sta	pos_x_hi_actor, x
	lda	#actor_modes::active
	sta	pos_y_hi_actor, x
	sta	actor_mode, x
	jsr	bg_objpos_y_get
	sta	pos_y_lo_actor, x
	jmp	actor_init_piranha_plant
.endif
; -----------------------------
	.export	bg_obj_alloc
bg_obj_alloc:
	ldx	#0
	: ; for (x = 0; actor_mode[x] != dead && x < (ENG_ACTOR_MAX-1); x++) {
		clc
		lda	actor_mode, x
		beq	:+
		inx
		cpx	#ENG_ACTOR_MAX-1
		bne	:-
	: ; }

	rts
; -----------------------------
bg_scenery_waterhole:
	jsr	bg_scenery_len
	lda	#metatile_2::water_a
	sta	gfx_metatile+10
	ldx	#11
	ldy	#1
	lda	#metatile_2::water_b
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_block_qhi:
	lda	#3
.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	bg_scenery_block_q_row
.endif

bg_scenery_block_qlo:
	lda	#7

bg_scenery_block_q_row:
	pha

	jsr	bg_scenery_len

	pla
	tax
	lda	#metatile_3::block_q_set
	sta	gfx_metatile, x
	rts
; -----------------------------
bg_scenery_bridge_hi:
	lda	#6
.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	bg_scenery_bridge
.endif

bg_scenery_bridge_mid:
	lda	#7
.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	bg_scenery_bridge
.endif

bg_scenery_bridge_lo:
	lda	#9

bg_scenery_bridge:
	pha

	jsr	bg_scenery_len

	pla
	tax
	lda	#metatile_0::bridge_rope
	sta	gfx_metatile, x
	inx
	ldy	#0
	lda	#metatile_1::bridge_base
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_pole_tip:
	jsr	bg_scenery_attr
	ldx	#2
	lda	#metatile_1::flag_ball
	jmp	bg_scenery_render
; --------------
bg_scenery_pole:
	lda	#metatile_0::flag_ball
	sta	gfx_metatile
	ldx	#1
	ldy	#8
	lda	#metatile_0::pole
	jsr	bg_scenery_render
	lda	#metatile_1::stair
	sta	gfx_metatile+10
	jsr	bg_objpos_x_get
	sec
	sbc	#8
	sta	pos_x_lo_actor+ENG_ACTOR_MAX-1
	lda	pos_x_hi_game
	sbc	#0
	sta	pos_x_hi_actor+ENG_ACTOR_MAX-1
	lda	#48
	sta	pos_y_lo_actor+ENG_ACTOR_MAX-1
	lda	#176
	sta	render_flag_score_pos_y
	lda	#actor::flag_enemy
	sta	actor_id+ENG_ACTOR_MAX-1
	inc	actor_mode+ENG_ACTOR_MAX-1
	rts
; -----------------------------
bg_scenery_rope_norm:
	ldx	#0
	ldy	#$0F
	jmp	bg_scenery_rope_draw

bg_scenery_rope_plat:
	txa
	pha

	ldx	#1
	ldy	#$0F
	lda	#metatile_1::pulley_e
	jsr	bg_scenery_render

	pla
	tax
	jsr	bg_scenery_attr
	ldx	#1

bg_scenery_rope_draw:
	lda	#metatile_1::pulley_a
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_coinrow_tiles:
	.byte	metatile_3::coin_b
	.byte	metatile_3::coin_a
	.byte	metatile_3::coin_a
	.byte	metatile_3::coin_a
; --------------
bg_scenery_coinrow:
	ldy	course_type
	lda	bg_scenery_coinrow_tiles, y
	jmp	bg_scenery_get_row
; -----------------------------
bg_scenery_castle_bridge_data:
	.byte	$06, $07, $08
bg_scenery_castle_bridge_tiles:
	.byte	metatile_3::axe
	.byte	metatile_0::chain
	.byte	metatile_2::bridge_castle
; --------------
bg_scenery_castle_bridge:
	ldy	#$0C
	jsr	bg_scenery_len_b
	jmp	bg_scenery_castle_bridge_draw

bg_scenery_castle_bridge_axe:
	lda	#nmi_addr::pal_bowser
	sta	nmi_addrs_ctl

bg_scenery_castle_bridge_draw:
	ldy	zp_byte_00
	ldx	bg_scenery_castle_bridge_data-2, y
	lda	bg_scenery_castle_bridge_tiles-2, y
	jmp	bg_scenery_castle_bridge_draw_do

bg_scenery_empty_draw:
	jsr	bg_scenery_attr
	ldx	BG_PROC_METATILE_ID
	lda	#metatile_3::block_invis

bg_scenery_castle_bridge_draw_do:
	ldy	#0
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_floor_tiles:
	.byte	metatile_1::floor_underwater
	.byte	metatile_1::stair
	.byte	metatile_1::stair
	.byte	metatile_1::floor_castle
bg_scenery_brick_tiles:
	.byte	metatile_0::coral
	.byte	metatile_1::brick_a
	.byte	metatile_1::brick_b
	.byte	metatile_1::brick_b
	.byte	metatile_2::cloud_small
; --------------
bg_scenery_brickrow:
	ldy	course_type
	lda	course_type_cloud
	beq	:+ ; if (course_type == cloud) {
		ldy	#course_types::cloud
	: ; }
	lda	bg_scenery_brick_tiles, y
	jmp	bg_scenery_get_row

bg_scenery_floorrow:
	ldy	course_type
	lda	bg_scenery_floor_tiles, y
bg_scenery_get_row:
	pha

	jsr	bg_scenery_len
bg_scenery_draw_row:
	ldx	BG_PROC_METATILE_ID
	ldy	#0

	pla
	jmp	bg_scenery_render

bg_scenery_brickcol:
	ldy	course_type
	lda	bg_scenery_brick_tiles, y
	jmp	bg_scenery_get_col

bg_scenery_floorcol:
	ldy	course_type
	lda	bg_scenery_floor_tiles, y
bg_scenery_get_col:
	pha

	jsr	bg_scenery_attr

	pla
	ldx	BG_PROC_METATILE_ID
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_cannon:
	jsr	bg_scenery_attr
	ldx	BG_PROC_METATILE_ID

	lda	#metatile_1::cannon_a
	sta	gfx_metatile, x
	inx
	dey
	bmi	:+ ; if (--y >= 0) {
		lda	#metatile_1::cannon_b
		sta	gfx_metatile, x
		inx
		dey
		bmi	:+ ; if (--y >= 0) {
			lda	#metatile_1::cannon_c
			jsr	bg_scenery_render
		; }
	: ; }

	ldx	eng_cannon_offset
	jsr	bg_objpos_y_get
	sta	pos_y_lo_cannon, x
	lda	pos_x_hi_game
	sta	pos_y_hi_cannon, x
	jsr	bg_objpos_x_get
	sta	pos_x_lo_cannon, x
	inx
	cpx	#6
	bcc	:+ ; if (x >= 6) {
		ldx	#0
	: ; }
	stx	eng_cannon_offset
	rts
; -----------------------------
bg_scenery_stairs_height:
	.byte	7, 7, 6, 5, 4, 3, 2, 1, 0
bg_scenery_stairs_row:
	.byte	3, 3, 4, 5, 6, 7, 8, 9, 10
; --------------
bg_scenery_stairs:
	jsr	bg_scenery_len
	bcc	:+ ; if (bg_scenery_len()) {
		lda	#9
		sta	eng_step_no
	: ; }

	dec	eng_step_no
	ldy	eng_step_no
	ldx	bg_scenery_stairs_row, y
	lda	bg_scenery_stairs_height, y
	tay
	lda	#metatile_1::stair
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_spring:
	jsr	bg_scenery_attr
	jsr	bg_obj_alloc
		.if	.defined(VS_SMB)|.defined(SMB2M)|.defined(PAL)
		bcs	:+ ; if () {
		.endif
		jsr	bg_objpos_x_get
		sta	pos_x_lo_actor, x
		lda	pos_x_hi_game
		sta	pos_x_hi_actor, x
		jsr	bg_objpos_y_get
		sta	pos_y_lo_actor, x
		sta	veloc_x_actor, x
		lda	#actor::spring
		sta	actor_id, x
		ldy	#1
		sty	pos_y_hi_actor, x
		inc	actor_mode, x
		ldx	BG_PROC_METATILE_ID
		lda	#metatile_1::spring_bg_a
		sta	gfx_metatile, x
		lda	#metatile_1::spring_bg_b
		sta	gfx_metatile+1, x
		.if	.defined(VS_SMB)|.defined(SMB2M)|.defined(PAL)
		: ; }
		.endif
	rts
; -----------------------------
bg_scenery_hidden_one_up:
	lda	bg_hidden_one_up_req
	beq	bg_scenery_block_rts
	lda	#0
	sta	bg_hidden_one_up_req
	jmp	bg_scenery_block_item

bg_scenery_block_q:
	jsr	bg_scenery_block_id
	jmp	bg_scenery_block_draw

bg_scenery_block_coin:
	lda	#0
	sta	eng_block_time

bg_scenery_block_item:
	jsr	bg_scenery_block_id
	sty	zp_byte_07
	lda	#0
	ldy	course_type
	dey
	beq	:+ ; if (course_type == overworld) {
		lda	#BLOCK_TILE_OFFSET
	: ; }
	clc
	adc	zp_byte_07
	tay

bg_scenery_block_draw:
	lda	block_tiles, y
	pha
	jsr	bg_scenery_attr
	jmp	bg_scenery_draw_row
; --------------
bg_scenery_block_id:
	lda	zp_byte_00
	sec
	sbc	#0
	tay

bg_scenery_block_rts:
	rts
; -----------------------------
bg_scenery_pit_tiles:
	.byte	metatile_2::water_b
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
; --------------
bg_scenery_pit:
	jsr	bg_scenery_len
	bcc	:++
	lda	course_type
	bne	:++ ; if (bg_scenery_len() && course_type == water) {
		ldx	eng_cannon_offset
		jsr	bg_objpos_x_get
		sec
		sbc	#16
		sta	pos_x_lo_cannon, x
		lda	pos_x_hi_game
		sbc	#0
		sta	pos_y_hi_cannon, x
		iny
		iny
		tya
		asl	a
		asl	a
		asl	a
		asl	a
		sta	pos_y_lo_cannon, x
		inx
		cpx	#5
		bcc	:+ ; if (x >= 5) {
			ldx	#0
		: ; }
		stx	eng_cannon_offset
	: ; }

	ldx	course_type
	lda	bg_scenery_pit_tiles, x
	ldx	#8
	ldy	#$0F
; -----------------------------
	.export	bg_scenery_render
bg_scenery_render:
	: ; for (x = metatile_base_id, y = eng_obj_height; x >= 0xD && y >= 0; x++, y--) {
		sty	eng_obj_height
		ldy	gfx_metatile, x
		beq	:+
		cpy	#metatile_0::plat_b_b
		beq	:++
		cpy	#METATILE_PLAT_A_B
		beq	:++
		cpy	#TILE_PAGE_3
		beq	:+
		cpy	#TILE_PAGE_3
		bcs	:++
		.if	.defined(SMBM)|.defined(VS_SMB)
			cpy	#metatile_1::floor_normal
			bne	:+
			cmp	#$50
			beq	:++
		.endif
		: ; if (metatile == blank_a || (metatile.not_in(plat_b_b, plat_a_b) && (metatile == 0xC0 || (metatile < 0xC0 && (metatile != floor_normal || a != 0x50))))) {
			sta	gfx_metatile, x
		: ; }

		inx
		cpx	#$0D
		bcs	:+
		ldy	eng_obj_height
		dey
		bpl	:---
	: ; }

	rts
; -----------------------------
bg_scenery_len:
	jsr	bg_scenery_attr

bg_scenery_len_b:
	lda	scenery_length, x
	clc
	bpl	:+ ; if () {
		tya
		sta	scenery_length, x
		sec
	: ; }

	rts
; -----------------------------
bg_scenery_attr:
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif
	ldy	scenery_offset+1, x
	lda	(course_scenery_addr), y
	and	#%00001111
	sta	BG_PROC_METATILE_ID
	iny
	lda	(course_scenery_addr), y
	and	#%00001111
	tay
	rts
; -----------------------------
bg_objpos_x_get:
	lda	pos_x_lo_game
	asl	a
	asl	a
	asl	a
	asl	a
	rts
; -----------------------------
bg_objpos_y_get:
	lda	zp_byte_07
	asl	a
	asl	a
	asl	a
	asl	a
	clc
	adc	#(2<<4)
	rts
; -----------------------------
	.export bg_buffer_ptr_lo, bg_buffer_ptr_hi
bg_buffer_ptr_lo:
	.byte	<bg_buffer_0, <bg_buffer_1

bg_buffer_ptr_hi:
	.byte	>bg_buffer_0, >bg_buffer_1
; --------------
	.export bg_get_buffer_ptr
bg_get_buffer_ptr:
	pha
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	tay
	lda	bg_buffer_ptr_hi, y
	sta	eng_buffer_ptr+1
	pla
	and	#%00001111
	clc
	adc	bg_buffer_ptr_lo, y
	sta	eng_buffer_ptr
	rts
; -----------------------------
.if	.defined(FC_SMB)
	.ifndef	PAL
		.res	2, $FF
	.endif
.elseif	.defined(VS_SMB)
	.res	55, $FF
.endif
