.include	"math.i"
.include	"mem.i"
.include	"misc.i"
.include	"joypad.i"
.include	"macros.i"

; -----------------------------------------------------------
LAKITU_VELOC_X	= 16
; -----------------------------------------------------------
actor_proc_lakitu_data:
	.byte	$15, $30, $40
; -----------------------------
	.export actor_proc_lakitu, actor_proc_lakitu_spiny
	.export	actor_A_11_proc
actor_proc_lakitu:
actor_A_11_proc:
	lda	state_actor, x
	and	#actor_states::bit_5
	beq	:+ ; if (actor.state & 0x20) {
		jmp	motion_y
	: ; } else {
		lda	state_actor, x
		beq	:+ ; if (actor_state != init) {
			lda	#0
			sta	veloc_y_actor, x
			sta	actor_swarm_buffer
			lda	#LAKITU_VELOC_X

			bne	:+++
		: ; } else {
			lda	#actor::spiny
			sta	actor_swarm_buffer
			ldy	#3-1
			: ; for (y = 3-1; y >= 0; y--) {
				lda	actor_proc_lakitu_data, y
				sta	zp_byte_01, y
				dey
				bpl	:-
			; }
		
			jsr	actor_proc_lakitu_spiny
		: ; }
		sta	veloc_x_actor, x

		ldy	#DIR_RIGHT
		lda	veloc_y_actor, x
		and	#MOD_2
		bne	:+ ; if (!(actor.veloc_y % 2)) {
			lda	veloc_x_actor, x
			neg_m
			sta	veloc_x_actor, x
			iny
		: ; }
		sty	motion_dir_actor, x
		jmp	motion_x
	; }
; -----------------------------
actor_proc_lakitu_spiny_pos_x_rel_abs	= zp_byte_00

actor_proc_lakitu_spiny:
	ldy	#0
	jsr	col_player_bullet_diff
	bpl	:+ ; if (col_player_bullet_diff() < 0) {
		iny
		lda	col_player_bullet_diff_pos_x_rel
		neg_m
		sta	actor_proc_lakitu_spiny_pos_x_rel_abs
	: ; }

	lda	actor_proc_lakitu_spiny_pos_x_rel_abs
	cmp	#$3C
	bcc	:++
	lda	#$3C
	sta	actor_proc_lakitu_spiny_pos_x_rel_abs
	lda	obj_id_actor, x
	cmp	#actor::lakitu
	bne	:++
	tya
	cmp	veloc_y_actor, x
	beq	:++
	lda	veloc_y_actor, x
	beq	:+
	dec	veloc_x_actor, x
	lda	veloc_x_actor, x
	bne	:+++++++
	: ; if (actor_proc_lakitu_spiny_pos_x_rel_abs < 0x3C || actor.id != lakitu || actor.veloc_y == dir_parity || actor.veloc_y == 0 || --actor.veloc_x == 0) {
		; if (actor.veloc_y == 0 || actor.veloc_x == 0) {
			tya
			sta	veloc_y_actor, x
		: ; }

		lda	actor_proc_lakitu_spiny_pos_x_rel_abs
		and	#%00111100
		lsr	a
		lsr	a
		sta	actor_proc_lakitu_spiny_pos_x_rel_abs
		ldy	#0
		lda	veloc_x_player
		beq	:+++
		lda	game_scroll_amount
		beq	:+++ ; if (player.veloc_x != 0 && game.scroll_amount != 0) {
			iny
			lda	veloc_x_player
			cmp	#LAKITU_SPINY_VELOC_X_PLAYER_CUTOFF
			bcc	:+
			lda	game_scroll_amount
			cmp	#2
			bcc	:+ ; if (player.veloc_x >= 25 && game.scroll_amount >= 2) {
				iny
			: ; }
		
			lda	obj_id_actor, x
			cmp	#actor::spiny
			bne	:+
			lda	veloc_x_player
			bne	:++
			: lda	veloc_y_actor, x
			bne	:+ ; if ((actor.id != spiny || player.veloc_x == 0) && actor.veloc_y == 0) {
				ldy	#0
			; }
		: ; }

		lda	zp_byte_01, y
		ldy	actor_proc_lakitu_spiny_pos_x_rel_abs
		: ; for (i = zp_byte_00; i >= 0; i--) {
			sec
			sbc	#1
	
			dey
			bpl	:-
		; }
	: ; }

	rts

