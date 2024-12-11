.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
bg_scenery_castle_bridge_data:
	.byte	$06, $07, $08
bg_scenery_castle_bridge_tiles:
	.byte	metatile_3::axe
	.byte	metatile_0::chain
	.byte	metatile_2::bridge_castle
; --------------
        .export bg_scenery_castle_bridge
        .export bg_scenery_castle_bridge_axe
        .export bg_scenery_castle_bridge_draw
        .export bg_scenery_empty_draw
bg_scenery_castle_bridge:
	ldy	#$0C
	jsr	bg_scenery_len_b
	jmp	bg_scenery_castle_bridge_draw

bg_scenery_castle_bridge_axe:
	lda	#nmi_addr::pal_bowser
	sta	nmi_buffer_ptr

bg_scenery_castle_bridge_draw:
	ldy	zp_byte_00
	ldx	bg_scenery_castle_bridge_data-2, y
	lda	bg_scenery_castle_bridge_tiles-2, y
	jmp	bg_scenery_castle_bridge_draw_do

bg_scenery_empty_draw:
	jsr	bg_scenery_attr
	ldx	bg_proc_metatile_id
	lda	#metatile_3::block_invis

bg_scenery_castle_bridge_draw_do:
	ldy	#0
	jmp	bg_scenery_render
