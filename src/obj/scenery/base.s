.include	"mem.i"
.include	"mem_low.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"const.i"
.include	"tiles.i"

	.export scenery_proc
scenery_proc:
	ldy	bg_scenery_proc_id
	bne	:+ ; if (bg_scenery_proc_id == main_c) {
		ldy	#scenery_procs::main_b
		sty	bg_scenery_proc_id
	: ; }

	dey
	tya
	jsr	scenery_proc_do

	dec	bg_scenery_proc_id
	bne	:+ ; if (bg_scenery_proc_id == inc_seam_a) {
		jsr	meta_render_attr
	: ; }

	rts
; ----------------------------------------------------------------------
	.export scenery_proc_tbl
	.export scenery_proc_inc_seam_a, scenery_proc_inc_seam_b
	.export scenery_proc_render_area_a, scenery_proc_render_area_b
	.export scenery_proc_render_area_c, scenery_proc_render_area_d
	.export scenery_proc_main_a, scenery_proc_main_b
scenery_proc_do:
	jsr	tbljmp
scenery_proc_tbl:
scenery_proc_inc_seam_a:		.addr	scenery_inc_seam
scenery_proc_render_area_a:		.addr	meta_render_area
scenery_proc_render_area_b:		.addr	meta_render_area
scenery_proc_main_a:			.addr	scenery_proc_main
scenery_proc_inc_seam_b:		.addr	scenery_inc_seam
scenery_proc_render_area_c:		.addr	meta_render_area
scenery_proc_render_area_d:		.addr	meta_render_area
scenery_proc_main_b:			.addr	scenery_proc_main
; ----------------------------------------------------------------------
scenery_inc_seam:
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
; ----------------------------------------------------------------------
	.export scenery_static_tbl
	.export scenery_static_tbl_cloud
	.export scenery_static_tbl_mnt_bush
	.export scenery_static_tbl_tree_fence
scenery_static_tbl:
scenery_static_tbl_cloud:		.byte	scenery_static_cloud-scenery_static
scenery_static_tbl_mnt_bush:		.byte	scenery_static_mnt_bush-scenery_static
scenery_static_tbl_tree_fence:	.byte	scenery_static_tree_fence-scenery_static

scenery_static:
scenery_static_cloud:
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.res	2, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.res	2, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+5-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+5-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+5-scenery_metatile)<<4))
	.res	6, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.res	6, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.res	4, ENG_TILEOBJ_NULL
	.byte   <((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+5-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+5-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+5-scenery_metatile)<<4))
	.byte   <((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+4-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+4-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+4-scenery_metatile)<<4))
	.res	5, ENG_TILEOBJ_NULL
	.byte   <((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))

