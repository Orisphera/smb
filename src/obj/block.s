.include	"system/cpu.i"

.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/tiles.i"
.include	"engine/sound.i"

.include	"engine/unk.i"

; -----------------------------------------------------------
BLOCK_TIMER_VAL		= 11
BLOCK_PLAYER_OFFSET_X	= 8
BLOCK_ITEM_VELOC_Y	= <-2
BLOCK_PLAYER_VELOC_Y	= <-2

BLOCK_BITS_B_OFFSET_Y	= 8
BLOCK_BITS_VELOC_X	= <-16
BLOCK_BITS_VELOC_Y	= <-6
BLOCK_BITS_B_VELOC_Y	= <-4
; -----------------------------------------------------------
block_punch_tile_id_b	= zp_byte_00
block_punch_tile_id_a	= zp_byte_05

block_punch_off_y:
	.byte	4, 18
; -----------------------------
	.export block_punch
block_punch:
	pha

	lda	#block_states::punch_bump
	ldx	obj_data_offset_ctl
	ldy	player_size
	bne	:+ ; if (player.size == large) {
		lda	#block_states::punch_break
	: ; }
	sta	state_block, x

	jsr	gfx_meta_destroy

	ldx	obj_data_offset_ctl
	lda	pos_y_block_proc
	sta	pos_y_orig_block, x
	tay
	lda	eng_buffer_ptr
	sta	block_buffer_idx, x
	lda	(eng_buffer_ptr), y
	jsr	block_is_tile
	sta	block_punch_tile_id_b
	ldy	player_size
	bne	:+ ; if (player.size == large) {
		tya
	: ; }
	bcc	:++++ ; if (this.is_block) {
		ldy	#block_states::punch_bump
		sty	state_block, x

		lda	#metatile_3::block_invis
		ldy	block_punch_tile_id_b
		cpy	#metatile_1::brick_g
		beq	:+
		cpy	#metatile_1::brick_l
		bne	:++++
		: ; if (this.tile.in(metatile_1::brick_g, metatile_1::brick_l)) {
			lda	eng_block_time
			bne	:+ ; if (this.block_time == 0) {
				lda	#BLOCK_TIMER_VAL
				sta	timer_block
				inc	eng_block_time
			: ; }
		
			lda	timer_block
			bne	:+ ; if (this.timer == 0) {
				ldy	#metatile_3::block_invis
			: ; }
			tya
		; }
	: ; }
	sta	block_tile, x
	jsr	block_initpos

	ldy	pos_y_block_proc
	lda	#metatile_0::blank_d
	sta	(eng_buffer_ptr), y
	lda	#BLOCK_TIMER_BOUNCE
	sta	timer_block_bounce	

	pla
	sta	block_punch_tile_id_a

	ldy	#0
	lda	player_crouch
	bne	:+
	lda	player_size
	beq	:++
	: ; if (player.crouch || player.size == small) {
		iny
	: ; }

	lda	pos_y_lo_player
	clc
	adc	block_punch_off_y, y
	and	#CLAMP_16
	sta	pos_y_lo_block, x

	ldy	state_block, x
	cpy	#block_states::punch_bump
	beq	:+ ; if (this.state != punch_bump) {
		jsr	block_break
		jmp	:++
	: ; } else {
		jsr	block_item
	: ; }

	lda	obj_data_offset_ctl
	eor	#1
	sta	obj_data_offset_ctl
	rts
; ------------------------------------------------------------
	.export block_initpos
block_initpos:
	lda	pos_x_lo_player
	clc
	adc	#<BLOCK_PLAYER_OFFSET_X
	and	#CLAMP_16
	sta	pos_x_lo_block, x
	lda	pos_x_hi_player
	adc	#>BLOCK_PLAYER_OFFSET_X
	sta	pos_x_hi_block, x
	sta	block_page_loc, x
	lda	pos_y_hi_player
	sta	pos_y_hi_block, x
	rts
