.include    "mem.i"
.include    "misc.i"

; -----------------------------------------------------------
HAMMER_BRO_COL_SIZE	= 11
HAMMER_BRO_TIMER_VS	= 255
HAMMER_BRO_TIMER_EASY	= 128
HAMMER_BRO_TIMER_HARD	= 80
; -----------------------------------------------------------
.if	.defined(CONS)
actor_init_hammer_bro_timer:
	.byte	HAMMER_BRO_TIMER_EASY, HAMMER_BRO_TIMER_HARD
.endif
; ------------------------------
	.export actor_init_hammer_bro
	.export	actor_A_05_init
actor_init_hammer_bro:
actor_A_05_init:
	lda	#0
	sta	timer_hammer_throw, x
	sta	veloc_x_actor, x

	.if	.defined(SMBV2)
		lda	course_no
		cmp	#course::no_07
		bcs	:+
	.endif ; if (!SMBV2 || course_no < no_07) {
		.if	.defined(CONS)
			ldy	game_hard_mode_b
			lda	actor_init_hammer_bro_timer, y
		.elseif	.defined(VS)
			lda	#HAMMER_BRO_TIMER_VS
		.endif
		sta	timer_actor, x
	: ; }
	lda	#HAMMER_BRO_COL_SIZE
	jmp	actor_init_col

