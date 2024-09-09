.include	"math.i"
.include	"mem.i"
.include	"tunables.i"
.include	"misc.i"
.include	"joypad.i"
.include	"sound.i"

.include	"unk.i"

.include	"macros.i"

; -----------------------------------------------------------
BOWSER_VELOC_X_ABS	= 16
BOWSER_VELOC_Y		= 8
BOWSER_VELOC_Y_NEG	= <-2
BOWSER_TIMER_START_POS_Y	= 128
BOWSER_COL_BOX		= col_boxes::box_10
; -----------------------------------------------------------
actor_bowser_ending_data:
	.byte	$1A, $58
	.byte	$98, $96, $94, $92, $90, $8E, $8C
	.byte	$8A, $88, $86, $84, $82, $80
; -----------------------------
	.export actor_bowser_ending
actor_bowser_ending:
	ldx	nmi_list_1_data+$27
	lda	actor_id, x
	cmp	#actor::bowser
	bne	:+
	stx	actor_index
	lda	state_actor, x
	beq	:+++
	and	#actor_states::bit_6
	beq	:+
	lda	pos_y_lo_actor, x
	cmp	#224
	bcc	:++
	: ; if (actor.id != bowser || (actor.state != state_0 && actor_state & 0x40) || actor.pos_y >= 224) {
		lda	#music_event::none
		sta	apu_music_event
		inc	game_state
		jmp	actor_killall
	: ; } else if () {
		jsr	motion_fall_slow
		jmp	actor_proc_bowser_finish
	: ; } else {
		dec	nmi_list_1_data+$23
		bne	:+ ; if () {
			lda	#$04
			sta	nmi_list_1_data+$23
			lda	nmi_list_1_data+$22
			eor	#1
			sta	nmi_list_1_data+$22
			lda	#$22
			sta	zp_byte_05
			ldy	nmi_list_1_data+$28
			lda	actor_bowser_ending_data, y
			sta	zp_byte_04
			ldy	nmi_list_0_offset
			iny
			ldx	#clear_blocks::blank_a*METATILE_SIZE
			jsr	gfx_clear_put_do
			ldx	actor_index
			jsr	gfx_meta_step
			lda	#sfx_pulse2::blast
			sta	apu_pulse2_queue
			lda	#sfx_noise::block_break_01
			sta	apu_noise_event
			inc	nmi_list_1_data+$28
			lda	nmi_list_1_data+$28
			cmp	#$0F
			bne	:+ ; if () {
				jsr	actor_init_veloc_y
				lda	#actor_states::bit_6
				sta	state_actor, x
				lda	#sfx_pulse2::bowser_fall
				sta	apu_pulse2_queue
			; }
		: ; }
	
		jmp	actor_proc_bowser_finish
	; }
; -----------------------------------------------------------
actor_proc_bowser_timer_data:
	.byte	33, 65, 17, 49
; ----------------------------
	.export actor_proc_bowser, actor_killall
