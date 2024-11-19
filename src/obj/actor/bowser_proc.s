.include	"math.i"
.include	"mem.i"
.include	"tunables.i"
.include	"misc.i"
.include	"joypad.i"
.include	"sound.i"
.include	"macros.i"

; -----------------------------------------------------------
BOWSER_VELOC_X_ABS	= 16
BOWSER_VELOC_Y		= 8
BOWSER_VELOC_Y_NEG	= <-2
BOWSER_TIMER_START_POS_Y	= 128
BOWSER_COL_BOX		= col_boxes::box_10
BOWSER_GFX_CLEAR_BASE	= PPU_VRAM_BG1+PPU_BG_ROW_16
BOWSER_DEATH_Y_POS	= 224
; -----------------------------------------------------------
actor_bowser_ending_clear_blocks:
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_0+PPU_BG_COL_26)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_2+PPU_BG_COL_24)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_24)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_22)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_20)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_18)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_16)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_14)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_12)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_10)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_8)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_6)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_4)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_2)
	.byte	<(BOWSER_GFX_CLEAR_BASE+PPU_BG_ROW_4+PPU_BG_COL_0)
actor_bowser_ending_clear_blocks_end:
; -----------------------------
	.export actor_bowser_ending
actor_bowser_ending:
	ldx	actor_index_bowser
	lda	obj_id_actor, x
	cmp	#actor::bowser
	bne	:+
	stx	actor_index
	lda	state_actor, x
	beq	:+++
	and	#actor_states::falling
	beq	:+
	lda	pos_y_lo_actor, x
	cmp	#BOWSER_DEATH_Y_POS
	bcc	:++
	: ; if (this.id != bowser || (this.state != init && !this.falling) || this.pos_y >= BOWSER_DEATH_Y_POS) {
		lda	#music_event::none
		sta	apu_music_event_req
		inc	proc_id_game
		jmp	actor_killall
	: ; } else if (this.state != init && this.falling && this.pos_y < BOWSER_DEATH_Y_POS) {
		jsr	motion_fall_slow
		jmp	actor_proc_bowser_finish
	: ; } else {
		dec	timer_ani_bowser
		bne	:+ ; if (--this.timer_ani == 0) {
			lda	#4
			sta	timer_ani_bowser
			lda	actor_bowser_ani_flag
			eor	#actor_bowser_ani::step_bit
			sta	actor_bowser_ani_flag

			lda	#>(BOWSER_GFX_CLEAR_BASE)
			sta	gfx_clear_put_do_addr+1
			ldy	actor_bowser_ending_clear_frame
			lda	actor_bowser_ending_clear_blocks, y
			sta	gfx_clear_put_do_addr
			ldy	nmi_list_0_offset
			iny
			ldx	#clear_blocks::blank_a*METATILE_SIZE
			jsr	gfx_clear_put_do
			ldx	actor_index
			jsr	gfx_meta_step
			lda	#sfx_pulse_2::blast
			sta	apu_sfx_pulse_2_req
			lda	#sfx_noise::block_break_01
			sta	apu_sfx_noise_req
			inc	actor_bowser_ending_clear_frame
			lda	actor_bowser_ending_clear_frame
			cmp	#(actor_bowser_ending_clear_blocks_end-actor_bowser_ending_clear_blocks)
			bne	:+ ; if (actor_bowser_ending_clear_frame > sizeof (actor_bowser_ending_clear_blocks)) {
				jsr	actor_init_veloc_y
				lda	#actor_states::falling
				sta	state_actor, x
				lda	#sfx_pulse_2::bowser_fall
				sta	apu_sfx_pulse_2_req
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
	lda	game_timer_stop
	beq	:+
	jmp	actor_proc_bowser_motion_skip
	: lda	actor_bowser_ani_flag
	bpl	:+
	jmp	:+++++++
	: ; if (!game_timer_stop && actor_bowser_ani.mouth_open) {
		dec	timer_ani_bowser
		bne	:+ ; if (--this.timer_ani == 0) {
			lda	#ACTOR_BOWSER_TIMER_INIT
			sta	timer_ani_bowser
			lda	actor_bowser_ani_flag
			eor	#actor_bowser_ani::step_bit
			sta	actor_bowser_ani_flag
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
			lda	#2
			sta	veloc_x_bowser
			lda	#ACTOR_BOWSER_TIMER_INIT
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
			cmp	pos_x_prev_bowser
			bne	:+ ; if (this.pos_x == this.pos_x_prev) {
				lda	srand, x
				and	#MOD_4
				tay
				lda	actor_proc_bowser_timer_data, y
				sta	actor_bowser_rand_offset
			: ; }
		
			lda	pos_x_lo_actor, x
			clc
			adc	veloc_x_bowser
			sta	pos_x_lo_actor, x
			ldy	motion_dir_actor, x
			cpy	#DIR_RIGHT
			beq	:++ ; if (actor.motion_dir == right) {
				ldy	#<-1
				sec
				sbc	pos_x_prev_bowser
				bpl	:+ ; if (this.pos_x < this.pos_x_prev) {
					neg_m
					ldy	#1
				: ; }
			
				cmp	actor_bowser_rand_offset
				bcc	:+ ; if (actor.pos_x >= actor_bowser_rand_offset) {
					sty	veloc_x_bowser
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
		lda	srand, x
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
	
	: ; while (actor_bowser_ani.mouth_closed) {
		lda	course_no
		cmp	#course::no_08
		beq	:+
		cmp	#course::no_06
		bcs	:+++
		: lda	timer_bowser_flame
		bne	:++ ; if (course_no.not_in(6, 7) && timer_bowser_flame == 0) {
			lda	#ACTOR_BOWSER_FLAME_TIMER
			sta	timer_bowser_flame

			lda	actor_bowser_ani_flag
			eor	#actor_bowser_ani::mouth_bit
			sta	actor_bowser_ani_flag
			bmi	:-- ; if (actor_bowser_ani.mouth_open) {
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
		; } else break;
	: ; }

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
	sta	obj_id_actor, x
	jsr	actor_proc_bowser_col

	pla
	sta	actor_index
	tax
	lda	#0
	sta	actor_bowser_ani_frame
	: rts
; -----------------------------
actor_proc_bowser_col:
	inc	actor_bowser_ani_frame
	jsr	actor_proc_toad
	lda	state_actor, x
	bne	:- ; if (this.state == init) {
		lda	#BOWSER_COL_BOX
		sta	col_box_actor, x
		jsr	col_actor_box
		jmp	col_player_actor_proc
	; }
