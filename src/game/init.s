.include	"system/ppu.i"

.include	"mem.i"
.include	"course_flags.i"
.include	"joypad.i"
.include	"sound.i"
.include	"tunables.i"
.include	"misc.i"
.include	"math.i"

.include	"unk.i"

	.if	.defined(SMB2)
		.res	2, $FF
	.endif

eng_init_data_0:
	.byte	$04, $30, $48, $60
	.byte	$78, $90, $A8, $C0
	.byte	$D8, $E8, $24, $F8
	.byte	$FC, $28, $2C
eng_init_data_0_end:

	.if	.defined(SMB)|.defined(VS_SMB)
eng_init_oam:
	.byte	$18, $FF, $23, $58
eng_init_oam_end:
	.endif
; -----------------------------------------------------------
	.export eng_init_0

	.if	.defined(SMB)|.defined(VS_SMB)
		.if	.defined(SMB)
	eng_init_0:
		.elseif	.defined(VS_SMB)
		.export	eng_init_ram
	eng_init_ram:
		.endif

		ldy	#$6F
		jsr	sub_clearram

		ldy	#(snd_ram_end-snd_ram)-1
		: ; for (byte of snd_ram) {
			sta	snd_ram, y

			dey
			bpl	:-
		; }

		.if	.defined(VS_SMB)
		rts
		.endif
; ----------------------------
		.if	.defined(VS_SMB)
	eng_init_0:
		jsr	eng_init_ram
		.endif

		lda	#TITLE_DEMO_TIMER
		sta	timer_demo
		jsr	course_descriptor_load
	.elseif	.defined(SMB2M)
	eng_init_0:
	.endif

	.export	eng_init_0_do
eng_init_0_do:
	ldy	#$4B
	jsr	sub_clearram

	ldx	#(timers_nmi_end-timers_nmi)-3
	lda	#0
	: ; for (timer of timers_nmi) {
		sta	timers_nmi, x

		dex
		bpl	:-
	; }

	.if	.defined(VS_SMB)
		sta	frame_count
		lda	nmi_timer_int_init+1
		sta	timer_nmi_tick
		sta	lib_rand
	.endif

	lda	pos_x_hi_alt_game
	ldy	game_start_type
	beq	:+ ; if (game.start_type != 0) {
		lda	pos_x_hi_init_game
	: ; }
	sta	pos_x_hi_screen_left
	sta	pos_x_hi_game
	sta	eng_page_cached

	jsr	game_proc_disp_pos
	ldy	#>PPU_VRAM_BG1
	and	#1
	beq	:+ ; if (game_proc_disp_pos() % 1) {
		ldy	#>PPU_VRAM_BG2
	: ; }
	sty	eng_bg_addr_hi
	ldy	#$80
	sty	eng_bg_addr_lo
	asl	a
	asl	a
	asl	a
	asl	a
	sta	disp_buff_col

	dec	scenery_length
	dec	scenery_length+1
	dec	scenery_length+2

	lda	#$0B
	sta	eng_columnsets
	jsr	course_load

	lda	ENG_HARDMODE_VAR
	bne	:+
	lda	course_no
	cmp	#ENG_HARDMODE_B_COURSE
	bcc	:++
	bne	:+
	lda	player_goals
	cmp	#ENG_HARDMODE_B_GOAL
	bcc	:++
	: ; if (hard_mode || eng_course.eng_goal >= hard_mode_course.hard_mode_goal) {
		inc	game_hard_mode_b
	: ; }

	lda	pos_x_hi_alt_game
	beq	:+ ; if (game.alt_pos_x.hi != 0) {
		lda	#COURSE_SCENERY_ENTER_POS_B0_A_VAL
		sta	course_enter_pos
	: ; }

	lda	#music_area::none
	sta	apu_music_area
	lda	#1
	sta	nmi_disp_disable

	.if	.defined(SMB2M)
		jsr	player_phys_load
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		inc	game_state
		rts
	.elseif	.defined(ANN)
		jmp	screen_title_bg_finish
	.endif
; -----------------------------------------------------------
	.export	eng_init_1

	.if	.defined(SMB)|.defined(VS_SMB)
		.if	.defined(SMB)
	eng_init_1:
		.elseif	.defined(VS_SMB)
		.export eng_init_setup
	eng_init_setup:
		jsr	vs_setbank_low
		.endif

		lda	#player_size::small
		sta	eng_req_timer
		sta	player_size

		.if	.defined(VS_SMB)
		lda	#1
		ldy	VS_RAM_ARENA0+$05
		bne	:+ ; if (vs_smb && !vs_ram_arena0[5]) {
		.endif
			lda	#2
		: ; }
		sta	player_lives
		sta	player_lives_b

		.if	.defined(VS_SMB)
		rts
		.endif
	; ----------------------------
		.if	.defined(VS_SMB)
	eng_init_1:
		jsr	eng_init_setup
		.endif
	.elseif	.defined(SMB2M)
	eng_init_1:
	.endif

	.export eng_init_1_do
