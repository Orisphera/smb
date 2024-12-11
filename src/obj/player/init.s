.include	"system/ppu.i"

.include	"mem.i"
.include	"course_flags.i"
.include	"tunables.i"
.include	"joypad.i"

; -----------------------------------------------------------
player_start_x:
	.byte	$28, $18, $38, $28

player_alt_y:
	.byte	COURSE_SCENERY_ENTER_POS_F0_VAL
	.byte	COURSE_SCENERY_ENTER_POS_00_A_VAL

	.export player_start_y
	.export player_start_y_00_A, player_start_y_00_B, player_start_y_00_C
	.export	player_start_y_20, player_start_y_50
	.export player_start_y_B0_A, player_start_y_B0_B, player_start_y_B0_C
	.export player_start_y_F0
player_start_y:
player_start_y_00_A:	.byte	$00
player_start_y_20:	.byte	$20
player_start_y_B0_A:	.byte	$B0
player_start_y_50:	.byte	$50
player_start_y_00_B:	.byte	$00
player_start_y_00_C:	.byte	$00
player_start_y_B0_B:	.byte	$B0
player_start_y_B0_C:	.byte	$B0
player_start_y_F0:	.byte	$F0

player_bg_priority:
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_low|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	obj_attr::priority_low|obj_attr::color0

enter_timer_vals:
.if	.defined(CONS)
	.byte	$04, $03, $02
.elseif	.defined(VS)
	.byte	$04, $03, $03, $00, $00

course_timer_vals_a:
	.byte	$05, $04, $03
course_timer_vals_b:
	.byte	$03, $00, $00, $05
.endif
; ----------------------------
	.export player_proc_init
player_proc_init:
	lda	pos_x_hi_screen_left
	sta	pos_x_hi_player
	lda	#PLAYER_GRAVITY_INIT
	sta	accel_y_gravity
	lda	#DIR_RIGHT
	sta	disp_dir_player
	sta	pos_y_hi_player
	lda	#player_state::ground
	sta	state_player
	dec	collision_player

	ldy	#0
	sty	pos_x_hi_alt_game
	lda	course_type
	bne	:+ ; if (course.type == water) {
		iny
	: ; }
	sty	player_swimming

	ldx	course_pos_y_start
	ldy	game_start_type
	beq	:+
	cpy	#1
	beq	:+ ; if ((y = game.start_type) > 1) {
		ldx	player_alt_y-2, y
	: ; }

	lda	player_start_x, y
	sta	pos_x_lo_player
	lda	player_start_y, x
	sta	pos_y_lo_player
	lda	player_bg_priority, x
	sta	attr_player
	jsr	screen_color_player

	ldy	course_timer
	beq	:+++
	lda	player_first_start
	beq	:+++ ; if (course_timer != 0 && player_first_start) {
	.if	.defined(VS)
		lda	VS_RAM_ARENA0+$03
		beq	:+ ; if (vs_ram_arena0[3]) {
			lda	course_timer_vals_a, y
			sta	stats_time_end-STATS_TIME_LEN
			lda	course_timer_vals_b, y
			sta	stats_time_end-STATS_TIME_LEN+1
			jmp	:++
		; } else {
	.endif
			: lda	enter_timer_vals-1, y
			sta	stats_time_end-STATS_TIME_LEN
		.if	.defined(VS)
			lda	enter_timer_vals+2, y
			sta	stats_time_end-STATS_TIME_LEN+1
		; }
		.endif
		: lda	#1
		sta	stats_time_end-STATS_TIME_LEN+2
		.if	.defined(SMB)|.defined(SMBV2)
			lsr	a
			sta	stats_time_end-STATS_TIME_LEN+1
		.elseif	.defined(VS_SMB)
			lda	#0
		.endif
		sta	player_first_start
		sta	timer_player_star
	: ; }

	ldy	game_joypad_override
	beq	:+ ; if (joypad_override) {
		lda	#player_state::climb
		sta	state_player
		ldx	#0
		jsr	block_initpos
		lda	#240
		sta	pos_y_lo_block
		ldx	#5
		ldy	#0
		jsr	actor_init_vine
	: ; }

	ldy	course_type
	bne	:+ ; if (course.type == water) {
		jsr	bubble_init
	: ; }

	lda	#player_procs::enter
	sta	proc_id_player
	rts