; ------------------------------------------------------------
block_item:
	jsr	block_top_check

	lda	#sfx_pulse1::bump
	sta	apu_pulse1_queue

	lda	#0
	sta	veloc_x_block, x
	sta	accel_y_block, x
	sta	veloc_y_player
	lda	#BLOCK_ITEM_VELOC_Y
	sta	veloc_y_block, x

	lda	block_punch_tile_id_a
	jsr	block_is_tile
	bcc	block_item_rts ; if (this.is_block) {
		tya
		cmp	#(block_item_end-block_item_start)/2
		bcc	:+ ; if (y >= end) {
			.if	.defined(SMBM)|.defined(VS_SMB)
			sbc	#(block_item_mid-block_item_start)/2
			.elseif	.defined(SMB2)
			sbc	#(block_item_mid_b-block_item_start)/2
			.endif
		: ; }
		jsr	eng_farjump
		block_item_start:
		.addr	block_mushroom_reg

		.if	.defined(SMB2)
			.addr	block_mushroom_poison
		.endif

		.addr	misc_init_coin_a
		.addr	misc_init_coin_a
		.addr	block_mushroom_oneup

		.if	.defined(SMB2)
			.addr	block_mushroom_poison
		.endif

		block_item_mid_b:
		.addr	block_mushroom_reg

		block_item_mid:
		.if	.defined(SMB2M)
			.addr	block_mushroom_reg
		.endif

		.if	.defined(SMB2)
			.addr	block_mushroom_poison
		.endif

		.addr	block_vine
		.addr	block_star
		.addr	misc_init_coin_a
		.addr	block_mushroom_oneup
		block_item_end:
	; }
; -----------------------------
block_mushroom_reg:
	lda	#powerup_type::mushroom_reg

.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	block_powerup
.endif

block_star:
	lda	#powerup_type::star

.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	block_powerup
.endif

.if	.defined(SMB2)
block_mushroom_poison:
	lda	#powerup_type::mushroom_poison

	.if	.defined(CONS)
		.byte	BIT_ABS_OPCODE
	.elseif	.defined(VS)
		jmp	block_powerup
	.endif
.endif

block_mushroom_oneup:
	lda	#powerup_type::mushroom_oneup

block_powerup:
	sta	eng_powerup_type
	jmp	actor_init_powerup_b
; -----------------------------
block_vine:
	ldx	#$05
	ldy	obj_data_offset_ctl
	jsr	game_proc_vine_init

block_item_rts:
	rts
; ------------------------------------------------------------
	.export block_tiles
block_tiles:
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	metatile_3::block_q_b, metatile_3::block_q_a
	.elseif	.defined(SMB2)
		.byte	metatile_3::block_q_a, metatile_3::block_q_b
	.endif

	.if	.defined(SMB2)
		.byte	metatile_3::block_q_c, metatile_1::blank_e
	.endif

	.if	.defined(SMB2M)
		.byte	metatile_1::blank_d
	.endif

	.byte	metatile_1::blank_b, metatile_1::blank_c

	.if	.defined(SMB2)
		.byte	metatile_1::brick_n
	.endif

	.byte	metatile_1::brick_d, metatile_1::brick_e
	.byte	metatile_1::brick_f, metatile_1::brick_g
	.byte	metatile_1::brick_h

	.if	.defined(SMB2)
		.byte	metatile_1::brick_o
	.endif

	.byte	metatile_1::brick_i, metatile_1::brick_j
	.byte	metatile_1::brick_k, metatile_1::brick_l
	.byte	metatile_1::brick_m
block_tiles_end:
; -----------------------------
block_is_tile:
	ldy	#(block_tiles_end-block_tiles)-1
	: ; for (tile of block_tiles) {
		cmp	block_tiles, y
		beq	:+
	
		dey
		bpl	:- ; if (no_match) {
			clc
		; }
	: ; }

	rts
; ------------------------------------------------------------
block_break:
	jsr	block_top_check
	lda	#sfx_noise::block_break_01
	sta	block_rep_flag, x
	sta	apu_noise_event
	jsr	block_bits_init
	lda	#BLOCK_PLAYER_VELOC_Y
	sta	veloc_y_player
	lda	#5
	sta	score_digit_mod+6
	jsr	misc_proc_coin_update_score
	ldx	obj_data_offset_ctl
	rts
