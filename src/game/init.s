.include	"system/ppu.i"

.include	"mem.i"
.include	"chr.i"
.include	"course_flags.i"
.include	"sound.i"
.include	"tunables.i"
.include	"misc.i"
.include	"math.i"

	.if	.defined(SMB2)
		.res	2, $FF
	.endif

game_init_data_0:
	.byte	$04, $30, $48, $60
	.byte	$78, $90, $A8, $C0
	.byte	$D8, $E8, $24, $F8
	.byte	$FC, $28, $2C
game_init_data_0_end:

	.if	.defined(SMB)|.defined(VS_SMB)
game_init_oam:
	.byte	(PPU_BG_ROW_3/PPU_CHR_PER_LINE)*PPU_CHR_HEIGHT_PX
	.byte	chr_obj::filler
	.byte	obj_attr::priority_low|obj_attr::color3
	.byte	PPU_BG_COL_11*PPU_CHR_WIDTH_PX
game_init_oam_end:
	.endif
; -----------------------------------------------------------
	.export game_init_0

	.if	.defined(SMB)|.defined(VS_SMB)
		.if	.defined(SMB)
	game_init_0:
		.elseif	.defined(VS_SMB)
		.export	game_init_ram
	game_init_ram:
		.endif

		ldy	#RAM_CLEAR_END_GAMEINIT
		jsr	game_init_clearram

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
	game_init_0:
		jsr	game_init_ram
		.endif

		lda	#TITLE_DEMO_TIMER
		sta	timer_demo
		jsr	course_descriptor_load
	.elseif	.defined(SMB2M)
	game_init_0:
	.endif

	.export	game_init_0_do
game_init_0_do:
	ldy	#RAM_CLEAR_END_GAMERESET
	jsr	game_init_clearram

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
		sta	srand
	.endif

	lda	pos_x_hi_alt_game
	ldy	game_start_type
	beq	:+ ; if (game.start_type != 0) {
		lda	pos_x_hi_init_game
	: ; }
	sta	pos_x_hi_screen_left
	sta	pos_x_hi_game
	sta	course_page_loaded

	jsr	game_disp_pos
	ldy	#>PPU_VRAM_BG1
	and	#1
	beq	:+ ; if (game_disp_pos() % 1) {
		ldy	#>PPU_VRAM_BG2
	: ; }
	sty	bg_addr
	ldy	#$80
	sty	bg_addr+1
	asl	a
	asl	a
	asl	a
	asl	a
	sta	disp_buff_col

	dec	scenery_length
	dec	scenery_length+1
	dec	scenery_length+2

	lda	#$0B
	sta	screen_bg_counter
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
	: ; if (hard_mode || course.goal >= hard_mode_course.hard_mode_goal) {
		inc	game_hard_mode_b
	: ; }

	lda	pos_x_hi_alt_game
	beq	:+ ; if (game.alt_pos_x.hi != 0) {
		lda	#COURSE_SCENERY_ENTER_POS_B0_A_VAL
		sta	course_pos_y_start
	: ; }

	lda	#music_base::none
	sta	apu_music_base_req
	lda	#1
	sta	nmi_disp_disable

	.if	.defined(SMB2M)
		jsr	player_phys_load
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		inc	proc_id_game
		rts
	.elseif	.defined(ANN)
		jmp	screen_title_bg_finish
	.endif
; -----------------------------------------------------------
	.export	game_init_1

	.if	.defined(SMB)|.defined(VS_SMB)
		.if	.defined(SMB)
	game_init_1:
		.elseif	.defined(VS_SMB)
		.export game_init_setup
	game_init_setup:
		jsr	vs_setbank_low
		.endif

		lda	#player_size::small
		sta	player_first_start
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
	game_init_1:
		jsr	game_init_setup
		.endif
	.elseif	.defined(SMB2M)
	game_init_1:
	.endif

	.export game_init_1_do
game_init_1_do:
	lda	#0
	sta	nmi_disp_disable
	
	.if	.defined(SMB2)
		sta	bg_scenery_wind_flag
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

	sta	game_time_up
	sta	screen_msg_disable
	sta	course_page_loaded

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

	jsr	game_init_area_music
	lda	#$38
	sta	sprite_strobe_amount+2
	lda	#$48
	sta	sprite_strobe_amount+1
	lda	#$58
	sta	sprite_strobe_amount

	ldx	#(game_init_data_0_end-game_init_data_0)-1
	: ; for (byte of game_init_data_0) {
		lda	game_init_data_0, x
		sta	obj_data_offset_player, x
		dex
		bpl	:-
	; }

	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	#(game_init_oam_end-game_init_oam)-1
		: ; for (byte of game_init_oam) {
			lda	game_init_oam, y
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*0), y
			dey
			bpl	:-
		; }

		jsr	sub_92AA_rts
	.endif

	jsr	sub_92AA
	inc	nmi_sprite_overlap

	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		inc	proc_id_game
		rts
	.elseif	.defined(ANN)
		jmp	screen_title_bg_finish
	.endif
; -----------------------------------------------------------
	.export game_init_clearram
game_init_clearram:
	ldx	#>(RAM_END-RAM_BASE)-1
	lda	#0
	sta	game_buffer
	: ; for (page of ram) {
		stx	game_buffer+1
		: ; for (byte of page) {
			cpx	#>STACK_BASE
			bne	:+
			cpy	#<cpu_stack_work_end
			bcs	:++
			.if	.defined(FDS)
			cpy	#<cpu_stack_work
			bcc	:++
			.endif
			: ; if (page != stack || (byte < work_mem_end && byte >= work_mem)) {
				sta	(game_buffer), y
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
	.byte	music_base::underwater
	.byte	music_base::overworld
	.byte	music_base::underground
	.byte	music_base::castle
area_music_data_clouds:
	.byte	music_base::clouds
area_music_data_pipe_intro:
	.byte	music_base::pipe_intro
; ----------------------------
	.export	game_init_area_music
game_init_area_music:
	lda	proc_id_system
	beq	:+++ ; if (proc_id_system != title) {
		lda	game_start_type
		cmp	#2
		beq	:+
		ldy	#area_music_data_pipe_intro-area_music_data
		lda	course_pos_y_start
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
		sta	apu_music_base_req
	: ; }

	rts
