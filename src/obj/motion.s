.include	"../../inc/system/cpu.i"

.include	"../../inc/engine/misc.i"

.include	"../../inc/engine/unk.i"

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
		lda	eng_player_veloc_x, x
		asl	a
		asl	a
		asl	a
		asl	a
		sta	zp_byte_01
		lda	eng_player_veloc_x, x
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

		lda	eng_player_accel_x_b, x
		clc
		adc	zp_byte_01
		sta	eng_player_accel_x_b, x

		lda	#0
		rol	a
		pha
	
		ror	a
		lda	eng_player_pos_x_lo, x
		adc	zp_byte_00
		sta	eng_player_pos_x_lo, x
		lda	eng_player_pos_x_hi, x
		adc	zp_byte_02
		sta	eng_player_pos_x_hi, x

		pla
		clc
		adc	zp_byte_00
	: ; }

	rts
; ------------------------------------------------------------
	.export motion_y_check_spring, motion_y
motion_y_check_spring:
	ldx	#0

	lda	eng_timer_ctl
	bne	:+
	lda	eng_spring_ani
	bne	:-
	: ; if (eng_timer_ctl || !eng_spring_ani) {
		lda	eng_player_accel_y
		sta	motion_gravity_accel_y_inc
		lda	#4
		jmp	motion_gravity_do
	; } else rts;

motion_y:
	ldy	#$3D
	lda	state_actor, x
	cmp	#5
	bne	:+ ; if (this.state == 5) {
		ldy	#$20
	: ; }
	jmp	motion_fall_max_hi
; ------------------------------------------------------------
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
motion_fall_fast:
	ldy	#$7F
	bne	motion_fall_max_lo

motion_fall_slow:
	ldy	#$0F

motion_fall_max_lo:
	lda	#2
	bne	motion_fall

motion_fall_mid:
	ldy	#$1C

motion_fall_max_hi:
	lda	#3

motion_fall:
	sty	motion_gravity_accel_y_inc
	inx
	jsr	motion_gravity_do
	ldx	actor_index
	rts
; ------------------------------------------------------------
motion_block_veloc_y_max:
	.byte	$06, $08
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
	lda	#$50
	sta	motion_gravity_accel_y_inc
	lda	motion_block_veloc_y_max, y

motion_gravity_do:
	sta	motion_gravity_veloc_y_max_abs
	lda	#0
	jmp	motion_gravity
; ------------------------------------------------------------
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
	cpy	#actor::unk_00
	bne	:+ ; if (this.actor_id == unk_00) {
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

	lda	eng_actor_accel_y_b, x
	clc
	adc	eng_actor_accel_y, x
	sta	eng_actor_accel_y_b, x

	ldy	#0
	lda	eng_player_veloc_y, x
	bpl	:+ ; if (this.veloc_y < 0) {
		dey
	: ; }
	sty	zp_byte_07
	adc	eng_player_pos_y_lo, x
	sta	eng_player_pos_y_lo, x
	lda	eng_player_pos_y_hi, x
	adc	zp_byte_07
	sta	eng_player_pos_y_hi, x

	lda	eng_actor_accel_y, x
	clc
	adc	motion_gravity_accel_y_inc
	sta	eng_actor_accel_y, x

	lda	eng_player_veloc_y, x
	adc	#0
	sta	eng_player_veloc_y, x
	cmp	motion_gravity_veloc_y_max_abs
	bmi	:+
	lda	eng_actor_accel_y, x
	cmp	#$80
	bcc	:+ ; if (abs(this.veloc_y) > abs(motion_gravity_veloc_y_max_abs) && this.accel_y < 0) {
		lda	motion_gravity_veloc_y_max_abs
		sta	eng_player_veloc_y, x
		lda	#0
		sta	eng_actor_accel_y, x
	: ; }

	pla
	beq	:+ ; if (a) {
		lda	motion_gravity_veloc_y_max_abs
		eor	#$FF
		tay
		iny
		sty	zp_byte_07

		lda	eng_actor_accel_y, x
		sec
		sbc	motion_gravity_accel_y_dec
		sta	eng_actor_accel_y, x

		lda	eng_player_veloc_y, x
		sbc	#0
		sta	eng_player_veloc_y, x
		cmp	zp_byte_07
		bpl	:+
		lda	eng_actor_accel_y, x
		cmp	#$80
		bcs	:+ ; if (abs(this.veloc_y) > abs(motion_gravity_veloc_y_max_abs) && this.accel_y >= 0) {
			lda	zp_byte_07
			sta	eng_player_veloc_y, x
			lda	#<-1
			sta	eng_actor_accel_y, x
		; }
	: ; }

	rts

.if	.defined(VS_SMB)
	.res	6, $FF
.elseif	.defined(SMB2)
	.res	11, $FF
.endif
