.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/sound.i"

.include	"engine/unk.i"

; ------------------------------------------------------------
obj_hammer_actor_id:
	.byte	4, 4, 4, 5, 5, 5, 6, 6, 6
obj_hammer_actor_id_end:

obj_hammer_veloc_x:
	.byte	16, <-16
; -----------------------------
	.export obj_hammer_init
obj_hammer_init:
	lda	eng_rand_seed+1
	and	#(obj_hammer_actor_id_end-obj_hammer_actor_id)-2
	bne	:+ ; if (!(eng_rand_seed[1] % obj_hammer_actor_id_count)) {
		lda	eng_rand_seed+1
		and	#(obj_hammer_actor_id_end-obj_hammer_actor_id)-1
	: ; }
	tay

	lda	state_misc, y
	bne	:+
	ldx	obj_hammer_actor_id, y
	lda	actor_mode, x
	bne	:+ ; if (obj_rand.state == 0 && obj_rand.mode == free) {
		ldx	actor_index
		txa
		sta	misc_actor_id, y
		lda	#$90
		sta	state_misc, y
		lda	#7
		sta	col_box_misc, y
		sec
		rts
	: ; } else {
		ldx	actor_index
		clc
		rts
	; }
; -----------------------------
obj_hammer_do:
	lda	eng_timer_ctl
	bne	:++++ ; if (!eng_timer_ctl) {
		lda	state_misc, x
		and	#$7F
		ldy	misc_actor_id, x
		cmp	#2
		beq	:+
		bcs	:++ ; if ((this.state & 0x7F) < 2) {
			txa
			clc
			adc	#ENG_MISC_OFF
			tax

			lda	#16
			sta	motion_gravity_accel_y_inc
			lda	#15
			sta	motion_gravity_accel_y_dec
			lda	#4
			sta	motion_gravity_veloc_y_max_abs
			lda	#0
			jsr	motion_gravity
			jsr	motion_x_do

			ldx	actor_index
			jmp	:+++
		: ; } else {
			; if (this.state == 2) {
				lda	#<-2
				sta	veloc_y_misc, x

				lda	state_actor, y
				and	#<~actor_states::bit_3
				sta	state_actor, y

				ldx	motion_dir_actor, y
				dex
				lda	obj_hammer_veloc_x, x
				ldx	actor_index
				sta	veloc_x_misc, x
			: ; }
	
			dec	state_misc, x

			lda	pos_x_lo_actor, y
			clc
			adc	#2
			sta	pos_x_lo_misc, x

			lda	pos_x_hi_actor, y
			adc	#0
			sta	pos_x_hi_misc, x

			lda	pos_y_lo_actor, y
			sec
			sbc	#10
			sta	pos_y_lo_misc, x

			lda	#1
			sta	pos_y_hi_misc, x
			bne	:++
		: ; }

		; if (this.actor_id.in(0, 1)) {
			jsr	col_player_hammer_proc
		; }
	: ; }

	jsr	lib_misc_bits_get
	jsr	lib_calc_misc_pos
	jsr	col_misc_box
	jsr	render_hammer
	rts
; ------------------------------------------------------------
	.export obj_misc_block_coin_a, obj_misc_block_coin_b
obj_misc_block_coin_a:
	jsr	obj_misc_block_alloc
	lda	pos_x_hi_block, x
	sta	pos_x_hi_misc, y
	lda	pos_x_lo_block, x
	ora	#%00000101
	sta	pos_x_lo_misc, y
	lda	pos_y_lo_block, x
	sbc	#16
	sta	pos_y_lo_misc, y
	jmp	obj_misc_block_coin
; -----------------------------
obj_misc_block_coin_b:
	jsr	obj_misc_block_alloc
	lda	block_page_loc, x
	sta	pos_x_hi_misc, y
	lda	zp_byte_06
	asl	a
	asl	a
	asl	a
	asl	a
	ora	#%00000101
	sta	pos_x_lo_misc, y
	lda	zp_byte_02
	adc	#32
	sta	pos_y_lo_misc, y

obj_misc_block_coin:
	lda	#<-5
	sta	veloc_y_misc, y
	lda	#sfx_pulse2::coin_01
	sta	pos_y_hi_misc, y
	sta	state_misc, y
	sta	apu_pulse2_queue
	stx	actor_index
	jsr	obj_misc_add_coin
	inc	eng_bonus_oneup_tally
	rts
