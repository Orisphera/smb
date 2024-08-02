.include	"system/ppu.i"

.include	"engine/mem.i"

.include	"engine/unk.i"

.include	"macros.i"

; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
PIRANHA_PLANT_CUTOFF_A	= 33
.elseif	.defined(ANN)
PIRANHA_PLANT_CUTOFF_A	= 19
.endif
PIRANHA_PLANT_TIMER_ANI	= 64
; -----------------------------------------------------------
	.export actor_proc_piranha_plant
	.export actor_proc_piranha_plant_smb2_cmp
actor_proc_piranha_plant:
	lda	state_actor, x
	bne	:++++++
	lda	eng_timer_actor_ani, x
	bne	:++++++ ; if (actor_state == dead && eng_timer_actor_ani == 0) {
		lda	veloc_y_actor, x
		bne	:+++
		lda	veloc_x_actor, x
		bmi	:++ ; if (actor.veloc_y == 0 && actor.veloc_x >= 0) {
			jsr	col_player_bullet_diff
			bpl	:+ ; if (col_player_bullet_diff() < 0) {
				lda	zp_byte_00
				neg_m
				sta	zp_byte_00
			: ; }
		
			lda	zp_byte_00
			actor_proc_piranha_plant_smb2_cmp:
			cmp	#PIRANHA_PLANT_CUTOFF_A
			bcc	:+++++
		: ; }
	
		; if (actor.veloc_y != 0 || actor.veloc_x < 0 || zp_byte_00_abs >= 0x21) {
			; if (actor.veloc_y == 0) {
				lda	veloc_x_actor, x
				neg_m
				sta	veloc_x_actor, x
				inc	veloc_y_actor, x
			: ; }
		
			lda	accel_y_actor_c, x
			ldy	veloc_x_actor, x
			bpl	:+ ; if (actor.veloc_y < 0) {
				lda	pos_y_actor, x
			: ; }
			sta	zp_byte_00

			.if	.defined(SMB2)
				lda	data_B517
				cmp	#$22
				beq	:+
			.endif
		
			lda	frame_count
			lsr	a
			bcc	:++
			: lda	eng_timer_ctl
			bne	:+ ; if (((SMB2 && data_B517 == 0x22) || ((frame_count % 2)) && eng_timer_ctl == 0) {
				lda	pos_y_lo_actor, x
				clc
				adc	veloc_x_actor, x
				sta	pos_y_lo_actor, x
				cmp	zp_byte_00
				bne	:+ ; if (actor.pos_y == zp_byte_00) {
					lda	#0
					sta	veloc_y_actor, x
					lda	#PIRANHA_PLANT_TIMER_ANI
					sta	eng_timer_actor_ani, x
				; }
			; }
		; }
	: ; }

	lda	#obj_attr::priority_low|obj_attr::color0
	sta	attr_actor, x
	rts
