.include	"system/ppu.i"

.include	"math.i"
.include	"mem.i"
.include	"misc.i"
.include	"joypad.i"
.include	"macros.i"

; -----------------------------------------------------------
FIREBAR_SHORT_COUNT		= 6
FIREBAR_LONG_COUNT		= 12
FIREBAR_VELOC_Y_CUTOFF_A	= 8
FIREBAR_VELOC_Y_CUTOFF_B	= 24
FIREBAR_VELOC_Y_CUTOFF_INC	= 1
FIREBAR_PLAYER_SHORT_OFFSET_Y	= 24
FIREBAR_POS_Y_CHECK_COUNT	= 3
FIREBAR_POS_Y_CHECK_OFFSET	= 8
FIREBAR_POS_X_CHECK_OFFSET	= <-16
FIREBAR_SCROLL_X_INC		= 4
FIREBAR_SPRITE_OFFSET		= 4
FIREBAR_COLLISION_DIST		= 8
; -----------------------------------------------------------
actor_firebar_pos_tbl:
actor_firebar_pos_tbl_0:
	.byte	$00, $01, $03, $04, $05, $06, $07, $07, $08
actor_firebar_pos_tbl_1:
	.byte	$00, $03, $06, $09, $0B, $0D, $0E, $0F, $10
actor_firebar_pos_tbl_2:
	.byte	$00, $04, $09, $0D, $10, $13, $16, $17, $18
actor_firebar_pos_tbl_3:
	.byte	$00, $06, $0C, $12, $16, $1A, $1D, $1F, $20
actor_firebar_pos_tbl_4:
	.byte	$00, $07, $0F, $16, $1C, $21, $25, $27, $28
actor_firebar_pos_tbl_5:
	.byte	$00, $09, $12, $1B, $21, $27, $2C, $2F, $30
actor_firebar_pos_tbl_6:
	.byte	$00, $0B, $15, $1F, $27, $2E, $33, $37, $38
actor_firebar_pos_tbl_7:
	.byte	$00, $0C, $18, $24, $2D, $35, $3B, $3E, $40
actor_firebar_pos_tbl_8:
	.byte	$00, $0E, $1B, $28, $32, $3B, $42, $46, $48
actor_firebar_pos_tbl_9:
	.byte	$00, $0F, $1F, $2D, $38, $42, $4A, $4E, $50
actor_firebar_pos_tbl_A:
	.byte	$00, $11, $22, $31, $3E, $49, $51, $56, $58
actor_firebar_pos_tbl_B:

actor_proc_firebar_flips:
	.byte	1, 3, 2, 0

actor_firebar_pos_tbl_idx:
	.byte	actor_firebar_pos_tbl_0-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_1-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_2-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_3-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_4-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_5-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_6-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_7-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_8-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_9-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_A-actor_firebar_pos_tbl
	.byte	actor_firebar_pos_tbl_B-actor_firebar_pos_tbl

actor_proc_firebar_pos_y:
	.byte	12, 24
; -----------------------------------------------------------
actor_firebar_loop_idx		= zp_byte_00
actor_firebar_pos_x_rel		= zp_byte_06
actor_firebar_pos_y_rel		= zp_byte_07
actor_firebar_loop_size		= zp_addr_ED
actor_firebar_veloc_y		= zp_byte_EF

	.export actor_proc_firebar_do