; -----------------------------
obj_misc_block_alloc:
	ldy	#ENG_MISC_MAX-1
	: ; for (obj of misc) {
		lda	state_misc, y
		beq	:+

		dey
		cpy	#5
		bne	:- ; if (index == 5) {
			ldy	#ENG_MISC_MAX-1
		; }
	: ; }
	sty	misc_block_id
	rts
; ------------------------------------------------------------
	.export	obj_misc_routine
obj_misc_routine:
	ldx	#ENG_MISC_MAX-1
	: ; for (obj of misc) {
		stx	actor_index
		lda	state_misc, x
		beq	:++++
		asl	a
		bcc	:+ ; if (this.state & 0x80) {
			jsr	obj_hammer_do
			jmp	:++++
		: ; } else if (this.state != 0) {
			ldy	state_misc, x
			dey
			beq	:+ ; if (this.state != 1) {
				inc	state_misc, x

				lda	pos_x_lo_misc, x
				clc
				adc	eng_scroll_amount
				sta	pos_x_lo_misc, x
				lda	pos_x_hi_misc, x
				adc	#0
				sta	pos_x_hi_misc, x

				lda	state_misc, x
				cmp	#$30
				bne	:++ ; if (this.state == 0x30) {
					lda	#0
					sta	state_misc, x
					jmp	:+++
				; }
			: ; } else {
				txa
				clc
				adc	#ENG_MISC_OFF
				tax

				lda	#$50
				sta	motion_gravity_accel_y_inc
				lda	#6
				sta	motion_gravity_veloc_y_max_abs
				lsr	a
				sta	motion_gravity_accel_y_dec
				lda	#0
				jsr	motion_gravity

				ldx	actor_index
				lda	veloc_y_misc, x
				cmp	#5
				bne	:+ ; if (this.veloc_y == 5) {
					inc	state_misc, x
				; }
			; }

			: ; if (this.state < 0x30) {
				jsr	lib_calc_misc_pos
				jsr	lib_misc_bits_get
				jsr	col_misc_box
				jsr	render_coin_score
			; }
		: ; }

		dex
		bpl	:-----
	; }

	rts
; ------------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	obj_misc_coin_players:
		.byte	$17, $1D

	obj_misc_score_players:
		.byte	$0B, $11

	obj_misc_stats_players:
		.byte	$02, $13

.endif

.if	.defined(VS)
	obj_misc_coin_max:
		.byte	COIN_MAX+(COIN_VS_INC*0)
		.byte	COIN_MAX+(COIN_VS_INC*1)
		.byte	COIN_MAX+(COIN_VS_INC*2)
		.byte	COIN_MAX+(COIN_VS_INC*3)
.endif
; -----------------------------
	.export obj_misc_update_score
	.export obj_misc_update_stats
	.export obj_misc_add_score
obj_misc_add_coin:
	lda	#1
	sta	STACK_BASE+$39
	.if	.defined(SMB)|.defined(VS_SMB)
		ldx	player_id
		ldy	obj_misc_coin_players, x
	.elseif	.defined(SMB2M)
		ldy	#$11
	.endif
	jsr	eng_stats_math
	inc	eng_coins
	lda	eng_coins

	.if	.defined(CONS)
		cmp	#COIN_MAX
	.elseif	.defined(VS)
		ldx	VS_RAM_ARENA0+2
		cmp	obj_misc_coin_max, x
	.endif
	bne	:++ ; if (eng_coins == COIN_MAX) {
		lda	#0
		sta	eng_coins

		.if	.defined(VS_SMB)
			ldx	player_id
			ldy	obj_misc_coin_players, x
			ldx	#4-1
			: ; for (x = 4-1; x > 0; x--) {
				sta	eng_score, y

				dey
				dex
				bpl	:-
			; }
		.else
			:
		.endif

		inc	eng_lives
		lda	#sfx_pulse2::oneup
		sta	apu_pulse2_queue
	: ; }

	lda	#$02
	sta	STACK_BASE+$38

obj_misc_update_score:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldx	player_id
		ldy	obj_misc_score_players, x
	.elseif	.defined(SMB2M)
		ldy	#$0B
	.endif
	jsr	eng_stats_math

obj_misc_update_stats:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	player_id
		lda	obj_misc_stats_players, y
	.elseif	.defined(SMB2M)
		lda	#$01
	.endif

obj_misc_add_score:
	jsr	eng_stats_print_num
	ldy	ppu_nmi_buffer_0_offset
	lda	OAM_DMA_BUFFER+$FB, y
	bne	:+ ; if (!OAM_DMA_BUFFER[0xFB]) {
		lda	#$24
		sta	OAM_DMA_BUFFER+$FB, y
	: ; }

	ldx	actor_index
	rts
