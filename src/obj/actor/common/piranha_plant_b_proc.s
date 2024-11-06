.include	"mem.i"
.include	"macros.i"

; ------------------------------------------------------------
PIRANHA_PLANT_B_TIMER_ANI	= 32
; ------------------------------------------------------------
actor_proc_piranha_plant_b_pos_y	= zp_byte_00

.if	.definedmacro(PLANT_B_PROC_BASE)
	.export	actor_proc_piranha_plant_b
.endif
actor_proc_piranha_plant_b:
	lda	state_actor, x
	bne	:+++
	lda	timer_ani_actor, x
	bne	:+++ ; if (this.state == init && this.timer_ani == 0) {
		lda	neg_y_piranha, x
		bne	:+ ; if (!this.neg_y) {
			lda	veloc_y_piranha, x
			neg_m
			sta	veloc_y_piranha, x
			inc	neg_y_piranha, x
		: ; }
	
		lda	pos_y_bottom_piranha, x
		ldy	veloc_y_piranha, x
		bpl	:+ ; if (this.veloc_y < 0) {
			lda	pos_y_top_piranha, x
		: ; }
		sta	actor_proc_piranha_plant_b_pos_y
		lda	game_timer_stop
		bne	:+
		lda	pos_y_lo_actor, x
		clc
		adc	veloc_y_piranha, x
		sta	pos_y_lo_actor, x
		cmp	actor_proc_piranha_plant_b_pos_y
		bne	:+ ; if (!game_timer_stop && ((this.pos_y += this.veloc_y) == pos_y_limit)) {
			lda	#0
			sta	neg_y_piranha, x
			lda	#PIRANHA_PLANT_B_TIMER_ANI
			sta	timer_ani_actor, x
		; }
	: ; }

	rts