; ------------------------------------------------------------
BLOCK_TOP_MISC_OFFSET_Y	= 16
; ------------------------------------------------------------
block_top_check:
	ldx	obj_data_offset_ctl
	ldy	pos_y_block_proc
	beq	:+ ; if (pos_y_block_proc) {
		tya
		sec
		sbc	#BLOCK_TOP_MISC_OFFSET_Y
		sta	pos_y_block_proc
		tay
		lda	(eng_buffer_ptr), y
		cmp	#metatile_3::coin_a
		bne	:+ ; if (eng_buffer_ptr[block_proc.pos_y-offset.y] == metatile_3::coin_a) {
			lda	#metatile_0::blank_a
			sta	(eng_buffer_ptr), y
			jsr	gfx_clear_small

			ldx	obj_data_offset_ctl
			jsr	misc_init_coin_b
		; }
	: ; }

	rts
; ------------------------------------------------------------
block_bits_init:
	lda	pos_x_lo_block, x
	sta	pos_x_orig_block, x
	lda	#BLOCK_BITS_VELOC_X
	sta	veloc_x_block, x
	sta	veloc_x_block+2, x
	lda	#BLOCK_BITS_VELOC_Y
	sta	veloc_y_block, x
	lda	#BLOCK_BITS_B_VELOC_Y
	sta	veloc_y_block+2, x
	lda	#0
	sta	accel_y_block, x
	sta	accel_y_block+2, x
	lda	pos_x_hi_block, x
	sta	pos_x_hi_block+2, x
	lda	pos_x_lo_block, x
	sta	pos_x_lo_block+2, x
	lda	pos_y_lo_block, x
	clc
	adc	#BLOCK_BITS_B_OFFSET_Y
	sta	pos_y_lo_block+2, x
	lda	#BLOCK_BITS_VELOC_Y
	sta	veloc_y_block, x
	rts
; ------------------------------------------------------------
	.export block_proc
block_proc:
	lda	state_block, x
	beq	:++++ ; if (this.state != inactive) {
		and	#BLOCK_STATE_PROC_MASK
		pha

		tay
		txa
		clc
		adc	#ENG_BLOCK_OFF
		tax
		dey
		beq	:++ ; if ((this.state & 0xF) == 1) {
			jsr	motion_block_fall_fast
			jsr	motion_x_do
			txa
			clc
			adc	#2
			tax
			jsr	motion_block_fall_fast
			jsr	motion_x_do

			ldx	actor_index
			jsr	lib_calc_block_pos
			jsr	lib_block_bits_get
			jsr	render_block_bits

			pla
			ldy	pos_y_hi_block, x
			beq	:++++ ; if (block.pos_y.hi) {
				pha

				lda	#240
				cmp	pos_y_lo_block+2, x
				bcs	:+ ; if (that.pos_y.lo < 240) {
					sta	pos_y_lo_block+2, x
				: ; }
		
				lda	pos_y_lo_block, x
				cmp	#240

				pla
				bcc	:+++
				bcs	:++
			; }
		: ; } else {
			jsr	motion_block_fall_fast
			ldx	actor_index
			jsr	lib_calc_block_pos
			jsr	lib_block_bits_get
			jsr	render_block
			lda	pos_y_lo_block, x
			and	#MOD_16
			cmp	#5

			pla
			bcs	:++ ; if ((this.pos_y.lo % 16) < 5) {
				lda	#1
				sta	block_rep_flag, x
			; }
		; }
	: ; }

	; if () {
		lda	#block_states::inactive
	: ; }
	sta	state_block, x
	rts
; ------------------------------------------------------------
	.export block_flatten
block_flatten:
	ldx	#ACTIVE_BLOCK_MAX-1
	: ; for (block of blocks) {
		stx	actor_index

		lda	ppu_nmi_buffer_0_data
		bne	:+
		lda	block_rep_flag, x
		beq	:+ ; if (*ppu_nmi_buffer == NMI_DATA_END && block_rep_flag[actor_index]) {
			lda	block_buffer_idx, x
			sta	eng_buffer_ptr
			lda	#5
			sta	eng_buffer_ptr+1
			lda	pos_y_orig_block, x
			sta	pos_y_block_proc
			tay
			lda	block_tile, x
			sta	(eng_buffer_ptr), y
			jsr	gfx_meta_replace

			lda	#0
			sta	block_rep_flag, x
		: ; }

		dex
		bpl	:--
	; }

	rts
