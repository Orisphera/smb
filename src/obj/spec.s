.include	"../../inc/system/cpu.i"

.include	"../../inc/engine/tunables.i"
.include	"../../inc/engine/tiles.i"

.include	"../../inc/engine/unk.i"

OBJ_MISC_POWERUP_ACTOR	= (ENG_ACTOR_MAX-1)

obj_spec_powerup_init:
	lda	#actor::power_up
	sta	actor_id+OBJ_MISC_POWERUP_ACTOR
	lda	eng_spec_pos_x_hi, x
	sta	eng_actor_pos_x_hi+OBJ_MISC_POWERUP_ACTOR
	lda	eng_spec_pos_x_lo, x
	sta	eng_actor_pos_x_lo+OBJ_MISC_POWERUP_ACTOR
	lda	#1
	sta	eng_actor_pos_y_hi+OBJ_MISC_POWERUP_ACTOR
	lda	eng_spec_pos_y_lo, x
	sec
	sbc	#8
	sta	eng_actor_pos_y_lo+OBJ_MISC_POWERUP_ACTOR
	lda	#1
	sta	state_actor+OBJ_MISC_POWERUP_ACTOR
	sta	actor_mode+OBJ_MISC_POWERUP_ACTOR
	lda	#3
	sta	eng_actor_col_box+OBJ_MISC_POWERUP_ACTOR

	lda	eng_powerup_type
	cmp	#powerup_type::star
	bcs	:++ ; if (powerup.type < star) {
		lda	eng_player_status
		cmp	#2
		bcc	:+ ; if (player.status >= 2) {
			lsr	a
		: ; }
		sta	eng_powerup_type
	: ; }

	lda	#$20
	sta	ppu_nmi_buffer+$CA
	lda	#$02
	sta	apu_pulse2_queue
	rts
; ------------------------------------------------------------
obj_spec_powerup_do:
	ldx	#OBJ_MISC_POWERUP_ACTOR
	stx	actor_index
	lda	state_actor+OBJ_MISC_POWERUP_ACTOR
	beq	:+++++ ; if (powerup.state) {
		asl	a
		bcc	:++
		lda	eng_timer_ctl
		bne	:++++
		lda	eng_powerup_type
		beq	:+
		cmp	#powerup_type::mushroom_b
		beq	:+
		.if	.defined(SMB2M)
			cmp	#powerup_type::type_04
			beq	:+
			cmp	#powerup_type::type_05
			beq	:+
		.endif
		cmp	#powerup_type::star
		bne	:++++ ; if ((powerup.state & 0x80) && !eng_timer_ctl && powerup.type == star) {
			jsr	actor_bounce
			jsr	col_actor_bounce_proc
			jmp	:++++
		: ; } else if ((powerup.state & 0x80) && !eng_timer_ctl && powerup.type.in(mushroom_a, mushroom_b, type_03, type_04)) {
			jsr	actor_move
			jsr	col_actor_ground_proc
			jmp	:+++
		: ; } else if (!eng_timer_ctl) {
			lda	frame_count
			and	#3
			bne	:+ ; if (frame_count % 4) {
				dec	eng_actor_pos_y_lo+OBJ_MISC_POWERUP_ACTOR
				lda	state_actor+OBJ_MISC_POWERUP_ACTOR
				inc	state_actor+OBJ_MISC_POWERUP_ACTOR
				cmp	#$11
				bcc	:+ ; if (powerup.state >= 0x11) {
					lda	#16
					sta	eng_actor_veloc_x, x
					lda	#$80
					sta	state_actor+OBJ_MISC_POWERUP_ACTOR
					asl	a
					sta	ppu_nmi_buffer+$CA
					rol	a
					sta	eng_actor_motion_dir, x
				; }
			: ; }

			lda	state_actor+OBJ_MISC_POWERUP_ACTOR
			cmp	#6
			bcc	:++
		: ; }

		; if ((!(powerup.state & 0x80) && eng_timer_ctl) || powerup.type.in(mushroom_a, star, mushroom_b) || powerup.state >= 6) {
			jsr	lib_calc_actor_pos
			jsr	lib_actor_bits_get
			jsr	col_actor_box
			jsr	render_powerup
			jsr	col_player_actor_proc
			jsr	col_actor_oob_proc
		; }
	: ; }

	rts
