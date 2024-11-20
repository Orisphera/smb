.include	"mem.i"

; -----------------------------------------------------------
actor_proc_firebar_spin_accel_x	= zp_byte_07

	.export actor_proc_firebar_spin
actor_proc_firebar_spin:
	sta	actor_proc_firebar_spin_accel_x
	lda	rot_dir_actor, x
	bne	:+ ; if (this.rot_dir == 0) {
		ldy	#24
		lda	veloc_x_actor, x
		clc
		adc	actor_proc_firebar_spin_accel_x
		sta	veloc_x_actor, x
		lda	veloc_y_actor, x
		adc	#0

		rts
	: ; } else {
		ldy	#8
		lda	veloc_x_actor, x
		sec
		sbc	actor_proc_firebar_spin_accel_x
		sta	veloc_x_actor, x
		lda	veloc_y_actor, x
		sbc	#0

		rts
	; }
