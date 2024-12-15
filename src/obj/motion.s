.include	"system/cpu.i"

.include	"mem.i"
.include	"misc.i"

veloc_x_lo_motion	= zp_byte_00
veloc_x_16x		= zp_byte_01
veloc_x_hi_motion	= zp_byte_02

	.export motion_x, motion_x_player, motion_x_do
motion_x:
	inx
	jsr	motion_x_do
	ldx	actor_index
	rts

motion_x_player:
	lda	player_on_spring
	bne	:+++ ; if (!player.on_spring || !is_player) {
		; if (is_player) {
			tax
		; }
	
	motion_x_do:
		lda	veloc_x, x
		asl	a
		asl	a
		asl	a
		asl	a
		sta	veloc_x_16x
		lda	veloc_x, x
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		cmp	#8
		bcc	:+ ; if (this.veloc_x >= 8) {
			ora	#$F0
		: ; }
		sta	veloc_x_lo_motion
	
		ldy	#0
		cmp	#0
		bpl	:+ ; if (veloc_x_lo_motion > 0) {
			dey
		: ; }
		sty	veloc_x_hi_motion

		lda	accel_x, x
		clc
		adc	veloc_x_16x
		sta	accel_x, x

		lda	#0
		rol	a
		pha
	
		ror	a
		lda	pos_x_lo, x
		adc	veloc_x_lo_motion
		sta	pos_x_lo, x
		lda	pos_x_hi, x
		adc	veloc_x_hi_motion
		sta	pos_x_hi, x

		pla
		clc
		adc	veloc_x_lo_motion
	: ; }

	rts
; ------------------------------------------------------------
	.export motion_y_player, motion_y
	.export motion_y_state_5
motion_y_player:
	ldx	#0

	lda	game_timer_stop
	bne	:+
	lda	player_on_spring
	bne	:-
	: ; if (game_timer_stop || !player.on_spring) {
		lda	accel_y_player_spring
		sta	motion_gravity_accel_y_inc
		lda	#MOTION_GRAVITY_VAL
		jmp	motion_gravity_do
	; } else rts;
; --------------
motion_y:
	ldy	#$3D
	lda	state_actor, x
	cmp	#actor_states::state_5
	bne	:+ ; if (this.state == state_05) {
	motion_y_state_5:
		ldy	#$20
	: ; }
	jmp	motion_fall_max_hi
; ------------------------------------------------------------
	.export motion_bounce_down, motion_bounce_up
	.export motion_bounce
motion_bounce_down:
	ldy	#0
	jmp	motion_bounce

motion_bounce_up:
	ldy	#1

motion_bounce:
	inx
	lda	#3
	sta	motion_gravity_accel_y_inc
	lda	#6
	sta	motion_gravity_accel_y_dec
	lda	#2
	sta	motion_gravity_veloc_y_max_abs
	tya
	jmp	motion_bounce_gravity_do
; ------------------------------------------------------------
	.export motion_fall_fast, motion_fall_slow
	.export motion_fall_mid, motion_fall
motion_fall_fast:
	ldy	#$7F
	bne	motion_fall_max_lo

motion_fall_slow:
	ldy	#MOTION_FALL_SLOW

motion_fall_max_lo:
	lda	#2
	bne	motion_fall

motion_fall_mid:
	ldy	#MOTION_FALL_MID

motion_fall_max_hi:
	lda	#MOTION_FALL_MAX_HI

motion_fall:
	sty	motion_gravity_accel_y_inc
	inx
	jsr	motion_gravity_do
	ldx	actor_index
	rts
; ------------------------------------------------------------
motion_block_veloc_y_max:
	.byte	6, 8
; -----------------------------
	.export motion_block_fall_fast
motion_block_fall_slow:
	ldy	#0

.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	motion_block_fall
.endif

motion_block_fall_fast:
	ldy	#1

motion_block_fall:
	lda	#MOTION_BLOCK_FALL_ACCEL_Y_INC
	sta	motion_gravity_accel_y_inc
	lda	motion_block_veloc_y_max, y

motion_gravity_do:
	sta	motion_gravity_veloc_y_max_abs
	lda	#0
	jmp	motion_gravity
; ------------------------------------------------------------
	.export motion_platform_down, motion_platform_up
motion_platform_down:
	lda	#0

.if	.defined(CONS)
	.byte	CPU_OPCODE_BIT_ABS
.elseif	.defined(VS)
	jmp	motion_platform
.endif

motion_platform_up:
	lda	#1

motion_platform:
	pha

	ldy	obj_id_actor, x
	inx
	lda	#5
	cpy	#actor::plat_drop
	bne	:+ ; if (this.obj_id_actor == plat_drop) {
		lda	#9
	: ; }
	sta	motion_gravity_accel_y_inc
	lda	#10
	sta	motion_gravity_accel_y_dec
	lda	#3
	sta	motion_gravity_veloc_y_max_abs

	pla
	tay

motion_bounce_gravity_do:
	jsr	motion_gravity
	ldx	actor_index
	rts
; ------------------------------------------------------------
veloc_y_grav	= zp_byte_07

	.export motion_gravity
motion_gravity:
	pha

	lda	accel_y, x
	clc
	adc	accel_y_grav, x
	sta	accel_y, x

	ldy	#0
	lda	veloc_y, x
	bpl	:+ ; if (this.veloc_y < 0) {
		dey
	: ; }
	sty	veloc_y_grav
	adc	pos_y_lo, x
	sta	pos_y_lo, x
	lda	pos_y_hi, x
	adc	veloc_y_grav
	sta	pos_y_hi, x

	lda	accel_y_grav, x
	clc
	adc	motion_gravity_accel_y_inc
	sta	accel_y_grav, x

	lda	veloc_y, x
	adc	#0
	sta	veloc_y, x
	cmp	motion_gravity_veloc_y_max_abs
	bmi	:+
	lda	accel_y_grav, x
	cmp	#$80
	bcc	:+ ; if (abs(this.veloc_y) > abs(motion_gravity_veloc_y_max_abs) && this.accel_y < 0) {
		lda	motion_gravity_veloc_y_max_abs
		sta	veloc_y, x
		lda	#0
		sta	accel_y_grav, x
	: ; }

	pla
	beq	:+ ; if (a) {
	motion_gravity_veloc_y_max_neg	= zp_byte_07

		lda	motion_gravity_veloc_y_max_abs
		eor	#<-1
		tay
		iny
		sty	motion_gravity_veloc_y_max_neg

		lda	accel_y_grav, x
		sec
		sbc	motion_gravity_accel_y_dec
		sta	accel_y_grav, x

		lda	veloc_y, x
		sbc	#0
		sta	veloc_y, x
		cmp	motion_gravity_veloc_y_max_neg
		bpl	:+
		lda	accel_y_grav, x
		cmp	#<-128
		bcs	:+ ; if (abs(this.veloc_y) > abs(motion_gravity_veloc_y_max_abs) && this.accel_y >= 0) {
			lda	motion_gravity_veloc_y_max_neg
			sta	veloc_y, x
			lda	#<-1
			sta	accel_y_grav, x
		; }
	: ; }

	rts
