.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

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
bg_proc_inc_col_a:		.addr	bg_inc_col
bg_proc_gfx_render_area_a:	.addr	gfx_render_area
bg_proc_gfx_render_area_b:	.addr	gfx_render_area
bg_proc_main_a:			.addr	bg_proc_main
bg_proc_inc_col_b:		.addr	bg_inc_col
bg_proc_gfx_render_area_c:	.addr	gfx_render_area
bg_proc_gfx_render_area_d:	.addr	gfx_render_area
bg_proc_main_b:			.addr	bg_proc_main
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
bg_scenery_static_tbl_cloud:		.byte	bg_scenery_static_cloud-bg_scenery_static
bg_scenery_static_tbl_mnt_bush:		.byte	bg_scenery_static_mnt_bush-bg_scenery_static
bg_scenery_static_tbl_tree_fence:	.byte	bg_scenery_static_tree_fence-bg_scenery_static

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
fg_scenery_tbl_water:	.byte	fg_scenery_water-fg_scenery
fg_scenery_tbl_walls:	.byte	fg_scenery_walls-fg_scenery
fg_scenery_tbl_surface:	.byte	fg_scenery_surface-fg_scenery

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

	.export	bg_floor_masks
	.export floor_mask_0, floor_mask_1
	.export floor_mask_2, floor_mask_3
	.export floor_mask_4, floor_mask_5
	.export floor_mask_6, floor_mask_7
	.export floor_mask_8, floor_mask_9
	.export floor_mask_10, floor_mask_11
	.export floor_mask_12, floor_mask_13
	.export floor_mask_14, floor_mask_15
bg_floor_masks:
floor_mask_0:	.byte	%00000000, %00000000
floor_mask_1:	.byte	%00000000, %00011000
floor_mask_2:	.byte	%00000001, %00011000
floor_mask_3:	.byte	%00000111, %00011000
floor_mask_4:	.byte	%00001111, %00011000
floor_mask_5:	.byte	%11111111, %00011000
floor_mask_6:	.byte	%00000001, %00011111
floor_mask_7:	.byte	%00000111, %00011111
floor_mask_8:	.byte	%00001111, %00011111
floor_mask_9:	.byte	%10000001, %00011111
floor_mask_10:	.byte	%00000001, %00000000
floor_mask_11:	.byte	%10001111, %00011111
floor_mask_12:	.byte	%11110001, %00011111
floor_mask_13:	.byte	%11111001, %00011000
floor_mask_14:	.byte	%11110001, %00011000
floor_mask_15:	.byte	%11111111, %00011111
; ------------------------------------------------------------
bg_proc_main_tile_idx	= zp_byte_00
bg_proc_main_floor_mask	= zp_byte_00
bg_proc_main_fg_next	= zp_byte_01
bg_proc_main_buffer_ptr_idx = zp_byte_00

