.include	"math.i"
.include	"mem.i"
.include	"misc.i"
.include	"sound.i"

; -----------------------------------------------------------
BULLET_CHEEP_SLOTS	= 3
BULLET_CHEEP_RED_CHANCE	= $AA
BULLET_CHEEP_TIMER_INIT	= 32

GROUP_MEMBER_OFFSET_X	= 24
GROUP_POS_Y_LOW		= 176
GROUP_POS_Y_HIGH	= 112
; -----------------------------------------------------------
	.export actor_init_bullet_cheep_data_a
actor_init_bullet_cheep_data_a:
	.byte	1<<0, 1<<1, 1<<2, 1<<3
	.byte	1<<4, 1<<5, 1<<6, 1<<7

bullet_cheep_pos_x_lo:
	.byte	64, 48, 144, 80
	.byte	32, 96, 160, 112


bullet_cheep_actor_ids:
	.byte	actor::cheep_grey
	.byte	actor::cheep_red
; ------------------------------
	.export actor_init_bullet_cheep, actor_group_do
actor_init_bullet_cheep:
	lda	timer_swarm
	bne	actor_init_bullet_cheep_rts
	lda	course_type
	bne	:++++++
	cpx	#BULLET_CHEEP_SLOTS
	bcs	actor_init_bullet_cheep_rts ; if (timer_swarm == 0 && course_type == water && actor_index < BULLET_CHEEP_SLOTS) {
		ldy	#0
		lda	srand, x
		cmp	#BULLET_CHEEP_RED_CHANCE
		bcc	:+ ; if (*srand >= BULLET_CHEEP_RED_CHANCE) {
			iny
		: ; }
		lda	course_no
		cmp	#course::no_02
		beq	:+ ; if (course_no != no_02) {
			iny
		: ; }
		tya
		and	#MOD_2
		tay
		lda	bullet_cheep_actor_ids, y
	
	actor_init_bullet_cheep_do:
		sta	actor_id, x

		lda	actor_bullet_cheep_mask
		cmp	#%11111111
		bne	:+ ; if (actor_bullet_cheep_mask == max) {
			lda	#0
			sta	actor_bullet_cheep_mask
		: ; }
		lda	srand, x
		and	#MOD_8
		: ; for (i = rand_seed % 8; (actor_init_bullet_cheep_data_a[i] & actor_bullet_cheep_mask); i = ((i + 1) % 8)) {
			tay
			lda	actor_init_bullet_cheep_data_a, y
			bit	actor_bullet_cheep_mask
			beq	:+
	
			iny
			tya
			and	#MOD_8
	
			jmp	:-
		: ; }
		ora	actor_bullet_cheep_mask
		sta	actor_bullet_cheep_mask

		lda	bullet_cheep_pos_x_lo, y
		jsr	actor_init_right_side
		sta	pos_y_actor, x
		lda	#BULLET_CHEEP_TIMER_INIT
		sta	timer_swarm
		jmp	actor_init_do
	: ; } else if (timer_swarm == 0 && course.type != water) {
		ldy	#<-1
		: ; for (y = 0; y < (ENG_ACTOR_MAX-1) && (actor[y].mode == free || actor[y].id != bullet_swarm); y++) {
			iny
			cpy	#ENG_ACTOR_MAX-1
			bcs	:+
		
			lda	actor_mode, y
			beq	:-
			lda	actor_id, y
			cmp	#actor::bullet_swarm
			bne	:-
		; }
		; if (found_bullet_swarm) {
		actor_init_bullet_cheep_rts:
			rts
		: ; } else {
			lda	apu_sfx_pulse_2_req
			ora	#sfx_pulse_2::blast
			sta	apu_sfx_pulse_2_req
		
			lda	#actor::bullet_swarm
			bne	actor_init_bullet_cheep_do ; if (this.is_group) {
			actor_group_pos_y_lo	= zp_byte_00
			actor_group_actor_id	= zp_byte_01
			actor_group_pos_x_hi	= zp_byte_02
			actor_group_pos_x_lo	= zp_byte_03

			actor_group_do:
				ldy	#actor::koopa_green
				sec
				sbc	#actor::group_start
				pha

				cmp	#actor::koopa_trio_lo-actor::group_start
				bcs	:++ ; if (this.id < koopa_trio_lo) {
					pha
				
					ldy	#ACTOR_SWAPPABLE_EASY
					lda	game_hard_mode
					beq	:+
					.if	.defined(ANN)
					lda	ENG_HARDMODE_VAR
					bne	:+
					.endif ; if (game_hard_mode && (!ANN || !hard_mode_b)) {
						ldy	#ACTOR_SWAPPABLE_HARD
					: ; }

					pla
				: ; }
				sty	actor_group_actor_id

				ldy	#GROUP_POS_Y_LOW
				and	#MOD_4_2_UP
				beq	:+ ; if ((this.group_id % 4) >= 2) {
					ldy	#GROUP_POS_Y_HIGH
				: ; }
				sty	actor_group_pos_y_lo

				lda	pos_x_hi_screen_right
				sta	actor_group_pos_x_hi
				lda	pos_x_lo_screen_right
				sta	actor_group_pos_x_lo

				ldy	#2

				pla
				lsr	a
				bcc	:+ ; if (!(this.group_id % 2)) {
					iny
				: ; }
				sty	actor_group_count
				: ; for (actor_group_count; actor_group_count > 0 && x < (ENG_ACTOR_MAX-1); actor_group_count--) {
					ldx	#<-1
					: ; for (x = 0; x < (ENG_ACTOR_MAX-1) && actor[x].mode != free; x++) {
						inx
						cpx	#ENG_ACTOR_MAX-1
						bcs	:+
				
						lda	actor_mode, x
						bne	:-
					; }
			
					; if (x < (ENG_ACTOR_MAX-1) && actor[x].mode == free) {	
						lda	actor_group_actor_id
						sta	actor_id, x

						lda	actor_group_pos_x_hi
						sta	pos_x_hi_actor, x
						lda	actor_group_pos_x_lo
						sta	pos_x_lo_actor, x
						clc
						adc	#GROUP_MEMBER_OFFSET_X
						sta	actor_group_pos_x_lo
						lda	actor_group_pos_x_hi
						adc	#0
						sta	actor_group_pos_x_hi

						lda	actor_group_pos_y_lo
						sta	pos_y_lo_actor, x
						lda	#actor_modes::active
						sta	pos_y_hi_actor, x
						sta	actor_mode, x
						jsr	actor_init_do
				
						dec	actor_group_count
						bne	:--
					; } else break;
				: ; }
			
				jmp	actor_special_do
			; } else actor_init_bullet_cheep_do();
		; }
	; } else rts;
