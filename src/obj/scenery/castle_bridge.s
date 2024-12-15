.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"
.include	"tunables.i"
.include	"tiles.i"

; -----------------------------
scenery_castle_bridge_data:
	.byte	$06, $07, $08
scenery_castle_bridge_tiles:
	.byte	metatile_3::axe
	.byte	metatile_0::chain
	.byte	metatile_2::bridge_castle
; --------------
        .export scenery_castle_bridge
        .export scenery_castle_bridge_axe
        .export scenery_castle_bridge_draw
        .export scenery_empty_draw
scenery_castle_bridge:
	ldy	#$0C
	jsr	scenery_len_b
	jmp	scenery_castle_bridge_draw

scenery_castle_bridge_axe:
	lda	#nmi_addr::pal_bowser
	sta	nmi_buffer_ptr

scenery_castle_bridge_draw:
	ldy	zp_byte_00
	ldx	scenery_castle_bridge_data-2, y
	lda	scenery_castle_bridge_tiles-2, y
	jmp	scenery_castle_bridge_draw_do

scenery_empty_draw:
	jsr	scenery_attr
	ldx	scenery_proc_metatile_id
	lda	#metatile_3::block_invis

scenery_castle_bridge_draw_do:
	ldy	#0
	jmp	scenery_render