; ------------------------------------------------------------
obj_spec_block_punch_off_y:
	.byte	$04, $12
; -----------------------------
obj_spec_block_punch:
	pha

	lda	#$11
	ldx	ppu_nmi_buffer+$EE
	ldy	eng_player_size
	bne	:+ ; if (player.size == large) {
		lda	#$12
	: ; }
	sta	state_spec, x

	jsr	gfx_meta_destroy

	ldx	ppu_nmi_buffer+$EE
	lda	zp_byte_02
	sta	ppu_nmi_buffer+$E4, x
	tay
	lda	eng_buffer_ptr
	sta	ppu_nmi_buffer+$E6, x
	lda	(eng_buffer_ptr), y
	jsr	obj_spec_block_is_tile
	sta	zp_byte_00
	ldy	eng_player_size
	bne	:+ ; if (player.size == large) {
		tya
	: ; }
	bcc	:++++ ; if (this.is_tile) {
		ldy	#$11
		sty	state_spec, x

		lda	#CASTLE_BRIDGE_TILE_A
		ldy	zp_byte_00
		cpy	#BLOCK_TILE_A
		beq	:+
		cpy	#BLOCK_TILE_B
		bne	:++++
		: ; if (this.tile.in(BLOCK_TILE_A, BLOCK_TILE_B)) {
			lda	eng_block_time
			bne	:+ ; if (!eng_block_timer) {
				lda	#$0B
				sta	eng_timer_block
				inc	eng_block_time
			: ; }
		
			lda	eng_timer_block
			bne	:+ ; if (!eng_timer_block) {
				ldy	#CASTLE_BRIDGE_TILE_A
			: ; }
			tya
		; }
	: ; }
	sta	eng_spec_tile, x
	jsr	obj_spec_block_initpos

	ldy	zp_byte_02
	lda	#BLOCK_TILE_C
	sta	(eng_buffer_ptr), y
	lda	#$10
	sta	eng_timer_block_bounce	

	pla
	sta	zp_byte_05

	ldy	#0
	lda	eng_crouch
	bne	:+
	lda	eng_player_size
	beq	:++
	: ; if (eng_crouch || player.size == small) {
		iny
	: ; }

	lda	eng_player_pos_y_lo
	clc
	adc	obj_spec_block_punch_off_y, y
	and	#$F0
	sta	eng_spec_pos_y_lo, x

	ldy	state_spec, x
	cpy	#$11
	beq	:+ ; if (this.state != 0x11) {
		jsr	obj_spec_block_break
		jmp	:++
	: ; } else {
		jsr	obj_spec_block_item
	: ; }

	lda	ppu_nmi_buffer+$EE
	eor	#1
	sta	ppu_nmi_buffer+$EE
	rts
; ------------------------------------------------------------
	.export obj_spec_block_initpos
obj_spec_block_initpos:
	lda	eng_player_pos_x_lo
	clc
	adc	#8
	and	#$F0
	sta	eng_spec_pos_x_lo, x
	lda	eng_player_pos_x_hi
	adc	#0
	sta	eng_spec_pos_x_hi, x
	sta	ppu_nmi_buffer+$EA, x
	lda	eng_player_pos_y_hi
	sta	eng_spec_pos_y_hi, x
	rts