actor_proc_firebar_do:
	jsr	lib_actor_bits_get
	lda	bits_offscr_actor
	and	#%00001000
	bne	:+++++++ ; if (!(actor.bits_offscr & 0x08)) {
		lda	eng_timer_ctl
		bne	:+ ; if (eng_timer_ctl == 0) {
			lda	veloc_ang_firebar, x
			jsr	actor_proc_firebar_spin
			and	#MOD_32
			sta	veloc_y_actor, x
		: ; }
	
		lda	veloc_y_actor, x
		ldy	actor_id, x
		cpy	#actor::firebar_end-1
		bcc	:++
		cmp	#FIREBAR_VELOC_Y_CUTOFF_A
		beq	:+
		cmp	#FIREBAR_VELOC_Y_CUTOFF_B
		bne	:++
		: ; if (actor.id > firebar_end && (actor.veloc_y == 8 || actor.veloc_y == 24)) {
			clc
			adc	#FIREBAR_VELOC_Y_CUTOFF_INC
			sta	veloc_y_actor, x
		: ; }
		sta	actor_firebar_veloc_y
	
		jsr	lib_calc_actor_pos
		jsr	actor_firebar_get_pos
		ldy	obj_data_offset_actor, x
		lda	pos_y_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		sta	actor_firebar_pos_y_rel
		lda	pos_x_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_H, y
		sta	actor_firebar_pos_x_rel
		lda	#1
		sta	actor_firebar_loop_idx
		jsr	actor_firebar_col

		ldy	#FIREBAR_SHORT_COUNT-1
		lda	actor_id, x
		cmp	#actor::firebar_end-1
		bcc	:+ ; if (actor.id > firebar_end) {
			ldy	#FIREBAR_LONG_COUNT-1
		: ; }
		sty	actor_firebar_loop_size

		lda	#0
		sta	actor_firebar_loop_idx
		: ; for (i = 0; i < actor_firebar_loop_size; i++) {
			lda	actor_firebar_veloc_y
			jsr	actor_firebar_get_pos
			jsr	actor_firebar_col_draw

			lda	actor_firebar_loop_idx
			cmp	#4
			bne	:+ ; if (actor_firebar_loop_idx == 4) {
				ldy	actor_dup_offset
				lda	obj_data_offset_actor, y
				sta	actor_firebar_pos_x_rel
			: ; }

			inc	actor_firebar_loop_idx
			lda	actor_firebar_loop_idx
			cmp	actor_firebar_loop_size
			bcc	:--
		; }
	: ; }

	rts
; -----------------------------------------------------------
actor_firebar_col_draw:
	lda	zp_byte_03
	sta	zp_byte_05
	ldy	actor_firebar_pos_x_rel
	lda	zp_byte_01

	lsr	zp_byte_05
	bcs	:+ ; if (!(zp_byte_05 % 2)) {
		neg_m_cc
	: ; }
	clc
	adc	pos_x_rel_actor
	sta	OAM_DMA_BUFFER+OBJ_POS_H, y
	sta	actor_firebar_pos_x_rel
	cmp	pos_x_rel_actor
	bcs	:+ ; if (actor_firebar_pos_x_rel < pos_x_rel_actor) {
		lda	pos_x_rel_actor
		sec
		sbc	actor_firebar_pos_x_rel

		jmp	:++
	: ; } else {
		sec
		sbc	pos_x_rel_actor
	: ; }

	cmp	#89
	bcc	:+
	lda	#<-8
	bne	:+++
	: lda	pos_y_rel_actor
	cmp	#<-8
	beq	:++ ; if ((pos_x_rel_actor < 89 || pos_x_rel_actor == -8) && pos_y_rel_actor != -8) {
		lda	zp_byte_02
		lsr	zp_byte_05
		bcs	:+ ; if (!(zp_byte_05 % 2)) {
			neg_m_cc
		: ; }
		clc
		adc	pos_y_rel_actor
	: ; }
	sta	OAM_DMA_BUFFER+OBJ_POS_V, y
	sta	actor_firebar_pos_y_rel
; -----------------------------
actor_firebar_col_player_pos_x	= zp_byte_04
actor_firebar_col_pos_y_rel_idx	= zp_byte_05

