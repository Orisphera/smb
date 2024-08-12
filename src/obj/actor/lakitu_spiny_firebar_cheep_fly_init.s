.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/joypad.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"

.include	"macros.i"

; -----------------------------------------------------------
LAKITU_SPINY_SWARM_TIMER	= 128
LAKITU_OFFSET_X			= 32
LAKITU_OFFSET_X_B		= 96
SPINY_PLAYER_Y_CUTOFF		= 44
SPINY_LAKITU_OFFSET_Y		= 8
SPINY_PLAYER_VELOC_X_CUTOFF	= 8
SPINY_VELOC_Y			= <-3

.if	.defined(SMB)|.defined(VS_SMB)
	LAKITU_SPAWN_TIME		= 7
.elseif	.defined(SMB2M)
	LAKITU_SPAWN_TIME		= 3
.endif

FIREBAR_OFFSET		= 4
FIREBAR_OFFSET_X	= FIREBAR_OFFSET
FIREBAR_OFFSET_Y	= FIREBAR_OFFSET

CHEEP_FLY_COUNT_BASE	= 3
CHEEP_FLY_VELOC_Y	= <-5
CHEEP_FLY_PLAYER_VELOC_OFFSET_X	= 25
; -----------------------------------------------------------
	.export actor_init_lakitu
actor_init_lakitu:
	lda	actor_swarm_buffer
	bne	:+ ; if (!actor_swarm_buffer) {
	actor_init_lakitu_do:
		lda	#0
		sta	eng_timer_lakitu_new
		jsr	actor_init_veloc_x_none
		jmp	actor_init_col_large_b
	: ; } else {
		jmp	actor_erase
	; }
; -----------------------------------------------------------
actor_spiny_data:
	.byte	$26, $2C, $32, $38
	.byte	$20, $22, $24, $26
	.byte	$13, $14, $15, $16
; ------------------------------
	.export actor_init_lakitu_spiny
actor_init_lakitu_spiny:
	lda	eng_timer_swarm
	bne	:+++++
	cpx	#ENG_ACTOR_MAX-1
	bcs	:+++++ ; if (eng_timer_swarm == 0 && this.idx < (ENG_ACTOR_MAX-1)) {
		lda	#LAKITU_SPINY_SWARM_TIMER
		sta	eng_timer_swarm
		ldy	#ENG_ACTOR_MAX-2
		: ; for (y = ENG_ACTOR_MAX-2; y >= 0; y--) {
			lda	actor_id, y
			cmp	#actor::lakitu
			beq	actor_proc_spiny

			dey
			bpl	:-
		; }

		; if (lakitu_not_found) {
			inc	eng_timer_lakitu_new
			lda	eng_timer_lakitu_new
			cmp	#LAKITU_SPAWN_TIME
			bcc	:++++ ; if (++this.timer_new >= LAKITU_SPAWN_TIME) {
				ldx	#ENG_ACTOR_MAX-2
				: ; for (x = ENG_ACTOR_MAX-2; x >= 0; x--) {
					lda	actor_mode, x
					beq	:+

					dex
					bpl	:-
					bmi	:++
				: ; }
				; if (free_actor_found) {
					lda	#actor_states::init
					sta	state_actor, x
					lda	#actor::lakitu
					sta	actor_id, x
					jsr	actor_init_lakitu_do
					lda	#LAKITU_OFFSET_X

					.if	.defined(SMB2M)
						ldy	byte_7FB

						.if	.defined(SMB2)
						bne	actor_init_lakitu_offset_x_b
						ldy	course_no
						cpy	#course::no_07
						bcc	actor_init_lakitu_offset_x_b_skip
						.elseif	.defined(ANN)
						beq	actor_init_lakitu_offset_x_b_skip
						.endif
						; if (byte_7FB || (SMB2 && course_no >= no_07)) {
						actor_init_lakitu_offset_x_b:
							lda	#LAKITU_OFFSET_X_B
						actor_init_lakitu_offset_x_b_skip: ; }
					.endif

					jsr	actor_init_right_side
				: ; }
			
				ldx	actor_index
			; }
		; }
	: ; }

	rts
; ------------------------------
actor_proc_spiny:
	lda	pos_y_lo_player
	cmp	#SPINY_PLAYER_Y_CUTOFF
	bcc	:-
	lda	state_actor, y
	bne	:- ; if (player.pos_y >= SPINY_PLAYER_Y_CUTOFF && lakitu.state == init) {
		lda	pos_x_hi_actor, y
		sta	pos_x_hi_actor, x
		lda	pos_x_lo_actor, y
		sta	pos_x_lo_actor, x
		lda	#1
		sta	pos_y_hi_actor, x
		lda	pos_y_lo_actor, y
		sec
		sbc	#SPINY_LAKITU_OFFSET_Y
		sta	pos_y_lo_actor, x
	
		lda	eng_rand_seed, x
		and	#MOD_4
		tay
		ldx	#3-1
		: ; for (x = 3-1; x >= 0; x--) {
			lda	actor_spiny_data, y
			sta	zp_byte_01, x
	
			iny
			iny
			iny
			iny
			dex
			bpl	:-
		; }
	
		ldx	actor_index
		jsr	actor_proc_lakitu_spiny
		ldy	veloc_x_player
		cpy	#SPINY_PLAYER_VELOC_X_CUTOFF
		bcs	:++ ; if (player.veloc_x < SPINY_PLAYER_VELOC_X_CUTOFF) {
			tay
	
			lda	eng_rand_seed+1, x
			and	#MOD_4
			beq	:+ ; if (eng_rand_seed[1] % 4) {
				tya
				eor	#<-1
				tay
				iny
			: ; }
		
			tya
		: ; }
	
		jsr	actor_init_col_small
		ldy	#DIR_LEFT
		sta	veloc_x_actor, x
		cmp	#0
		bmi	:+ ; if (this.veloc_x > 0) {
			dey
		: ; }
		sty	motion_dir_actor, x
		lda	#SPINY_VELOC_Y
		sta	veloc_y_actor, x
		lda	#actor_modes::active
		sta	actor_mode, x
		lda	#actor_states::state_5
		sta	state_actor, x
	; }

