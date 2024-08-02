.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/misc.i"
.include	"engine/joypad.i"

.include	"engine/unk.i"

.include	"macros.i"

; -----------------------------------------------------------
LAKITU_VELOC_X	= 16
; -----------------------------------------------------------
actor_proc_lakitu_data:
	.byte	$15, $30, $40
; -----------------------------
	.export actor_proc_lakitu, actor_proc_lakitu_spiny
actor_proc_lakitu:
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

		ldy	#MOTION_DIR_RIGHT
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
actor_proc_lakitu_spiny:
	ldy	#0
	jsr	col_player_bullet_diff
	bpl	:+ ; if (col_player_bullet_diff() < 0) {
		iny
		lda	zp_byte_00
		neg_m
		sta	zp_byte_00
	: ; }

	lda	zp_byte_00
	cmp	#$3C
	bcc	:++
	lda	#$3C
	sta	zp_byte_00
	lda	actor_id, x
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
	: ; if (zp_byte_00 < 0x3C || actor.id != lakitu || actor.veloc_y == dir_parity || actor.veloc_y == 0 || --actor.veloc_x == 0) {
		; if (actor.veloc_y == 0 || actor.veloc_x == 0) {
			tya
			sta	veloc_y_actor, x
		: ; }

		lda	zp_byte_00
		and	#%00111100
		lsr	a
		lsr	a
		sta	zp_byte_00
		ldy	#0
		lda	veloc_x_player
		beq	:+++
		lda	eng_scroll_amount
		beq	:+++ ; if (player.veloc_x != 0 && eng_scroll_amount != 0) {
			iny
			lda	veloc_x_player
			cmp	#25
			bcc	:+
			lda	eng_scroll_amount
			cmp	#2
			bcc	:+ ; if (player.veloc_x >= 25 && eng_scroll_amount >= 2) {
				iny
			: ; }
		
			lda	actor_id, x
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
		ldy	zp_byte_00
		: ; for (i = zp_byte_00; i >= 0; i--) {
			sec
			sbc	#1
	
			dey
			bpl	:-
		; }
	: ; }

	rts

