.include	"math.i"
.include	"mem.i"
.include	"tunables.i"
.include	"misc.i"
.include	"sound.i"

; -----------------------------------------------------------
BOWSER_FLAME_TIMESLICE		= 16
BOWSER_FLAME_OFFSET_X		= 32

BOWSER_FLAME_SHOOT_OFFSET_X	= 14
BOWSER_FLAME_SHOOT_OFFSET_Y	= 8

BOWSER_FLAME_COL_BOX		= col_boxes::box_8

BOWSER_FLAME_ACCEL_Y_ABS	= 1
; -----------------------------------------------------------
	.export actor_init_dup
actor_init_dup:
	ldy	#<-1
	: ; for (y = 0; actor[y].mode != free; y++) {
		iny
		lda	actor_mode, y
		bne	:-
	; }
	sty	actor_dup_offset

	txa
	ora	#ACTOR_MODE_CHILD_BIT
	sta	actor_mode, y
	lda	pos_x_hi_actor, x
	sta	pos_x_hi_actor, y
	lda	pos_x_lo_actor, x
	sta	pos_x_lo_actor, y
	lda	#actor_modes::active
	sta	actor_mode, x
	sta	pos_y_hi_actor, y
	lda	pos_y_lo_actor, x
	sta	pos_y_lo_actor, y

actor_init_dup_rts:
	rts
; -----------------------------------------------------------
	.export actor_bowser_flame_pos_y_offset
actor_bowser_flame_pos_y_offset:
	.byte	<-112, <-128, 112, <-112
bowser_flame_accel_y:
	.byte	<-BOWSER_FLAME_ACCEL_Y_ABS, BOWSER_FLAME_ACCEL_Y_ABS
; ------------------------------
	.export actor_init_bowser_flame, actor_init_right_side
actor_init_bowser_flame:
	lda	timer_swarm
	bne	actor_init_dup_rts ; if (timer_swarm == 0) {
		sta	accel_y_actor_c, x
		lda	apu_noise_event
		ora	#sfx_noise::flame
		sta	apu_noise_event
		ldy	nmi_list_1_data+$27
		lda	actor_id, y
		cmp	#actor::bowser
		beq	:++ ; if (parent.id != bowser) {
			jsr	actor_proc_bowser_flame_timer_init
			clc
			adc	#ACTOR_BOWSER_FLAME_TIMER
			ldy	game_hard_mode_b
			beq	:+ ; if (game_hard_mode_b) {
				sec
				sbc	#ACTOR_BOWSER_FLAME_TIMER_HARD_OFFSET
			: ; }
			sta	timer_swarm
		
			lda	srand, x
			and	#MOD_4
			sta	pos_y_actor, x
			tay
			lda	actor_bowser_flame_pos_y_offset, y
		
		actor_init_right_side:
			sta	pos_y_lo_actor, x
			lda	pos_x_lo_screen_right
			clc
			adc	#<BOWSER_FLAME_OFFSET_X
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_screen_right
			adc	#>BOWSER_FLAME_OFFSET_X
			sta	pos_x_hi_actor, x
	
			jmp	:+++
		: ; } else {
			lda	pos_x_lo_actor, y
			sec
			sbc	#BOWSER_FLAME_SHOOT_OFFSET_X
			sta	pos_x_lo_actor, x
			lda	pos_x_hi_actor, y
			sta	pos_x_hi_actor, x
			lda	pos_y_lo_actor, y
			clc
			adc	#BOWSER_FLAME_SHOOT_OFFSET_Y
			sta	pos_y_lo_actor, x
		
			lda	srand, x
			and	#MOD_4
			sta	pos_y_actor, x
			tay
			lda	actor_bowser_flame_pos_y_offset, y
			ldy	#0
			cmp	pos_y_lo_actor, x
			bcc	:+ ; if (this.pos_y <= *actor_bowser_flame_pos_y_offset) {
				iny
			: ; }
			lda	bowser_flame_accel_y, y
			sta	accel_y_actor_c, x
		
			lda	#0
			sta	actor_swarm_buffer
		: ; }
	
		lda	#BOWSER_FLAME_COL_BOX
		sta	col_box_actor, x
		lda	#actor_modes::active
		sta	pos_y_hi_actor, x
		sta	actor_mode, x
		lsr	a
		sta	accel_x_actor, x
		sta	state_actor, x
		rts
	; } else rts;

