.include	"system/cpu.i"

.include	"engine/mem.i"
.include	"engine/course_flags.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

.if	.defined(CONS)
.define	COURSE_ACTOR_DATA_ADDR_LO	course_actor_addr_lo,y
.define COURSE_ACTOR_DATA_ADDR_HI	course_actor_addr_hi,y
.define COURSE_SCENERY_DATA_ADDR_LO	course_scenery_addr_lo,y
.define COURSE_SCENERY_DATA_ADDR_HI	course_scenery_addr_hi,y
.elseif	.defined(VS)
.define COURSE_ACTOR_DATA_ADDR_LO	#<vs_actor_data
.define COURSE_ACTOR_DATA_ADDR_HI	#>vs_actor_data
.define COURSE_SCENERY_DATA_ADDR_LO	#<vs_scenery_data
.define COURSE_SCENERY_DATA_ADDR_HI	#>vs_scenery_data
.endif

; ------------------------------------------------------------
	.export course_descriptor_get
course_descriptor_get:
	ldy	course_no
	lda	courses_world_offsets, y
	clc
	adc	course_sub
	tay
	lda	courses_area_offsets, y
	rts
; ------------------------------------------------------------
	.export	course_load
course_load:
	.if	.defined(VS)
		jsr	vs_setbank_low
		lda	#vs_req::chr_high|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
		lda	PPU_SR
		lda	zp_addr_00
		sta	PPU_VRAM_AR
		lda	zp_addr_00
		sta	PPU_VRAM_AR
	
		ldy	#0
		lda	PPU_VRAM_IO
		: ; for (y = 0; y < 0x20; y++) {
			lda	PPU_VRAM_IO
			sta	VS_RAM, y
	
			iny
			cpy	#$20
			bne	:-
		; }
	.endif

	lda	course_descriptor
	jsr	course_type_get
	tay

	lda	course_descriptor
	and	#(COURSE_AREA_OFFSET_MAX<<COURSE_DESC_PAGE_BIT)
	sta	course_page_offset

	lda	course_actor_pages, y
	clc
	adc	course_page_offset
	.if	.defined(VS_SMB)
		asl	a
	.endif
	tay

	.if	.defined(VS)
		lda	PPU_SR
		lda	course_actor_addr_lo+1, y
		sta	PPU_VRAM_AR
		lda	course_actor_addr_lo, y
		sta	PPU_VRAM_AR
	
		ldy	#0
		lda	PPU_VRAM_IO
		: ; for (y = 0; vs_actor_data[y] != COURSE_ACTORS_END; y++) {
			lda	PPU_VRAM_IO
			sta	vs_actor_data, y
	
			iny
			cmp	#COURSE_ACTORS_END
			bne	:-
		; }
	.endif

	lda	COURSE_ACTOR_DATA_ADDR_LO
	sta	course_actor_addr
	lda	COURSE_ACTOR_DATA_ADDR_HI
	sta	course_actor_addr+1

	ldy	course_type
	lda	course_scenery_pages, y
	clc
	adc	course_page_offset
	.if	.defined(VS_SMB)
		asl	a
	.endif
	tay

	.if	.defined(VS)
		lda	PPU_SR
		lda	course_scenery_addr_lo+1, y
		sta	PPU_VRAM_AR
		lda	course_scenery_addr_lo, y
		sta	PPU_VRAM_AR
	
		ldy	#0
		lda	PPU_VRAM_IO
		: ; for (y = 0; vs_scenery_data[y] != COURSE_SCENERY_END) {
			lda	PPU_VRAM_IO
			sta	vs_scenery_data, y
	
			iny
			cmp	#COURSE_SCENERY_END
			bne	:-
		; }
	.endif

	lda	COURSE_SCENERY_DATA_ADDR_LO
	sta	course_scenery_addr
	lda	COURSE_SCENERY_DATA_ADDR_HI
	sta	course_scenery_addr+1

	ldy	#0
	lda	(course_scenery_addr), y
	pha

	and	#(COURSE_SCENERY_BG_COL_MAX<<COURSE_SCENERY_FG_BG_SHIFT)
	cmp	#(COURSE_SCENERY_FG_MAX+1)
	bcc	:+ ; if ((course_scenery_addr.data_bg_fg) >= (COURSE_SCENERY_FG_MAX+1)) {
		sta	course_bg_col
		lda	#COURSE_SCENERY_FG_NONE
	: ; }
	sta	course_fg_id

	pla
	pha

	and	#(COURSE_SCENERY_ENTER_POS_MAX<<COURSE_SCENERY_ENTER_POS_SHIFT)
	lsr	a
	lsr	a
	lsr	a
	sta	course_enter_pos

	pla
	and	#(COURSE_TIMER_SETTING_MAX<<COURSE_TIMER_SETTING_SHIFT)
	clc
	rol	a
	rol	a
	rol	a
	sta	course_timer_setting

	iny
	lda	(course_scenery_addr), y
	pha

	and	#(COURSE_FG_MASK_MAX<<(COURSE_FG_MASK_SHIFT-8))
	sta	course_fg_mask_id

	pla
	pha

	and	#(COURSE_BG_MAX<<(COURSE_BG_SHIFT-8))
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	sta	course_bg_id

	pla
	and	#(COURSE_AREA_LEDGE_MAX<<(COURSE_AREA_LEDGE_SHIFT-8))
	clc
	rol	a
	rol	a
	rol	a
	cmp	#COURSE_AREA_LEDGE_CLOUD_VAL
	bne	:+ ; if (ledge_type == CLOUD) {
		sta	course_type_cloud
		lda	#COURSE_AREA_LEDGE_TREE_VAL
	: ; }
	sta	course_ledge_type

	lda	course_scenery_addr
	clc
	adc	#<WORD_SIZE
	sta	course_scenery_addr
	lda	course_scenery_addr+1
	adc	#>WORD_SIZE
	sta	course_scenery_addr+1
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif
	rts
