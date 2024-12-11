.include	"mem.i"
.include	"tunables.i"
.include	"misc.i"

; -----------------------------------------------------------
BOWSER_FLAME_TIMER_INIT	= 223
BOWSER_HP	= 5
; -----------------------------------------------------------
	.export actor_init_bowser
	.export	actor_B_18_init
actor_init_bowser:
actor_B_18_init:
	.if	.defined(SMBV2)
	        ldy     #ENG_ACTOR_MAX-2
		: ; for (y = ENG_ACTOR_MAX-2; y >= 0; y--) {
		        cpy     actor_index
		        beq     :+
		        lda     obj_id_actor, y
		        cmp     #actor::bowser
		        bne     :+ ; if (actor.idx != 0 && actor.id == bowser) {
		        	lda     #0
		        	sta     obj_id_actor, y
		        	sta     proc_id_actor, y
			: ; }

		        dey
		        bpl     :--
		; }
	.endif

	jsr	actor_init_dup
	stx	actor_index_bowser
	lda	#0
	sta	actor_bowser_ani_flag
	sta	actor_bowser_ending_clear_frame
	lda	pos_x_lo_actor, x
	sta	pos_x_prev_bowser
	lda	#BOWSER_FLAME_TIMER_INIT
	sta	timer_bowser_flame
	sta	motion_dir_actor, x
	lda	#ACTOR_BOWSER_TIMER_INIT
	sta	timer_ani_bowser
	sta	timer_ani_actor, x
	lda	#BOWSER_HP
	sta	hp_bowser
	lsr	a
	sta	veloc_x_bowser
	rts