bg_proc_main:
	lda	course_page_loaded
	beq	:+ ; if (course.page_loaded) {
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
	sta	bg_proc_metatile_id

	ldx	#0
	lda	course_floor_mask_id
	asl	a
	tay
	: ; for (x = 0, y = 2*course.floor_mask_id; x < 0xD && y < 0x100; x += 8, y++) {
		lda	bg_floor_masks, y
		sta	bg_proc_main_floor_mask
		iny
		sty	bg_proc_main_fg_next
		lda	course_type_cloud
		beq	:+	
		cpx	#0
		beq	:+ ; if (course.type == cloud && x != 0) {
			lda	bg_proc_main_floor_mask
			and	#%00001000
			sta	bg_proc_main_floor_mask
		: ; }
	
		ldy	#0
		: ; for (y = 0; x < 0xD && y < 8; x++, y++) {
			lda	actor_init_bullet_cheep_data_a, y
			bit	bg_proc_main_floor_mask
			beq	:+ ; if ((actor_init_bullet_cheep_data_a[y] & floor_mask)) {
				lda	bg_proc_metatile_id
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
				sta	bg_proc_metatile_id
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
		sta	(game_buffer), y
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

	bg_scenery_outer_loop: ; while (course.page_calc || course.page_loaded) {
		ldx	#SCENERY_ACTIVE_MAX-1
		bg_scenery_loop: ; for (item of scenery) {
			stx	actor_index
			lda	#0
			sta	course_page_calc
			ldy	scenery_offset_base

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
				lda	course_page_loaded
				bne	:++
				: lda	scenery_page_loc
				cmp	pos_x_hi_game
				bcc	:++
			; }
			: ; if (
			;	this == COURSE_SCENERY_END
			;	|| this.length >= 0
			;	|| (this.type == E && course.page_loaded)
			;	|| this.page_loc >= pos_x_hi_game) {
				jsr	bg_scenery_decode
				jmp	:+++
			: ; } else if (scenery_page_loc < pos_x_hi_game) {
				inc	course_page_calc
			: ; }
			; if (needs_increment) {
				jsr	bg_buffer_inc
			: ; }
		
			ldx	actor_index
			lda	scenery_length, x
			bmi	:+ ; if (this.length >= 0) {
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

		lda	course_page_calc
		.if	.defined(CONS)
			bne	bg_scenery_outer_loop
		.elseif	.defined(VS)
			beq	:+
				jmp	bg_scenery_outer_loop
			:
		.endif

		lda	course_page_loaded
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
	inc	scenery_offset_base
	inc	scenery_offset_base
	lda	#0
	sta	scenery_page_on
	rts
; ------------------------------------------------------------
bg_obj_tbl_base		= zp_byte_00
BG_OBJ_TBL_OFFSET	= zp_byte_07

bg_scenery_decode:
	lda	scenery_length, x
	bmi	:+ ; if (!(scenery_length & 0x80)) {
		ldy	scenery_offset, x
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
				inc	course_loop_flag
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
			and	#COURSE_OBJ_C_MASK>>8
			jmp	bg_obj_set_base
		: ; } else {
			sta	bg_obj_tbl_base
			cmp	#>(COURSE_SCENERY_OBJ_MASK)
			bne	:+
	
			.if	.defined(VS)
				lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
				sta	VS_REQ
			.endif

			lda	(course_scenery_addr), y
			and	#%00001000
			beq	:+ ; if (bg_obj_tbl_base == 0x70 && (course_scenery_byte_1 & 0x08)) {
				lda	#(bg_obj_tbl_pipe_vert_a-bg_obj_tbl)/WORD_SIZE
				sta	bg_obj_tbl_base
			: ; }
		
			lda	bg_obj_tbl_base
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
	sta	bg_obj_tbl_base

	lda	scenery_length, x
	bpl	:++++
	lda	scenery_page_loc
	cmp	pos_x_hi_game
	beq	:+
	ldy	scenery_offset_base

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	lda	(course_scenery_addr), y
	and	#<COURSE_SCENERY_TYPE_MASK
	cmp	#<COURSE_SCENERY_TYPE_E
	bne	bg_scenery_decode_rts
	lda	course_page_loaded
	bne	:+++
bg_scenery_decode_rts:
	; if ((scenery_length & 0x80) && scenery_page_loc != pos_x_hi_game && (((course_scenery_byte_0 & 0xF) != 0xE) || !course.page_loaded)) {
		rts
	: lda	course_page_loaded
	beq	:+ ; } else if (course.page_loaded) {
		lda	#0
		sta	course_page_loaded
		sta	course_page_calc
		sta	actor_index
	bg_scenery_decode_rts2:
		rts
	: ; } else {
		ldy	scenery_offset_base
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
		lda	scenery_offset_base
		sta	scenery_offset, x
		jsr	bg_buffer_inc
	: ; }

	lda	bg_obj_tbl_base
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
	.if	.defined(SMBV2)
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
	.if	.defined(SMBV2)
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
bg_obj_tbl_pipe_vert_a:	.addr	bg_scenery_pipe_vert
bg_obj_tbl_ledge:	.addr	bg_scenery_ledge
bg_obj_tbl_brickrow:	.addr	bg_scenery_brickrow
bg_obj_tbl_floorrow:	.addr	bg_scenery_floorrow
bg_obj_tbl_coinrow:	.addr	bg_scenery_coinrow
bg_obj_tbl_brickcol:	.addr	bg_scenery_brickcol
bg_obj_tbl_floorcol:	.addr	bg_scenery_floorcol
bg_obj_tbl_pipe_vert_b:	.addr	bg_scenery_pipe_vert

bg_obj_spec_A:
bg_obj_tbl_pit:		.addr	bg_scenery_pit
bg_obj_tbl_pulley:	.addr	bg_scenery_pulley
bg_obj_tbl_bridge_hi:	.addr	bg_scenery_bridge_hi
bg_obj_tbl_bridge_mid:	.addr	bg_scenery_bridge_mid
bg_obj_tbl_bridge_lo:	.addr	bg_scenery_bridge_lo
bg_obj_tbl_waterhole:	.addr	bg_scenery_waterhole
bg_obj_tbl_block_qhi:	.addr	bg_scenery_block_qhi
bg_obj_tbl_block_qlo:	.addr	bg_scenery_block_qlo

bg_obj_spec_B:
bg_obj_tbl_rope_norm:	.addr	bg_scenery_rope_norm
bg_obj_tbl_rope_plat:	.addr	bg_scenery_rope_plat
bg_obj_tbl_castle:	.addr	bg_scenery_castle
bg_obj_tbl_stairs:	.addr	bg_scenery_stairs
bg_obj_tbl_pipe_exit:	.addr	bg_scenery_pipe_exit
bg_obj_tbl_pole_tip:	.addr	bg_scenery_pole_tip

.if	.defined(SMBV2)
bg_obj_tbl_pipe_v_flip_a:	.addr	bg_scenery_pipe_v_flip_a
bg_obj_tbl_pipe_v_flip_b:	.addr	bg_scenery_pipe_v_flip_b
.endif

bg_obj_spec_C:
bg_obj_tbl_block_q_a:		.addr	bg_scenery_block_q
bg_obj_tbl_block_q_b:		.addr	bg_scenery_block_q
bg_obj_tbl_block_q_c:		.addr	bg_scenery_block_q

.if	.defined(SMB2)
bg_obj_tbl_block_q_d:		.addr	bg_scenery_block_q
.endif

bg_obj_tbl_hidden_one_up:	.addr	bg_scenery_hidden_one_up

.if	.defined(SMBV2)
bg_obj_tbl_block_q_e:		.addr	bg_scenery_block_q
.endif

.if	.defined(SMB2)
bg_obj_tbl_block_q_f:		.addr	bg_scenery_block_q
bg_obj_tbl_block_item_e:	.addr	bg_scenery_block_item
.endif

bg_obj_tbl_block_item_a:	.addr	bg_scenery_block_item
bg_obj_tbl_block_item_b:	.addr	bg_scenery_block_item
bg_obj_tbl_block_item_c:	.addr	bg_scenery_block_item
bg_obj_tbl_block_coin:		.addr	bg_scenery_block_coin
bg_obj_tbl_block_item_d:	.addr	bg_scenery_block_item
bg_obj_tbl_pipe_water:		.addr	bg_scenery_pipe_water
bg_obj_tbl_empty_draw:		.addr	bg_scenery_empty_draw
bg_obj_tbl_spring:		.addr	bg_scenery_spring

bg_obj_spec_D:
bg_obj_tbl_pipe_intro:		.addr	bg_scenery_pipe_intro
bg_obj_tbl_pole:		.addr	bg_scenery_pole
bg_obj_tbl_castle_bridge_axe:	.addr	bg_scenery_castle_bridge_axe
bg_obj_tbl_castle_bridge_draw:	.addr	bg_scenery_castle_bridge_draw
bg_obj_tbl_castle_bridge:	.addr	bg_scenery_castle_bridge
bg_obj_tbl_lock_warp:		.addr	bg_scenery_lock_warp
bg_obj_tbl_lock_end:		.addr	bg_scenery_lock
bg_obj_tbl_lock_start:		.addr	bg_scenery_lock
bg_obj_tbl_swarm_a:		.addr	bg_scenery_swarm
bg_obj_tbl_swarm_b:		.addr	bg_scenery_swarm
bg_obj_tbl_swarm_c:		.addr	bg_scenery_swarm
bg_obj_tbl_decode_rts:		.addr	bg_scenery_decode_rts2

.if	.defined(SMB2)
bg_obj_tbl_wind_on:	.addr	bg_scenery_wind_on
bg_obj_tbl_wind_off:	.addr	bg_scenery_wind_off
.endif

bg_obj_tbl_set_attr:		.addr	bg_scenery_set_attr
; ------------------------------------------------------------
bg_scenery_set_attr:
	ldy	scenery_offset, x
	iny
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif
	lda	(course_scenery_addr), y
	pha
	and	#>COURSE_OBJ_E_FLOOR_MASK
	bne	:+ ; if (!(course_scenery_addr[y] & COURSE_OBJ_E_FLOOR_MASK)) {
		pla
		pha
		and	#COURSE_FLOOR_MASK_MAX
		sta	course_floor_mask_id
		pla
		and	#COURSE_BG_MAX<<4
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		sta	course_bg_id
		rts
	: ; } else {
		pla
		and	#COURSE_SCENERY_BG_FG_MASK
		cmp	#COURSE_SCENERY_FG_MAX+1
		bcc	:+ ; if ((course_scenery_byte_1 & bg_fg_mask) >= (fg_max+1)) {
			sta	course_bg_col
			lda	#COURSE_SCENERY_FG_NONE_VAL
		: ; }
		sta	course_fg_id
		rts
	; }
; -----------------------------
bg_scenery_lock_warp:
	.if	.defined(SMBV1)
		ldx	#4
	.elseif	.defined(SMBV2)
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
	sta	game_warp_ctrl

	.if	.defined(SMBV1)
		jsr	screen_text_draw
	.elseif	.defined(SMBV2)
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
	lda	#proc_id_actors::free
	ldx	#ENG_ACTOR_MAX-2
	: ; for (entry of obj_id_actor) {
		ldy	obj_id_actor, x
		cpy	bg_actor_kill_id
		bne	:+ ; if (obj_id_actor == bg_actor_kill_id) {
			sta	proc_id_actor, x
		: ; }
	
		dex
		bpl	:--
	; }

	rts
