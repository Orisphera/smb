.include	"engine/mem.i"
.include	"engine/misc.i"
.include	"engine/tunables.i"

.include	"engine/unk.i"
; ------------------------------------------------------------
MISC_HAMMER_ACCEL_Y_INC		= 16
MISC_HAMMER_ACCEL_Y_DEC		= 15
MISC_HAMMER_VELOC_Y_MAX_ABS	= 4
MISC_HAMMER_VELOC_X_INIT_ABS	= 16
MISC_HAMMER_VELOC_Y_INIT	= <-2
MISC_HAMMER_GRAVITY_INIT 	= 0
MISC_HAMMER_COL_BOX		= col_boxes::box_7

MISC_HAMMER_ACTOR_OFFSET_X	= 2
MISC_HAMMER_ACTOR_OFFSET_Y	= $10A
; ------------------------------------------------------------
misc_hammer_actor_id:
	.byte	4, 4, 4, 5, 5, 5, 6, 6, 6
misc_hammer_actor_id_end:

misc_hammer_veloc_x:
	.byte	MISC_HAMMER_VELOC_X_INIT_ABS, <-MISC_HAMMER_VELOC_X_INIT_ABS
; -----------------------------
	.export misc_init_hammer
misc_init_hammer:
	lda	eng_rand_seed+1
	and	#(misc_hammer_actor_id_end-misc_hammer_actor_id)-2
	bne	:+ ; if (!(eng_rand_seed[1] % misc_hammer_actor_id_count)) {
		lda	eng_rand_seed+1
		and	#(misc_hammer_actor_id_end-misc_hammer_actor_id)-1
	: ; }
	tay

	lda	state_misc, y
	bne	:+
	ldx	misc_hammer_actor_id, y
	lda	actor_mode, x
	bne	:+ ; if (this.state == inactive && this.mode == free) {
		ldx	actor_index
		txa
		sta	misc_actor_id, y
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
; -----------------------------
	.export misc_proc_hammer
misc_proc_hammer:
	lda	eng_timer_ctl
	bne	:++++ ; if (eng_timer_ctl == 0) {
		lda	state_misc, x
		and	#<~misc_states::hammer
		ldy	misc_actor_id, x
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

	jsr	lib_misc_bits_get
	jsr	lib_calc_misc_pos
	jsr	col_misc_box
	jsr	render_hammer

	rts