actor_proc_bowser:
	lda	state_actor, x
	and	#actor_states::bit_5
	beq	:++
	lda	pos_y_lo_actor, x
	cmp	#224
	bcc	:--- ; if ((actor.state & 0x20) && actor.pos_y >= 224) {
	actor_killall:
		ldx	#ENG_ACTOR_MAX-2
		: ; for (x = ENG_ACTOR_MAX-2; x >= 0; x--) {
			jsr	actor_erase
	
			dex
			bpl	:-
		; }
	
		sta	actor_swarm_buffer
		ldx	actor_index
		rts
	: ; }
	lda	#0
	sta	actor_swarm_buffer
	lda	eng_timer_ctl
	beq	:+
	jmp	actor_proc_bowser_motion_skip
	: lda	nmi_list_1_data+$22
	bpl	:+
	jmp	:+++++++
	: ; if () {
		dec	nmi_list_1_data+$23
		bne	:+ ; if () {
			lda	#$20
			sta	nmi_list_1_data+$23
			lda	nmi_list_1_data+$22
			eor	#1
			sta	nmi_list_1_data+$22
		: ; }
	
		lda	frame_count
		and	#MOD_16
		bne	:+ ; if (!(frame_count % 16))
			lda	#DIR_LEFT
			sta	motion_dir_actor, x
		: ; }
	
		lda	timer_ani_actor, x
		beq	:+
		jsr	col_player_bullet_diff
		bpl	:+ ; if (timer_ani_actor && col_player_bullet_dif() < 0) {
			lda	#DIR_RIGHT
			sta	motion_dir_actor, x
			lda	#$02
			sta	nmi_list_1_data+$24
			lda	#32
			sta	timer_ani_actor, x
			sta	timer_bowser_flame
			lda	pos_x_lo_actor, x
			cmp	#200
			bcs	:++++
		: ; }
	
		lda	frame_count
		and	#MOD_4
		bne	:+++ ; if ((!timer_ani_actor || col_player_bullet_diff() >= 0 || (this.pos_x < 200)) && !(frame_count % 4)) {
			lda	pos_x_lo_actor, x
			cmp	nmi_list_1_data+$25
			bne	:+ ; if () {
				lda	lib_rand, x
				and	#MOD_4
				tay
				lda	actor_proc_bowser_timer_data, y
				sta	eng_bowser_rand_offset
			: ; }
		
			lda	pos_x_lo_actor, x
			clc
			adc	nmi_list_1_data+$24
			sta	pos_x_lo_actor, x
			ldy	motion_dir_actor, x
			cpy	#DIR_RIGHT
			beq	:++ ; if (actor.motion_dir == right) {
				ldy	#<-1
				sec
				sbc	nmi_list_1_data+$25
				bpl	:+ ; if () {
					neg_m
					ldy	#1
				: ; }
			
				cmp	eng_bowser_rand_offset
				bcc	:+ ; if (actor.pos_x >= eng_bowser_rand_offset) {
					sty	nmi_list_1_data+$24
				; }
			; }
		; }
	: ; }

	lda	timer_ani_actor, x
	bne	:++

	jsr	motion_fall_slow

	lda	course_no
	cmp	#course::no_06
	bcc	:+
	lda	frame_count
	and	#MOD_4
	bne	:+ ; if (course_no >= no_06 && !(frame_count % 4)) {
		jsr	misc_init_hammer
	: ; }

	lda	pos_y_lo_actor, x
	cmp	#BOWSER_TIMER_START_POS_Y
	bcc	:++ ; if (actor.pos_y >= timer_start_pos) {
		lda	lib_rand, x
		and	#MOD_4
		tay
		lda	actor_proc_bowser_timer_data, y
		sta	timer_ani_actor, x
	; }

actor_proc_bowser_motion_skip:
	jmp	:++
	: cmp	#1
	bne	:+ ; if (timer_ani_actor == 1) {
		dec	pos_y_lo_actor, x
		jsr	actor_init_veloc_y
		lda	#BOWSER_VELOC_Y_NEG
		sta	veloc_y_actor, x
	; }
	
	: ; for () {
		lda	course_no
		cmp	#course::no_08
		beq	:+
		cmp	#course::no_06
		bcs	actor_proc_bowser_finish
		: lda	timer_bowser_flame
		bne	actor_proc_bowser_finish ; if (course_no != no_07 && timer_bowser_flame == 0) {
			lda	#ACTOR_BOWSER_FLAME_TIMER
			sta	timer_bowser_flame
			lda	nmi_list_1_data+$22
			eor	#%10000000
			sta	nmi_list_1_data+$22
			bmi	:--
		; }
	; }

	; if () {
		jsr	actor_proc_bowser_flame_timer_init
		ldy	game_hard_mode_b
		beq	:+ ; if (game_hard_mode_b) {
			sec
			sbc	#ACTOR_BOWSER_FLAME_TIMER_HARD_OFFSET
		: ; }
		sta	timer_bowser_flame
	
		lda	#actor::bowser_flame
		sta	actor_swarm_buffer
	; }

actor_proc_bowser_finish:
	jsr	actor_proc_bowser_col
	ldy	#BOWSER_VELOC_X_ABS
	lda	motion_dir_actor, x
	lsr	a
	bcc	:+ ; if (this.motion_dir == right) {
		ldy	#<-BOWSER_VELOC_X_ABS
	: ; }
	tya
	clc
	adc	pos_x_lo_actor, x
	ldy	actor_dup_offset
	sta	pos_x_lo_actor, y
	lda	pos_y_lo_actor, x
	clc
	adc	#BOWSER_VELOC_Y
	sta	pos_y_lo_actor, y
	lda	state_actor, x
	sta	state_actor, y
	lda	motion_dir_actor, x
	sta	motion_dir_actor, y
	lda	actor_index
	pha

	ldx	actor_dup_offset
	stx	actor_index
	lda	#actor::bowser
	sta	actor_id, x
	jsr	actor_proc_bowser_col

	pla
	sta	actor_index
	tax
	lda	#0
	sta	nmi_list_1_data+$29
	: rts
; -----------------------------
actor_proc_bowser_col:
	inc	nmi_list_1_data+$29
	jsr	actor_proc_toad
	lda	state_actor, x
	bne	:- ; if (actor.state == init) {
		lda	#BOWSER_COL_BOX
		sta	col_box_actor, x
		jsr	col_actor_box
		jmp	col_player_actor_proc
	; }
