.include	"math.i"
.include	"mem.i"
.include	"joypad.i"
.include	"modes.i"
.include	"misc.i"
.include	"tunables.i"
.include	"charmap.i"

.if	.defined(OG_PAD)
.if	.defined(SMB2)
	.res	2, $FF
.endif
.endif

.if	.defined(SMBV1)
	.export sys_title
	.export	title_mode_tbl
	.export	title_mode_init_0
	.export	title_mode_scr
	.export	title_mode_init_1
	.export	title_mode_proc
sys_title:
.if	.defined(VS)
	lda	VS_RAM_ARENA0+$10
	beq	:+ ; if (VS && VS_RAM_ARENA0[0x10]) {
		lda	#game_modes::init
		sta	proc_id_game
		sta	nmi_sprite_overlap
		inc	proc_id_system
		lda	#1
		sta	nmi_disp_disable
		rts
	: ; } else {
.endif
		lda	proc_id_game
		jsr	tbljmp
	
	title_mode_tbl:
		.if	.defined(VS)
			.export	title_mode_vs_init
		title_mode_vs_init:
			.addr	vs_title_init
		.endif

	title_mode_init_0:
		.addr	game_init_0
	title_mode_scr:
		.addr	bg_proc
	title_mode_init_1:
		.addr	game_init_1
	title_mode_proc:
		.addr	title_proc
		.if	.defined(VS)
			.export	title_mode_init_player_select
			.export	title_mode_init_ppu
			.export	title_mode_super_players
			.export	title_mode_tick
		title_mode_init_player_select:
			.addr	vs_player_select_init_0
		title_mode_init_ppu:
			.addr	vs_title_ppu_init
		title_mode_super_players:
			.addr	vs_title_super_players
		title_mode_tick:
			.addr	vs_title_tick
		.endif
	; }
; ----------------------------
.if	.defined(VS)
vs_title_init:
	lda	#1
	sta	nmi_disp_disable
	lda	#0
	sta	nmi_sprite_overlap
	inc	proc_id_game
	rts
.endif
; -----------------------------------------------------------
title_course_no:
	.byte	(:+++)-(:+)
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_3+PPU_BG_COL_19
	.byte	(:++)-(:+)
	: .byte	"0"
	: .byte	NMI_LIST_END
title_course_no_end:
.endif
; ----------------------------
.if	.defined(SMBV1)
TITLE_PLAYER_ID	= player_count
.elseif	.defined(SMBV2)
TITLE_PLAYER_ID = player_id
.endif
TITLE_PRESSED_B	= 1

	.export title_proc
	.export	title_recycle
	.export	title_exit
