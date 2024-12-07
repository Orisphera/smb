.include	"system/ppu.i"

.include	"math.i"
.include	"mem.i"
.include	"chr.i"

; -----------------------------------------------------------
BOWSER_FLAME_POS_X_OFFSET		= 1
BOWSER_FLAME_TIMER_IDX_MASK		= %00000111
; -----------------------------------------------------------
actor_proc_bowser_flame_timer_data:
	.ifndef	PAL
		.byte	191, 64, 191, 191, 191, 64, 64, 191
	.else
		.byte	128, 48, 48, 128, 128, 128, 48, 80
	.endif
; ----------------------------
	.export actor_proc_bowser_flame_timer_init
actor_proc_bowser_flame_timer_init:
	ldy	actor_bowser_flame_timer_idx
	inc	actor_bowser_flame_timer_idx
	lda	actor_bowser_flame_timer_idx
	and	#BOWSER_FLAME_TIMER_IDX_MASK
	sta	actor_bowser_flame_timer_idx
	lda	actor_proc_bowser_flame_timer_data, y
	: rts
; -----------------------------------------------------------
actor_proc_bowser_flame_accel_x_offset	= zp_byte_00
actor_proc_bowser_flame_obj_tile	= zp_byte_00
actor_proc_bowser_flame_obj_attr	= zp_byte_01

	.export actor_proc_bowser_flame_do
actor_proc_bowser_flame_do:
	lda	game_timer_stop
	bne	:++ ; if (!game_timer_stop) {
		lda	#BOWSER_FLAME_ACCEL_X_OFFSET
		ldy	game_hard_mode_b
		beq	:+ ; if (game_hard_mode_b) {
			lda	#BOWSER_FLAME_ACCEL_X_OFFSET_HARD
		: ; }
		sta	actor_proc_bowser_flame_accel_x_offset

		lda	accel_x_actor, x
		sec
		sbc	actor_proc_bowser_flame_accel_x_offset
		sta	accel_x_actor, x
		lda	pos_x_lo_actor, x
		sbc	#<BOWSER_FLAME_POS_X_OFFSET
		sta	pos_x_lo_actor, x
		lda	pos_x_hi_actor, x
		sbc	#>BOWSER_FLAME_POS_X_OFFSET
		sta	pos_x_hi_actor, x
		ldy	accel_y1_actor, x
		lda	pos_y_lo_actor, x
		cmp	actor_bowser_flame_pos_y_offset, y
		beq	:+ ; if (this.pos_y != actor_bowser_flame_pos_y_offset) {
			clc
			adc	accel_y2_actor, x
			sta	pos_y_lo_actor, x
		; }
	: ; }

	jsr	pos_calc_x_rel_actor
	lda	state_actor, x
	bne	:---
	lda	#chr_obj::bowser_flame
	sta	actor_proc_bowser_flame_obj_tile

	ldy	#obj_attr::color2
	lda	frame_count
	and	#MOD_4_2_UP
	beq	:+ ; if ((frame_count % 4) >= 2) {
		ldy	#obj_attr::v_flip|obj_attr::color2
	: ; }
	sty	actor_proc_bowser_flame_obj_attr

	ldy	obj_data_offset_actor, x
	ldx	#0
	: ; for (tile of bowser_flame) {
		lda	pos_y_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		lda	actor_proc_bowser_flame_obj_tile
		sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
		inc	actor_proc_bowser_flame_obj_tile
		lda	actor_proc_bowser_flame_obj_attr
		sta	OAM_DMA_BUFFER+OBJ_ATTR, y
		lda	pos_x_rel_actor
		sta	OAM_DMA_BUFFER+OBJ_POS_H, y
		clc
		adc	#PPU_CHR_WIDTH_PX
		sta	pos_x_rel_actor

		iny
		iny
		iny
		iny
		inx
		cpx	#chr_obj::bowser_flame_end-chr_obj::bowser_flame
		bcc	:-
	; }

	ldx	actor_index

	jsr	pos_bits_get_actor

	ldy	obj_data_offset_actor, x
	lda	bits_offscr_actor
	lsr	a
	pha

	bcc	:+ ; if (bits_offscr_actor & 0x01) {
		lda	#OAM_INIT_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*3), y
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if (bits_offscr_actor & 0x02) {
		lda	#OAM_INIT_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*2), y
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if (bits_offscr_actor & 0x04) {
		lda	#OAM_INIT_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*1), y
	: ; }

	pla
	lsr	a
	bcc	:+ ; if (bits_offscr_actor & 0x08) {
		lda	#OAM_INIT_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*0), y
	: ; }

	rts
