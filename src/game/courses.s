.include	"../../inc/system/cpu.i"

.include	"../../inc/engine/course_flags.i"
.include	"../../inc/engine/misc.i"

.include	"../../inc/engine/unk.i"

.if	.defined(CONS)
.define	COURSE_ACTOR_DATA_ADDR_LO	courses_actor_addr_lo,y
.define COURSE_ACTOR_DATA_ADDR_HI       courses_actor_addr_hi,y
.define COURSE_AREA_DATA_ADDR_LO	courses_data_addr_lo,y
.define COURSE_AREA_DATA_ADDR_HI	courses_data_addr_hi,y
.elseif	.defined(VS)
.define COURSE_ACTOR_DATA_ADDR_LO	#<vs_actor_data
.define COURSE_ACTOR_DATA_ADDR_HI	#>vs_actor_data
.define COURSE_AREA_DATA_ADDR_LO	#<vs_area_data
.define COURSE_AREA_DATA_ADDR_HI	#>vs_area_data
.endif

; -----------------------------------------------------------
	.export	course_descriptor_load
course_descriptor_load:
	jsr	course_descriptor_get
	sta	course_descriptor

course_type_get:
	and	#(course_types::MAX<<5)
	asl	a
	rol	a
	rol	a
	rol	a
	sta	course_type
	rts
; --------------
course_descriptor_get:
	ldy	course_no
	lda	courses_world_offsets, y
	clc
	adc	course_sub
	tay
	lda	courses_area_offsets, y
	rts
; -----------------------------
	.export	course_load
course_load:
	.if	.defined(VS)
	        jsr     vs_setbank_low
	        lda     #vs_req::chr_high|vs_req::irq_rel|vs_req::ctrl_rel
	        sta     VS_REQ
	        lda     PPU_SR
	        lda     zp_addr_00
	        sta     PPU_VRAM_AR
	        lda     zp_addr_00
	        sta     PPU_VRAM_AR
	
	        ldy     #0
	        lda     PPU_VRAM_IO
	        : ; for (y = 0; y < 0x20; y++) {
	                lda     PPU_VRAM_IO
	                sta     VS_RAM, y
	
	                iny
	                cpy     #$20
	                bne     :-
	        ; }
	.endif

	lda	course_descriptor
	jsr	course_type_get
	tay

	lda	course_descriptor
	and	#(COURSE_AREA_OFFSET_MAX<<0)
	sta	course_page_offset

	lda	course_actor_pages, y
	clc
	adc	course_page_offset
	.if	.defined(VS)
		asl	a
	.endif
	tay

	.if	.defined(VS)
		lda	PPU_SR
		lda	courses_actor_addr_lo+1, y
		sta	PPU_VRAM_AR
		lda	courses_actor_addr_lo, y
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
	lda	course_data_pages, y
	clc
	adc	course_page_offset
	.if	.defined(VS)
		asl	a
	.endif
	tay

	.if	.defined(VS)
		lda	PPU_SR
		lda	courses_data_addr_lo+1, y
		sta	PPU_VRAM_AR
		lda	courses_data_addr_lo, y
		sta	PPU_VRAM_AR
	
		ldy	#0
		lda	PPU_VRAM_IO
		: ; for (y = 0; vs_area_data[y] != COURSE_DATA_END) {
			lda	PPU_VRAM_IO
			sta	vs_area_data, y
	
			iny
			cmp	#COURSE_DATA_END
			bne	:-
		; }
	.endif

	lda	COURSE_AREA_DATA_ADDR_LO
	sta	course_data_addr
	lda	COURSE_AREA_DATA_ADDR_HI
	sta	course_data_addr+1

	ldy	#0
	lda	(course_data_addr), y
	pha

	and	#(COURSE_DATA_BG_COL_MAX<<COURSE_DATA_FG_BG_SHIFT)
	cmp	#(COURSE_DATA_FG_MAX+1)
	bcc	:+ ; if ((course_data_addr.data_bg_fg) >= (COURSE_DATA_FG_MAX+1)) {
		sta	course_bg_col
		lda	#COURSE_DATA_FG_NONE
	: ; }
	sta	course_fg_id

	pla
	pha

	and	#(COURSE_DATA_ENTER_POS_MAX<<COURSE_DATA_ENTER_POS_SHIFT)
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
	lda	(course_data_addr), y
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

	lda	course_data_addr
	clc
	adc	#<WORD_SIZE
	sta	course_data_addr
	lda	course_data_addr+1
	adc	#>WORD_SIZE
	sta	course_data_addr+1
	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif
	rts
