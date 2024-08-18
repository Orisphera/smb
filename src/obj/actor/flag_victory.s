.include	"system/ppu.i"

.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/misc.i"
.include	"engine/chr.i"
.include	"engine/sound.i"

.include	"engine/unk.i"

; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)
	ENG_TIMER_DISP	= eng_timer_disp
.elseif	.defined(SMB2M)
	ENG_TIMER_DISP	= eng_timer_disp_b
.endif
.if	.defined(SMB)|.defined(VS_SMB)
ACTOR_PROC_FLAG_VICTORY_TIMER_VAL	= $23
.elseif	.defined(SMB2M)
ACTOR_PROC_FLAG_VICTORY_TIMER_VAL	= $17
.endif
; -----------------------------------------------------------
actor_proc_flag_pos_y:
	.byte	0, 0, 8, 8

actor_proc_flag_pos_x:
	.byte	0, 8, 0, 8

actor_proc_flag_chr_nos:
	.byte	tile_obj::flag_victory
	.byte	tile_obj::flag_victory+1
	.byte	tile_obj::flag_victory+2
	.byte	tile_obj::flag_victory+3
actor_proc_flag_chr_nos_end:
; ----------------------------
	.export actor_proc_flag_victory
	.export actor_proc_flag_victory_tbl
	.export actor_proc_flag_victory_tbl_null
	.export actor_proc_flag_victory_tbl_fireworks
	.export actor_proc_flag_victory_tbl_timer_score
	.export actor_proc_flag_victory_tbl_raise
	.export actor_proc_flag_victory_tbl_delay
	.export actor_proc_flag_victory_tbl_done
actor_proc_flag_victory:
	lda	#0
	sta	actor_swarm_buffer
	lda	actor_proc_flag_victory_id
	cmp	#<victory_flag_proc::done
	bcs	actor_proc_flag_victory_fireworks_rts
	jsr	eng_farjump
actor_proc_flag_victory_tbl:
actor_proc_flag_victory_tbl_null:
	.addr	actor_proc_flag_victory_fireworks_rts
actor_proc_flag_victory_tbl_fireworks:
	.addr	actor_proc_flag_victory_fireworks
actor_proc_flag_victory_tbl_timer_score:
	.addr	actor_proc_flag_victory_timer_score
actor_proc_flag_victory_tbl_raise:
	.addr	actor_proc_flag_victory_raise
actor_proc_flag_victory_tbl_delay:
	.addr	actor_proc_flag_victory_delay
actor_proc_flag_victory_tbl_done:
; -----------------------------------------------------------
actor_proc_flag_victory_fireworks:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	#actor_states::state_5
		lda	ENG_TIMER_DISP+2
		cmp	#1
		beq	:+ ; if (eng_timer_disp[2] != 1) {
			ldy	#actor_states::state_3
	
			cmp	#3
			beq	:+ ; if (eng_timer_disp[2] != 3) {
				ldy	#actor_states::init
	
				cmp	#6
				beq	:+ ; if (eng_timer_disp[2] != 6) {
					lda	#<-1
				; }
			; }
		: ; }
	.elseif	.defined(SMB2M)
	        lda     ENG_TIMER_DISP+2
	        cmp     byte_7E8
	        bne     :++
	        and     #MOD_2
	        beq     :+ ; if ((ENG_TIMER_DISP[2] == byte_7E8) && (ENG_TIMER_DISP[2] % 2)) {
	        	ldy     #actor_states::state_3
	        	lda     #3

	        	bne     :+++
		: ; } else if ((ENG_TIMER_DISP[2] == byte_7E8) && !(ENG_TIMER_DISP[2] % 2)) {
	        	ldy     #actor_states::init
	        	lda     #6

	        	bne     :++
		: ; } else {
	        	ldy     #actor_states::init
			lda	#<-1
		: ; }
	.endif
	sta	actor_firework_counter
	sty	state_actor, x

actor_proc_flag_victory_fireworks_step:
	inc	actor_proc_flag_victory_id

actor_proc_flag_victory_fireworks_rts:
	rts
; -----------------------------------------------------------
	.export actor_proc_flag_victory_timer_score_do
	.export actor_proc_course_end_stats
actor_proc_flag_victory_timer_score:
	lda	ENG_TIMER_DISP
	ora	ENG_TIMER_DISP+1
	ora	ENG_TIMER_DISP+2
	beq	actor_proc_flag_victory_fireworks_step

actor_proc_flag_victory_timer_score_do:
	lda	frame_count
	and	#MOD_8_4_UP
	beq	:+ ; if ((frame_count % 8) >= 4) {
		lda	#sfx_pulse2::tick
		sta	apu_pulse2_queue
	: ; }

	ldy	#ACTOR_PROC_FLAG_VICTORY_TIMER_VAL
	lda	#$FF
	sta	score_digit_mod+6
	jsr	eng_stats_math
	lda	#5
	sta	score_digit_mod+6
; ------------------------------
actor_proc_course_end_stats:
	ldy	#$0B

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	player_id
		beq	:+ ; if (player_id) {
			ldy	#$11
		: ; }
	.endif

	jsr	eng_stats_math

	.if	.defined(SMB)|.defined(VS_SMB)
		lda	player_id
		asl	a
		asl	a
		asl	a
		asl	a
		ora	#%00000100
	.elseif	.defined(SMB2M)
		lda	#2
	.endif
	jmp	misc_proc_coin_add_score
; -----------------------------------------------------------
actor_proc_flag_victory_raise:
	lda	pos_y_lo_actor, x
	cmp	#114
	bcc	:+ ; if (actor.pos_y >= 114) {
		dec	pos_y_lo_actor, x

		jmp	actor_proc_flag_victory_draw
	: lda	actor_firework_counter
	beq	actor_proc_flag_victory_start_flag
	bmi	actor_proc_flag_victory_start_flag ; } else if (actor_firework_counter > 0) {
		lda	#actor::fireworks
		sta	actor_swarm_buffer
	; } else actor_proc_flag_victory_start_flag();
; ------------------------------
actor_proc_flag_victory_draw:
	jsr	lib_calc_actor_pos
	ldy	obj_data_offset_actor, x
	ldx	#(actor_proc_flag_chr_nos_end-actor_proc_flag_chr_nos)-1
	: ; for () {
		lda	pos_y_rel_actor
		clc
		adc	actor_proc_flag_pos_y, x
		sta	OAM_DMA_BUFFER+OBJ_POS_V, y
		lda	actor_proc_flag_chr_nos, x
		sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
		lda	#obj_attr::priority_low|obj_attr::color2
		sta	OAM_DMA_BUFFER+OBJ_ATTR, y
		lda	pos_x_rel_actor
		clc
		adc	actor_proc_flag_pos_x, x
		sta	OAM_DMA_BUFFER+OBJ_POS_H, y

		iny
		iny
		iny
		iny
		dex
		bpl	:-
	; }

	ldx	actor_index
	rts
; -----------------------------
actor_proc_flag_victory_start_flag:
	jsr	actor_proc_flag_victory_draw
	lda	#6
	sta	timer_actor, x

actor_proc_flag_victory_next:
	inc	actor_proc_flag_victory_id
	rts
; -----------------------------------------------------------
actor_proc_flag_victory_delay:
	jsr	actor_proc_flag_victory_draw

	lda	timer_actor, x
	bne	:+ ; if (actor.timer == 0) {
		lda	snd_ram+1
		beq	actor_proc_flag_victory_next
	: ; }

	rts