; ------------------------------------------------------------
obj_spec_block_item:
	jsr	obj_spec_block_top_check

	lda	#$02
	sta	apu_pulse1_queue

	lda	#0
	sta	eng_spec_veloc_x, x
	sta	eng_spec_accel_y, x
	sta	eng_player_veloc_y
	lda	#<-2
	sta	eng_spec_veloc_y, x

	lda	zp_byte_05
	jsr	obj_spec_block_is_tile
	bcc	obj_spec_block_item_rts ; if (this.is_tile) {
		tya
		cmp	#(obj_spec_block_item_end-obj_spec_block_item_start)/2
		bcc	:+ ; if (y >= end) {
			.if	.defined(SMBM)|.defined(VS_SMB)
			sbc	#(obj_spec_block_item_mid-obj_spec_block_item_start)/2
			.elseif	.defined(SMB2)
			sbc	#(obj_spec_block_item_mid_b-obj_spec_block_item_start)/2
			.endif
		: ; }
		jsr	eng_farjump
		obj_spec_block_item_start:
		.addr	obj_spec_block_mushroom_a

		.if	.defined(SMB2)
			.addr	obj_spec_block_powerup_4
		.endif

		.addr	obj_misc_block_coin_a
		.addr	obj_misc_block_coin_a
		.addr	obj_spec_block_mushroom_b

		.if	.defined(SMB2)
			.addr	obj_spec_block_powerup_4
		.endif

		obj_spec_block_item_mid_b:
		.addr	obj_spec_block_mushroom_a

		obj_spec_block_item_mid:
		.if	.defined(SMB2M)
			.addr	obj_spec_block_mushroom_a
		.endif

		.if	.defined(SMB2)
			.addr	obj_spec_block_powerup_4
		.endif

		.addr	obj_spec_block_vine
		.addr	obj_spec_block_star
		.addr	obj_misc_block_coin_a
		.addr	obj_spec_block_mushroom_b
		obj_spec_block_item_end:
	; }
; -----------------------------
obj_spec_block_mushroom_a:
	lda	#powerup_type::mushroom_a

.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	obj_spec_block_powerup
.endif

obj_spec_block_star:
	lda	#powerup_type::star

.if	.defined(CONS)
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	obj_spec_block_powerup
.endif

.if	.defined(SMB2)
obj_spec_block_powerup_4:
	lda	#powerup_type::type_04

	.if	.defined(CONS)
		.byte	BIT_ABS_OPCODE
	.elseif	.defined(VS)
		jmp	obj_spec_block_powerup
	.endif
.endif

obj_spec_block_mushroom_b:
	lda	#powerup_type::mushroom_b

obj_spec_block_powerup:
	sta	eng_powerup_type
	jmp	obj_spec_powerup_init
; -----------------------------
obj_spec_block_vine:
	ldx	#$05
	ldy	ppu_nmi_buffer+$EE
	jsr	game_proc_vine_init

obj_spec_block_item_rts:
	rts
; ------------------------------------------------------------
	.export obj_spec_block_tiles
obj_spec_block_tiles:
	.if	.defined(SMBM)|.defined(VS_SMB)
		.byte	BLOCK_TILE_E, BLOCK_TILE_D
	.elseif	.defined(SMB2)
		.byte	BLOCK_TILE_D, BLOCK_TILE_E
	.endif

	.if	.defined(SMB2)
		.byte	BLOCK_TILE_P, BLOCK_TILE_Q
	.endif

	.if	.defined(SMB2M)
		.byte	BLOCK_TILE_R
	.endif

	.byte	BLOCK_TILE_F, BLOCK_TILE_G

	.if	.defined(SMB2)
		.byte	BLOCK_TILE_S
	.endif

	.byte	BLOCK_TILE_H, BLOCK_TILE_I
	.byte	BLOCK_TILE_J, BLOCK_TILE_A
	.byte	BLOCK_TILE_K

	.if	.defined(SMB2)
		.byte	BLOCK_TILE_T
	.endif

	.byte	BLOCK_TILE_L, BLOCK_TILE_M
	.byte	BLOCK_TILE_N, BLOCK_TILE_B
	.byte	BLOCK_TILE_O
obj_spec_block_tiles_end:
; -----------------------------
obj_spec_block_is_tile:
	ldy	#(obj_spec_block_tiles_end-obj_spec_block_tiles)-1
	: ; for (tile of obj_spec_block_tiles) {
		cmp	obj_spec_block_tiles, y
		beq	:+
	
		dey
		bpl	:- ; if (no_match) {
			clc
		; }
	: ; }

	rts
; ------------------------------------------------------------
obj_spec_block_break:
	jsr	obj_spec_block_top_check
	lda	#1
	sta	ppu_nmi_buffer+$EC, x
	sta	apu_noise_event
	jsr	obj_spec_block_bits_init
	lda	#<-2
	sta	eng_player_veloc_y
	lda	#5
	sta	STACK_BASE+$39
	jsr	obj_misc_update_score
	ldx	ppu_nmi_buffer+$EE
	rts