; ---------------------------------------
courses_world_offsets:
	.byte	course_01_areas-courses_area_offsets
	.byte   course_02_areas-courses_area_offsets
	.byte   course_03_areas-courses_area_offsets
	.byte   course_04_areas-courses_area_offsets
	.byte   course_05_areas-courses_area_offsets
	.byte   course_06_areas-courses_area_offsets
	.byte   course_07_areas-courses_area_offsets
	.byte   course_08_areas-courses_area_offsets
; --------------
courses_area_offsets:
course_01_areas:
	.byte	$25, $29, $C0
.if	.defined(SMB)
	.byte	$26, $60
.elseif	.defined(VS_SMB)
	.byte	$36, $66
.endif

course_02_areas:
	.byte	$28, $29
.if	.defined(SMB)
	.byte	$01, $27
.elseif	.defined(VS_SMB)
	.byte	$03, $37
.endif
	.byte	$62

course_03_areas:
	.byte	$24, $35, $20, $63

course_04_areas:
	.byte	$22, $29, $41, $2C
.if	.defined(SMB)
	.byte	$61
.elseif	.defined(VS_SMB)
	.byte	$67
.endif

course_05_areas:
	.byte	$2A, $31
.if	.defined(SMB)
	.byte	$26, $62
.elseif	.defined(VS_SMB)
	.byte	$2D, $61
.endif

course_06_areas:
	.byte	$2E, $23
.if	.defined(SMB)
	.byte	$2D
.elseif	.defined(VS_SMB)
	.byte	$26
.endif
	.byte	$60

course_07_areas:
	.byte	$33, $29, $01, $27, $64

course_08_areas:
	.byte	$30, $32, $21, $65
; -----------------------------
.if	.defined(CONS)
	COURSE_OFFSET_INC_SIZE	= 1
.elseif	.defined(VS)
	COURSE_OFFSET_INC_SIZE	= WORD_SIZE