scenery_static_mnt_bush:
	.byte	<((((scenery_row_mnt_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_mnt_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+8-scenery_metatile)<<4))
	.byte	<((((scenery_row_mnt_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+8-scenery_metatile)<<4))
	.byte	<((((scenery_row_mnt_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+8-scenery_metatile)<<4))
	.byte	<((((scenery_row_mnt_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.res	3, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_mnt_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_mnt_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_mnt_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_bush_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.res	4, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_bush_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_bush_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.res	3, ENG_TILEOBJ_NULL

scenery_static_tree_fence:
	.byte   <((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.res	7, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_tree_short-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_tree_tall-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+8-scenery_metatile)<<4))
	.byte	<((((scenery_row_fence-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_fence-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_fence-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_fence-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_tree_tall-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+8-scenery_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_tree_short-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_tree_short-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.res	2, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+1-scenery_metatile)<<4))
	.res	4, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_fence-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_fence-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.byte	<((((scenery_row_tree_short-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+9-scenery_metatile)<<4))
	.byte	<((((scenery_row_fence-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+10-scenery_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_tree_tall-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+8-scenery_metatile)<<4))
	.res	1, ENG_TILEOBJ_NULL
	.byte	<((((scenery_row_cloud_left-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_middle-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))
	.byte	<((((scenery_row_cloud_right-scenery_rows)/SCENERY_ROW_SIZE)+1)|((scenery_metatile+0-scenery_metatile)<<4))

scenery_rows:
scenery_row_cloud_left:
	.byte	metatile_2::cloud_a
	.byte	metatile_2::cloud_d
	.byte	metatile_0::blank_a
scenery_row_cloud_middle:
	.byte	metatile_2::cloud_b
	.byte	metatile_2::cloud_e
	.byte	metatile_0::blank_a
scenery_row_cloud_right:
	.byte	metatile_2::cloud_c
	.byte	metatile_2::cloud_f
	.byte	metatile_0::blank_a

scenery_row_bush_left:
	.byte	metatile_0::bush_a
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
scenery_row_bush_middle:
	.byte	metatile_0::bush_b
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
scenery_row_bush_right:
	.byte	metatile_0::bush_c
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a

scenery_row_mnt_left:
	.byte	metatile_0::blank_a
	.byte	metatile_0::hill_a
	.byte	metatile_0::hill_b
scenery_row_mnt_middle:
	.byte	metatile_0::hill_c
	.byte	metatile_0::hill_b
	.byte	metatile_0::hill_f
scenery_row_mnt_right:
	.byte	metatile_0::blank_a
	.byte	metatile_0::hill_d
	.byte	metatile_0::hill_e

scenery_row_fence:
	.byte	metatile_1::post
	.byte	metatile_0::blank_a
	.byte	metatile_0::blank_a
scenery_row_tree_tall:
	.byte	metatile_0::tree_a
	.byte	metatile_0::tree_c
	.byte	metatile_1::tree_trunk
scenery_row_tree_short:
	.byte	metatile_0::tree_b
	.byte	metatile_1::tree_trunk
	.byte	metatile_1::tree_trunk
scenery_rows_end:

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

scenery_fg_tiles:
	.byte	metatile_1::floor_underwater
	.byte	metatile_1::floor_normal
	.byte	metatile_1::brick_b
	.byte	metatile_1::floor_castle

	.export	scenery_floor_masks
	.export floor_mask_0, floor_mask_1
	.export floor_mask_2, floor_mask_3
	.export floor_mask_4, floor_mask_5
	.export floor_mask_6, floor_mask_7
	.export floor_mask_8, floor_mask_9
	.export floor_mask_10, floor_mask_11
	.export floor_mask_12, floor_mask_13
	.export floor_mask_14, floor_mask_15
scenery_floor_masks:
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
; ----------------------------------------------------------------------
scenery_proc_main_tile_idx	= zp_byte_00
scenery_proc_main_floor_mask	= zp_byte_00
scenery_proc_main_fg_next	= zp_byte_01
scenery_proc_main_buffer_ptr_idx = zp_byte_00

scenery_proc_main:
	lda	course_page_loaded
	beq	:+ ; if (course.page_loaded) {
		jsr	scenery_do
	: ; }

	ldx	#METATILE_MAX-1
	lda	#metatile_0::blank_a
	: ; for (entry of scenery_metatile) {
		sta	scenery_metatile, x

		dex
		bpl	:-
	; }

	ldy	course_bg_id
	beq	:++++ ; if (course.bg_id != 0) {
		lda	pos_x_hi_game
		: ; while ((game.pos_x.hi -= SCENERY_ROW_SIZE) > SCENERY_ROW_SIZE) {
			cmp	#SCENERY_ROW_SIZE
			bmi	:+
			sec
			sbc	#SCENERY_ROW_SIZE
			bpl	:-
		: ; }
	
		asl	a
		asl	a
		asl	a
		asl	a
		adc	scenery_static_tbl-1, y
		adc	pos_x_lo_game
		tax
		lda	scenery_static, x
		beq	:++ ; if (scenery_static[(game.pos_x.hi*16)+scenery_static_tbl[course_bg_id-1]+pos_x_lo_game]) {
			pha

			and	#%00001111
			sec
			sbc	#1
			sta	scenery_proc_main_tile_idx
			asl	a
			adc	scenery_proc_main_tile_idx
			tax

			pla
			lsr	a
			lsr	a
			lsr	a
			lsr	a
			tay
			lda	#SCENERY_ROW_SIZE
			sta	scenery_proc_main_tile_idx
			: ; for (
			;	x = scenery_static_byte.scenery_rows_id, y = scenery_static_byte.metatile_b_id, i = SCENERY_ROW_SIZE;
			;	y < (sizeof (scenery_rows)-1)/SCENERY_ROW_SIZE && i > 0;
			;	 x++, y++, i--
			; ) {
				lda	scenery_rows, x
				sta	scenery_metatile, y
		
				inx
				iny
				cpy	#((scenery_rows_end-scenery_rows)-1)/SCENERY_ROW_SIZE
				beq	:+
				dec	scenery_proc_main_tile_idx
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
				sta	scenery_metatile, x
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
		lda	scenery_fg_tiles, y
		ldy	course_type_cloud
		beq	:+ ; if (course.type == cloud) {
			lda	#metatile_2::cloud_small
		; }
	: ; }
	sta	scenery_proc_metatile_id

	ldx	#0
	lda	course_floor_mask_id
	asl	a
	tay
	: ; for (x = 0, y = 2*course.floor_mask_id; x < 0xD && y < 0x100; x += 8, y++) {
		lda	scenery_floor_masks, y
		sta	scenery_proc_main_floor_mask
		iny
		sty	scenery_proc_main_fg_next
		lda	course_type_cloud
		beq	:+	
		cpx	#0
		beq	:+ ; if (course.type == cloud && x != 0) {
			lda	scenery_proc_main_floor_mask
			and	#%00001000
			sta	scenery_proc_main_floor_mask
		: ; }
	
		ldy	#0
		: ; for (y = 0; x < 0xD && y < 8; x++, y++) {
			lda	actor_init_bullet_cheep_data_a, y
			bit	scenery_proc_main_floor_mask
			beq	:+ ; if ((actor_init_bullet_cheep_data_a[y] & floor_mask)) {
				lda	scenery_proc_metatile_id
				sta	scenery_metatile, x
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
				sta	scenery_proc_metatile_id
			: ; }
		
			iny
			cpy	#8
			bne	:---
		; }
	
		ldy	scenery_proc_main_fg_next
		bne	:-----
	: ; }

	jsr	scenery_do
	lda	disp_buff_col
	jsr	scenery_get_buffer_ptr
	ldx	#0
	ldy	#0
	: ; for (entry of scenery_metatile) {
		sty	scenery_proc_main_buffer_ptr_idx
		lda	scenery_metatile, x
		and	#TILE_PAGE_BITS
		asl	a
		rol	a
		rol	a
		tay
		lda	scenery_metatile, x
		cmp	scenery_buffer_cutoff, y
		bcs	:+ ; if (scenery_metatile_entry < this.buffer_cutoff[scenery_metatile_entry>>6]) {
			lda	#metatile_0::blank_a
		: ; }
		ldy	scenery_proc_main_buffer_ptr_idx
		sta	(game_buffer), y
		tya
		clc
		adc	#PPU_VRAM_COLUMN_COUNT/METATILE_WIDTH_CHR
		tay

		inx
		cpx	#METATILE_MAX
		bcc	:--
	; }

	rts
; ----------------
scenery_buffer_cutoff:
	.byte	metatile_0::scenery_prio
	.byte	metatile_1::scenery_prio
	.byte	metatile_2::scenery_prio
	.byte	metatile_3::scenery_prio
; ----------------------------------------------------------------------
scenery_do:
	.if	.defined(VS)
		jsr	vs_setbank_low
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	scenery_outer_loop: ; while (course.page_calc || course.page_loaded) {
		ldx	#SCENERY_ACTIVE_MAX-1
		scenery_loop: ; for (item of scenery) {
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
				jsr	scenery_decode
				jmp	:+++
			: ; } else if (scenery_page_loc < pos_x_hi_game) {
				inc	course_page_calc
			: ; }
			; if (needs_increment) {
				jsr	scenery_offset_base_inc
			: ; }
		
			ldx	actor_index
			lda	scenery_length, x
			bmi	:+ ; if (this.length >= 0) {
				dec	scenery_length, x
			: ; }
		
			dex
			.if	.defined(CONS)
				bpl	scenery_loop
			.elseif	.defined(VS)
				bmi	:+
					jmp	scenery_loop
				:
			.endif
		; }

		lda	course_page_calc
		.if	.defined(CONS)
			bne	scenery_outer_loop
		.elseif	.defined(VS)
			beq	:+
				jmp	scenery_outer_loop
			:
		.endif

		lda	course_page_loaded
		.if	.defined(CONS)
			bne	scenery_outer_loop
		.elseif	.defined(VS)
			beq	:+
				jmp	scenery_outer_loop
			:
		.endif
	; }

scenery_do_rts:
	.if	.defined(VS)
		jsr	vs_setbank_low
	.endif
	rts
; ----------------------------------------------------------------------
scenery_offset_base_inc:
	inc	scenery_offset_base
	inc	scenery_offset_base
	lda	#0
	sta	scenery_page_on
	rts
; ----------------------------------------------------------------------
SCENERY_TBL_OFFSET	= zp_byte_07

scenery_decode:
	lda	scenery_length, x
	bmi	:+ ; if (!(scenery_length & 0x80)) {
		ldy	scenery_offset, x
	: ; }

	ldx	#(scenery_spec_B-scenery_tbl)/WORD_SIZE

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	lda	(course_scenery_addr), y
	cmp	#COURSE_SCENERY_END
	beq	scenery_do_rts
	and	#<COURSE_SCENERY_TYPE_MASK
	cmp	#<COURSE_SCENERY_TYPE_F
	beq	:+ ; if (course_scenery_type == 0xC) {
		ldx	#(scenery_spec_A-scenery_tbl)/WORD_SIZE
	cmp	#COURSE_SCENERY_TYPE_C
	beq	:+ ; } else if (course_scenery_type != 0xF) {
		ldx	#(scenery_norm-scenery_tbl)/WORD_SIZE
	: ; }
	stx	SCENERY_TBL_OFFSET
	ldx	actor_index
	cmp	#<COURSE_SCENERY_TYPE_E
	bne	:+ ; if (course_scenery_type == 0xE) {
		lda	#(scenery_norm-scenery_tbl)/WORD_SIZE
		sta	SCENERY_TBL_OFFSET

		lda	#(scenery_tbl_set_attr-scenery_tbl)/WORD_SIZE
		bne	scenery_set_base
	: cmp	#<COURSE_SCENERY_TYPE_D
	bne	:++ ; } else if (course_scenery_type == 0xD) {
		lda	#(scenery_spec_D-scenery_tbl)/WORD_SIZE
		sta	SCENERY_TBL_OFFSET

		iny

		.if	.defined(VS)
			lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			sta	VS_REQ
		.endif

		lda	(course_scenery_addr), y
		and	#>COURSE_SCENERY_TYPE_D_MASK
		beq	scenery_decode_rts ; if (scenery.is_D_object) {
			lda	(course_scenery_addr), y
			and	#>(COURSE_SCENERY_TYPE_D_OBJ_MASK|COURSE_SCENERY_TYPE_D_MASK)
			cmp	#>(COURSE_OBJ_D_LOOP|COURSE_SCENERY_TYPE_D_MASK)
			bne	:+ ; if (scenery.type_D_type == loop) {
				inc	course_loop_flag
			: ; }
			and	#>COURSE_SCENERY_TYPE_D_OBJ_MASK
			jmp	scenery_set_base
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
			lda	#(scenery_spec_C-scenery_tbl)/WORD_SIZE
			sta	SCENERY_TBL_OFFSET
	
			lda	(course_scenery_addr), y
			and	#COURSE_OBJ_C_MASK>>8
			jmp	scenery_set_base
		: ; } else {
			sta	scenery_tbl_base
			cmp	#>(COURSE_SCENERY_OBJ_MASK)
			bne	:+
	
			.if	.defined(VS)
				lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
				sta	VS_REQ
			.endif

			lda	(course_scenery_addr), y
			and	#%00001000
			beq	:+ ; if (scenery_tbl_base == 0x70 && (course_scenery_byte_1 & 0x08)) {
				lda	#(scenery_tbl_pipe_vert_a-scenery_tbl)/WORD_SIZE
				sta	scenery_tbl_base
			: ; }
		
			lda	scenery_tbl_base
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

scenery_set_base:
	sta	scenery_tbl_base

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
	bne	scenery_decode_rts
	lda	course_page_loaded
	bne	:+++
scenery_decode_rts:
	; if ((scenery_length & 0x80) && scenery_page_loc != pos_x_hi_game && (((course_scenery_byte_0 & 0xF) != 0xE) || !course.page_loaded)) {
		rts
	: lda	course_page_loaded
	beq	:+ ; } else if (course.page_loaded) {
		lda	#0
		sta	course_page_loaded
		sta	course_page_calc
		sta	actor_index
	scenery_decode_rts2:
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
		bne	scenery_decode_rts
	: ; }
	; if () {
		lda	scenery_offset_base
		sta	scenery_offset, x
		jsr	scenery_offset_base_inc
	: ; }

	lda	scenery_tbl_base
	clc
	adc	SCENERY_TBL_OFFSET
	jsr	tbljmp
	.export scenery_tbl

	.export scenery_norm
	.export scenery_tbl_pipe_vert_a
	.export scenery_tbl_ledge
	.export	scenery_tbl_brickrow
	.export	scenery_tbl_floorrow
	.export	scenery_tbl_coinrow
	.export	scenery_tbl_brickcol
	.export	scenery_tbl_floorcol
	.export scenery_tbl_pipe_vert_b

	.export	scenery_spec_A
	.export	scenery_tbl_pit
	.export	scenery_tbl_pulley
	.export	scenery_tbl_bridge_hi
	.export	scenery_tbl_bridge_mid
	.export	scenery_tbl_bridge_lo
	.export	scenery_tbl_waterhole
	.export	scenery_tbl_block_qhi
	.export	scenery_tbl_block_qlo

	.export scenery_spec_B
	.export	scenery_tbl_rope_norm
	.export	scenery_tbl_rope_plat
	.export	scenery_tbl_castle
	.export	scenery_tbl_stairs
	.export	scenery_tbl_pipe_exit
	.export	scenery_tbl_pole_tip
	.if	.defined(SMBV2)
		.export	scenery_tbl_pipe_v_flip_a
		.export	scenery_tbl_pipe_v_flip_b
	.endif

	.export	scenery_spec_C
	.export	scenery_tbl_block_q_a
	.export	scenery_tbl_block_q_b
	.export	scenery_tbl_block_q_c
	.if	.defined(SMB2)
		.export scenery_tbl_block_q_d
		.export scenery_tbl_block_q_f
		.export scenery_tbl_block_item_e
	.endif
	.if	.defined(SMBV2)
		.export scenery_tbl_block_q_e
	.endif
	.export	scenery_tbl_hidden_one_up
	.export	scenery_tbl_block_item_a
	.export	scenery_tbl_block_item_b
	.export scenery_tbl_block_item_c
	.export	scenery_tbl_block_item_d
	.export scenery_tbl_block_coin
	.export scenery_tbl_pipe_water
	.export scenery_tbl_empty_draw
	.export scenery_tbl_spring

	.export scenery_spec_D
	.export	scenery_tbl_pipe_intro
	.export	scenery_tbl_pole
	.export	scenery_tbl_castle_bridge_axe
	.export	scenery_tbl_castle_bridge_draw
	.export	scenery_tbl_castle_bridge
	.export	scenery_tbl_lock_warp
	.export	scenery_tbl_lock_end
	.export	scenery_tbl_lock_start
	.export	scenery_tbl_swarm_a
	.export	scenery_tbl_swarm_b
	.export	scenery_tbl_swarm_c
	.export	scenery_tbl_decode_rts
	.if	.defined(SMB2)
		.export	scenery_tbl_wind_on
		.export	scenery_tbl_wind_off
	.endif
scenery_tbl:
scenery_norm:
scenery_tbl_pipe_vert_a:	.addr	scenery_pipe_vert
scenery_tbl_ledge:	.addr	scenery_ledge
scenery_tbl_brickrow:	.addr	scenery_brickrow
scenery_tbl_floorrow:	.addr	scenery_floorrow
scenery_tbl_coinrow:	.addr	scenery_coinrow
scenery_tbl_brickcol:	.addr	scenery_brickcol
scenery_tbl_floorcol:	.addr	scenery_floorcol
scenery_tbl_pipe_vert_b:	.addr	scenery_pipe_vert

scenery_spec_A:
scenery_tbl_pit:		.addr	scenery_pit
scenery_tbl_pulley:	.addr	scenery_pulley
scenery_tbl_bridge_hi:	.addr	scenery_bridge_hi
scenery_tbl_bridge_mid:	.addr	scenery_bridge_mid
scenery_tbl_bridge_lo:	.addr	scenery_bridge_lo
scenery_tbl_waterhole:	.addr	scenery_waterhole
scenery_tbl_block_qhi:	.addr	scenery_block_qhi
scenery_tbl_block_qlo:	.addr	scenery_block_qlo

scenery_spec_B:
scenery_tbl_rope_norm:	.addr	scenery_rope_norm
scenery_tbl_rope_plat:	.addr	scenery_rope_plat
scenery_tbl_castle:	.addr	scenery_castle
scenery_tbl_stairs:	.addr	scenery_stairs
scenery_tbl_pipe_exit:	.addr	scenery_pipe_exit
scenery_tbl_pole_tip:	.addr	scenery_pole_tip

.if	.defined(SMBV2)
scenery_tbl_pipe_v_flip_a:	.addr	scenery_pipe_v_flip_a
scenery_tbl_pipe_v_flip_b:	.addr	scenery_pipe_v_flip_b
.endif

scenery_spec_C:
scenery_tbl_block_q_a:		.addr	scenery_block_q
scenery_tbl_block_q_b:		.addr	scenery_block_q
scenery_tbl_block_q_c:		.addr	scenery_block_q

.if	.defined(SMB2)
scenery_tbl_block_q_d:		.addr	scenery_block_q
.endif

scenery_tbl_hidden_one_up:	.addr	scenery_hidden_one_up

.if	.defined(SMBV2)
scenery_tbl_block_q_e:		.addr	scenery_block_q
.endif

.if	.defined(SMB2)
scenery_tbl_block_q_f:		.addr	scenery_block_q
scenery_tbl_block_item_e:	.addr	scenery_block_item
.endif

scenery_tbl_block_item_a:	.addr	scenery_block_item
scenery_tbl_block_item_b:	.addr	scenery_block_item
scenery_tbl_block_item_c:	.addr	scenery_block_item
scenery_tbl_block_coin:		.addr	scenery_block_coin
scenery_tbl_block_item_d:	.addr	scenery_block_item
scenery_tbl_pipe_water:		.addr	scenery_pipe_water
scenery_tbl_empty_draw:		.addr	scenery_empty_draw
scenery_tbl_spring:		.addr	scenery_spring

scenery_spec_D:
scenery_tbl_pipe_intro:		.addr	scenery_pipe_intro
scenery_tbl_pole:		.addr	scenery_pole
scenery_tbl_castle_bridge_axe:	.addr	scenery_castle_bridge_axe
scenery_tbl_castle_bridge_draw:	.addr	scenery_castle_bridge_draw
scenery_tbl_castle_bridge:	.addr	scenery_castle_bridge
scenery_tbl_lock_warp:		.addr	scenery_lock_warp
scenery_tbl_lock_end:		.addr	scenery_lock
scenery_tbl_lock_start:		.addr	scenery_lock
scenery_tbl_swarm_a:		.addr	scenery_swarm
scenery_tbl_swarm_b:		.addr	scenery_swarm
scenery_tbl_swarm_c:		.addr	scenery_swarm
scenery_tbl_decode_rts:		.addr	scenery_decode_rts2

.if	.defined(SMB2)
scenery_tbl_wind_on:	.addr	scenery_wind_on
scenery_tbl_wind_off:	.addr	scenery_wind_off
.endif

scenery_tbl_set_attr:		.addr	scenery_set_attr
; ----------------------------------------------------------------------
scenery_set_attr:
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
; ----------------------------------
scenery_lock_warp:
	.if	.defined(SMBV1)
		ldx	#4
	.elseif	.defined(SMBV2)
		ldx	#$80
		lda	ENG_HARDMODE_VAR
		bne	scenery_lock_warp_hard_mode
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

			scenery_lock_warp_hard_mode:
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
			jmp	scenery_lock_warp_load
		scenery_lock_warp_hard_mode: ; } else if (hard_mode) {
			lda	#$87
			clc
			adc	player_goals
			bne	scenery_lock_warp_do
		: ; } else {
			ldx	#$83
			lda	course_no
			cmp	#course::no_03
			beq	scenery_lock_warp_load ; if (course != no_03) {
				inx
				cmp	#course::no_05
				bne	:+
				lda	course_page_offset
				cmp	#$0B
				beq	scenery_lock_warp_load
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

		scenery_lock_warp_load: ; if (!hard_mode) {
			txa
		scenery_lock_warp_do: ; }
	.endif
	sta	game_warp_ctrl

	.if	.defined(SMBV1)
		jsr	bg_text_draw
	.elseif	.defined(SMBV2)
		jsr	bg_text_draw_over
	.endif

	lda	#actor::piranha_plant
	jsr	scenery_actor_kill

scenery_lock:
	lda	game_scroll_lock
	eor	#1
	sta	game_scroll_lock
	rts
; ----------------------------------
scenery_actor_kill_id	= zp_byte_00

	.export scenery_actor_kill
scenery_actor_kill:
	sta	scenery_actor_kill_id
	lda	#proc_id_actors::free
	ldx	#ACTOR_COUNT_MAX-2
	: ; for (entry of obj_id_actor) {
		ldy	obj_id_actor, x
		cpy	scenery_actor_kill_id
		bne	:+ ; if (entry.obj_id == actor_kill_id) {
			sta	proc_id_actor, x
		: ; }
	
		dex
		bpl	:--
	; }

	rts