; ---------------------------------------
	.export courses_world_offsets, courses_area_offsets
courses_world_offsets:
	.byte	course_01_areas-courses_area_offsets
	.byte	course_02_areas-courses_area_offsets
	.byte	course_03_areas-courses_area_offsets
	.byte	course_04_areas-courses_area_offsets
	.byte	course_05_areas-courses_area_offsets
	.byte	course_06_areas-courses_area_offsets
	.byte	course_07_areas-courses_area_offsets
	.byte	course_08_areas-courses_area_offsets
; --------------
courses_area_offsets:
course_01_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_06
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
		.byte	COURSE_TYPE_UNDERGROUND_B|(%100)<<5|course_underground::no_01
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_07
	.if	.defined(SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_07_vs
	.endif

course_02_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_09
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
		.byte	COURSE_TYPE_WATER_B|course_water::no_02
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_08
	.if	.defined(SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_03
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01
	.endif

course_03_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_05
	.if	.defined(SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_22
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_22_vs
	.endif
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_01
	.byte	COURSE_TYPE_CASTLE_B|course_castle::no_04

course_04_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_03
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
		.byte	COURSE_TYPE_UNDERGROUND_B|course_underground::no_02
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_13
	.if	.defined(SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_02
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_03
	.endif

course_05_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_11
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_18
	.if	.defined(SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_07
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_03
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_14
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_02
	.endif

course_06_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_15
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_04
	.if	.defined(SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_14
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01
	.elseif	.defined(VS_SMB)
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_07_vs
		.byte	COURSE_TYPE_CASTLE_B|course_castle::no_01_vs
	.endif

course_07_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_20
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_10
	.if	.defined(SMB)
			.byte	COURSE_TYPE_WATER_B|course_water::no_02
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_08
	.elseif	.defined(VS_SMB)
			.byte	COURSE_TYPE_WATER_B|course_water::no_02_vs
		.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_08_vs
	.endif
	.byte	COURSE_TYPE_CASTLE_B|course_castle::no_05

course_08_areas:
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_17
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_19
	.byte	COURSE_TYPE_OVERWORLD_B|course_overworld::no_02
	.byte	COURSE_TYPE_CASTLE_B|course_castle::no_06
; -----------------------------
.if	.defined(CONS)
	COURSE_OFFSET_INC_SIZE	= 1
.elseif	.defined(VS)
	COURSE_OFFSET_INC_SIZE	= WORD_SIZE
.endif
course_actor_pages:
	.byte	(course_actor_addr_lo_water-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_overworld-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_underground-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_actor_addr_lo_castle-course_actor_addr_lo)/COURSE_OFFSET_INC_SIZE

.if	.defined(CONS)
	course_actor_addr_lo:
	course_actor_addr_lo_castle:
		.if	.defined(SMB)
			.byte	<course_actor_castle_1
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_castle_1_vs
		.endif
		.byte	<course_actor_castle_2
		.if	.defined(SMB)
			.byte	<course_actor_castle_3
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_castle_1
		.endif
		.byte	<course_actor_castle_4
		.byte	<course_actor_castle_5, <course_actor_castle_6

		.if	.defined(VS_SMB)
			.byte	<course_actor_castle_7_vs, <course_actor_castle_3
		.endif
	
	course_actor_addr_lo_overworld:
		.byte	<course_actor_overworld_1, <course_actor_overworld_2
		.byte	<course_actor_overworld_3, <course_actor_overworld_4
		.byte	<course_actor_overworld_5, <course_actor_overworld_6
		.if	.defined(SMB)
			.byte	<course_actor_overworld_7, <course_actor_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_overworld_7_vs, <course_actor_overworld_8_vs
		.endif
		.byte	<course_actor_overworld_9, <course_actor_overworld_10
		.byte	<course_actor_overworld_11, <course_actor_overworld_12
		.byte	<course_actor_overworld_13, <course_actor_overworld_14
		.byte	<course_actor_overworld_15, <course_actor_overworld_16
		.byte	<course_actor_overworld_17, <course_actor_overworld_18
		.byte	<course_actor_overworld_19, <course_actor_overworld_20
		.byte	<course_actor_overworld_21
		.if	.defined(SMB)
			.byte	<course_actor_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	<course_actor_overworld_7, <course_actor_overworld_8
		.endif
	
	course_actor_addr_lo_underground:
		.byte	<course_actor_underground_1
		.byte	<course_actor_underground_2
		.byte	<course_actor_underground_3
	
	course_actor_addr_lo_water:
		.byte	<course_actor_water_1
		.if	.defined(SMB)
			.byte	<course_actor_water_2
		.elseif	.defined(VS_SMB)
			.byte	<course_actor_water_2_vs
		.endif
		.byte	<course_actor_water_3

		.if	.defined(VS_SMB)
			.byte	<course_actor_water_2
		.endif
	
	course_actor_addr_hi:
	course_actor_addr_hi_castle:
		.if	.defined(SMB)
			.byte	>course_actor_castle_1
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_castle_1_vs
		.endif
		.byte	>course_actor_castle_2
		.if	.defined(SMB)
			.byte	>course_actor_castle_3
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_castle_1
		.endif
		.byte	>course_actor_castle_4
		.byte	>course_actor_castle_5, >course_actor_castle_6

		.if	.defined(VS_SMB)
			.byte	>course_actor_castle_7_vs, >course_actor_castle_3
		.endif
	
	course_actor_addr_hi_overworld:
		.byte	>course_actor_overworld_1, >course_actor_overworld_2
		.byte	>course_actor_overworld_3, >course_actor_overworld_4
		.byte	>course_actor_overworld_5, >course_actor_overworld_6
		.if	.defined(SMB)
			.byte	>course_actor_overworld_7, >course_actor_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_overworld_7_vs, >course_actor_overworld_8_vs
		.endif
		.byte	>course_actor_overworld_9, >course_actor_overworld_10
		.byte	>course_actor_overworld_11, >course_actor_overworld_12
		.byte	>course_actor_overworld_13, >course_actor_overworld_14
		.byte	>course_actor_overworld_15, >course_actor_overworld_16
		.byte	>course_actor_overworld_17, >course_actor_overworld_18
		.byte	>course_actor_overworld_19, >course_actor_overworld_20
		.byte	>course_actor_overworld_21
		.if	.defined(SMB)
			.byte	>course_actor_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	>course_actor_overworld_7, >course_actor_overworld_8
		.endif
	
	course_actor_addr_hi_underground:
		.byte	>course_actor_underground_1
		.byte	>course_actor_underground_2
		.byte	>course_actor_underground_3
	
	course_actor_addr_hi_water:
		.byte	>course_actor_water_1
		.if	.defined(SMB)
			.byte	>course_actor_water_2
		.elseif	.defined(VS_SMB)
			.byte	>course_actor_water_2_vs
		.endif
		.byte	>course_actor_water_3

		.if	.defined(VS_SMB)
			.byte	>course_actor_water_2
		.endif
.elseif	.defined(VS)
	course_actor_addr_lo:
	course_actor_addr_lo_castle:
		.if	.defined(SMB)
			.addr	course_actor_castle_1
		.elseif	.defined(VS_SMB)
			.addr	course_actor_castle_1_vs
		.endif
		.addr	course_actor_castle_2
		.if	.defined(SMB)
			.addr	course_actor_castle_3
		.elseif	.defined(VS_SMB)
			.addr	course_actor_castle_1
		.endif
		.addr	course_actor_castle_4
		.addr	course_actor_castle_5, course_actor_castle_6

		.if	.defined(VS_SMB)
			.addr	course_actor_castle_7_vs, course_actor_castle_3
		.endif

	course_actor_addr_lo_overworld:
		.addr	course_actor_overworld_1, course_actor_overworld_2
		.addr	course_actor_overworld_3, course_actor_overworld_4
		.addr	course_actor_overworld_5, course_actor_overworld_6
		.if	.defined(SMB)
			.addr	course_actor_overworld_7, course_actor_overworld_8
		.elseif	.defined(VS_SMB)
			.addr	course_actor_overworld_7_vs, course_actor_overworld_8_vs
		.endif
		.addr	course_actor_overworld_9, course_actor_overworld_10
		.addr	course_actor_overworld_11, course_actor_overworld_12
		.addr	course_actor_overworld_13, course_actor_overworld_14
		.addr	course_actor_overworld_15, course_actor_overworld_16
		.addr	course_actor_overworld_17, course_actor_overworld_18
		.addr	course_actor_overworld_19, course_actor_overworld_20
		.addr	course_actor_overworld_21
		.if	.defined(SMB)
			.addr	course_actor_overworld_22
		.elseif	.defined(VS_SMB)
			.addr	course_actor_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.addr	course_actor_overworld_7, course_actor_overworld_8
		.endif

	course_actor_addr_lo_underground:
		.addr	course_actor_underground_1
		.addr	course_actor_underground_2
		.addr	course_actor_underground_3

	course_actor_addr_lo_water:
		.addr	course_actor_water_1
		.if	.defined(SMB)
			.addr	course_actor_water_2
		.elseif	.defined(VS_SMB)
			.addr	course_actor_water_2_vs
		.endif
		.addr	course_actor_water_3

		.if	.defined(VS_SMB)
			.addr	course_actor_water_2
		.endif
.endif
; --------------
course_scenery_pages:
	.byte	(course_scenery_addr_lo_water-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_overworld-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_underground-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(course_scenery_addr_lo_castle-course_scenery_addr_lo)/COURSE_OFFSET_INC_SIZE

.if	.defined(CONS)
	course_scenery_addr_lo:
	course_scenery_addr_lo_water:
		.byte	<course_scenery_water_1
		.if	.defined(SMB)
			.byte	<course_scenery_water_2
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_water_2_vs
		.endif
		.byte	<course_scenery_water_3

		.if	.defined(VS_SMB)
			.byte	<course_scenery_water_2
		.endif
	
	course_scenery_addr_lo_overworld:
		.byte	<course_scenery_overworld_1, <course_scenery_overworld_2
		.byte	<course_scenery_overworld_3, <course_scenery_overworld_4
		.byte	<course_scenery_overworld_5, <course_scenery_overworld_6
		.if	.defined(SMB)
			.byte	<course_scenery_overworld_7, <course_scenery_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_overworld_7_vs, <course_scenery_overworld_8_vs
		.endif
		.byte	<course_scenery_overworld_9, <course_scenery_overworld_10
		.byte	<course_scenery_overworld_11, <course_scenery_overworld_12
		.byte	<course_scenery_overworld_13, <course_scenery_overworld_14
		.byte	<course_scenery_overworld_15, <course_scenery_overworld_16
		.byte	<course_scenery_overworld_17, <course_scenery_overworld_18
		.byte	<course_scenery_overworld_19, <course_scenery_overworld_20
		.byte	<course_scenery_overworld_21
		.if	.defined(SMB)
			.byte	<course_scenery_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	<course_scenery_overworld_7, <course_scenery_overworld_8
		.endif
	
	course_scenery_addr_lo_underground:
		.byte	<course_scenery_underground_1
		.byte	<course_scenery_underground_2
		.byte	<course_scenery_underground_3
	
	course_scenery_addr_lo_castle:
		.if	.defined(SMB)
			.byte	<course_scenery_castle_1
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_castle_1_vs
		.endif
		.byte	<course_scenery_castle_2
		.if	.defined(SMB)
			.byte	<course_scenery_castle_3
		.elseif	.defined(VS_SMB)
			.byte	<course_scenery_castle_1
		.endif
		.byte	<course_scenery_castle_4
		.byte	<course_scenery_castle_5, <course_scenery_castle_6

		.if	.defined(VS_SMB)
			.byte	<course_scenery_castle_7_vs, <course_scenery_castle_3
		.endif
	
	course_scenery_addr_hi:
	course_scenery_addr_hi_water:
		.byte	>course_scenery_water_1
		.if	.defined(SMB)
			.byte	>course_scenery_water_2
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_water_2_vs
		.endif
		.byte	>course_scenery_water_3

		.if	.defined(VS_SMB)
			.byte	>course_scenery_water_2
		.endif
	
	course_scenery_addr_hi_overworld:
		.byte	>course_scenery_overworld_1, >course_scenery_overworld_2
		.byte	>course_scenery_overworld_3, >course_scenery_overworld_4
		.byte	>course_scenery_overworld_5, >course_scenery_overworld_6
		.if	.defined(SMB)
			.byte	>course_scenery_overworld_7, >course_scenery_overworld_8
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_overworld_7_vs, >course_scenery_overworld_8_vs
		.endif
		.byte	>course_scenery_overworld_9, >course_scenery_overworld_10
		.byte	>course_scenery_overworld_11, >course_scenery_overworld_12
		.byte	>course_scenery_overworld_13, >course_scenery_overworld_14
		.byte	>course_scenery_overworld_15, >course_scenery_overworld_16
		.byte	>course_scenery_overworld_17, >course_scenery_overworld_18
		.byte	>course_scenery_overworld_19, >course_scenery_overworld_20
		.byte	>course_scenery_overworld_21

		.if	.defined(SMB)
			.byte	>course_scenery_overworld_22
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.byte	>course_scenery_overworld_7, >course_scenery_overworld_8
		.endif
	
	course_scenery_addr_hi_underground:
		.byte	>course_scenery_underground_1
		.byte	>course_scenery_underground_2
		.byte	>course_scenery_underground_3
	
	course_scenery_addr_hi_castle:
		.if	.defined(SMB)
			.byte	>course_scenery_castle_1
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_castle_1_vs
		.endif
		.byte	>course_scenery_castle_2
		.if	.defined(SMB)
			.byte	>course_scenery_castle_3
		.elseif	.defined(VS_SMB)
			.byte	>course_scenery_castle_1
		.endif
		.byte	>course_scenery_castle_4
		.byte	>course_scenery_castle_5, >course_scenery_castle_6

		.if	.defined(VS_SMB)
			.byte	>course_scenery_castle_7_vs, >course_scenery_castle_3
		.endif
.elseif	.defined(VS)
	course_scenery_addr_lo:
	course_scenery_addr_lo_water:
		.addr	course_scenery_water_1
		.if	.defined(SMB)
			.addr	course_scenery_water_2
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_water_2_vs
		.endif
		.addr	course_scenery_water_3

		.if	.defined(VS_SMB)
			.addr	course_scenery_water_2
		.endif

	course_scenery_addr_lo_overworld:
		.addr	course_scenery_overworld_1, course_scenery_overworld_2
		.addr	course_scenery_overworld_3, course_scenery_overworld_4
		.addr	course_scenery_overworld_5, course_scenery_overworld_6
		.if	.defined(SMB)
			.addr	course_scenery_overworld_7, course_scenery_overworld_8
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_overworld_7_vs, course_scenery_overworld_8_vs
		.endif
		.addr	course_scenery_overworld_9, course_scenery_overworld_10
		.addr	course_scenery_overworld_11, course_scenery_overworld_12
		.addr	course_scenery_overworld_13, course_scenery_overworld_14
		.addr	course_scenery_overworld_15, course_scenery_overworld_16
		.addr	course_scenery_overworld_17, course_scenery_overworld_18
		.addr	course_scenery_overworld_19, course_scenery_overworld_20
		.addr	course_scenery_overworld_21
		.if	.defined(SMB)
			.addr	course_scenery_overworld_22
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_overworld_22_vs
		.endif

		.if	.defined(VS_SMB)
			.addr	course_scenery_overworld_7, course_scenery_overworld_8
		.endif

	course_scenery_addr_lo_underground:
		.addr	course_scenery_underground_1
		.addr	course_scenery_underground_2
		.addr	course_scenery_underground_3

	course_scenery_addr_lo_castle:
		.if	.defined(SMB)
			.addr	course_scenery_castle_1
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_castle_1_vs
		.endif
		.addr	course_scenery_castle_2
		.if	.defined(SMB)
			.addr	course_scenery_castle_3
		.elseif	.defined(VS_SMB)
			.addr	course_scenery_castle_1
		.endif
		.addr	course_scenery_castle_4
		.addr	course_scenery_castle_5, course_scenery_castle_6

		.if	.defined(VS_SMB)
			.addr	course_scenery_castle_7_vs, course_scenery_castle_3
		.endif
.endif

.if	.defined(VS_SMB)
	.res	9, $FF
.endif