.endif
course_actor_pages:
	.byte	(courses_actor_addr_lo_water-courses_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(courses_actor_addr_lo_overworld-courses_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(courses_actor_addr_lo_underground-courses_actor_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(courses_actor_addr_lo_castle-courses_actor_addr_lo)/COURSE_OFFSET_INC_SIZE

.if	.defined(CONS)
	courses_actor_addr_lo:
	courses_actor_addr_lo_castle:
		.byte	<courses_actor_castle_1, <courses_actor_castle_2
		.byte	<courses_actor_castle_3, <courses_actor_castle_4
		.byte	<courses_actor_castle_5, <courses_actor_castle_6
	
	courses_actor_addr_lo_overworld:
		.byte	<courses_actor_overworld_1, <courses_actor_overworld_2
		.byte   <courses_actor_overworld_3, <courses_actor_overworld_4
		.byte   <courses_actor_overworld_5, <courses_actor_overworld_6
		.byte   <courses_actor_overworld_7, <courses_actor_overworld_8
		.byte   <courses_actor_overworld_9, <courses_actor_overworld_10
		.byte   <courses_actor_overworld_11, <courses_actor_overworld_12
		.byte   <courses_actor_overworld_13, <courses_actor_overworld_14
		.byte   <courses_actor_overworld_15, <courses_actor_overworld_16
		.byte   <courses_actor_overworld_17, <courses_actor_overworld_18
		.byte   <courses_actor_overworld_19, <courses_actor_overworld_20
		.byte   <courses_actor_overworld_21, <courses_actor_overworld_22
	
	courses_actor_addr_lo_underground:
		.byte	<courses_actor_underground_1
		.byte	<courses_actor_underground_2
		.byte	<courses_actor_underground_3
	
	courses_actor_addr_lo_water:
		.byte	<courses_actor_water_1
		.byte	<courses_actor_water_2
		.byte	<courses_actor_water_3
	
	courses_actor_addr_hi:
	courses_actor_addr_hi_castle:
		.byte	>courses_actor_castle_1, >courses_actor_castle_2
		.byte	>courses_actor_castle_3, >courses_actor_castle_4
		.byte	>courses_actor_castle_5, >courses_actor_castle_6
	
	courses_actor_addr_hi_overworld:
		.byte	>courses_actor_overworld_1, >courses_actor_overworld_2
		.byte   >courses_actor_overworld_3, >courses_actor_overworld_4
		.byte   >courses_actor_overworld_5, >courses_actor_overworld_6
		.byte   >courses_actor_overworld_7, >courses_actor_overworld_8
		.byte   >courses_actor_overworld_9, >courses_actor_overworld_10
		.byte   >courses_actor_overworld_11, >courses_actor_overworld_12
		.byte   >courses_actor_overworld_13, >courses_actor_overworld_14
		.byte   >courses_actor_overworld_15, >courses_actor_overworld_16
		.byte   >courses_actor_overworld_17, >courses_actor_overworld_18
		.byte   >courses_actor_overworld_19, >courses_actor_overworld_20
		.byte   >courses_actor_overworld_21, >courses_actor_overworld_22
	
	courses_actor_addr_hi_underground:
		.byte	>courses_actor_underground_1
		.byte	>courses_actor_underground_2
		.byte	>courses_actor_underground_3
	
	courses_actor_addr_hi_water:
		.byte	>courses_actor_water_1
		.byte	>courses_actor_water_2
		.byte	>courses_actor_water_3
.elseif	.defined(VS)
	courses_actor_addr_lo:
	courses_actor_addr_lo_castle:
		.addr	courses_actor_castle_1, courses_actor_castle_2
		.addr	courses_actor_castle_3, courses_actor_castle_4
		.addr	courses_actor_castle_5, courses_actor_castle_6
	.if	.defined(VS_SMB)
		.addr	courses_actor_castle_7, courses_actor_castle_8
	.endif

	courses_actor_addr_lo_overworld:
		.addr	courses_actor_overworld_1, courses_actor_overworld_2
		.addr	courses_actor_overworld_3, courses_actor_overworld_4
		.addr	courses_actor_overworld_5, courses_actor_overworld_6
		.addr	courses_actor_overworld_7, courses_actor_overworld_8
		.addr	courses_actor_overworld_9, courses_actor_overworld_10
		.addr	courses_actor_overworld_11, courses_actor_overworld_12
		.addr	courses_actor_overworld_13, courses_actor_overworld_14
		.addr	courses_actor_overworld_15, courses_actor_overworld_16
		.addr	courses_actor_overworld_17, courses_actor_overworld_18
		.addr	courses_actor_overworld_19, courses_actor_overworld_20
		.addr	courses_actor_overworld_21, courses_actor_overworld_22
	.if	.defined(VS_SMB)
		.addr	courses_actor_overworld_23, courses_actor_overworld_24
	.endif

	courses_actor_addr_lo_underground:
		.addr	courses_actor_underground_1
		.addr	courses_actor_underground_2
		.addr	courses_actor_underground_3

	courses_actor_addr_lo_water:
		.addr	courses_actor_water_1
		.addr	courses_actor_water_2
		.addr	courses_actor_water_3
	.if	.defined(VS_SMB)
		.addr	courses_actor_water_4
	.endif
.endif
; --------------
course_data_pages:
	.byte	(courses_data_addr_lo_water-courses_data_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(courses_data_addr_lo_overworld-courses_data_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(courses_data_addr_lo_underground-courses_data_addr_lo)/COURSE_OFFSET_INC_SIZE
	.byte	(courses_data_addr_lo_castle-courses_data_addr_lo)/COURSE_OFFSET_INC_SIZE

.if	.defined(CONS)
	courses_data_addr_lo:
	courses_data_addr_lo_water:
		.byte	<courses_data_water_1
		.byte	<courses_data_water_2
		.byte	<courses_data_water_3
	
	courses_data_addr_lo_overworld:
		.byte	<courses_data_overworld_1, <courses_data_overworld_2
		.byte   <courses_data_overworld_3, <courses_data_overworld_4
		.byte   <courses_data_overworld_5, <courses_data_overworld_6
		.byte   <courses_data_overworld_7, <courses_data_overworld_8
		.byte   <courses_data_overworld_9, <courses_data_overworld_10
		.byte   <courses_data_overworld_11, <courses_data_overworld_12
		.byte   <courses_data_overworld_13, <courses_data_overworld_14
		.byte   <courses_data_overworld_15, <courses_data_overworld_16
		.byte   <courses_data_overworld_17, <courses_data_overworld_18
		.byte   <courses_data_overworld_19, <courses_data_overworld_20
		.byte   <courses_data_overworld_21, <courses_data_overworld_22
	
	courses_data_addr_lo_underground:
		.byte	<courses_data_underground_1
		.byte	<courses_data_underground_2
		.byte	<courses_data_underground_3
	
	courses_data_addr_lo_castle:
		.byte	<courses_data_castle_1, <courses_data_castle_2
		.byte	<courses_data_castle_3, <courses_data_castle_4
		.byte	<courses_data_castle_5, <courses_data_castle_6
	
	courses_data_addr_hi:
	courses_data_addr_hi_water:
		.byte	>courses_data_water_1
		.byte	>courses_data_water_2
		.byte	>courses_data_water_3
	
	courses_data_addr_hi_overworld:
		.byte	>courses_data_overworld_1, >courses_data_overworld_2
		.byte   >courses_data_overworld_3, >courses_data_overworld_4
		.byte   >courses_data_overworld_5, >courses_data_overworld_6
		.byte   >courses_data_overworld_7, >courses_data_overworld_8
		.byte   >courses_data_overworld_9, >courses_data_overworld_10
		.byte   >courses_data_overworld_11, >courses_data_overworld_12
		.byte   >courses_data_overworld_13, >courses_data_overworld_14
		.byte   >courses_data_overworld_15, >courses_data_overworld_16
		.byte   >courses_data_overworld_17, >courses_data_overworld_18
		.byte   >courses_data_overworld_19, >courses_data_overworld_20
		.byte   >courses_data_overworld_21, >courses_data_overworld_22
	
	courses_data_addr_hi_underground:
		.byte	>courses_data_underground_1
		.byte	>courses_data_underground_2
		.byte	>courses_data_underground_3
	
	courses_data_addr_hi_castle:
		.byte	>courses_data_castle_1, >courses_data_castle_2
		.byte	>courses_data_castle_3, >courses_data_castle_4
		.byte	>courses_data_castle_5, >courses_data_castle_6
.elseif	.defined(VS)
	courses_data_addr_lo:
	courses_data_addr_lo_water:
		.addr	courses_data_water_1
		.addr	courses_data_water_2
		.addr	courses_data_water_3
	.if	.defined(VS_SMB)
		.addr	courses_data_water_4
	.endif

	courses_data_addr_lo_overworld:
		.addr	courses_data_overworld_1, courses_data_overworld_2
		.addr	courses_data_overworld_3, courses_data_overworld_4
		.addr	courses_data_overworld_5, courses_data_overworld_6
		.addr	courses_data_overworld_7, courses_data_overworld_8
		.addr	courses_data_overworld_9, courses_data_overworld_10
		.addr	courses_data_overworld_11, courses_data_overworld_12
		.addr	courses_data_overworld_13, courses_data_overworld_14
		.addr	courses_data_overworld_15, courses_data_overworld_16
		.addr	courses_data_overworld_17, courses_data_overworld_18
		.addr	courses_data_overworld_19, courses_data_overworld_20
		.addr	courses_data_overworld_21, courses_data_overworld_22
	.if	.defined(VS_SMB)
		.addr	courses_data_overworld_23, courses_data_overworld_24
	.endif

	courses_data_addr_lo_underground:
		.addr	courses_data_underground_1
		.addr	courses_data_underground_2
		.addr	courses_data_underground_3

	courses_data_addr_lo_castle:
		.addr	courses_data_castle_1, courses_data_castle_2
		.addr	courses_data_castle_3, courses_data_castle_4
		.addr	courses_data_castle_5, courses_data_castle_6
	.if	.defined(VS_SMB)
		.addr	courses_data_castle_7, courses_data_castle_8
	.endif
.endif

.if	.defined(VS_SMB)
	.res	9, $FF
.endif