actor_spiny_rts:
	rts

; -----------------------------------------------------------
firebar_veloc_ang:
	.byte	40, 56, 40, 56, 40

actor_firebar_victory_right_x_hi:
	.byte	0, 0, 16, 16, 0
; ------------------------------
	.export actor_init_firebar_long, actor_init_firebar_short
actor_init_firebar_long:
	jsr	actor_init_dup
; ------------------------------
actor_init_firebar_short:
	lda	#0
	sta	veloc_x_actor, x
	lda	actor_id, x
	sec
	sbc	#actor::firebar_start
	tay
	lda	firebar_veloc_ang, y
	sta	veloc_ang_firebar, x
	lda	actor_firebar_victory_right_x_hi, y
	sta	pos_x_hi_victory_right, x
	lda	pos_y_lo_actor, x
	clc
	adc	#FIREBAR_OFFSET_Y
	sta	pos_y_lo_actor, x
	lda	pos_x_lo_actor, x
	clc
	adc	#FIREBAR_OFFSET_X
	sta	pos_x_lo_actor, x
	lda	pos_x_hi_actor, x
	adc	#0
	sta	pos_x_hi_actor, x
	jmp	actor_init_col_large_b
; -----------------------------------------------------------
actor_cheep_fly_count		= zp_byte_00
actor_cheep_fly_offset_rand	= zp_byte_00
actor_cheep_fly_veloc_x_rand	= zp_byte_01

actor_cheep_fly_player_offset:
	.byte	<-128, 48, 64, <-128
	.byte	48, 80, 80, 112
	.byte	32, 64, <-128, <-96
	.byte	112, 64, <-112, 104

actor_cheep_fly_veloc_x:
	.byte	14, 5, 6, 14
	.byte	28, 32, 16, 12
	.byte	30, 34, 24, 20

actor_cheep_fly_timers:
	.byte	16, 96, 32, 72
; ------------------------------
	.export actor_init_cheep_fly
actor_init_cheep_fly:
	lda	eng_timer_swarm
	bne	actor_spiny_rts ; if (eng_timer_swarm == 0) {
		jsr	actor_init_col_small
	
		lda	eng_rand_seed+1, x
		and	#MOD_4
		tay
		lda	actor_cheep_fly_timers, y
		sta	eng_timer_swarm
	
		ldy	#CHEEP_FLY_COUNT_BASE
		lda	eng_hard_mode_b
		beq	:+ ; if (eng_hard_mode_b) {
			iny
		: ; }
		sty	actor_cheep_fly_count
		cpx	actor_cheep_fly_count
		bcs	actor_spiny_rts ; if (this.idx < 3 || (eng_hard_mode_b && this.idx < 4)) {
			lda	eng_rand_seed, x
			and	#MOD_4
			sta	actor_cheep_fly_offset_rand
			sta	actor_cheep_fly_veloc_x_rand
			lda	#CHEEP_FLY_VELOC_Y
			sta	veloc_y_actor, x
		
			lda	#0
			ldy	veloc_x_player
			beq	:+ ; if (player.veloc_x) {
				lda	#4

				cpy	#CHEEP_FLY_PLAYER_VELOC_OFFSET_X
				bcc	:+ ; if (player.veloc_x >= player_veloc_offset) {
					asl	a
				; }
			: ; }
			pha
		
			clc
			adc	actor_cheep_fly_offset_rand
			sta	actor_cheep_fly_offset_rand
			lda	eng_rand_seed+1, x
			and	#MOD_4
			beq	:+ ; if (eng_rand_seed[1] % 4) {
				lda	eng_rand_seed+2, x
				and	#MOD_16
				sta	actor_cheep_fly_offset_rand
			: ; }
		
			pla
			clc
			adc	actor_cheep_fly_veloc_x_rand
			tay
			lda	actor_cheep_fly_veloc_x, y
			sta	veloc_x_actor, x
			lda	#DIR_RIGHT
			sta	motion_dir_actor, x
		
			lda	veloc_x_player
			bne	:+
			ldy	actor_cheep_fly_offset_rand
			tya
			and	#MOD_4_2_UP
			beq	:+ ; if ((actor_cheep_fly_offset_rand % 4) >= 2) {
				lda	veloc_x_actor, x
				neg_m
				sta	veloc_x_actor, x
				inc	motion_dir_actor, x
			: ; }
			tya
			and	#MOD_4_2_UP
			beq	:+ ; if ((actor_cheep_fly_offset_rand % 4) >= 2) {
				lda	pos_x_lo_player
				clc
				adc	actor_cheep_fly_player_offset, y
				sta	pos_x_lo_actor, x
				lda	pos_x_hi_player
				adc	#0

				jmp	:++
			: ; } else {
				lda	pos_x_lo_player
				sec
				sbc	actor_cheep_fly_player_offset, y
				sta	pos_x_lo_actor, x
				lda	pos_x_hi_player
				sbc	#0
			: ; }
			sta	pos_x_hi_actor, x
		
			lda	#actor_modes::active
			sta	actor_mode, x
			sta	pos_y_hi_actor, x
			lda	#ENG_OAM_CLEAR_SCANLINE
			sta	pos_y_lo_actor, x
			rts
		; } else rts;
	; } else rts;

