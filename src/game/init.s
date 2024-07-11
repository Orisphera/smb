.include	"../../inc/system/ppu.i"

.include	"../../inc/engine/course_flags.i"
.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/sound.i"
.include	"../../inc/engine/tunables.i"

.include	"../../inc/engine/unk.i"

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
		sta	eng_timer_demo
		jsr	course_descriptor_load
	.elseif	.defined(SMB2M)
	eng_init_0:
	.endif

	.export	eng_init_0_do
eng_init_0_do:
	ldy	#$4B
	jsr	sub_clearram

	ldx	#(eng_timers_nmi_end-eng_timers_nmi)-1
	lda	#0
	: ; for (timer of eng_timers_nmi) {
		sta	eng_timers_nmi, x

		dex
		bpl	:-
	; }

	.if	.defined(VS_SMB)
		sta	frame_count
		lda	nmi_timer_int_init+1
		sta	eng_timer_int
		sta	eng_rand_seed
	.endif

	lda	eng_startpage_alt
	ldy	eng_start_alt
	beq	:+ ; if (!eng_start_alt) {
		lda	eng_startpage_init
	: ; }
	sta	eng_screen_left_hi
	sta	eng_page_current
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

	dec	eng_lenareaobj_0
	dec	eng_lenareaobj_1
	dec	eng_lenareaobj_2

	lda	#$0B
	sta	eng_columnsets
	jsr	course_load

	lda	ENG_HARDMODE_VAR
	bne	:+
	lda	course_no
	cmp	#ENG_HARDMODE_B_COURSE
	bcc	:++
	bne	:+
	lda	eng_goals
	cmp	#ENG_HARDMODE_B_GOAL
	bcc	:++
	: ; if (hard_mode || eng_course.eng_goal >= hard_mode_course.hard_mode_goal) {
		inc	eng_hard_mode_b
	: ; }

	lda	eng_startpage_alt
	beq	:+ ; if (eng_startpage_alt) {
		lda	#COURSE_DATA_ENTER_POS_B0_A_VAL
		sta	course_enter_pos
	: ; }

	lda	#music_area::none
	sta	apu_music_area
	lda	#1
	sta	eng_disp_disable

	.if	.defined(SMB2M)
		jsr	sub_C241
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		inc	eng_gameplay_mode
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
		sta	eng_player_size

		.if	.defined(VS_SMB)
		lda	#1
		ldy	VS_RAM_ARENA0+$05
		bne	:+ ; if (vs_smb && !vs_ram_arena0[5]) {
		.endif
			lda	#2
		: ; }
		sta	eng_lives
		sta	eng_lives_b

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
	sta	eng_disp_disable
	
	.if	.defined(SMB2)
		sta	byte_7F9
	.endif

	.if	.defined(SMB2M)
		sta	byte_7F6
	.endif

	tay
	: ; for (byte of ppu_nmi_buffer) {
		sta	ppu_nmi_buffer, y

		iny
		bne	:-
	; }

	sta	eng_done_timer
	sta	eng_disable_b
	sta	eng_page_cached

	lda	#$FF
	sta	ppu_nmi_buffer+$A0
	lda	eng_screen_left_hi
	.if	.defined(SMB)|.defined(VS_SMB)
		lsr	ppu_ctlr0_b
		and	#$01
		ror	a
		rol	ppu_ctlr0_b
	.elseif	.defined(SMB2M)
		and	#$01
		sta	eng_player_count
	.endif

	jsr	sub_load_area_music
	lda	#$38
	sta	tbl_6E1+2
	lda	#$48
	sta	tbl_6E1+1
	lda	#$58
	sta	tbl_6E1

	ldx	#(eng_init_data_0_end-eng_init_data_0)-1
	: ; for (byte of eng_init_data_0) {
		lda	eng_init_data_0, x
		sta	tbl_6E4, x
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
	inc	eng_sprite_overlap

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		inc	eng_gameplay_mode
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
	lda	eng_game_mode
	beq	:+++ ; if (eng_game_mode != title) {
		lda	eng_start_alt
		cmp	#2
		beq	:+
		ldy	#area_music_data_pipe_intro-area_music_data
		lda	course_enter_pos
		cmp	#COURSE_DATA_ENTER_POS_B0_B_VAL
		beq	:++
		cmp	#COURSE_DATA_ENTER_POS_B0_C_VAL
		beq	:++
		: ; if (eng_start_alt == 2 || course_enter_pos != 0xB0) {
			ldy	course_type
			lda	course_type_cloud
			beq	:+ ; if (course_type_cloud) {
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
	.byte	COURSE_DATA_ENTER_POS_F0_VAL
	.byte	COURSE_DATA_ENTER_POS_00_A_VAL

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
	.byte	$00, $20, $00, $00, $00, $00, $00, $00, $20

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

.if	.defined(SMB)|.defined(VS_SMB)
	ENG_TIMER_DISP	= eng_timer_disp
.elseif	.defined(SMB2M)
	ENG_TIMER_DISP	= eng_timer_disp_b
.endif
; ----------------------------
	.export game_proc_start
game_proc_start:
	lda	eng_screen_left_hi
	sta	eng_player_pos_x_hi
	lda	#$28
	sta	eng_player_gravity
	lda	#PLAYER_DIR_RIGHT
	sta	eng_player_dir
	sta	eng_player_pos_y_hi
	lda	#player_state::ground
	sta	state_player
	dec	eng_player_collision

	ldy	#0
	sty	eng_startpage_alt
	lda	course_type
	bne	:+ ; if (courese_type == water) {
		iny
	: ; }
	sty	eng_player_swimming

	ldx	course_enter_pos
	ldy	eng_start_alt
	beq	:+
	cpy	#1
	beq	:+ ; if ((y = eng_start_alt) > 1) {
		ldx	player_alt_y-2, y
	: ; }

	lda	player_start_x, y
	sta	eng_player_pos_x_lo
	lda	player_start_y, x
	sta	eng_player_pos_y_lo
	lda	player_bg_priority, x
	sta	ppu_nmi_buffer+$C4
	jsr	screen_color_player

	ldy	course_timer_setting
	beq	:+++
	lda	eng_req_timer
	beq	:+++ ; if (course_timer_setting != 0 && eng_req_timer > 0) {
	.if	.defined(VS)
		lda	VS_RAM_ARENA0+$03
		beq	:+ ; if (vs_ram_arena0[3]) {
			lda	eng_timer_vals_a, y
			sta	ENG_TIMER_DISP
			lda	eng_timer_vals_b, y
			sta	ENG_TIMER_DISP+1
			jmp	:++
		; } else {
	.endif
			: lda	enter_timer_vals-1, y
			sta	ENG_TIMER_DISP
		.if	.defined(VS)
			lda	enter_timer_vals+2, y
			sta	ENG_TIMER_DISP+1
		; }
		.endif
		: lda	#1
		sta	ENG_TIMER_DISP+2
		.if	.defined(SMB)|.defined(SMB2M)
			lsr	a
			sta	ENG_TIMER_DISP+1
		.elseif	.defined(VS_SMB)
			lda	#0
		.endif
		sta	eng_req_timer
		sta	eng_timer_star
	: ; }

	ldy	eng_joypad_override
	beq	:+ ; if (eng_joypad_override) {
		lda	#player_state::climb
		sta	state_player
		ldx	#0
		jsr	obj_spec_block_initpos
		lda	#$F0
		sta	eng_spec_pos_y_lo
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
	inc	eng_disp_disable
	lda	#0
	sta	eng_sprite_overlap
	lda	#music_event::none
	sta	apu_music_event
	dec	eng_lives
	bpl	:+ ; if (--eng_lives < 0) {
		lda	#gameplay_mode::init_0
		sta	eng_gameplay_mode
		lda	#game_mode::game_over
		sta	eng_game_mode
		rts
	: ; } else {
		lda	course_no
		asl	a
		tax
		lda	eng_goals
		and	#$02
		beq	:+ ; if (eng_goals & 0x02) {
			inx
		: ; }

		ldy	lifedown_starts, x
		lda	eng_goals
		lsr	a
		tya
		bcs	:+ ; if (eng_goals % 1) {
			lsr	a
			lsr	a
			lsr	a
			lsr	a
		: ; }
		and	#$0F
		cmp	eng_screen_left_hi
		beq	:+
		bcc	:+ ; if (lifedown_starts > eng_screen_left_hi) {
			lda	#0
		: ; }
		sta	eng_startpage_alt

		.if	.defined(SMB)|.defined(VS_SMB)
			jsr	eng_player_switch
		.endif

		jmp	eng_game_continue
	; }

