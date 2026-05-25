.include	"mem.i"
.include	"misc.i"
.include	"tiles.i"
.include	"const.i"

POS_X_LONE_BALL	= 2

HEIGHT_BALL	= 1
HEIGHT_POLE	= 10
HEIGHT_BASE	= 1

OFFSET_X_FLAG	= 8
OFFSET_Y_FLAG	= 48
OFFSET_Y_FLAG_SCORE = (OFFSET_Y_FLAG+128)

	.export	scenery_pole_tip
scenery_pole_tip:
	jsr	scenery_attr
	ldx	#POS_X_LONE_BALL
	lda	#metatile_1::flag_ball
	jmp	scenery_render
; ----------------
	.export	scenery_pole
scenery_pole:
	lda	#metatile_0::flag_ball
	sta	scenery_metatile
	ldx	#HEIGHT_BALL
	ldy	#HEIGHT_POLE-(HEIGHT_BALL+HEIGHT_BASE)
	lda	#metatile_0::pole
	jsr	scenery_render
	lda	#metatile_1::stair
	sta	scenery_metatile+HEIGHT_POLE

	jsr	scenery_pos_x_get
	sec
	sbc	#<OFFSET_X_FLAG
	sta	pos_x_lo_actor+ACTOR_COUNT_MAX-1
	lda	pos_x_hi_game
	sbc	#>OFFSET_X_FLAG
	sta	pos_x_hi_actor+ACTOR_COUNT_MAX-1
	lda	#OFFSET_Y_FLAG
	sta	pos_y_lo_actor+ACTOR_COUNT_MAX-1
	lda	#OFFSET_Y_FLAG_SCORE
	sta	render_flag_score_pos_y
	lda	#actor::flag_enemy
	sta	obj_id_actor+ACTOR_COUNT_MAX-1
	inc	proc_id_actor+ACTOR_COUNT_MAX-1
	rts