; ------------------------------------------------------------
obj_spec_block_top_check:
	ldx	ppu_nmi_buffer+$EE
	ldy	zp_byte_02
	beq	:+ ; if (zp_byte_02) {
		tya
		sec
		sbc	#$10
		sta	zp_byte_02
		tay
		lda	(eng_buffer_ptr), y
		cmp	#COINROW_TILE_A
		bne	:+ ; if (eng_buffer_ptr[zp_byte_02-0x10] == COINROW_TILE_A) {
			lda	#0
			sta	(eng_buffer_ptr), y
			jsr	gfx_clear_small
			ldx	ppu_nmi_buffer+$EE
			jsr	obj_misc_block_coin_b
		; }
	: ; }

	rts
; ------------------------------------------------------------
obj_spec_block_bits_init:
	lda	eng_spec_pos_x_lo, x
	sta	ppu_nmi_buffer+$F1, x
	lda	#<-16
	sta	eng_spec_veloc_x, x
	sta	eng_spec_veloc_x+2, x
	lda	#<-6
	sta	eng_spec_veloc_y, x
	lda	#<-4
	sta	eng_spec_veloc_y+2, x
	lda	#0
	sta	eng_spec_accel_y, x
	sta	eng_spec_accel_y+2, x
	lda	eng_spec_pos_x_hi, x
	sta	eng_spec_pos_x_hi+2, x
	lda	eng_spec_pos_x_lo, x
	sta	eng_spec_pos_x_lo+2, x
	lda	eng_spec_pos_y_lo, x
	clc
	adc	#8
	sta	eng_spec_pos_y_lo+2, x
	lda	#<-6
	sta	eng_spec_veloc_y, x
	rts
; ------------------------------------------------------------
	.export obj_spec_block_proc
obj_spec_block_proc:
	lda	state_spec, x
	beq	:++++ ; if (this.state != 0) {
		and	#$0F
		pha

		tay
		txa
		clc
		adc	#ENG_SPECIAL_OFF
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
			jsr	lib_calc_spec_pos
			jsr	lib_spec_bits_get
			jsr	render_block_bits

			pla
			ldy	eng_spec_pos_y_hi, x
			beq	:++++ ; if (this.pos_y.hi) {
				pha

				lda	#$F0
				cmp	eng_spec_pos_y_lo+2, x
				bcs	:+ ; if (that.pos_y.lo < 0xF0) {
					sta	eng_spec_pos_y_lo+2, x
				: ; }
		
				lda	eng_spec_pos_y_lo, x
				cmp	#$F0

				pla
				bcc	:+++
				bcs	:++
			; }
		: ; } else {
			jsr	motion_block_fall_fast
			ldx	actor_index
			jsr	lib_calc_spec_pos
			jsr	lib_spec_bits_get
			jsr	render_block
			lda	eng_spec_pos_y_lo, x
			and	#$0F
			cmp	#5

			pla
			bcs	:++ ; if ((this.pos_y.lo & 0xF) < 5) {
				lda	#1
				sta	ppu_nmi_buffer+$EC, x
			; }
		; }
	: ; }

	; if () {
		lda	#0
	: ; }
	sta	state_spec, x
	rts
; ------------------------------------------------------------
	.export obj_spec_block_flatten
obj_spec_block_flatten:
	ldx	#ACTIVE_BLOCK_MAX-1
	: ; for (block of blocks) {
		stx	actor_index

		lda	ppu_nmi_buffer+$01
		bne	:+
		lda	ppu_nmi_buffer+$EC, x
		beq	:+ ; if (!ppu_nmi_buffer[1] && ppu_nmi_buffer[0xEC]) {
			lda	ppu_nmi_buffer+$E6, x
			sta	eng_buffer_ptr
			lda	#5
			sta	eng_buffer_ptr+1
			lda	ppu_nmi_buffer+$E4, x
			sta	zp_byte_02
			tay
			lda	ppu_nmi_buffer+$E8, x
			sta	(eng_buffer_ptr), y
			jsr	gfx_meta_replace

			lda	#0
			sta	ppu_nmi_buffer+$EC, x
		: ; }

		dex
		bpl	:--
	; }

	rts