actor_firebar_col:
	jsr	render_firebar
	tya
	pha

	lda	timer_player_star
	ora	eng_timer_ctl
	bne	:+++++++++ ; if (player.timer_star == 0 && eng_timer_ctl == 0) {
		sta	actor_firebar_col_pos_y_rel_idx
	
		ldy	pos_y_hi_player
		dey
		bne	:+++++++++ ; if (player.pos_y_hi == 1) {
			ldy	pos_y_lo_player
			lda	player_size
			bne	:+
			lda	player_crouch
			beq	:++
			: ; if (player_size != large || player_crouch) {
				.repeat	FIREBAR_POS_Y_CHECK_COUNT-1
					inc	actor_firebar_col_pos_y_rel_idx
				.endrepeat

				tya
				clc
				adc	#FIREBAR_PLAYER_SHORT_OFFSET_Y
				tay
			: ; }
	
			tya
			: ; for (i = 0; player_small || i <= 2; i++) {
				sec
				sbc	actor_firebar_pos_y_rel
				bpl	:+ ; if (player.pos_y >= this.pos_y) {
					neg_m
				: ; }
			
				cmp	#FIREBAR_POS_Y_CHECK_OFFSET
				bcs	:++
				lda	actor_firebar_pos_x_rel
				cmp	#FIREBAR_POS_X_CHECK_OFFSET
				bcs	:++ ; if ((player.pos_y - this.pos_y) < check_offset.y && (player.pos_x - this.pos_x) < check_offset.x) {
					lda	OAM_DMA_BUFFER+OBJ_POS_H+(OBJ_SIZE*1)
					clc
					adc	#FIREBAR_SPRITE_OFFSET
					sta	actor_firebar_col_player_pos_x
					sec
					sbc	actor_firebar_pos_x_rel
					bpl	:+ ; if (player.pos_x < this.pos_x) {
						neg_m
					: ; }
				
					cmp	#FIREBAR_COLLISION_DIST
					bcc	:++ ; if ((player.pos_x - this.pos_x) < 8) break;
				: ; }
	
				lda	actor_firebar_col_pos_y_rel_idx
				cmp	#FIREBAR_POS_Y_CHECK_COUNT-1
				beq	:+++
				ldy	actor_firebar_col_pos_y_rel_idx
				lda	pos_y_lo_player
				clc
				adc	actor_proc_firebar_pos_y, y
				inc	actor_firebar_col_pos_y_rel_idx
				jmp	:----
			: ; }
	
			; if (hit_detected) {
				ldx	#DIR_RIGHT
				lda	actor_firebar_col_player_pos_x
				cmp	actor_firebar_pos_x_rel
				bcs	:+ ; if (player.pos_x < this.pos_x) {
					inx
				: ; }
				stx	motion_dir_actor
		
				ldx	#0
				lda	actor_firebar_loop_idx
				pha
			
				jsr	col_player_harm_proc
			
				pla
				sta	actor_firebar_loop_idx
			; }
		; }
	: ; }

	pla
	clc
	adc	#FIREBAR_SCROLL_X_INC
	sta	actor_firebar_pos_x_rel
	ldx	actor_index
	rts
; -----------------------------------------------------------
actor_firebar_get_pos:
	pha

	and	#MOD_16
	cmp	#9
	bcc	:+; if ((a & 0x0F) >= 9) {
		eor	#%00001111
		clc
		adc	#1
	: ; }
	sta	zp_byte_01
	ldy	zp_byte_00
	lda	actor_firebar_pos_tbl_idx, y
	clc
	adc	zp_byte_01
	tay
	lda	actor_firebar_pos_tbl, y
	sta	zp_byte_01

	pla
	pha

	clc
	adc	#8
	and	#MOD_16
	cmp	#9
	bcc	:+ ; if () {
		eor	#%00001111
		clc
		adc	#1
	: ; }
	sta	zp_byte_02
	ldy	zp_byte_00
	lda	actor_firebar_pos_tbl_idx, y
	clc
	adc	zp_byte_02
	tay
	lda	actor_firebar_pos_tbl, y
	sta	zp_byte_02

	pla
	lsr	a
	lsr	a
	lsr	a
	tay
	lda	actor_proc_firebar_flips, y
	sta	zp_byte_03
	rts

