.include	"system/ppu.i"

.include	"math.i"
.include	"mem.i"
.include	"chr.i"

; -----------------------------------------------------------
BOWSER_FLAME_POS_X_OFFSET		= 1
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
	ldy	nmi_list_1_data+$26
	inc	nmi_list_1_data+$26
	lda	nmi_list_1_data+$26
	and	#%00000111
	sta	nmi_list_1_data+$26
	lda	actor_proc_bowser_flame_timer_data, y
	: rts
; -----------------------------------------------------------
actor_proc_bowser_flame_accel_x_offset	= zp_byte_00
actor_proc_bowser_flame_obj_tile	= zp_byte_00
actor_proc_bowser_flame_obj_attr	= zp_byte_01

	.export actor_proc_bowser_flame_do
actor_proc_bowser_flame_do:
	lda	eng_timer_ctl
	bne	:++ ; if (eng_timer_ctl == 0) {
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
		ldy	pos_y_actor, x
		lda	pos_y_lo_actor, x
		cmp	actor_bowser_flame_pos_y_offset, y
		beq	:+ ; if (this.pos_y != actor_bowser_flame_pos_y_offset) {
			clc
			adc	accel_y_actor_c, x
			sta	pos_y_lo_actor, x
		; }
	: ; }

	jsr	lib_calc_actor_pos
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
	jsr	lib_actor_bits_get

	ldy	obj_data_offset_actor, x
	lda	bits_offscr_actor
	lsr	a
	pha

	bcc	:+ ; if (bits_offscr_actor & 0x01) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*3), y
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if (bits_offscr_actor & 0x02) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*2), y
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if (bits_offscr_actor & 0x04) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*1), y
	: ; }

	pla
	lsr	a
	bcc	:+ ; if (bits_offscr_actor & 0x08) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		sta	OAM_DMA_BUFFER+OBJ_POS_V+(OBJ_SIZE*0), y
	: ; }

	rts