eng_init_1_do:
	lda	#0
	sta	nmi_disp_disable
	
	.if	.defined(SMB2)
		sta	byte_7F9
	.endif

	.if	.defined(SMB2M)
		sta	game_level_end_apu_on
	.endif

	tay
	: ; for (byte of nmi_list) {
		sta	nmi_list, y

		iny
		bne	:-
	; }

	sta	eng_done_timer
	sta	eng_disable_b
	sta	eng_page_cached

	lda	#$FF
	sta	actor_plat_align
	lda	pos_x_hi_screen_left
	.if	.defined(SMB)|.defined(VS_SMB)
		lsr	ppu_ctlr0_b
	.endif
	and	#ppu_ctlr0::bg_parity
	.if	.defined(SMB)|.defined(VS_SMB)
		ror	a
		rol	ppu_ctlr0_b
	.elseif	.defined(SMB2M)
		sta	ppu_ctlr0_bg
	.endif

	jsr	sub_load_area_music
	lda	#$38
	sta	sprite_strobe_amount+2
	lda	#$48
	sta	sprite_strobe_amount+1
	lda	#$58
	sta	sprite_strobe_amount

	ldx	#(eng_init_data_0_end-eng_init_data_0)-1
	: ; for (byte of eng_init_data_0) {
		lda	eng_init_data_0, x
		sta	obj_data_offset_player, x
		dex
		bpl	:-
	; }

	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	#(eng_init_oam_end-eng_init_oam)-1
		: ; for (byte of eng_init_oam) {
			lda	eng_init_oam, y
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*0), y
			dey
			bpl	:-
		; }

		jsr	sub_92AA_rts
	.endif

	jsr	sub_92AA
	inc	nmi_sprite_overlap

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		inc	game_state
		rts
	.elseif	.defined(ANN)
		jmp	screen_title_bg_finish
	.endif
; -----------------------------------------------------------
.if	.defined(FDS_SMB)
	FDS_CUTOFF	= 4
.elseif	.defined(SMB2M)
	FDS_CUTOFF	= 9
.endif
	.export sub_clearram

sub_clearram:
	ldx	#7
	lda	#0
	sta	zp_addr_06
	: ; for (x = 7; x >= 0; x--) {
		stx	zp_addr_06+1
		: ; for (y; y >= 0; y--) {
			cpx	#1
			bne	:+
			cpy	#$60
			bcs	:++
			.if	.defined(FDS)
			cpy	#FDS_CUTOFF
			bcc	:++
			.endif
			: ; if (x != 1 || (y < 0x60 && (!FDS || y >= FDS_CUTOFF))) {
				sta	(zp_addr_06), y
			: ; }

			dey
			cpy	#<-1
			bne	:---
		; }

		dex
		bpl	:----
	; }

	rts
; -----------------------------------------------------------
area_music_data:
	.byte	music_area::underwater
	.byte	music_area::overworld
	.byte	music_area::underground
	.byte	music_area::castle
area_music_data_clouds:
	.byte	music_area::clouds
area_music_data_pipe_intro:
	.byte	music_area::pipe_intro
; ----------------------------
	.export	sub_load_area_music
sub_load_area_music:
	lda	game_mode
	beq	:+++ ; if (game.mode != title) {
		lda	game_start_type
		cmp	#2
		beq	:+
		ldy	#area_music_data_pipe_intro-area_music_data
		lda	course_enter_pos
		cmp	#COURSE_SCENERY_ENTER_POS_B0_B_VAL
		beq	:++
		cmp	#COURSE_SCENERY_ENTER_POS_B0_C_VAL
		beq	:++
		: ; if (game.start_type == 2 || course.enter_pos != 0xB0) {
			ldy	course_type
			lda	course_type_cloud
			beq	:+ ; if (course.type == cloud) {
				ldy	#area_music_data_clouds-area_music_data
			; }
		: ; }

		lda	area_music_data, y
		sta	apu_music_area
	: ; }

	rts
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
player_start_y_00_A:
	.byte	$00

player_start_y_20:
	.byte	$20

player_start_y_B0_A:
	.byte	$B0

player_start_y_50:
	.byte	$50

player_start_y_00_B:
	.byte	$00

player_start_y_00_C:
	.byte	$00

player_start_y_B0_B:
	.byte	$B0

player_start_y_B0_C:
	.byte	$B0

player_start_y_F0:
	.byte	$F0

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

