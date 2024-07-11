.include	"../../inc/engine/course_flags.i"
.include	"../../inc/engine/misc.i"
.include	"../../inc/engine/tunables.i"
.include	"../../inc/engine/tiles.i"
 
.include	"../../inc/engine/unk.i"

BG_PROC_METATILE_ID	= zp_byte_07

	.export bg_proc
bg_proc:
	ldy	bg_proc_id
	bne	:+ ; if (!bg_proc_id) {
		ldy	#8
		sty	bg_proc_id
	: ; }

	dey
	tya
	jsr	bg_proc_do
	dec	bg_proc_id
	bne	:+ ; if (!--bg_proc_id) {
		jsr	gfx_render_attr
	: ; }

	rts
; ------------------------------------------------------------
bg_proc_do:
	jsr	eng_farjump
	.addr	bg_inc_col
	.addr	gfx_render_area
	.addr	gfx_render_area
	.addr	bg_proc_main
	.addr	bg_inc_col
	.addr	gfx_render_area
	.addr	gfx_render_area
	.addr	bg_proc_main
; ------------------------------------------------------------
bg_inc_col:
	inc	eng_pos_x
	lda	eng_pos_x
	and	#$0F
	bne	:+ ; if (!(eng_pos_x & 0xF)) {
		sta	eng_pos_x
		inc	eng_page_current
	: ; }

	inc	disp_buff_col
	lda	disp_buff_col
	and	#$1F
	sta	disp_buff_col
	rts
; ------------------------------------------------------------
	.export bg_scenery_tbl
	.export bg_scenery_tbl_cloud
	.export bg_scenery_tbl_mnt_bush
	.export bg_scenery_tbl_tree_fence
bg_scenery_tbl:
bg_scenery_tbl_cloud:
	.byte	bg_scenery_cloud-bg_scenery

bg_scenery_tbl_mnt_bush:
	.byte	bg_scenery_mnt_bush-bg_scenery

bg_scenery_tbl_tree_fence:
	.byte	bg_scenery_tree_fence-bg_scenery

bg_scenery:
bg_scenery_cloud:
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.res	2, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.res	2, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_05-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_05-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_05-tbl_metatile_b)<<4))
	.res	6, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.res	6, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.res	4, ENG_METATILE_NULL
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_05-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_05-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_05-tbl_metatile_b)<<4))
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_04-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_04-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_04-tbl_metatile_b)<<4))
	.res	5, ENG_METATILE_NULL
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))

