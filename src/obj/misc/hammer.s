.include	"mem.i"
.include	"mem_low.i"
.include	"misc.i"
.include	"const.i"

; ----------------------------------------------------------------------
MISC_HAMMER_ACCEL_Y_DEC		= 15
MISC_HAMMER_VELOC_Y_MAX_ABS	= 4
MISC_HAMMER_GRAVITY_INIT 	= 0
MISC_HAMMER_COL_BOX		= col_boxes::box_7

MISC_HAMMER_ACTOR_OFFSET_X	= 2
MISC_HAMMER_ACTOR_OFFSET_Y	= $10A
; ----------------------------------------------------------------------
misc_hammer_obj_id_actor:
	.byte	4, 4, 4, 5, 5, 5, 6, 6, 6
misc_hammer_obj_id_actor_end:

misc_hammer_veloc_x:
	.byte	MISC_HAMMER_VELOC_X_INIT_ABS, <-MISC_HAMMER_VELOC_X_INIT_ABS
; ----------------------------------
	.export misc_init_hammer
misc_init_hammer:
	lda	srand+1
	and	#(misc_hammer_obj_id_actor_end-misc_hammer_obj_id_actor)-2
	bne	:+ ; if (!(srand[1] % misc_hammer_obj_id_actor_count)) {
		lda	srand+1
		and	#(misc_hammer_obj_id_actor_end-misc_hammer_obj_id_actor)-1
	: ; }
	tay

	lda	state_misc, y
	bne	:+
	ldx	misc_hammer_obj_id_actor, y
	lda	proc_id_actor, x
	bne	:+ ; if (this.state == inactive && this.mode == free) {
		ldx	actor_index
		txa
		sta	misc_obj_id_actor, y
		lda	#misc_states::hammer|misc_states::bit_4
		sta	state_misc, y
		lda	#MISC_HAMMER_COL_BOX
		sta	col_box_misc, y
		sec
		rts
	: ; } else {
		ldx	actor_index
		clc
		rts
	; }
; ----------------------------------
	.export misc_proc_hammer
misc_proc_hammer:
	lda	game_timer_stop
	bne	:++++ ; if (!game_timer_stop) {
		lda	state_misc, x
		and	#<~misc_states::hammer
		ldy	misc_obj_id_actor, x
		cmp	#misc_states::throw
		beq	:+
		bcs	:++ ; if (this.state == init) {
			txa
			clc
			adc	#ENG_MISC_OFF
			tax

			lda	#MISC_HAMMER_ACCEL_Y_INC
			sta	motion_gravity_accel_y_inc
			lda	#MISC_HAMMER_ACCEL_Y_DEC
			sta	motion_gravity_accel_y_dec
			lda	#MISC_HAMMER_VELOC_Y_MAX_ABS
			sta	motion_gravity_veloc_y_max_abs
			lda	#MISC_HAMMER_GRAVITY_INIT
			jsr	motion_gravity
			jsr	motion_x_do

			ldx	actor_index
			jmp	:+++
		: ; } else {
			; if (this.state == throw) {
				lda	#MISC_HAMMER_VELOC_Y_INIT
				sta	veloc_y_misc, x

				lda	state_actor, y
				and	#<~actor_states::bit_3
				sta	state_actor, y

				ldx	motion_dir_actor, y
				dex
				lda	misc_hammer_veloc_x, x
				ldx	actor_index
				sta	veloc_x_misc, x
			: ; }
	
			dec	state_misc, x

			lda	pos_x_lo_actor, y
			clc
			adc	#<MISC_HAMMER_ACTOR_OFFSET_X
			sta	pos_x_lo_misc, x

			lda	pos_x_hi_actor, y
			adc	#>MISC_HAMMER_ACTOR_OFFSET_X
			sta	pos_x_hi_misc, x

			lda	pos_y_lo_actor, y
			sec
			sbc	#<MISC_HAMMER_ACTOR_OFFSET_Y
			sta	pos_y_lo_misc, x

			lda	#>MISC_HAMMER_ACTOR_OFFSET_Y
			sta	pos_y_hi_misc, x
			bne	:++
		: ; }

		; if (this.off_y) {
			jsr	col_player_hammer_proc
		; }
	: ; }

	jsr	pos_bits_get_misc
	jsr	pos_calc_x_rel_misc

	jsr	col_misc_box

	jsr	render_hammer

	rts