eng_timer_vals_a:
	.byte	$05, $04, $03
eng_timer_vals_b:
	.byte	$03, $00, $00, $05
.endif
; ----------------------------
	.export game_proc_start
game_proc_start:
	lda	pos_x_hi_screen_left
	sta	pos_x_hi_player
	lda	#PLAYER_GRAVITY_INIT
	sta	player_gravity
	lda	#DIR_RIGHT
	sta	disp_dir_player
	sta	pos_y_hi_player
	lda	#player_state::ground
	sta	state_player
	dec	collision_player

	ldy	#0
	sty	pos_x_hi_alt_game
	lda	course_type
	bne	:+ ; if (courese_type == water) {
		iny
	: ; }
	sty	player_swimming

	ldx	course_enter_pos
	ldy	game_start_type
	beq	:+
	cpy	#1
	beq	:+ ; if ((y = game_start_type) > 1) {
		ldx	player_alt_y-2, y
	: ; }

	lda	player_start_x, y
	sta	pos_x_lo_player
	lda	player_start_y, x
	sta	pos_y_lo_player
	lda	player_bg_priority, x
	sta	attr_player
	jsr	screen_color_player

	ldy	course_timer_setting
	beq	:+++
	lda	eng_req_timer
	beq	:+++ ; if (course_timer_setting != 0 && eng_req_timer > 0) {
	.if	.defined(VS)
		lda	VS_RAM_ARENA0+$03
		beq	:+ ; if (vs_ram_arena0[3]) {
			lda	eng_timer_vals_a, y
			sta	stats_time_end-STATS_TIME_LEN
			lda	eng_timer_vals_b, y
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
		.if	.defined(SMB)|.defined(SMB2M)
			lsr	a
			sta	stats_time_end-STATS_TIME_LEN+1
		.elseif	.defined(VS_SMB)
			lda	#0
		.endif
		sta	eng_req_timer
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
		jsr	game_proc_vine_init
	: ; }

	ldy	course_type
	bne	:+ ; if (course_type == water) {
		jsr	game_proc_bubble_init
	: ; }

	lda	#game_proc::enter
	sta	game_proc_id
	rts
; -----------------------------------------------------------
lifedown_starts:
.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$56, $40
.elseif	.defined(SMB2)
	.byte	$66, $60
.endif

.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$65, $70
.elseif	.defined(SMB2)
	.byte	$88, $60
.endif

.if	.defined(SMBM)
	.byte	$66, $40
.elseif	.defined(VS_SMB)
	.byte	$68, $40
.elseif	.defined(SMB2)
	.byte	$66, $70
.endif

.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$66, $40
.elseif	.defined(SMB2)
	.byte	$77, $60
.endif

.if	.defined(SMB)
	.byte	$66, $40
.elseif	.defined(VS_SMB)|.defined(ANN)
	.byte	$66, $60
.elseif	.defined(SMB2)
	.byte	$D6, $00
.endif

.if	.defined(SMBM)|.defined(VS_SMB)
	.byte	$66, $60
.elseif	.defined(SMB2)
	.byte	$77, $80
.endif

.if	.defined(SMB)
	.byte	$65, $70
.elseif	.defined(VS_SMB)
	.byte	$68, $80
.elseif	.defined(ANN)
	.byte	$67, $80
.elseif	.defined(SMB2)
	.byte	$70, $B0
.endif

	.byte	$00, $00

.if	.defined(SMB2)
	.byte	$00, $00
.endif
; ----------------------------
	.export	game_proc_lifedown
game_proc_lifedown:
	inc	nmi_disp_disable
	lda	#0
	sta	nmi_sprite_overlap
	lda	#music_event::none
	sta	apu_music_event
	dec	player_lives
	bpl	:+ ; if (--player_lives < 0) {
		lda	#game_states::init_0
		sta	game_state
		lda	#game_modes::game_over
		sta	game_mode
		rts
	: ; } else {
		lda	course_no
		asl	a
		tax
		lda	player_goals
		and	#MOD_4_2_UP
		beq	:+ ; if ((player.goals % 4) >= 2) {
			inx
		: ; }

		ldy	lifedown_starts, x
		lda	player_goals
		lsr	a
		tya
		bcs	:+ ; if ((player.goals % 2)) {
			lsr	a
			lsr	a
			lsr	a
			lsr	a
		: ; }
		and	#%00001111
		cmp	pos_x_hi_screen_left
		beq	:+
		bcc	:+ ; if (lifedown_starts > pos_x_hi_screen_left) {
			lda	#0
		: ; }
		sta	pos_x_hi_alt_game

		.if	.defined(SMB)|.defined(VS_SMB)
			jsr	player_switch
		.endif

		jmp	eng_game_continue
	; }
