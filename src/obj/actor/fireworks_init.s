.include	"engine/mem.i"
.include	"engine/misc.i"

; -----------------------------------------------------------
FIREWORKS_SWARM_TIMER		= 32
FIREWORKS_VELOC_Y		= 8
FIREWORKS_ACTOR_OFFSET_Y	= 48
; -----------------------------------------------------------
fireworks_pos_x_hi_tmp	= zp_byte_00

fireworks_pos_x:	.byte	0,  48, 96,  96, 0,  32
fireworks_pos_y:	.byte	96, 64, 112, 64, 96, 48
; ------------------------------
	.export actor_init_fireworks
actor_init_fireworks:
	lda	eng_timer_swarm
	bne	:++ ; if (eng_timer_swarm == 0) {
		lda	#FIREWORKS_SWARM_TIMER
		sta	eng_timer_swarm
		dec	actor_firework_counter

		ldy	#ENG_ACTOR_MAX
		: ; for (actor of actors) {
			dey
			lda	actor_id, y
			cmp	#actor::flag_victory
			bne	:-
		; }
	
		lda	pos_x_lo_actor, y
		sec
		sbc	#FIREWORKS_ACTOR_OFFSET_Y
		pha

		lda	pos_x_hi_actor, y
		sbc	#0
		sta	fireworks_pos_x_hi_tmp
		lda	actor_firework_counter
		clc
		adc	state_actor, y
		tay

		pla
		clc
		adc	fireworks_pos_x, y
		sta	pos_x_lo_actor, x

		lda	fireworks_pos_x_hi_tmp
		adc	#0
		sta	pos_x_hi_actor, x
		lda	fireworks_pos_y, y
		sta	pos_y_lo_actor, x
		lda	#actor_modes::active
		sta	pos_y_hi_actor, x
		sta	actor_mode, x
		lsr	a
		sta	veloc_x_actor, x
		lda	#FIREWORKS_VELOC_Y
		sta	veloc_y_actor, x
	: ; }

	rts

