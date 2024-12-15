.include	"mem.i"
.include	"misc.i"
.include	"sound.i"

	.export actor_init_vine
	.export	actor_B_1A_init
actor_init_vine:
actor_B_1A_init:
	lda	#actor::vine
	sta	obj_id_actor, x
	lda	#proc_id_actors::active
	sta	proc_id_actor, x
	lda	pos_x_hi_block, y
	sta	pos_x_hi_actor, x
	lda	pos_x_lo_block, y
	sta	pos_x_lo_actor, x

	lda	pos_y_lo_block, y
	sta	pos_y_lo_actor, x
	ldy	actor_vine_flag
	bne	:+ ; if (!actor_vine_flag) {
		sta	pos_y_vine
	: ; }

	txa
	sta	actor_vine_offset, y
	inc	actor_vine_flag
	lda	#sfx_pulse_2::spawn_vine
	sta	apu_sfx_pulse_2_req
	rts
; ------------------------------------------------------------
GAME_PROC_VINE_ACTOR_ID	= (ENG_ACTOR_MAX-1)

actor_proc_vine_heights:
	.byte	$30, $60
; -----------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(ANN)
VINE_DO_VAR0	= $26
.elseif	.defined(SMB2)
VINE_DO_VAR0	= $23
.endif

	.export actor_proc_vine
	.export	actor_B_1A_proc
actor_proc_vine:
actor_B_1A_proc:
	cpx	#5
.if	.defined(SMB)
	bne	:+++++ ; if (x == 5) {
.elseif	.defined(VS_SMB)|.defined(SMBV2)
	beq	:+ ; if (x != 5) {
		rts
	: ; }
.endif
		ldy	actor_vine_flag
		dey
		lda	height_vine
		cmp	actor_proc_vine_heights, y
		beq	:+
		lda	frame_count
		lsr	a
		lsr	a
		bcc	:+ ; if (height_vine != actor_proc_vine_heights[actor_vine_flag] && frame_count % 4) {
			lda	pos_y_lo_actor+GAME_PROC_VINE_ACTOR_ID
			sbc	#1
			sta	pos_y_lo_actor+GAME_PROC_VINE_ACTOR_ID
			inc	height_vine
		: ; }
	
		lda	height_vine
		cmp	#8
		bcc	:++++ ; if (height_vine >= 8) {
			jsr	pos_calc_x_rel_actor
			jsr	pos_bits_get_actor

			ldy	#0
			: ; for (y = 0; y < actor_vine_flag; y++) {
				jsr	render_vine

				iny
				cpy	actor_vine_flag
				bne	:-
			; }
		
			lda	bits_offscr_actor
			and	#%00001100
			beq	:++ ; if (bits_offscr_actor & 0x0C) {
				dey
				: ; for (y = actor_vine_flag - 1; y >= 0; y--) {
					ldx	actor_vine_offset, y
					jsr	actor_erase

					dey
					bpl	:-
				; }

				sta	actor_vine_flag
				sta	height_vine
			: ; }
		
			lda	height_vine
			cmp	#$20
			bcc	:+ ; if (height_vine >= 0x20) {
				ldx	#$06
				lda	#$01
				ldy	#$1B
				jsr	col_box_buffer

				ldy	zp_byte_02
				cpy	#$D0
				bcs	:+
				lda	(game_buffer), y
				bne	:+ ; if (zp_byte_02 < 0xD0 && !game_buffer[zp_byte_02]) {
					lda	#VINE_DO_VAR0
					sta	(game_buffer), y
				; }
			; }
		; }
	: ; }

	.if	.defined(VS_SMB)|.defined(SMBV2)
		lda	pos_x_lo_actor+GAME_PROC_VINE_ACTOR_ID
		sec
		sbc	pos_x_lo_screen_left
		tay
		lda	pos_x_hi_actor+GAME_PROC_VINE_ACTOR_ID
		sbc	pos_x_hi_screen_left
		bmi	:+
		cpy	#9
		bcs	:++++
		: ; if (screen_left.pos_x.hi < 0 || (actor.pos_x.lo - screen_left.pos_x.lo) < 9) {
			lda	#proc_id_actors::free
			sta	proc_id_actor+GAME_PROC_VINE_ACTOR_ID
			lda	pos_x_hi_actor+GAME_PROC_VINE_ACTOR_ID
			and	#1
			.if	.defined(VS_SMB)
				nop
			.endif
			tay
			lda	scenery_buffer_ptr_lo, y
			sta	game_buffer
			lda	scenery_buffer_ptr_hi, y
			sta	game_buffer+1

			lda	pos_x_lo_actor+GAME_PROC_VINE_ACTOR_ID
			lsr	a
			lsr	a
			lsr	a
			lsr	a
			: ; for (a = actor.pos_x.lo / 16; a < 0xD0; a += 0x10) {
				tay
				lda	(game_buffer), y
				cmp	#VINE_DO_VAR0
				bne	:+ ; if (game_buffer[a] == vine_do_var0) {
					lda	#0
					sta	(game_buffer), y
				: ; }

				tya
				clc
				adc	#$10
				cmp	#$D0
				bcc	:--
			; }
		: ; }
	.endif

	ldx	actor_index
	rts
