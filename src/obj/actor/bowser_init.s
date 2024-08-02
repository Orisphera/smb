.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"

; -----------------------------------------------------------
BOWSER_FLAME_TIMER_INIT	= 223
BOWSER_HP	= 5
; -----------------------------------------------------------
	.export actor_init_bowser
actor_init_bowser:
	.if	.defined(SMB2M)
	        ldy     #ENG_ACTOR_MAX-2
		: ; for (y = ENG_ACTOR_MAX-2; y >= 0; y--) {
		        cpy     actor_index
		        beq     :+
		        lda     actor_id, y
		        cmp     #actor::bowser
		        bne     :+ ; if (actor.idx != 0 && actor.id == bowser) {
		        	lda     #0
		        	sta     actor_id, y
		        	sta     actor_mode, y
			: ; }

		        dey
		        bpl     :--
		; }
	.endif

	jsr	actor_init_dup
	stx	ppu_nmi_buffer_1_data+$27
	lda	#0
	sta	ppu_nmi_buffer_1_data+$22
	sta	ppu_nmi_buffer_1_data+$28
	lda	pos_x_lo_actor, x
	sta	ppu_nmi_buffer_1_data+$25
	lda	#BOWSER_FLAME_TIMER_INIT
	sta	eng_timer_bowser_flame
	sta	motion_dir_actor, x
	lda	#$20
	sta	ppu_nmi_buffer_1_data+$23
	sta	eng_timer_actor_ani, x
	lda	#BOWSER_HP
	sta	hp_bowser
	lsr	a
	sta	ppu_nmi_buffer_1_data+$24
	rts

