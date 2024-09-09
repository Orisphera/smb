.include	"system/cpu.i"

.include	"mem.i"
.include	"course_flags.i"
.include	"misc.i"

.include	"unk.i"

.if	.defined(SMB)
.define	COURSE_ACTOR_DATA_ADDR_LO	course_actor_addr_lo,y
.define COURSE_ACTOR_DATA_ADDR_HI	course_actor_addr_hi,y
.define COURSE_SCENERY_DATA_ADDR_LO	course_scenery_addr_lo,y
.define COURSE_SCENERY_DATA_ADDR_HI	course_scenery_addr_hi,y
.elseif	.defined(VS_SMB)
.define COURSE_ACTOR_DATA_ADDR_LO	#<vs_actor_data
.define COURSE_ACTOR_DATA_ADDR_HI	#>vs_actor_data
.define COURSE_SCENERY_DATA_ADDR_LO	#<vs_scenery_data
.define COURSE_SCENERY_DATA_ADDR_HI	#>vs_scenery_data
.elseif	.defined(SMB2M)
.define	COURSE_ACTOR_DATA_ADDR_LO	course_actor_addr_lo,y
.define COURSE_ACTOR_DATA_ADDR_HI	course_actor_addr_lo+1,y
.define COURSE_SCENERY_DATA_ADDR_LO	course_scenery_addr_lo,y
.define COURSE_SCENERY_DATA_ADDR_HI	course_scenery_addr_lo+1,y
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
	.if	.defined(VS_SMB)|.defined(SMB2M)
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

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	COURSE_ACTOR_DATA_ADDR_LO
		sta	course_actor_addr
		lda	COURSE_ACTOR_DATA_ADDR_HI
		sta	course_actor_addr+1
	.elseif	.defined(SMB2M)
		lda	COURSE_ACTOR_DATA_ADDR_HI
		sta	course_actor_addr+1
		lda	COURSE_ACTOR_DATA_ADDR_LO
		sta	course_actor_addr
	.endif

	ldy	course_type
	lda	course_scenery_pages, y
	clc
	adc	course_page_offset
	.if	.defined(VS_SMB)|.defined(SMB2M)
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

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	COURSE_SCENERY_DATA_ADDR_LO
		sta	course_scenery_addr
		lda	COURSE_SCENERY_DATA_ADDR_HI
		sta	course_scenery_addr+1
	.elseif	.defined(SMB2M)
		lda	COURSE_SCENERY_DATA_ADDR_HI
		sta	course_scenery_addr+1
		lda	COURSE_SCENERY_DATA_ADDR_LO
		sta	course_scenery_addr
	.endif

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

