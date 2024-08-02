.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/misc.i"

.include	"macros.i"

; -----------------------------------------------------------
CHEEP_FLY_ACCEL_OFFSET_Y	= 16
CHEEP_FLY_ACCEL_DIST		= 8
; -----------------------------------------------------------
actor_cheep_fly_offset_y:
	.byte	<-8
	.byte	<-96
	.byte	112
	.byte	<-67
	.byte	0

actor_cheep_fly_attr:
	.byte	obj_attr::priority_low|obj_attr::color0
	.byte	obj_attr::priority_low|obj_attr::color0
	.byte	obj_attr::priority_low|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
; -----------------------------
	.export actor_proc_cheep_fly
actor_proc_cheep_fly:
	lda	state_actor, x
	and	#actor_states::bit_5
	beq	:+ ; if () {
		lda	#obj_attr::priority_high|obj_attr::color0
		sta	attr_actor, x
		jmp	motion_fall_mid
	: ; } else {
		jsr	motion_x
		ldy	#13
		lda	#5
		jsr	motion_fall
		lda	accel_y_actor_c, x
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		tay
		lda	pos_y_lo_actor, x
		sec
		sbc	actor_cheep_fly_offset_y, y
		bpl	:+ ; if (actor.pos_y < actor_cheep_fly_offset_y) {
			neg_m
		: ; }
	
		cmp	#CHEEP_FLY_ACCEL_DIST
		bcs	:+ ; if ((actor.pos_y - actor_cheep_fly_offset_y) < 8) {
			lda	accel_y_actor_c, x
			clc
			adc	#CHEEP_FLY_ACCEL_OFFSET_Y
			sta	accel_y_actor_c, x
			lsr	a
			lsr	a
			lsr	a
			lsr	a
			tay
		: ; }
	
		lda	actor_cheep_fly_attr, y
		sta	attr_actor, x
		rts
	; }

