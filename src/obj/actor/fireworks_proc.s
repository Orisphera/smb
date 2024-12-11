.include	"system/cpu.i"

.include	"mem.i"
.include	"misc.i"
.include	"sound.i"

; -----------------------------------------------------------
	.export actor_proc_fireworks
	.export	actor_B_01_proc
actor_proc_fireworks:
actor_B_01_proc:
	dec	veloc_y_actor, x
	bne	:+
	lda	#8
	sta	veloc_y_actor, x
	inc	veloc_x_actor, x
	lda	veloc_x_actor, x
	cmp	#3
	bcs	:++
	: ; if (--actor.veloc_y > 0 || ++actor.veloc_x < 3) {
		jsr	pos_calc_x_rel_actor
		lda	pos_y_rel_actor
		sta	pos_y_rel_proj
		lda	pos_x_rel_actor
		sta	pos_x_rel_proj
		ldy	obj_data_offset_actor, x
		lda	veloc_x_actor, x
		jsr	render_fireworks
		rts
	: ; } else {
		lda	#proc_id_actors::free
		sta	proc_id_actor, x
		lda	#sfx_pulse_2::blast
		sta	apu_sfx_pulse_2_req
		lda	#5
		sta	score_digit_mod+5
		jmp	actor_proc_course_end_stats
	; }
