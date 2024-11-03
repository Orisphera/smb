.include	"system/cpu.i"

.include	"mem.i"
.include	"misc.i"
.include	"sound.i"

; -----------------------------------------------------------
	.export actor_proc_fireworks
actor_proc_fireworks:
	dec	veloc_y_actor, x
	bne	:+
	lda	#8
	sta	veloc_y_actor, x
	inc	veloc_x_actor, x
	lda	veloc_x_actor, x
	cmp	#3
	bcs	:++
	: ; if (--actor.veloc_y > 0 || ++actor.veloc_x < 3) {
		jsr	lib_calc_actor_pos
		lda	pos_y_rel_actor
		sta	pos_y_rel_proj
		lda	pos_x_rel_actor
		sta	pos_x_rel_proj
		ldy	obj_data_offset_actor, x
		lda	veloc_x_actor, x
		jsr	render_fireworks
		rts
	: ; } else {
		lda	#actor_modes::free
		sta	actor_mode, x
		lda	#sfx_pulse_2::blast
		sta	apu_sfx_pulse_2_req
		lda	#5
		sta	score_digit_mod+5
		jmp	actor_proc_course_end_stats
	; }
