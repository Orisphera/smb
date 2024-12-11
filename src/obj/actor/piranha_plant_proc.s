.include	"system/ppu.i"

.include	"mem.i"
.include	"macros.i"

; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
PIRANHA_PLANT_CUTOFF_A	= 33
.elseif	.defined(ANN)
PIRANHA_PLANT_CUTOFF_A	= 19
.endif
PIRANHA_PLANT_TIMER_ANI	= 64
; -----------------------------------------------------------
actor_proc_piranha_plant_pos_x_rel_abs	= zp_byte_00
actor_proc_piranha_plant_pos_y		= zp_byte_00

	.export actor_proc_piranha_plant
	.export actor_proc_piranha_plant_smb2_cmp
	.export	actor_A_0D_proc
actor_proc_piranha_plant:
actor_A_0D_proc:
	lda	state_actor, x
	bne	:++++++
	lda	timer_ani_actor, x
	bne	:++++++ ; if (this.state == init && this.timer_ani == 0) {
		lda	neg_y_piranha, x
		bne	:+++
		lda	veloc_y_piranha, x
		bmi	:++ ; if (!this.negated && this.veloc_y >= 0) {
			jsr	col_player_bullet_diff
			bpl	:+ ; if (col_player_bullet_diff() < 0) {
				lda	col_player_bullet_diff_pos_x_rel
				neg_m
				sta	actor_proc_piranha_plant_pos_x_rel_abs
			: ; }
		
			lda	actor_proc_piranha_plant_pos_x_rel_abs
			actor_proc_piranha_plant_smb2_cmp:
			cmp	#PIRANHA_PLANT_CUTOFF_A
			bcc	:+++++
		: ; }
	
		; if (this.negated || this.veloc_y < 0 || abs(this.pos_x_rel) >= cutoff) {
			; if (!this.negated) {
				lda	veloc_y_piranha, x
				neg_m
				sta	veloc_y_piranha, x
				inc	neg_y_piranha, x
			: ; }
		
			lda	pos_y_top_piranha, x
			ldy	veloc_y_piranha, x
			bpl	:+ ; if (this.veloc_y < 0) {
				lda	pos_y_bottom_piranha, x
			: ; }
			sta	actor_proc_piranha_plant_pos_y

			.if	.defined(SMB2)
				lda	render_actor_attrs_piranha_plant
				cmp	#obj_attr::priority_low|obj_attr::color2
				beq	:+
			.endif
		
			lda	frame_count
			lsr	a
			bcc	:++
			: lda	game_timer_stop
			bne	:+ ; if ((((SMB2 && this.color == color2) || ((frame_count % 2))) && !game_timer_stop) {
				lda	pos_y_lo_actor, x
				clc
				adc	veloc_y_piranha, x
				sta	pos_y_lo_actor, x
				cmp	actor_proc_piranha_plant_pos_y
				bne	:+ ; if (this.pos_y == limit) {
					lda	#0
					sta	neg_y_piranha, x
					lda	#PIRANHA_PLANT_TIMER_ANI
					sta	timer_ani_actor, x
				; }
			; }
		; }
	: ; }

	lda	#obj_attr::priority_low|obj_attr::color0
	sta	attr_actor, x
	rts