bg_scenery_mnt_bush:
	.byte	<((((bg_tile_mnt_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_mnt_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_08-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_mnt_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_08-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_mnt_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_08-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_mnt_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.res	3, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_mnt_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_mnt_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_mnt_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.res	1, ENG_METATILE_NULL
	.byte	<((((bg_tile_bush_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.res	1, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.res	4, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.res	1, ENG_METATILE_NULL
	.byte	<((((bg_tile_bush_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_bush_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.res	3, ENG_METATILE_NULL

bg_scenery_tree_fence:
	.byte   <((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.res	7, ENG_METATILE_NULL
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.res	1, ENG_METATILE_NULL
	.byte	<((((bg_tile_tree_tall-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_08-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_tree_tall-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_08-tbl_metatile_b)<<4))
	.res	1, ENG_METATILE_NULL
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.res	2, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_01-tbl_metatile_b)<<4))
	.res	4, ENG_METATILE_NULL
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_tree_short-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_09-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_fence-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_0A-tbl_metatile_b)<<4))
	.res	1, ENG_METATILE_NULL
	.byte	<((((bg_tile_tree_tall-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_08-tbl_metatile_b)<<4))
	.res	1, ENG_METATILE_NULL
	.byte	<((((bg_tile_cloud_left-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_middle-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))
	.byte	<((((bg_tile_cloud_right-bg_tiles)/ENG_METATILE_SIZE)+1)|((tbl_metatile_b_00-tbl_metatile_b)<<4))

bg_tiles:
bg_tile_cloud_left:
	.byte	$80, $83, $00
bg_tile_cloud_middle:
	.byte	$81, $84, $00
bg_tile_cloud_right:
	.byte	$82, $85, $00
bg_tile_bush_left:
	.byte	$02, $00, $00
bg_tile_bush_middle:
	.byte	$03, $00, $00
bg_tile_bush_right:
	.byte	$04, $00, $00
bg_tile_mnt_left:
	.byte	$00, $05, $06
bg_tile_mnt_middle:
	.byte	$07, $06, $0A
bg_tile_mnt_right:
	.byte	$00, $08, $09
bg_tile_fence:
	.byte	$4D, $00, $00
bg_tile_tree_tall:
	.byte	$0D, $0F, $4E
bg_tile_tree_short:
	.byte	$0E, $4E, $4E
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
	.byte	$86, $87, $87, $87, $87, $87, $87
	.byte	$87, $87, $87, $87

	.byte	FG_BASE_TILE_A, FG_BASE_TILE_A

fg_scenery_walls:
	.res	5, ENG_METATILE_NULL
	.byte	$45, $47, $47, $47, $47, $47
	.res	2, ENG_METATILE_NULL

fg_scenery_surface:
	.res	11, ENG_METATILE_NULL
	.byte	$86, $87

fg_tiles:
	.byte	FG_BASE_TILE_A, FG_BASE_TILE_B, FG_BASE_TILE_C, FG_BASE_TILE_D

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
bg_proc_main:
	lda	eng_page_cached
	beq	:+ ; if (eng_page_cached) {
		jsr	bg_area
	: ; }

	ldx	#<(tbl_metatile_b_end-tbl_metatile_b)-1
	lda	#0
	: ; for (entry of tbl_metatile_b) {
		sta	tbl_metatile_b, x

		dex
		bpl	:-
	; }

	ldy	course_bg_id
	beq	:++++ ; if (course_bg_id) {
		lda	eng_page_current
		: ; while ((eng_page_current -= ENG_METATILE_SIZE) > ENG_METATILE_SIZE) {
			cmp	#ENG_METATILE_SIZE
			bmi	:+
			sec
			sbc	#ENG_METATILE_SIZE
			bpl	:-
		: ; }
	
		asl	a
		asl	a
		asl	a
		asl	a
		adc	bg_scenery_tbl-1, y
		adc	eng_pos_x
		tax
		lda	bg_scenery, x
		beq	:++ ; if (bg_scenery[(eng_page_current*16)+bg_scenery_tbl[course_bg_id-1]+eng_pos_x]) {
			pha
			and	#$0F
			sec
			sbc	#1
			sta	zp_byte_00
			asl	a
			adc	zp_byte_00
			tax
			pla
			lsr	a
			lsr	a
			lsr	a
			lsr	a
			tay
			lda	#ENG_METATILE_SIZE
			sta	zp_byte_00
			: ; for (
			;	x = bg_scenery_byte.bg_tiles_id, y = bg_scenery_byte.metatile_b_id, i = ENG_METATILE_SIZE;
			;	y < (sizeof (bg_tiles)-1)/ENG_METATILE_SIZE && i > 0;
			;	 x++, y++, i--
			; ) {
				lda	bg_tiles, x
				sta	tbl_metatile_b, y
		
				inx
				iny
				cpy	#((bg_tiles_end-bg_tiles)-1)/ENG_METATILE_SIZE
				beq	:+
				dec	zp_byte_00
				bne	:-
			; }
		; }
	: ; }

	ldx	course_fg_id
	beq	:+++ ; if (course_fg_id) {
		ldy	fg_scenery_tbl-1, x
		ldx	#0
		: ; for (byte of fg_scenery) {
			lda	fg_scenery, y
			beq	:+ ; if (fg_scenery_byte) {
				sta	tbl_metatile_b, x
			: ; }
		
			iny
			inx
			cpx	#<(tbl_metatile_b_end-tbl_metatile_b)
			bne	:--
		; }
	: ; }

	ldy	course_type
	bne	:+
	lda	course_no
	cmp	#course::no_08
	bne	:+ ; if (course_type == water && course_no == no_08) {
		lda	#FG_BASE_TILE_D
		jmp	:++
	: ; } else {
		lda	fg_tiles, y
		ldy	course_type_cloud
		beq	:+ ; if (course_type_cloud) {
			lda	#$88
		; }
	: ; }
	sta	zp_byte_07

	ldx	#0
	lda	course_fg_mask_id
	asl	a
	tay
	: ; for (x = 0, y = 2*course_fg_mask_id; x < 0xD && y < 0x100; x += 8, y++) {
		lda	fg_masks, y
		sta	zp_byte_00
		iny
		sty	zp_byte_01
		lda	course_type_cloud
		beq	:+	
		cpx	#0
		beq	:+ ; if () {
			lda	zp_byte_00
			and	#$08
			sta	zp_byte_00
		: ; }
	
		ldy	#0
		: ; for (y = 0; x < 0xD && y < 8; x++, y++) {
			lda	area_bitmasks, y
			bit	zp_byte_00
			beq	:+ ; if ((area_bitmasks[y] & fg_mask)) {
				lda	zp_byte_07
				sta	tbl_metatile_b, x
			: ; }
		
			inx
			cpx	#<(tbl_metatile_b_end-tbl_metatile_b)
			beq	:++
		
			lda	course_type
			cmp	#course_types::underground
			bne	:+
			cpx	#(tbl_metatile_b_0B-tbl_metatile_b)
			bne	:+ ; if (course_type == underground && x == tbl_metatile_b_0B) {
				lda	#FG_BASE_TILE_B
				sta	zp_byte_07
			: ; }
		
			iny
			cpy	#8
			bne	:---
		; }
	
		ldy	zp_byte_01
		bne	:-----
	: ; }

	jsr	bg_area
	lda	disp_buff_col
	jsr	bg_get_buffer_ptr
	ldx	#0
	ldy	#0
	: ; for (entry of tbl_metatile_b) {
		sty	zp_byte_00
		lda	tbl_metatile_b, x
		and	#$C0
		asl	a
		rol	a
		rol	a
		tay
		lda	tbl_metatile_b, x
		cmp	bg_buffer_cutoff, y
		bcs	:+ ; if (tbl_metatile_b_entry < bg_buffer_cutoff[tbl_metatile_b_entry>>6]) {
			lda	#0
		: ; }
		ldy	zp_byte_00
		sta	(eng_buffer_ptr), y
		tya
		clc
		adc	#$10
		tay

		inx
		cpx	#<(tbl_metatile_b_end-tbl_metatile_b)
		bcc	:--
	; }

	rts
; --------------
.if	.defined(SMBM)|.defined(VS_SMB)
	BG_BUFFER_CUTOFF_B	= $51
.elseif	.defined(SMB2)
	BG_BUFFER_CUTOFF_B	= $4F
.endif

bg_buffer_cutoff:
	.byte	$10, BG_BUFFER_CUTOFF_B, $88, $C0
; ------------------------------------------------------------
bg_area:
	.if	.defined(VS)
		jsr	vs_setbank_low
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_SR
	.endif
	bg_areaobj_outer_loop: ; while (eng_area_bg_flag || eng_page_cached) {
		ldx	#3-1
		bg_areaobj_loop: ; for (actor_index = 3-1; actor_index >= 0; x--) {
			stx	actor_index
			lda	#0
			sta	eng_area_bg_flag
			ldy	eng_area_offset
			.if	.defined(VS)
				lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
				sta	VS_SR
			.endif
			lda	(course_data_addr), y
			cmp	#COURSE_DATA_END
			beq	:++++
			lda	eng_lenareaobj_0, x
			bpl	:++++ ; if (course_data_byte_0 != COURSE_DATA_END && (eng_lenareaobj & 0x80)) {
				iny
				lda	(course_data_addr), y
				asl	a
				bcc	:+
				lda	eng_areaobj_page_on
				bne	:+ ; if ((course_data_byte_1 & 0x80) && !eng_area_obj_page_on) {
					inc	eng_areaobj_page_on
					inc	eng_areaobj_page_loc
				: ; }
			
				dey
				.if	.defined(VS)
					lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
					sta	VS_SR
				.endif
				lda	(course_data_addr), y
				and	#<COURSE_DATA_TYPE_MASK
				cmp	#<COURSE_DATA_TYPE_D
				bne	:+
				iny
				lda	(course_data_addr), y
				dey
				and	#>COURSE_DATA_TYPE_D_MASK
				bne	:++
				lda	eng_areaobj_page_on
				bne	:++ ; if ((course_data_byte_0 & 0xF) == 0xD && !(course_data_byte_1 & 0x40) && !eng_areaobj_page_on) {
					iny
					.if	.defined(VS)
						lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
						sta	VS_SR
					.endif
					lda	(course_data_addr), y
					and	#>COURSE_DATA_TYPE_D_LOC_MASK
					sta	eng_areaobj_page_loc
					inc	eng_areaobj_page_on
					jmp	:+++++
				: ; }
				cmp	#<COURSE_DATA_TYPE_E
				bne	:+
				lda	eng_page_cached
				bne	:++
				: lda	eng_areaobj_page_loc
				cmp	eng_page_current
				bcc	:++
			; }
			: ; if (
			;	course_data_byte == COURSE_DATA_END
			;	|| !(eng_lenareaobj & 0x80)
			;	|| (((course_data_byte & 0xF) == 0xE && eng_page_cached)
			;	|| eng_areaobj_page_loc >= eng_page_current)) {
				jsr	bg_area_decode
				jmp	:+++
			: ; } else if (eng_areaobj_page_loc < eng_page_current) {
				inc	eng_area_bg_flag
			: ; }
			; if (needs_increment) {
				jsr	bg_buffer_inc
			: ; }
		
			ldx	actor_index
			lda	eng_lenareaobj_0, x
			bmi	:+ ; if (!(eng_lenareaobj & 0x80)) {
				dec	eng_lenareaobj_0, x
			: ; }
		
			dex
			.if	.defined(CONS)
				bpl	bg_areaobj_loop
			.elseif	.defined(VS)
				bmi	:+
					jmp	bg_areaobj_loop
				:
			.endif
		; }

		lda	eng_area_bg_flag
		.if	.defined(CONS)
			bne	bg_areaobj_outer_loop
		.elseif	.defined(VS)
			beq	:+
				jmp	bg_areaobj_outer_loop
			:
		.endif

		lda	eng_page_cached
		.if	.defined(CONS)
			bne	bg_areaobj_outer_loop
		.elseif	.defined(VS)
			beq	:+
				jmp	bg_areaobj_outer_loop
			:
		.endif
	; }

bg_area_rts:
	.if	.defined(VS)
		jsr	vs_setbank_low
	.endif
	rts
; ------------------------------------------------------------
bg_buffer_inc:
	inc	eng_area_offset
	inc	eng_area_offset
	lda	#0
	sta	eng_areaobj_page_on
	rts
; ------------------------------------------------------------
BG_OBJ_TBL_BASE		= zp_byte_00
BG_OBJ_TBL_OFFSET	= zp_byte_07

bg_area_decode:
	lda	eng_lenareaobj_0, x
	bmi	:+ ; if (!(eng_lenareaobj & 0x80)) {
		ldy	eng_areaobj_offset_0, x
	: ; }

	ldx	#(bg_obj_spec_B-bg_obj_tbl)/WORD_SIZE
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_SR
	.endif
	lda	(course_data_addr), y
	cmp	#COURSE_DATA_END
	beq	bg_area_rts
	and	#<COURSE_DATA_TYPE_MASK
	cmp	#<COURSE_DATA_TYPE_F
	beq	:+ ; if (course_data_type == 0xC) {
		ldx	#(bg_obj_spec_A-bg_obj_tbl)/WORD_SIZE
	cmp	#COURSE_DATA_TYPE_C
	beq	:+ ; } else if (course_data_type != 0xF) {
		ldx	#(bg_obj_norm-bg_obj_tbl)/WORD_SIZE
	: ; }
	stx	BG_OBJ_TBL_OFFSET
	ldx	actor_index
	cmp	#<COURSE_DATA_TYPE_E
	bne	:+ ; if (course_data_type == 0xE) {
		lda	#(bg_obj_norm-bg_obj_tbl)/WORD_SIZE
		sta	BG_OBJ_TBL_OFFSET

		lda	#(bg_obj_tbl_set_attr-bg_obj_tbl)/WORD_SIZE
		bne	bg_obj_set_base
	: cmp	#<COURSE_DATA_TYPE_D
	bne	:++ ; } else if (course_data_type == 0xD) {
		lda	#(bg_obj_spec_D-bg_obj_tbl)/WORD_SIZE
		sta	BG_OBJ_TBL_OFFSET

		iny
		.if	.defined(VS)
			lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			sta	VS_SR
		.endif
		lda	(course_data_addr), y
		and	#>COURSE_DATA_TYPE_D_MASK
		beq	bg_area_decode_rts ; if (course_data_byte_1 & 0x40) {
			lda	(course_data_addr), y
			and	#>(COURSE_DATA_TYPE_D_OBJ_MASK|COURSE_DATA_TYPE_D_MASK)
			cmp	#>(COURSE_OBJ_D_LOOP|COURSE_DATA_TYPE_D_MASK)
			bne	:+ ; if ((course_data_byte_1 & obj_mask) == rts) {
				inc	eng_loop_flag
			: ; }
			and	#>COURSE_DATA_TYPE_D_OBJ_MASK
			jmp	bg_obj_set_base
		; } else rts;
	: cmp	#<COURSE_DATA_TYPE_C
	bcs	:+++ ; } else if (course_data_type < 0xC) {
		iny
		.if	.defined(VS)
			lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			sta	VS_SR
		.endif
		lda	(course_data_addr), y
		and	#>(COURSE_AREAOBJ_MASK)
		bne	:+ ; if (!(course_data_byte_1 & 0x70)) {
			lda	#(bg_obj_spec_C-bg_obj_tbl)/WORD_SIZE
			sta	BG_OBJ_TBL_OFFSET
	
			lda	(course_data_addr), y
			and	#$0F
			jmp	bg_obj_set_base
		: ; } else {
			sta	BG_OBJ_TBL_BASE
			cmp	#>(COURSE_AREAOBJ_MASK)
			bne	:+
			.if	.defined(VS)
				lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
				sta	VS_SR
			.endif
			lda	(course_data_addr), y
			and	#$08
			beq	:+ ; if (BG_OBJ_TBL_BASE == 0x70 && (course_data_byte_1 & 0x08)) {
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
				sta	VS_SR
			.endif
			lda	(course_data_addr), y
			and	#>COURSE_AREAOBJ_MASK
		: ; }

		lsr	a
		lsr	a
		lsr	a
		lsr	a
	: ; }

bg_obj_set_base:
	sta	BG_OBJ_TBL_BASE

	lda	eng_lenareaobj_0, x
	bpl	:++++
	lda	eng_areaobj_page_loc
	cmp	eng_page_current
	beq	:+
	ldy	eng_area_offset
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_SR
	.endif
	lda	(course_data_addr), y
	and	#<COURSE_DATA_TYPE_MASK
	cmp	#<COURSE_DATA_TYPE_E
	bne	bg_area_decode_rts
	lda	eng_page_cached
	bne	:+++
bg_area_decode_rts:
	; if ((eng_lenareaobj & 0x80) && eng_areaobj_page_loc != eng_page_current && (((course_data_byte_0 & 0xF) != 0xE) || !eng_page_cached)) {
		rts
	: lda	eng_page_cached
	beq	:+ ; } else if (eng_page_cached) {
		lda	#0
		sta	eng_page_cached
		sta	eng_area_bg_flag
		sta	actor_index
	bg_area_decode_rts2:
		rts
	: ; } else {
		ldy	eng_area_offset
		.if	.defined(VS)
			lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
			sta	VS_SR
		.endif
		lda	(course_data_addr), y
		and	#<COURSE_DATA_POSX_MASK
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		cmp	eng_pos_x
		bne	bg_area_decode_rts
	: ; }
	; if () {
		lda	eng_area_offset
		sta	eng_areaobj_offset_0, x
		jsr	bg_buffer_inc
	: ; }

	lda	BG_OBJ_TBL_BASE
	clc
	adc	BG_OBJ_TBL_OFFSET
	jsr	eng_farjump
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
bg_obj_tbl:
bg_obj_norm:
bg_obj_tbl_pipe_vert_a:
	.addr	bg_areaobj_pipe_vert

bg_obj_tbl_ledge:
	.addr	bg_areaobj_ledge

bg_obj_tbl_brickrow:
	.addr	bg_areaobj_brickrow

bg_obj_tbl_floorrow:
	.addr	bg_areaobj_floorrow

bg_obj_tbl_coinrow:
	.addr	bg_areaobj_coinrow

bg_obj_tbl_brickcol:
	.addr	bg_areaobj_brickcol

bg_obj_tbl_floorcol:
	.addr	bg_areaobj_floorcol

bg_obj_tbl_pipe_vert_b:
	.addr	bg_areaobj_pipe_vert

bg_obj_spec_A:
bg_obj_tbl_pit:
	.addr	bg_areaobj_pit

bg_obj_tbl_pulley:
	.addr	bg_areaobj_pulley

bg_obj_tbl_bridge_hi:
	.addr	bg_areaobj_bridge_hi

bg_obj_tbl_bridge_mid:
	.addr	bg_areaobj_bridge_mid

bg_obj_tbl_bridge_lo:
	.addr	bg_areaobj_bridge_lo

bg_obj_tbl_waterhole:
	.addr	bg_areaobj_waterhole

bg_obj_tbl_block_qhi:
	.addr	bg_areaobj_block_qhi

bg_obj_tbl_block_qlo:
	.addr	bg_areaobj_block_qlo

bg_obj_spec_B:
bg_obj_tbl_rope_norm:
	.addr	bg_areaobj_rope_norm

bg_obj_tbl_rope_plat:
	.addr	bg_areaobj_rope_plat

bg_obj_tbl_castle:
	.addr	bg_areaobj_castle

bg_obj_tbl_stairs:
	.addr	bg_areaobj_stairs

bg_obj_tbl_pipe_exit:
	.addr	bg_areaobj_pipe_exit

bg_obj_tbl_pole_tip:
	.addr	bg_areaobj_pole_tip

	.if	.defined(SMB2M)
		.addr	bg_areaobj_C470
		.addr	bg_areaobj_C475
	.endif

bg_obj_spec_C:
bg_obj_tbl_block_q_a:
	.addr	bg_areaobj_block_q

bg_obj_tbl_block_q_b:
	.addr	bg_areaobj_block_q

bg_obj_tbl_block_q_c:
	.addr	bg_areaobj_block_q

	.if	.defined(SMB2)
	bg_obj_tbl_block_q_d:
		.addr	bg_areaobj_block_q
	.endif

bg_obj_tbl_hidden_one_up:
	.addr	bg_areaobj_hidden_one_up

	.if	.defined(SMB2M)
	bg_obj_tbl_block_q_e:
		.addr	bg_areaobj_block_q
	.endif

	.if	.defined(SMB2)
	bg_obj_tbl_block_q_f:
		.addr	bg_areaobj_block_q

	bg_obj_tbl_block_item_e:
		.addr	bg_areaobj_block_item
	.endif

bg_obj_tbl_block_item_a:
	.addr	bg_areaobj_block_item

bg_obj_tbl_block_item_b:
	.addr	bg_areaobj_block_item

bg_obj_tbl_block_item_c:
	.addr	bg_areaobj_block_item

bg_obj_tbl_block_coin:
	.addr	bg_areaobj_block_coin

bg_obj_tbl_block_item_d:
	.addr	bg_areaobj_block_item

bg_obj_tbl_pipe_water:
	.addr	bg_areaobj_pipe_water

bg_obj_tbl_empty_draw:
	.addr	bg_areaobj_empty_draw

bg_obj_tbl_spring:
	.addr	bg_areaobj_spring

bg_obj_spec_D:
bg_obj_tbl_pipe_intro:
	.addr	bg_areaobj_pipe_intro
bg_obj_tbl_pole:
	.addr	bg_areaobj_pole
bg_obj_tbl_castle_bridge_axe:
	.addr	bg_areaobj_castle_bridge_axe
bg_obj_tbl_castle_bridge_draw:
	.addr	bg_areaobj_castle_bridge_draw
bg_obj_tbl_castle_bridge:
	.addr	bg_areaobj_castle_bridge
bg_obj_tbl_lock_warp:
	.addr	bg_areaobj_lock_warp
bg_obj_tbl_lock_end:
	.addr	bg_areaobj_lock
bg_obj_tbl_lock_start:
	.addr	bg_areaobj_lock
bg_obj_tbl_swarm_a:
	.addr	bg_areaobj_swarm
bg_obj_tbl_swarm_b:
	.addr	bg_areaobj_swarm
bg_obj_tbl_swarm_c:
	.addr	bg_areaobj_swarm
bg_obj_tbl_decode_rts:
	.addr	bg_area_decode_rts2

	.if	.defined(SMB2)
		.addr	bg_areaobj_C5BE
		.addr	bg_areaobj_C5C2
	.endif

bg_obj_tbl_set_attr:
	.addr	bg_areaobj_set_attr
; ------------------------------------------------------------
bg_areaobj_set_attr:
	ldy	eng_areaobj_offset_0, x
	iny
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_SR
	.endif
	lda	(course_data_addr), y
	pha
	and	#$40
	bne	:+ ; if ((course_data_byte_1 & 0x40)) {
		pla
		pha
		and	#$0F
		sta	course_fg_mask_id
		pla
		and	#$30
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		sta	course_bg_id
		rts
	: ; } else {
		pla
		and	#$07
		cmp	#4
		bcc	:+ ; if ((eng_area_data_byte_1 & 0x7) >= 4) {
			sta	course_bg_col
			lda	#COURSE_DATA_FG_NONE_VAL
		: ; }
		sta	course_fg_id
		rts
	; }
; -----------------------------
bg_areaobj_lock_warp:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldx	#4
	.elseif	.defined(SMB2M)
		ldx	#$80
		lda	byte_7FB
		bne	bg_areaobj_lock_warp_7FB_set
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

			bg_areaobj_lock_warp_7FB_set:
				ldx	#$84
				lda	course_no
				bne	:+ ; if (course_no == no_01) {
					dex
					ldy	eng_goals
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
		bne	:+++ ; if (!byte_7FB && course_no == no_01) {
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
			jmp	bg_areaobj_lock_warp_load
		bg_areaobj_lock_warp_7FB_set: ; } else if (byte_7FB) {
			lda	#$87
			clc
			adc	eng_goals
			bne	bg_areaobj_lock_warp_do
		: ; } else {
			ldx	#$83
			lda	course_no
			cmp	#course::no_03
			beq	bg_areaobj_lock_warp_load ; if (course != no_03) {
				inx
				cmp	#course::no_05
				bne	:+
				lda	course_page_offset
				cmp	#$0B
				beq	bg_areaobj_lock_warp_load
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

		bg_areaobj_lock_warp_load: ; if (!byte_7FB) {
			txa
		bg_areaobj_lock_warp_do: ; }
	.endif
	sta	eng_warp_ctrl

	.if	.defined(SMB)|.defined(VS_SMB)
		jsr	screen_text_draw
	.elseif	.defined(SMB2M)
		jsr	screen_text_draw_over
	.endif

	lda	#actor::piranha_plant
	jsr	bg_actor_kill

bg_areaobj_lock:
	lda	eng_scroll_lock
	eor	#$01
	sta	eng_scroll_lock
	rts
; -----------------------------
bg_actor_kill:
	sta	zp_byte_00
	lda	#actor_mode::dead
	ldx	#ENG_ACTOR_MAX-2
	: ; for (entry of actor_id) {
		ldy	actor_id, x
		cpy	zp_byte_00
		bne	:+ ; if (actor_id == zp_byte_00) {
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

bg_areaobj_swarm:
	ldx	zp_byte_00
	lda	bg_swarm_ids-8, x
	ldy	#6-1
	: ; for (y = 6-1; y > 0; y--) {
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
	.export bg_areaobj_ledge_tbl
	.export bg_areaobj_ledge_tbl_tree
	.export bg_areaobj_ledge_tbl_mushroom
	.export bg_areaobj_ledge_tbl_cannon
bg_areaobj_ledge:
	lda	course_ledge_type
	jsr	eng_farjump

bg_areaobj_ledge_tbl:
bg_areaobj_ledge_tbl_tree:
	.addr	bg_areaobj_ledge_tree

bg_areaobj_ledge_tbl_mushroom:
	.addr	bg_areaobj_ledge_mushroom

bg_areaobj_ledge_tbl_cannon:
	.addr	bg_areaobj_cannon
; --------------
bg_areaobj_ledge_tree:
	jsr	eng_loadobjattr
	lda	eng_lenareaobj_0, x
	beq	:++	
	bpl	:+ ; if (eng_lenareaobj) {
		; if (eng_lenareaobj_bit_7) {
			tya
			sta	eng_lenareaobj_0, x
			lda	eng_page_current
			ora	eng_pos_x
			beq	:+ ; if (eng_page_current|eng_pos_x) {
				lda	#$16
				jmp	bg_areaobj_ledge_no_base
			; }
		: ; }

		ldx	BG_PROC_METATILE_ID
		lda	#$17
		sta	tbl_metatile_b, x
		lda	#$4C
		jmp	bg_areaobj_ledge_base
	: ; } else {
		lda	#$18
		jmp	bg_areaobj_ledge_no_base
	; }
; --------------
bg_areaobj_ledge_mushroom:
	jsr	eng_loadobjlen
	sty	zp_byte_06
	bcc	:+ ; if (eng_loadobjlen()) {
		lda	eng_lenareaobj_0, x
		lsr	a
		sta	eng_ledge_dims, x
		lda	#LEDGE_MUSHROOM_TILE_A
		jmp	bg_areaobj_ledge_no_base
	: ; } else {
		lda	#LEDGE_MUSHROOM_TILE_C
		ldy	eng_lenareaobj_0, x
		beq	bg_areaobj_ledge_no_base ; if (eng_lenareaobj) {
			lda	eng_ledge_dims, x
			sta	zp_byte_06
			ldx	BG_PROC_METATILE_ID
			lda	#LEDGE_MUSHROOM_TILE_B
			sta	tbl_metatile_b, x
			.if	.defined(SMBM)|.defined(VS_SMB)
				cpy	zp_byte_06
				bne	bg_areaobj_pulley_rts ; if (eng_lenareaobj == tbl_736_obj) {
					inx
					lda	#$4F
					sta	tbl_metatile_b, x
					lda	#$50
			.elseif	.defined(SMB2)
				rts
			.endif

			bg_areaobj_ledge_base:
				inx
				ldy	#$0F
				jmp	bg_objrenderbase
			; } else rts;
		; }
	; }

bg_areaobj_ledge_no_base:
	ldx	BG_PROC_METATILE_ID
	ldy	#0
	jmp	bg_objrenderbase
; -----------------------------
bg_areaobj_pulley_tiles:
	.byte	$42, $41, $43
; --------------
bg_areaobj_pulley:
	jsr	eng_loadobjlen
	ldy	#0
	bcs	:+ ; if (!eng_loadobjlen()) {
		iny

		lda	eng_lenareaobj_0, x
		bne	:+ ; if (!eng_lenareaobj) {
			iny
		; }
	: ; }
	lda	bg_areaobj_pulley_tiles, y
	sta	tbl_metatile_b

bg_areaobj_pulley_rts:
	rts
; -----------------------------
bg_areaobj_castle_tiles:
	.byte	$00, $45, $45, $45, $00
	.byte	$00, $48, $47, $46, $00
	.byte	$45, $49, $49, $49, $45
	.byte	$47, $47, $4A, $47, $47
	.byte	$47, $47, $4B, $47, $47
	.byte	$49, $49, $49, $49, $49
	.byte	$47, $4A, $47, $4A, $47
	.byte	$47, $4B, $47, $4B, $47
	.byte	$47, $47, $47, $47, $47
	.byte	$4A, $47, $4A, $47, $4A
	.byte	$4B, $47, $4B, $47, $4B
; --------------
bg_areaobj_castle:
	jsr	eng_loadobjattr
	sty	zp_byte_07
	ldy	#4
	jsr	eng_loadobjlen_b
	txa
	pha

	ldy	eng_lenareaobj_0, x
	ldx	zp_byte_07
	lda	#$0B
	sta	zp_byte_06
	: ; for (x = zp_byte_07, i = 0x0B; x < 0x0B; x++, i--, y += 5) {
		lda	bg_areaobj_castle_tiles, y
		sta	tbl_metatile_b, x

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
		cpx	#$0B
		bne	:--
	; }

	pla
	tax
	lda	eng_page_current
	beq	:+++ ; if (eng_page_current) {
		lda	eng_lenareaobj_0, x
		cmp	#1
		beq	:++
		ldy	zp_byte_07
		bne	:+
		cmp	#3
		beq	:++
		: cmp	#2
		bne	:++ ; if (eng_lenareaobj == 2) {
			jsr	bg_objpos_x_get
			pha

			jsr	bg_obj_alloc

			pla
			sta	eng_actor_pos_x_lo, x
			lda	eng_page_current
			sta	eng_actor_pos_x_hi, x
			lda	#$01
			sta	eng_actor_pos_y_hi, x
			sta	actor_mode, x
			lda	#$90
			sta	eng_actor_pos_y_lo, x
			lda	#actor::flag_victory
			sta	actor_id, x
			rts
		: ; } else if (eng_lenareaobj == 1 || (zp_byte_07 && eng_lenareaobj != 2) || eng_lenareaobj == 3) {
			ldy	#FG_BASE_TILE_C
			sty	tbl_metatile_b_0A
		; }
	: ; }

	rts
; -----------------------------
bg_areaobj_pipe_water:
	jsr	eng_loadobjattr
	ldy	eng_lenareaobj_0, x
	ldx	BG_PROC_METATILE_ID
	lda	#PIPE_WATER_TILE_A
	sta	tbl_metatile_b_00, x
	lda	#PIPE_WATER_TILE_B
	sta	tbl_metatile_b_01, x
	rts
; -----------------------------
BG_AREAOBJ_PIPE_SIZE	= 7

bg_areaobj_pipe_intro:
	ldy	#3
	jsr	eng_loadobjlen_b
	ldy	#$0A
	jsr	bg_areaobj_pipe_horiz
	bcs	:++ ; if (!bg_areaobj_pipe_horiz()) {
		ldx	#BG_AREAOBJ_PIPE_SIZE-1
		: ; for (tile of bg_areaobj_pipe) {
			lda	#0
			sta	tbl_metatile_b, x

			dex
			bpl	:-
		; }

		lda	bg_areaobj_pipe_v_tiles, y
		sta	tbl_metatile_b+BG_AREAOBJ_PIPE_SIZE
	: ; }

	rts
; --------------
bg_areaobj_pipe_horiz_m:
	.byte	PIPE_TILE_BASE
	.byte	PIPE_TILE_M_B
	.byte	0
	.byte	0
bg_areaobj_pipe_horiz_t:
	.byte	PIPE_TILE_BASE
	.byte	PIPE_TILE_T_B
	.byte	PIPE_TILE_T_C
	.byte	PIPE_TILE_T_D
bg_areaobj_pipe_horiz_b:
	.byte	PIPE_TILE_BASE
	.byte	PIPE_TILE_B_B
	.byte	PIPE_TILE_B_C
	.byte	PIPE_TILE_B_D
; --------------
bg_areaobj_pipe_exit:
	ldy	#3
	jsr	eng_loadobjlen_b
	jsr	eng_loadobjattr

bg_areaobj_pipe_horiz:
	dey
	dey
	sty	zp_byte_05
	ldy	eng_lenareaobj_0, x
	sty	zp_byte_06
	ldx	zp_byte_05
	inx
	lda	bg_areaobj_pipe_horiz_m, y
	cmp	#0
	beq	:+ ; if (bg_reaobj_pipe_horiz_m[eng_lenareaobj]) {
		ldx	#0
		ldy	zp_byte_05
		jsr	bg_objrenderbase
		clc
	: ; }

	ldy	zp_byte_06
	lda	bg_areaobj_pipe_horiz_t, y
	sta	tbl_metatile_b, x
	lda	bg_areaobj_pipe_horiz_b, y
	sta	tbl_metatile_b+1, x
	rts
; --------------
bg_areaobj_pipe_v_tiles:
	.byte	$11, $10
	.byte	$15, $14
	.byte	$13, $12
	.byte	$15, $14
; --------------
bg_areaobj_pipe_vert:
	jsr	bg_areaobj_pipe_h
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

	ldy	eng_lenareaobj_0, x
	beq	:+
	jsr	bg_obj_alloc
	bcs	:+ ; if ((course_sub|course_no) && eng_lenareaobj && !bg_obj_alloc()) {
		.if	.defined(SMB)|.defined(VS_SMB)
			jsr	bg_objpos_x_get
			clc
			adc	#8
			sta	eng_actor_pos_x_lo, x
			lda	eng_page_current
			adc	#0
			sta	eng_actor_pos_x_hi, x
			lda	#1
			sta	eng_actor_pos_y_hi, x
			sta	actor_mode, x
			jsr	bg_objpos_y_get
			sta	eng_actor_pos_y_lo, x
		.elseif	.defined(ANN)
			lda	course_no
			ora	course_sub
			ora	byte_7FB
			beq	:+
		.endif

		lda	#actor::piranha_plant

		.if	.defined(SMB)|.defined(VS_SMB)
			sta	actor_id, x
			jsr	eng_piranha_plant_init
		.elseif	.defined(SMB2M)
			jsr	bg_areaobj_pipe_vert_plant
		.endif
	: ; }

	pla
	tay
	ldx	BG_PROC_METATILE_ID
	lda	bg_areaobj_pipe_v_tiles, y
	sta	tbl_metatile_b, x
	inx
	lda	bg_areaobj_pipe_v_tiles+2, y
	ldy	zp_byte_06
	dey
	jmp	bg_objrenderbase
; --------------
bg_areaobj_pipe_h:
	ldy	#1
	jsr	eng_loadobjlen_b
	jsr	eng_loadobjattr
	tya
	and	#$07
	sta	zp_byte_06
	ldy	eng_lenareaobj_0, x
	rts
; -------------
.if	.defined(SMB2M)
bg_areaobj_pipe_vert_plant:
	sta	actor_id, x
	jsr	bg_objpos_x_get
	clc
	adc	#8
	sta	eng_actor_pos_x_lo, x
	lda	eng_page_current
	adc	#0
	sta	eng_actor_pos_x_hi, x
	lda	#1
	sta	eng_actor_pos_y_hi, x
	sta	actor_mode, x
	jsr	bg_objpos_y_get
	sta	eng_actor_pos_y_lo, x
	jmp	eng_piranha_plant_init
.endif
; -----------------------------
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
bg_areaobj_waterhole:
	jsr	eng_loadobjlen
	lda	#$86
	sta	tbl_metatile_b_0A
	ldx	#$0B
	ldy	#1
	lda	#$87
	jmp	bg_objrenderbase
; -----------------------------
bg_areaobj_block_qhi:
	lda	#3
.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	bg_areaobj_block_q_row
.endif

bg_areaobj_block_qlo:
	lda	#7

bg_areaobj_block_q_row:
	pha

	jsr	eng_loadobjlen

	pla
	tax
	lda	#$C0
	sta	tbl_metatile_b, x
	rts
; -----------------------------
bg_areaobj_bridge_hi:
	lda	#6
.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	bg_areaobj_bridge
.endif

bg_areaobj_bridge_mid:
	lda	#7
.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	bg_areaobj_bridge
.endif

bg_areaobj_bridge_lo:
	lda	#9

bg_areaobj_bridge:
	pha

	jsr	eng_loadobjlen

	pla
	tax
	lda	#$0B
	sta	tbl_metatile_b, x
	inx
	ldy	#0
	lda	#BRIDGE_TILE
	jmp	bg_objrenderbase
; -----------------------------
bg_areaobj_pole_tip:
	jsr	eng_loadobjattr
	ldx	#2
	lda	#POLE_TIP_TILE
	jmp	bg_objrenderbase
; --------------
bg_areaobj_pole:
	lda	#POLE_TILE_A
	sta	tbl_metatile_b
	ldx	#1
	ldy	#8
	lda	#POLE_TILE_B
	jsr	bg_objrenderbase
	lda	#POLE_TILE_C
	sta	tbl_metatile_b_0A
	jsr	bg_objpos_x_get
	sec
	sbc	#8
	sta	eng_actor_pos_x_lo+ENG_ACTOR_MAX-1
	lda	eng_page_current
	sbc	#0
	sta	eng_actor_pos_x_hi+ENG_ACTOR_MAX-1
	lda	#$30
	sta	eng_actor_pos_y_lo+ENG_ACTOR_MAX-1
	lda	#$B0
	sta	STACK_BASE+$0D
	lda	#actor::flag_enemy
	sta	actor_id+ENG_ACTOR_MAX-1
	inc	actor_mode+ENG_ACTOR_MAX-1
	rts
; -----------------------------
bg_areaobj_rope_norm:
	ldx	#0
	ldy	#$0F
	jmp	bg_areaobj_rope_draw

bg_areaobj_rope_plat:
	txa
	pha

	ldx	#1
	ldy	#$0F
	lda	#$44
	jsr	bg_objrenderbase

	pla
	tax
	jsr	eng_loadobjattr
	ldx	#1

bg_areaobj_rope_draw:
	lda	#$40
	jmp	bg_objrenderbase
; -----------------------------
bg_areaobj_coinrow_tiles:
	.byte	COINROW_TILE_B
	.byte	COINROW_TILE_A
	.byte	COINROW_TILE_A
	.byte	COINROW_TILE_A
; --------------
bg_areaobj_coinrow:
	ldy	course_type
	lda	bg_areaobj_coinrow_tiles, y
	jmp	bg_areaobj_get_row
; -----------------------------
bg_areaobj_castle_bridge_data:
	.byte	$06, $07, $08
bg_areaobj_castle_bridge_tiles:
	.byte	CASTLE_BRIDGE_TILE_B, $0C, $89
; --------------
bg_areaobj_castle_bridge:
	ldy	#$0C
	jsr	eng_loadobjlen_b
	jmp	bg_areaobj_castle_bridge_draw

bg_areaobj_castle_bridge_axe:
	lda	#nmi_addr::pal_bowser
	sta	nmi_addrs_ctl

bg_areaobj_castle_bridge_draw:
	ldy	zp_byte_00
	ldx	bg_areaobj_castle_bridge_data-2, y
	lda	bg_areaobj_castle_bridge_tiles-2, y
	jmp	bg_areaobj_castle_bridge_draw_do

bg_areaobj_empty_draw:
	jsr	eng_loadobjattr
	ldx	BG_PROC_METATILE_ID
	lda	#CASTLE_BRIDGE_TILE_A

bg_areaobj_castle_bridge_draw_do:
	ldy	#0
	jmp	bg_objrenderbase
; -----------------------------
bg_areaobj_floor_tiles:
	.byte	FG_BASE_TILE_A
	.byte	POLE_TILE_C
	.byte	POLE_TILE_C
	.byte	FG_BASE_TILE_D
bg_areaobj_brick_tiles:
	.byte	BRICK_TILE_A
	.byte	BRICK_TILE_B
	.byte	FG_BASE_TILE_C
	.byte	FG_BASE_TILE_C
	.byte	$88
; --------------
bg_areaobj_brickrow:
	ldy	course_type
	lda	course_type_cloud
	beq	:+ ; if (course_type == cloud) {
		ldy	#course_types::cloud
	: ; }
	lda	bg_areaobj_brick_tiles, y
	jmp	bg_areaobj_get_row

bg_areaobj_floorrow:
	ldy	course_type
	lda	bg_areaobj_floor_tiles, y
bg_areaobj_get_row:
	pha

	jsr	eng_loadobjlen
bg_areaobj_draw_row:
	ldx	BG_PROC_METATILE_ID
	ldy	#0

	pla
	jmp	bg_objrenderbase

bg_areaobj_brickcol:
	ldy	course_type
	lda	bg_areaobj_brick_tiles, y
	jmp	bg_areaobj_get_col

bg_areaobj_floorcol:
	ldy	course_type
	lda	bg_areaobj_floor_tiles, y
bg_areaobj_get_col:
	pha

	jsr	eng_loadobjattr

	pla
	ldx	BG_PROC_METATILE_ID
	jmp	bg_objrenderbase
; -----------------------------
bg_areaobj_cannon:
	jsr	eng_loadobjattr
	ldx	BG_PROC_METATILE_ID

	lda	#CANNON_TILE_A
	sta	tbl_metatile_b, x
	inx
	dey
	bmi	:+ ; if (--y >= 0) {
		lda	#CANNON_TILE_B
		sta	tbl_metatile_b, x
		inx
		dey
		bmi	:+ ; if (--y >= 0) {
			lda	#CANNON_TILE_C
			jsr	bg_objrenderbase
		; }
	: ; }

	ldx	eng_cannon_offset
	jsr	bg_objpos_y_get
	sta	eng_cannon_pos_y_lo, x
	lda	eng_page_current
	sta	eng_cannon_pos_y_hi, x
	jsr	bg_objpos_x_get
	sta	eng_cannon_pos_x_lo, x
	inx
	cpx	#6
	bcc	:+ ; if (x >= 6) {
		ldx	#0
	: ; }
	stx	eng_cannon_offset
	rts
; -----------------------------
bg_areaobj_stairs_height:
	.byte	7, 7, 6, 5, 4, 3, 2, 1, 0
bg_areaobj_stairs_row:
	.byte	3, 3, 4, 5, 6, 7, 8, 9, 10
; --------------
bg_areaobj_stairs:
	jsr	eng_loadobjlen
	bcc	:+ ; if (eng_loadobjlen()) {
		lda	#9
		sta	eng_step_no
	: ; }

	dec	eng_step_no
	ldy	eng_step_no
	ldx	bg_areaobj_stairs_row, y
	lda	bg_areaobj_stairs_height, y
	tay
	lda	#POLE_TILE_C
	jmp	bg_objrenderbase
; -----------------------------
bg_areaobj_spring:
	jsr	eng_loadobjattr
	jsr	bg_obj_alloc
		.if	.defined(VS_SMB)|.defined(SMB2M)
		bcs	:+ ; if () {
		.endif
		jsr	bg_objpos_x_get
		sta	eng_actor_pos_x_lo, x
		lda	eng_page_current
		sta	eng_actor_pos_x_hi, x
		jsr	bg_objpos_y_get
		sta	eng_actor_pos_y_lo, x
		sta	eng_actor_veloc_x, x
		lda	#actor::jump_spring
		sta	actor_id, x
		ldy	#1
		sty	eng_actor_pos_y_hi, x
		inc	actor_mode, x
		ldx	BG_PROC_METATILE_ID
		lda	#SPRING_TILE_A
		sta	tbl_metatile_b, x
		lda	#SPRING_TILE_B
		sta	tbl_metatile_b+1, x
		.if	.defined(VS_SMB)|.defined(SMB2M)
		: ; }
		.endif
	rts
; -----------------------------
bg_areaobj_hidden_one_up:
	lda	eng_hidden_one_up
	beq	bg_areaobj_block_rts
	lda	#0
	sta	eng_hidden_one_up
	jmp	bg_areaobj_block_item

bg_areaobj_block_q:
	jsr	bg_areaobj_block_id
	jmp	bg_areaobj_block_draw

bg_areaobj_block_coin:
	lda	#0
	sta	eng_block_time

bg_areaobj_block_item:
	jsr	bg_areaobj_block_id
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

bg_areaobj_block_draw:
	lda	obj_spec_block_tiles, y
	pha
	jsr	eng_loadobjattr
	jmp	bg_areaobj_draw_row
; --------------
bg_areaobj_block_id:
	lda	zp_byte_00
	sec
	sbc	#0
	tay

bg_areaobj_block_rts:
	rts
; -----------------------------
bg_areaobj_pit_tiles:
	.byte	$87, $00, $00, $00
; --------------
bg_areaobj_pit:
	jsr	eng_loadobjlen
	bcc	:++
	lda	course_type
	bne	:++ ; if (eng_loadobjlen() && course_type == water) {
		ldx	eng_cannon_offset
		jsr	bg_objpos_x_get
		sec
		sbc	#$10
		sta	eng_cannon_pos_x_lo, x
		lda	eng_page_current
		sbc	#0
		sta	eng_cannon_pos_y_hi, x
		iny
		iny
		tya
		asl	a
		asl	a
		asl	a
		asl	a
		sta	eng_cannon_pos_y_lo, x
		inx
		cpx	#5
		bcc	:+ ; if (x >= 5) {
			ldx	#0
		: ; }
		stx	eng_cannon_offset
	: ; }

	ldx	course_type
	lda	bg_areaobj_pit_tiles, x
	ldx	#8
	ldy	#$0F
; -----------------------------
bg_objrenderbase:
	: ; for (x = metatile_base_id, y = eng_obj_height; x >= 0xD && y >= 0; x++, y--) {
		sty	eng_obj_height
		ldy	tbl_metatile_b, x
		beq	:+
		cpy	#$17
		beq	:++
		cpy	#LEDGE_MUSHROOM_TILE_B
		beq	:++
		cpy	#$C0
		beq	:+
		cpy	#$C0
		bcs	:++
		.if	.defined(SMBM)|.defined(VS_SMB)
			cpy	#FG_BASE_TILE_B
			bne	:+
			cmp	#$50
			beq	:++
		.endif
		: ; if (metatile == 0 || (metatile.not_in(0x17, 0x1A) && (metatile == 0xC0 || (metatile < 0xC0 && (metatile != 0x54 || a != 0x50))))) {
			sta	tbl_metatile_b, x
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
eng_loadobjlen:
	jsr	eng_loadobjattr

eng_loadobjlen_b:
	lda	eng_lenareaobj_0, x
	clc
	bpl	:+ ; if () {
		tya
		sta	eng_lenareaobj_0, x
		sec
	: ; }

	rts
; -----------------------------
eng_loadobjattr:
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_SR
	.endif
	ldy	eng_areaobj_offset_0, x
	lda	(course_data_addr), y
	and	#$0F
	sta	BG_PROC_METATILE_ID
	iny
	lda	(course_data_addr), y
	and	#$0F
	tay
	rts
; -----------------------------
bg_objpos_x_get:
	lda	eng_pos_x
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
	and	#$0F
	clc
	adc	bg_buffer_ptr_lo, y
	sta	eng_buffer_ptr
	rts
; -----------------------------
.if	.defined(FC_SMB)
	.res	2, $FF
.elseif	.defined(VS_SMB)
	.res	55, $FF
.endif
