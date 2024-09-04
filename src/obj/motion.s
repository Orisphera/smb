.include	"system/cpu.i"

.include	"engine/mem.i"
.include	"engine/misc.i"

	.export motion_x, motion_x_check_spring, motion_x_do
motion_x:
	inx
	jsr	motion_x_do
	ldx	actor_index
	rts

motion_x_check_spring:
	lda	eng_spring_ani
	bne	:+++ ; if (!eng_spring_ani) {
		tax
	
	motion_x_do:
		lda	veloc_x_player, x
		asl	a
		asl	a
		asl	a
		asl	a
		sta	zp_byte_01
		lda	veloc_x_player, x
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		cmp	#8
		bcc	:+ ; if (this.veloc_x.hi >= 8) {
			ora	#$F0
		: ; }
		sta	zp_byte_00
	
		ldy	#0
		cmp	#0
		bpl	:+ ; if (zp_byte_00 > 0) {
			dey
		: ; }
		sty	zp_byte_02

		lda	accel_x_player_b, x
		clc
		adc	zp_byte_01
		sta	accel_x_player_b, x

		lda	#0
		rol	a
		pha
	
		ror	a
		lda	pos_x_lo_player, x
		adc	zp_byte_00
		sta	pos_x_lo_player, x
		lda	pos_x_hi_player, x
		adc	zp_byte_02
		sta	pos_x_hi_player, x

		pla
		clc
		adc	zp_byte_00
	: ; }

	rts
; ------------------------------------------------------------
	.export motion_y_check_spring, motion_y
	.export motion_y_state_5
motion_y_check_spring:
	ldx	#0

	lda	eng_timer_ctl
	bne	:+
	lda	eng_spring_ani
	bne	:-
	: ; if (eng_timer_ctl || !eng_spring_ani) {
		lda	accel_y_player
		sta	motion_gravity_accel_y_inc
		lda	#MOTION_GRAVITY_VAL
		jmp	motion_gravity_do
	; } else rts;

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
	.byte	BIT_ABS_OPCODE
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
	.byte	BIT_ABS_OPCODE
.elseif	.defined(VS)
	jmp	motion_platform
.endif

motion_platform_up:
	lda	#1

motion_platform:
	pha

	ldy	actor_id, x
	inx
	lda	#5
	cpy	#actor::plat_drop
	bne	:+ ; if (this.actor_id == plat_drop) {
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
	.export motion_gravity
motion_gravity:
	pha

	lda	accel_y_actor_b, x
	clc
	adc	accel_y_actor, x
	sta	accel_y_actor_b, x

	ldy	#0
	lda	veloc_y_player, x
	bpl	:+ ; if (this.veloc_y < 0) {
		dey
	: ; }
	sty	zp_byte_07
	adc	pos_y_lo_player, x
	sta	pos_y_lo_player, x
	lda	pos_y_hi_player, x
	adc	zp_byte_07
	sta	pos_y_hi_player, x

	lda	accel_y_actor, x
	clc
	adc	motion_gravity_accel_y_inc
	sta	accel_y_actor, x

	lda	veloc_y_player, x
	adc	#0
	sta	veloc_y_player, x
	cmp	motion_gravity_veloc_y_max_abs
	bmi	:+
	lda	accel_y_actor, x
	cmp	#$80
	bcc	:+ ; if (abs(this.veloc_y) > abs(motion_gravity_veloc_y_max_abs) && this.accel_y < 0) {
		lda	motion_gravity_veloc_y_max_abs
		sta	veloc_y_player, x
		lda	#0
		sta	accel_y_actor, x
	: ; }

	pla
	beq	:+ ; if (a) {
	motion_gravity_veloc_y_max_neg	= zp_byte_07

		lda	motion_gravity_veloc_y_max_abs
		eor	#<-1
		tay
		iny
		sty	motion_gravity_veloc_y_max_neg

		lda	accel_y_actor, x
		sec
		sbc	motion_gravity_accel_y_dec
		sta	accel_y_actor, x

		lda	veloc_y_player, x
		sbc	#0
		sta	veloc_y_player, x
		cmp	motion_gravity_veloc_y_max_neg
		bpl	:+
		lda	accel_y_actor, x
		cmp	#<-128
		bcs	:+ ; if (abs(this.veloc_y) > abs(motion_gravity_veloc_y_max_abs) && this.accel_y >= 0) {
			lda	motion_gravity_veloc_y_max_neg
			sta	veloc_y_player, x
			lda	#<-1
			sta	accel_y_actor, x
		; }
	: ; }

	rts

.if	.defined(PAL)
	.res	1, $FF
.elseif	.defined(VS_SMB)
	.res	6, $FF
.elseif	.defined(SMB2)
	.res	11, $FF
.endif
