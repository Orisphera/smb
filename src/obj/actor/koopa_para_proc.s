.include	"math.i"
.include	"mem.i"

; -----------------------------------------------------------
KOOPA_GREEN_FLY_OFFSET_Y_ABS	= 1
; -----------------------------------------------------------
	.export actor_proc_koopa_red_fly
	.export	actor_A_0F_proc
actor_proc_koopa_red_fly:
actor_A_0F_proc:
	lda	veloc_y_actor, x
	ora	accel_y2_actor, x
	bne	:++
	sta	accel_y1_actor, x
	lda	pos_y_lo_actor, x
	cmp	accel_x_actor, x
	bcs	:++ ; if () {
		lda	frame_count
		and	#MOD_8
		bne	:+ ; if (!(frame_count % 8)) {
			inc	pos_y_lo_actor, x
		: ; }
	
		rts
	: ; } else {
		lda	pos_y_lo_actor, x
		cmp	veloc_x_actor, x
		bcc	:+ ; if (actor.pos_y >= actor.veloc_x) {
			jmp	motion_bounce_up
		: ; } else {
			jmp	motion_bounce_down
		; }
	; }
; -----------------------------------------------------------
actor_proc_koopa_green_fly_y_offset	= zp_byte_00

	.export actor_proc_koopa_green_fly
	.export	actor_A_10_proc
actor_proc_koopa_green_fly:
actor_A_10_proc:
	jsr	actor_floater_koopa
	jsr	actor_floater_move

	ldy	#KOOPA_GREEN_FLY_OFFSET_Y_ABS
	lda	frame_count
	and	#MOD_4
	bne	:++ ; if (!(frame_count % 4)) {
		lda	frame_count
		and	#MOD_128_64_UP
		bne	:+ ; if ((frame_count % 128) < 64) {
			ldy	#<-KOOPA_GREEN_FLY_OFFSET_Y_ABS
		: ; }
		sty	actor_proc_koopa_green_fly_y_offset
	
		lda	pos_y_lo_actor, x
		clc
		adc	actor_proc_koopa_green_fly_y_offset
		sta	pos_y_lo_actor, x
	: ; }

	rts
