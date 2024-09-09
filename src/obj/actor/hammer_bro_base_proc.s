.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/joypad.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

; -----------------------------------------------------------
HAMMER_BRO_VELOC_X_A		= <-6
HAMMER_BRO_VELOC_X_B		= <-3
HAMMER_BRO_VELOC_CUTOFF_POS_Y	= 112

ACTOR_ACCEL_X_ABS	= 24
; -----------------------------------------------------------
actor_hammer_bro_timers:
	.byte	48, 28

actor_proc_accel_x:
	.byte	0, <-ACTOR_ACCEL_X_ABS
	.byte	0, ACTOR_ACCEL_X_ABS

actor_proc_veloc_x:
	.byte	ACTOR_HAMMER_BRO_VELOC_X, <-ACTOR_HAMMER_BRO_VELOC_X
	.byte	ACTOR_HAMMER_BRO_VELOC_X_HARD, <-ACTOR_HAMMER_BRO_VELOC_X_HARD
; ------------------------------
	.export actor_proc_hammer_bro
actor_proc_hammer_bro:
	lda	state_actor, x
	and	#actor_states::bit_5
	beq	:+ ; if (actor.state_bit_5) {
		jmp	actor_proc_base_defeated
	: ; } else {
		lda	eng_timer_hammer_bro_jump, x
		beq	actor_proc_hammer_bro_jump ; if (eng_timer_hammer_bro_jump) {
			dec	eng_timer_hammer_bro_jump, x
			lda	bits_offscr_actor
			and	#%00001100
			bne	actor_proc_hammer_bro_move_h ; if (!(bits_offscr_actor & 0x0C)) {
				lda	timer_hammer_throw, x
				bne	:+ ; if (timer_hammer_throw == 0) {
					ldy	game_hard_mode_b
					lda	actor_hammer_bro_timers, y
					sta	timer_hammer_throw, x
					jsr	misc_init_hammer
					bcc	:+ ; if (misc_init_hammer()) {
						lda	state_actor, x
						ora	#actor_states::bit_3
						sta	state_actor, x
						jmp	actor_proc_hammer_bro_move_h
					; }
				: ; }
			
				dec	timer_hammer_throw, x
				jmp	actor_proc_hammer_bro_move_h
			; } else actor_proc_hammer_bro_move_h();
		; } else actor_proc_hammer_bro_jump();
	; }
; ------------------------------
hammer_bro_jump_timers:
	.byte	32, 55
; ------------------------------
actor_proc_hammer_bro_jump_rand	= zp_byte_00

actor_proc_hammer_bro_jump:
	lda	state_actor, x
	and	#actor_states::state_mask
	cmp	#actor_states::state_1
	beq	:+++ ; if (actor.state != state_1) {
		lda	#0
		sta	actor_proc_hammer_bro_jump_rand
		ldy	#HAMMER_BRO_VELOC_X_A
		lda	pos_y_lo_actor, x
		bmi	:+
		ldy	#HAMMER_BRO_VELOC_X_B
		cmp	#HAMMER_BRO_VELOC_CUTOFF_POS_Y
		inc	actor_proc_hammer_bro_jump_rand
		bcc	:+ ; if (actor.pos_y.lo > veloc_cutoff_pos_y) {
			dec	actor_proc_hammer_bro_jump_rand
			lda	lib_rand+1, x
			and	#MOD_2
			bne	:+ ; if (!(lib_rand[1] % 2)) {
				ldy	#HAMMER_BRO_VELOC_X_A
			; }
		: ; }

		.export actor_proc_hammer_bro_jump_do
	actor_proc_hammer_bro_jump_do:
		sty	veloc_y_actor, x
	
		lda	state_actor, x
		ora	#actor_states::state_1
		sta	state_actor, x
	
		lda	actor_proc_hammer_bro_jump_rand
		and	lib_rand+2, x
		tay
		lda	game_hard_mode_b
		bne	:+ ; if (!game_hard_mode_b) {
			tay
		: ; }
		lda	hammer_bro_jump_timers, y
		sta	timer_ani_actor, x
		lda	lib_rand+1, x
		ora	#%11000000
		sta	eng_timer_hammer_bro_jump, x
	: ; }