title_proc:
	.if	.defined(SMBV1)
	ldy	#0
	.endif

	.if	.defined(CONS)
	lda	joypad_p1
	.if	.defined(SMBV1)
	ora	joypad_p2
	cmp	#joypad_button::start
	beq	:+
	cmp	#(joypad_button::face_a|joypad_button::start)
	bne	:++
	: jmp	title_exit
	.elseif	.defined(SMBV2)
	and	#joypad_button::start
	beq	:++ ; if (joypad[0].start == PRESSED) {
		lda	#0
		.if	.defined(SMB2)
		sta	game_courses_cleared
		.endif
		sta	disk_loader_proc
		sta	ENG_HARDMODE_VAR

		lda	save
		cmp	#HARD_MODE_GAME_CLEARS
		bcc	:+
		lda	joypad_p1
		and	#joypad_button::face_a
		beq	:+ ; if (save >= 8 && joypad[0].a == PRESSED) {
			inc	ENG_HARDMODE_VAR
		: ; }
		jmp	title_exit
	; }
	.endif

	: ; if (CONS && (!joypad[0].start || (!SMBV2 && joypad[0].face_a))) {
		.if	.defined(SMBV2)
		lda	joypad_p1
		.endif
			cmp	#joypad_button::select
			beq	:++ ; if (joypad[0].select == PRESSED) {
				ldx	timer_demo
				.if	.defined(SMBV1)
				bne	:+
				.elseif	.defined(SMBV2)
				bne	:+++++ ; if (!timer_demo) {
				.endif
					sta	timer_select
					jsr	title_demo

					bcs	title_recycle
					.if	.defined(SMBV1)
					jmp	:++++++
					.elseif	.defined(SMBV2)
					bcc	:++++++
					.endif
				: ; }

				.if	.defined(SMBV1)
					ldx	title_course_sel_on
					beq	:++++
					cmp	#joypad_button::face_b
					bne	:++++
					iny
				.endif
			: ; }

			lda	timer_demo
			beq	title_recycle ; if (timer_demo) {
				lda	#TITLE_DEMO_TIMER
				sta	timer_demo

				.if	.defined(SMBV2)
					lda	frame_count
					and	#<~1
					sta	frame_count
				.endif

				lda	timer_select
				bne	:+++ ; if (!timer_select) {
					lda	#TITLE_SELECT_TIMER
					sta	timer_select

					.if	.defined(SMBV1)
						cpy	#TITLE_PRESSED_B
						beq	:+ ; if (joypad[0].b != PRESSED) {
					.endif
						lda	TITLE_PLAYER_ID
						eor	#1
						sta	TITLE_PLAYER_ID
						jsr	title_cursor_draw
					.if	.defined(SMBV1)
							jmp	:+++
						: ; } else {
							ldx	title_course_sel_no
							inx
							txa
							and	#MOD_8
							sta	title_course_sel_no
							jsr	title_course_set
							: ; for (x = (title_course_sel_no+1); x < sizeof (title_course_no); x++) {
								lda	title_course_no, x
								sta	ppu_displist_0_data-1, x

								inx
								cpx	#(title_course_no_end-title_course_no)
								bmi	:-
							; }

							ldy	course_no
							iny
							sty	ppu_displist_0_tile
						; }
					.elseif	.defined(SMBV2)
					:
					:
					.endif
				: ; }

				lda	#joypad_button::none
				sta	joypad_p1

			: ; }
	; }
	.elseif	.defined(VS)
		ldx	timer_demo
		bne	:+ ; if (timer_demo == 0) {
			jsr	title_demo
			bcs	title_next
			jmp	:++
		: ; } else {
			lda	#joypad_button::none
			sta	joypad_p1
			sta	joypad_p2
		: ; }
	.endif

	; if ((VS || (!joypad[0].start || (!SMBV2 && joypad[0].face_a))) && timer_demo != 0) {
		jsr	game_proc
		lda	proc_id_player
		cmp	#player_procs::lifedown
		bne	title_continue ; if (player.proc_id == lifedown) {
		.if	.defined(VS)
		title_next:
			inc	proc_id_game
			lda	#0
			sta	nmi_sprite_overlap
			inc	nmi_disp_disable
			rts
		.endif

		title_recycle:
			lda	#0
			sta	proc_id_system
			sta	proc_id_game
			sta	nmi_sprite_overlap
			inc	nmi_disp_disable
		; }
		rts
	; }

	title_exit:
		.if	.defined(CONS)
		.if	.defined(SMBV1)
			ldy	timer_demo
		.elseif	.defined(SMBV2)
			lda	timer_demo
		.endif
		beq	title_recycle ; if (timer_demo) {
		.endif
			.if	.defined(SMBV1)
				asl	a
				bcc	:+ ; if (joypad.a) {
					lda	course_no_continued
					jsr	title_course_set
				: ; }

				jsr	course_descriptor_load
				inc	scenery_hidden_one_up_req
				inc	scenery_hidden_one_up_req_b
				inc	player_first_start
				inc	proc_id_system
				lda	title_course_sel_on
				sta	ENG_HARDMODE_VAR

				.if	.defined(SMB)
				lda	#game_modes::init_0
				.elseif	.defined(VS_SMB)
				lda	#game_modes::vs_init
				.endif
				sta	proc_id_game

				sta	timer_demo
			.elseif	.defined(SMBV2)
				inc	proc_id_game

				jsr	title_patch_player

				lda	#course::no_01
				sta	course_no
				lda	#0
				sta	player_goals
				lda	#0
				sta	course_sub
			.endif

			ldx	#(stats_player_end-stats_player)-1
			lda	#0
			: ; for (byte of player.stats) {
				sta	stats_player, x

				dex
				bpl	:-
			; }

		title_continue:
			rts

		.if	.defined(CONS)
		; }
		.endif
	; }
; ----------------------------
.if	.defined(SMBV1)
title_course_set:
	sta	course_no
	sta	course_no_b
	ldx	#0
	stx	course_sub
	stx	course_sub_b
	rts
.endif
