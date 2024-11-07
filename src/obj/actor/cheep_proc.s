.include	"mem.i"
.include	"misc.i"

.include	"macros.i"

; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	CHEEP_VELOC_Y	= 32
.elseif	.defined(SMB2M)
	CHEEP_VELOC_Y	= 64
.endif
CHEEP_VELOC_X			= 16
CHEEP_VELOC_X_SET_CUTOFF	= 15
CHEEP_FAST_SLOW_ACTOR_IDX	= 2
; -----------------------------------------------------------
actor_proc_cheep_accel_x_val	= zp_byte_02
actor_proc_cheep_veloc_y_abs	= zp_byte_02
actor_proc_cheep_veloc_y	= zp_byte_03

actor_proc_cheep_accel_x:
	.byte	64, <-128, 4, 4
; -----------------------------
	.export actor_proc_cheep
actor_proc_cheep:
	lda	state_actor, x
	and	#actor_states::bit_5
	beq	:+ ; if (actor.state & 0x20) {
		jmp	motion_fall_slow
	: ; } else {
		sta	actor_proc_cheep_veloc_y
		lda	obj_id_actor, x
		sec
		sbc	#actor::cheep
		tay
		lda	actor_proc_cheep_accel_x, y
		sta	actor_proc_cheep_accel_x_val
		lda	accel_x_actor, x
		sec
		sbc	actor_proc_cheep_accel_x_val
		sta	accel_x_actor, x
		lda	pos_x_lo_actor, x
		sbc	#0
		sta	pos_x_lo_actor, x
		lda	pos_x_hi_actor, x
		sbc	#0
		sta	pos_x_hi_actor, x
		lda	#CHEEP_VELOC_Y
		sta	actor_proc_cheep_veloc_y_abs
		cpx	#CHEEP_FAST_SLOW_ACTOR_IDX
		bcc	:++++ ; if (actor.idx >= 2) {
			lda	veloc_x_actor, x
			cmp	#CHEEP_VELOC_X
			bcc	:+ ; if (actor.veloc_x >= CHEEP_VELOC_X) {
				lda	accel_y1_actor, x
				clc
				adc	actor_proc_cheep_veloc_y_abs
				sta	accel_y1_actor, x
				lda	pos_y_lo_actor, x
				adc	actor_proc_cheep_veloc_y
				sta	pos_y_lo_actor, x
				lda	pos_y_hi_actor, x
				adc	#0

				jmp	:++
			: ; } else {
				lda	accel_y1_actor, x
				sec
				sbc	actor_proc_cheep_veloc_y_abs
				sta	accel_y1_actor, x
				lda	pos_y_lo_actor, x
				sbc	actor_proc_cheep_veloc_y
				sta	pos_y_lo_actor, x
				lda	pos_y_hi_actor, x
				sbc	#0
			: ; }
			sta	pos_y_hi_actor, x

			ldy	#0
			lda	pos_y_lo_actor, x
			sec
			sbc	accel_y2_actor, x
			bpl	:+ ; if (actor.pos_y < actor.accel_y) { 
				ldy	#CHEEP_VELOC_X
				neg_m
			: ; }

			cmp	#CHEEP_VELOC_X_SET_CUTOFF
			bcc	:+ ; if ((actor.pos_y - actor.accel_y) >= cutoff) {
				tya
				sta	veloc_x_actor, x
			; }
		: ; }

		rts
	; }