; ------------------------------
actor_proc_hammer_bro_move_h:
	ldy	#<-HAMMER_BRO_VELOC_X_C_ABS
	lda	frame_count
	and	#MOD_128_64_UP
	bne	:+ ; if ((frame_count % 128) < 64) {
		ldy	#HAMMER_BRO_VELOC_X_C_ABS
	: ; }
	sty	veloc_x_actor, x

	ldy	#DIR_RIGHT
	jsr	col_player_bullet_diff
	bmi	:+ ; if (col_player_bullet_diff() >= 0) {
		iny
		lda	timer_actor, x
		bne	:+ ; if (!actor.timer) {
			lda	#HAMMER_BRO_VELOC_X_D
			sta	veloc_x_actor, x
		; }
	: ; }
	sty	motion_dir_actor, x
; -----------------------------------------------------------
	.export actor_proc_base
actor_proc_base:
	ldy	#0
	lda	state_actor, x
	and	#actor_states::bit_6
	bne	:+
	lda	state_actor, x
	asl	a
	bcs	:++++
	lda	state_actor, x
	and	#actor_states::bit_5
	bne	actor_proc_base_defeated
	lda	state_actor, x
	and	#actor_states::state_mask
	beq	:++++
	cmp	#actor_states::state_5
	beq	:+
	cmp	#actor_states::state_3
	bcs	:++++++
	: ; if ((actor.state & 0x40) || (!(actor.state & 0xA0) && actor.state.in(1, 2, 5))) {
		jsr	motion_y
	; }
	ldy	#0
	lda	state_actor, x
	cmp	#actor_states::state_2
	beq	:+
	and	#actor_states::bit_6
	beq	:+++
	lda	actor_id, x
	cmp	#actor::power_up
	beq	:+++
	bne	:++
	: ; if (((actor_state & 0x40) || !(actor_state & 0xA0)) && (actor.state == state_2)) {
		jmp	motion_x
	: ; } else if (actor.state != 2 && ()) {
		; if (actor_state & 0x40 && actor.id != power_up) {
			ldy	#1
		: ; }
	
		lda	veloc_x_actor, x
		pha

		bpl	:+ ; if (actor.veloc_x < 0) {
			iny
			iny
		: ; }
		clc
		adc	actor_proc_accel_x, y
		sta	veloc_x_actor, x
		jsr	motion_x

		pla
		sta	veloc_x_actor, x
		rts
	: ; } else {
		lda	timer_actor, x
		bne	:++ ; if (actor.timer == 0) {
			sta	state_actor, x
			lda	frame_count
			and	#MOD_2
			tay
			iny
			sty	motion_dir_actor, x
			dey
			.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
			lda	game_hard_mode
			beq	:+
			.elseif	.defined(ANN)
			lda	byte_77D
			beq	:+
			lda	ENG_HARDMODE_VAR
			bne	:+
			.endif ; if ((!ANN && game.hard_mode) || (ANN && byte_77D && !game.hard_mode)) {
				iny
				iny
			: ; }
			lda	actor_proc_veloc_x, y
			sta	veloc_x_actor, x
			rts
		; } else if () {
		actor_proc_base_defeated:
			jsr	motion_y
			jmp	motion_x
		: ; } else {
			cmp	#GOOMBA_ERASE_CUE
			bne	:+
			lda	actor_id, x
			cmp	#actor::goomba
			bne	:+ ; if (actor.timer == GOOMBA_ERASE_CUE && actor_id == goomba) {
				jsr	actor_erase
			: ; }
		
			rts
		; }
	; }
; -----------------------------------------------------------
	.export actor_proc_bounce
actor_proc_bounce:
	jsr	motion_fall_mid
	jmp	motion_x

