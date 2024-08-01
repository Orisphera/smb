.include	"system/cpu.i"
.include	"system/ppu.i"
.include	"system/palettes.i"

.include	"engine/mem.i"
.include	"engine/charmap.i"
.include	"engine/joypad.i"
.include	"engine/sound.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

	.export eng_victory
eng_victory:
	jsr	victory_enter

	lda	eng_gameplay_mode
	beq	:++
	.if	.defined(SMB2M)
		ldx	course_no
		cpx	#course::no_08
		bne	:+
		cmp	#gameplay_mode::mode_5
		beq	eng_victory-1
		cmp	#gameplay_mode::mode_D
		beq	eng_victory-1
		; NOTE: This assumes this module follows an rts
	.endif
	: ; if (eng_gameplay_mode != bridge && (course_no != course_08 || eng_gameplay_mode.not_in(5, $D))) {
		ldx	#0
		stx	actor_index
		jsr	actor_proc
	: ; }

	jsr	lib_calc_player_pos
	jmp	render_player
; -----------------------------------------------------------
victory_enter:
	.if	.defined(SMB2M)
		lda	course_no
		cmp	#course::no_08
		beq	victory_course_8 ; if (!SMB2M || course_no != course_8) {
	.endif
		lda	eng_gameplay_mode
		jsr	eng_farjump
		.addr	actor_bowser_ending
		.addr	victory_init
		.addr	victory_proc
		.addr	victory_msg
		.if	.defined(SMB2M)|.defined(VS_SMB)
			.addr	sub_63AF
		.endif
		.addr	victory_end
		.if	.defined(VS_SMB)
			.addr	sub_84CF
			.addr	sub_8526
			.addr	sub_85E0
			.addr	sub_864C
			.addr	sub_865D
		.endif
	.if	.defined(SMB2M)
	victory_course_8: ; } else {
		lda	eng_gameplay_mode
		jsr	eng_farjump
		.addr	actor_bowser_ending
		.addr	victory_init
		.addr	victory_proc
		.addr	sub_C081
		.addr	sub_C088
		.addr	sub_C08E
		.addr	sub_C5FE
		.addr	sub_C642
		.addr	sub_63AF
		.addr	sub_C686
		.addr	sub_C6CA
		.addr	sub_C710
		.addr	sub_C727
		.addr	sub_C738
	; }
	.endif
; -----------------------------------------------------------
	.if	.defined(ANN)
	vram_addr_7A0	= $7A0
	vram_addr_CD0	= $CD0
	vram_addr_EE0	= $EE0

	data_62FA:
		.addr	data_D13E
		.addr	data_D19E
		.addr	data_D1FE
		.addr	data_D25E
		.addr	data_D14F
		.addr	data_D1AF
		.addr	data_D20F

	data_6308:
		.byte	>vram_addr_CD0
		.byte	>vram_addr_7A0
		.byte	>vram_addr_EE0
	data_630B:
		.byte	<vram_addr_CD0
		.byte	<vram_addr_7A0
		.byte	<vram_addr_EE0
	data_630E:
		.byte	$30, $50, $60
; ----------------------------
		.export sub_6311
	sub_6311:
		lda	eng_goals
		cmp	#ENG_HARDMODE_B_GOAL
		bne	:+++
		ldy	ENG_HARDMODE_VAR
		bne	:+++ ; if (eng_goals == ENG_HARDMODE_B_GOAL && !ENG_HARDMODE_VAR) {
			sty	zp_byte_06

			lda	course_no
			asl	a
			tax
			lda	data_62FA, x
			sta	zp_addr_00
			inx
			lda	data_62FA, x
			sta	zp_addr_00+1
			: ; for (i = 0; i < 3; i++) {
				ldx	zp_byte_06
				lda	data_6308, x
				sta	PPU_VRAM_AR
				lda	data_630B, x
				sta	PPU_VRAM_AR
				: ; for (j; j != data_630E[j]; j++) {
					lda	(zp_addr_00), y
					sta	PPU_VRAM_IO

					iny
					tya
					cmp	data_630E, x
					bne	:-
				; }

				inc	zp_byte_06
				lda	zp_byte_06
				cmp	#3
				bne	:--
			: ; }
		; }

		jmp	screen_title_bg_finish
	.endif
; -----------------------------------------------------------
	.if	.defined(SMB2)
	victory_init_mask:
		.byte	1<<0, 1<<1, 1<<2, 1<<3
		.byte	1<<4, 1<<5, 1<<6, 1<<7
	.elseif	.defined(ANN)
		.export data_C97D
	data_6354:
		.addr	data_6363
		.addr	data_6365
		.addr	data_6367
		.addr	data_6369

	data_635C:
		.byte	$04, $02, $00, $04
		.byte	$02, $00, $08

	data_6363:
		.byte	$30, $12

	data_6365:
		.byte	$30, $1A

	data_6367:
		.byte	$30, $16

	data_6369:
		.byte	$17, $2A

	data_C97D:
		.byte	$3F, $18, $04, $0F, $36

	data_6370:
		.byte	0, 0, 0
	data_6370_end:
	.endif
; ----------------------------
victory_init:
	.if	.defined(ANN)
		lda	ENG_HARDMODE_VAR
		bne	:++
		ldx	course_no
		cpx	#course::no_08
		beq	:++ ; if (!ENG_HARDMODE_VAR && course_no != course_08) {
			ldy	data_635C, x
			lda	data_6354, y
			sta	zp_addr_00
			iny
			lda	data_6354, y
			sta	zp_addr_00+1
			ldy	#0
			: ; for (byte of data_6370) {
				lda	(zp_addr_00), y
				sta	data_6370, y
				iny
				cpy	#(data_6370_end-data_6370)-1
				bne	:-
			; }

			lda	#nmi_addr::addr_C97D
			sta	nmi_addrs_ctl
		: ; }
	.endif

	ldx	pos_x_hi_screen_right
	inx
	stx	pos_x_hi_victory_right

	.if	.defined(SMB2)
		ldy	course_no
		lda	victory_init_mask, y
		ora	byte_7FA
		sta	byte_7FA
	.endif

	.if	.defined(SMB2M)
		lda	ENG_HARDMODE_VAR
		beq	:+
		lda	course_no
		cmp	#ENG_HARDMODE_B_COURSE
		bcc	:+ ; if (ENG_HARDMODE_VAR && course_no >= course_04) {
			lda	#course::no_08
			sta	course_no
		: ; }
	.endif

	lda	#music_event::victory_castle
	sta	apu_music_event

	.if	.defined(SMB2M)
		.export screen_title_bg, screen_title_bg_finish
	screen_title_bg_finish:
		inc	eng_gameplay_mode
		rts

	screen_title_bg:
		lda	eng_game_mode
		bne	screen_title_bg_finish

		lda	#5
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		jmp	screen_title_end
	.elseif	.defined(SMB2M)
		jmp	screen_color_init_4_end
	.endif
; -----------------------------------------------------------
victory_proc:
	ldy	#joypad_button::none
	sty	victory_proc_ctrl
	lda	pos_x_hi_player
	cmp	pos_x_hi_victory_right
	bne	:+
	lda	pos_x_lo_player
	cmp	#VICTORY_X_POS
	bcs	:++
	: ; if ((player.pos_x < victory.pos_x) {
		inc	victory_proc_ctrl
		iny
	: ; }
	tya
	jsr	game_proc_auto

	lda	pos_x_hi_screen_left
	cmp	pos_x_hi_victory_right
	beq	:+ ; if (screen_left.pos_x.hi != victory_right.pos_x.hi) {
		lda	eng_scroll_subpix
		clc
		adc	#VICTORY_SCROLL
		sta	eng_scroll_subpix
		lda	#1
		adc	#0
		tay
		jsr	game_proc_scroll_do
		jsr	game_proc_scroll_save
		inc	victory_proc_ctrl
	: ; }
	lda	victory_proc_ctrl
	beq	victory_next
	rts
; -----------------------------------------------------------
victory_msg:
	lda	victory_msg_timer_lo
	bne	victory_msg_dotick

	.if	.defined(CONS)
		lda	victory_msg_timer_hi
		beq	victory_msg_do
		cmp	#VICTORY_MSG_TIMER_UPPER
		bcs	victory_msg_dotick

		.if	.defined(SMB)
			ldy	course_no
			cpy	#course::no_08
			bne	:+ ; if (course_no == course_8) {
				cmp	#3
				bcc	victory_msg_dotick
				sbc	#1
				jmp	victory_msg_do
			: ; }
		.endif

		cmp	#VICTORY_MSG_TIMER_LOWER
		bcc	victory_msg_dotick

	victory_msg_do:
		tay
		.if	.defined(SMB)
			bne	:+ ; if () {
				lda	player_id
				beq	victory_msg_sound_check
				iny
				bne	victory_msg_sound_check
			: ; }

			iny
			lda	course_no
			cmp	#course::no_08
			beq	victory_msg_sound_check
			dey
		.elseif	.defined(SMB2M)
			beq	victory_msg_finish
		.endif

		cpy	#VICTORY_NOTICK_END
		bcs	victory_msg_notick
		cpy	#VICTORY_DOTICK_END
		bcs	victory_msg_dotick
	.elseif	.defined(VS)
		ldy	victory_msg_timer_hi
		lda	course_no
		cmp	#course::no_08
		beq	:++ ; if (!victory_msg_timer_lo && course_no != no_08) {
			cpy	#0
			bne	:+ ; if (victory_msg_timer_hi == 0) {
				inc	victory_msg_timer_hi
				lda	player_id
				beq	:+ ; if (player_id != 0) {
					iny
				; }
			: ; }

			cpy	#VICTORY_NOTICK_END
			bcc	victory_msg_finish
			bcs	victory_msg_notick
		: ; } else if (!victory_msg_timer_lo) {
			cpy	#VICTORY_MSG_TIMER_LOWER
			beq	:+
			cpy	#VICTORY_MSG_TIMER_LOWER_B
			bne	:++
			: ; if (victory_msg_timer_hi.in(2, 6)) {
				inc	victory_msg_timer_hi
				lda	player_id
				beq	:+ ; if (player.id != 0) {
					iny
				; }
			: ; }

			cpy	#VICTORY_MSG_TIMER_UPPER
			bcs	victory_msg_notick
		; }
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
	victory_msg_sound_check:
		.if	.defined(SMB)
			cpy	#3
		.elseif	.defined(VS_SMB)
			iny
			iny
			iny
			cpy	#7
		.endif
		bne	:+ ; if ((SMB && victory_msg_timer_hi == 3) || (VS_SMB && (victory_msg_timer_hi += 3) == 7)) {
			lda	#music_event::victory_normal
			sta	apu_music_event
		: ; }
	.endif

victory_msg_finish:
	tya
	clc
	adc	#nmi_addr::msg_ty_mario
	sta	nmi_addrs_ctl

victory_msg_dotick:
	lda	victory_msg_timer_lo
	clc
	adc	#VICTORY_TICK
	sta	victory_msg_timer_lo
	lda	victory_msg_timer_hi
	adc	#0
	sta	victory_msg_timer_hi
	.if	.defined(CONS)
		cmp	#VICTORY_MSG_TIMER_END
	.elseif	.defined(VS)
		rts
	.endif

victory_msg_notick:
	.if	.defined(CONS)
		bcc	:+ ; if (victory_msg_timer_hi >= end) {
	.endif
		lda	#VICTORY_TIMER_SET
		sta	eng_timer_victory

	victory_next:
		inc	eng_gameplay_mode

	.if	.defined(VS)
		lda	#0
		sta	VS_RAM_ARENA0+$18
		sta	VS_RAM_ARENA0+$22
		sta	VS_RAM_ARENA0+$1F
	.endif
	: ; }

	rts
; -----------------------------------------------------------
	.if	.defined(SMB2M)|.defined(VS_SMB)

	.if	.defined(SMB2M)
		SUB_63AF_TIMER_CUTOFF	= 6
	.elseif	.defined(VS_SMB)
		SUB_63AF_TIMER_CUTOFF	= 10
	.endif

	.if	.defined(SMB2M)
		ENG_TIMER_DISP	= eng_timer_disp_b
	.elseif	.defined(VS_SMB)
		ENG_TIMER_DISP	= eng_timer_disp
	.endif

	sub_63AF:
		lda	eng_timer_victory
		cmp	#SUB_63AF_TIMER_CUTOFF
		bcs	:++ ; if (eng_timer_victory < 6) {
			.if	.defined(VS_SMB)|.defined(SMB2)
				jsr	actor_proc_flag_victory_timer_score_do
			.endif

			lda	ENG_TIMER_DISP
			ora	ENG_TIMER_DISP+1
			ora	ENG_TIMER_DISP+2
			.if	.defined(SMB2)|.defined(VS_SMB)
				bne	:++ ; if (!(VAR_0|VAR_1|VAR_2)) {
			.elseif	.defined(ANN)
				beq	:+ ; if (VAR_0|VAR_1|VAR_2) {
					jmp	actor_proc_flag_victory_timer_score_do
				; } else {
			.endif
			: ; if (!(VAR_0|VAR_1|VAR_2)) {
				lda	#$30
				sta	eng_timer_select
				.if	.defined(SMB2M)
					lda	#6
					sta	eng_timer_victory
				.endif
				inc	eng_gameplay_mode
			; }
		: ; }

		rts
	.endif
; -----------------------------------------------------------
	.if	.defined(VS_SMB)
pal_8492:
	.byte	PPU_COLOR_YGREEN0, PPU_COLOR_YELLOW1, PPU_COLOR_ROSE2,  PPU_COLOR_PITCH0
	.byte	PPU_COLOR_GREY3,   PPU_COLOR_PITCH0,  PPU_COLOR_PITCH0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0,	PPU_COLOR_PITCH0
	.byte	PPU_COLOR_AZURE2,  PPU_COLOR_BLUE1,   PPU_COLOR_AZURE2, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_ORANGE2, PPU_COLOR_ORANGE1, PPU_COLOR_GREY0,	PPU_COLOR_YELLOW1
pal_8492_end:

pal_84A6:
	.byte	PPU_COLOR_AZURE0, PPU_COLOR_BLUE0, PPU_COLOR_AZURE1, PPU_COLOR_AZURE2

ppu_84AA:
	.dbyt	PPU_VRAM_BG2+$286
	.byte	NMI_REPEAT|21
	.byte	" "

	.dbyt	PPU_VRAM_BG2+$2A6
	.byte	NMI_REPEAT|21
	.byte	" "

	.byte	NMI_DATA_END
ppu_84AA_end:

obj_data_offset_enemy_84B3:
	.byte	$50, $B0, $E0, $68
	.byte	$98, $C8

obj_data_offset_enemy_84B9:
	.byte	$80, $50, $68, $80
	.byte	$98, $B0, $C8

actor_pos_y_lo_84C0:
	.byte	$E0, $B8, $90, $70
	.byte	$68, $70, $90

ppu_84C7:
	.byte	$B8, $38, $48, $60
	.byte	$80, $A0, $B8, $C8
; ----------------------------
sub_84CF:
	lda	course_no
	cmp	#course::no_08
	beq	:+ ; if (course_no != no_08) {
		lda	eng_gameplay_mode
		clc
		adc	#2
		sta	eng_gameplay_mode
		rts
	: ; } else {
		inc	VS_RAM_ARENA0+$18
		lda	VS_RAM_ARENA0+$1F
		bne	:+ ; if (!vs_ram_arena0[0x1F]) {
			lda	VS_RAM_ARENA0+$18
			and	#$FF
			bne	:++++++
			inc	VS_RAM_ARENA0+$1F
			jmp	:++
		: ; } else {
			lda	VS_RAM_ARENA0+$18
			and	#$0F
			bne	:+++++
		: ; }

		; if ((!vs_ram_arena0[0x1F] && vs_ram_arena0[0x18] == 0) || !(vs_ram_arena0[0x18] & 0xF)) {
			ldx	#(pal_8492_end-pal_8492)-1
			: ; for (color of pal_8492) {
				lda	pal_8492, x
				sta	ppu_nmi_buffer_0_data+0, x

				dex
				bpl	:-
			; }

			ldx	#12
			ldy	VS_RAM_ARENA0+$22
			: ; for (x = 12; x > 0; x -= 4) {
				lda	pal_84A6, y
				sta	ppu_nmi_buffer_0_data+3, x

				dex
				dex
				dex
				dex
				bpl	:-
			; }

			inc	VS_RAM_ARENA0+$22
			lda	VS_RAM_ARENA0+$22
			cmp	#4
			bne	:+ ; if (++vs_ram_arena0[0x22] == 4) {
				inc	eng_gameplay_mode
			: ; }
		: ; }

		rts
	; }
; -----------------------------------------------------------
sub_8526:
	ldx	#(ppu_84AA_end-ppu_84AA)-1
	: ; for (entry of ppu_84AA) {
		lda	ppu_84AA, x
		sta	ppu_nmi_buffer_0_data, x
		dex
		bpl	:-
	; }

	inc	eng_gameplay_mode
	ldx	player_id
	lda	#1
	sta	VS_RAM_ARENA0+$28, x
	lda	#0
	sta	VS_RAM_ARENA0+$22
	sta	VS_RAM_ARENA0+$18
	sta	VS_RAM_ARENA0+$1F
	lda	#6
	sta	eng_timer_victory
	lda	#$60
	sta	VS_RAM_ARENA0+$2A
	rts
; -----------------------------------------------------------
sub_8552:
	lda	VS_RAM_ARENA0+$2A
	beq	:+ ; if (vs_ram_arena0[0x2A]) {
		dec	VS_RAM_ARENA0+$2A
		rts
	: ; } else {
		ldx	VS_RAM_ARENA0+$22
		cpx	#7
		beq	:+ ; if (vs_ram_arena0[0x22] != 7) {
			lda	VS_RAM_ARENA0+$18
			and	#$1F
			bne	:++ ; if (!(vs_ram_arena0[0x18] & 0x1F)) {
				inc	VS_RAM_ARENA0+$22
				lda	#sfx_pulse2::coin_01
				sta	apu_pulse2_queue
				jmp	:++
			; }
		: ; } else {
			lda	VS_RAM_ARENA0+$18
			and	#$1F
			bne	:+ ; if (!(vs_ram_arena0[0x18] & 0x1F)) {
				inc	VS_RAM_ARENA0+$1F
				lda	VS_RAM_ARENA0+$1F
				cmp	#11
				bcc	:+ ; if (+vs_ram_arena0[0x1F] >= 11) {
					lda	#4
					sta	VS_RAM_ARENA0+$1F
				; }
			; }
		: ; }

		inc	VS_RAM_ARENA0+$18
		lda	course_no
		pha
		lda	VS_RAM_ARENA0+$22
		pha
		tax
		: ; for (vs_ram_arena0[0x22]; vs_ram_arena0[0x22] > 0; vs_ram_arena0[0x22]--){
			lda	VS_RAM_ARENA0+$1F
			cmp	#4
			bcc	:+
			sbc	#4
			tay
			lda	obj_data_offset_enemy_84B3, y
			cmp	obj_data_offset_enemy_84B9, x
			beq	:++
			: ; if ((vs_ram_arena0[0x1F] < 4) || (obj_data_offset_enemy_84B3[vs_ram_arena[0x1F]-4] != obj_data_offset_enemy_84B9[vs_ram_arena0[0x22]])) {
				ldy	obj_data_offset_enemy_84B9, x
				sty	obj_data_offset_enemy
				lda	#$35
				sta	actor_id
				lda	actor_pos_y_lo_84C0, x
				sta	pos_y_lo_actor
				lda	ppu_84C7, x
				sta	pos_x_rel_actor
				ldx	#0
				stx	course_no
				stx	actor_index
				jsr	render_actor
			: ; }

			dec	VS_RAM_ARENA0+$22
			ldx	VS_RAM_ARENA0+$22
			bne	:---
		; }

		pla
		sta	VS_RAM_ARENA0+$22
		pla
		sta	course_no
		lda	#$30
		sta	obj_data_offset_enemy
		lda	#$B8
		sta	pos_y_lo_actor
		rts
	; }
; -----------------------------------------------------------
sub_85E0:
	lda	course_no
	cmp	#course::no_08
	bne	:+ ; if (course_no == no_08) {
		jsr	sub_8552
	: ; }

	lda	eng_timer_victory
	bne	:+
	ldy	course_no
	cpy	#course::no_08
	bcs	:++ ; if (!eng_timer_victory || course_no < no_08) {
		; if (!eng_timer_victory) {
			lda	#0
			sta	course_sub
			sta	eng_goals
			sta	eng_gameplay_mode
			inc	course_no
			jsr	course_descriptor_load
			inc	eng_req_timer
			lda	#game_mode::normal
			sta	eng_game_mode
		: ; }

		rts
	: ; } else {
		lda	#0
		sta	eng_timer_ctl
		lda	#$1C
		sta	eng_timer_actor+1
		inc	eng_gameplay_mode
		rts
	; }
	.endif
; -----------------------------------------------------------
victory_end:
	lda	eng_timer_victory
	bne	victory_end_rts

	.if	.defined(CONS)
		.if	.defined(SMB)
			ldy	course_no
			cpy	#course::no_08
			bcs	:+ ; if (course_no < course_8) {
		.endif

		lda	#0
		sta	course_sub
		sta	eng_goals
		sta	eng_gameplay_mode

		.if	.defined(SMBM)
			inc	course_no
		.elseif	.defined(SMB2)
			lda	course_no
			clc
			adc	#1
			cmp	#course::no_09
			bcc	:+ ; if (course_no >= course_09) {
				lda	#course::no_09
			: ; }
			sta	course_no
		.endif

		jsr	course_descriptor_load
		inc	eng_req_timer
		lda	#game_mode::normal
		sta	eng_game_mode
	.elseif	.defined(VS)
		lda	course_no
		cmp	#course::no_08
		bne	:+
		lda	eng_lives
		bmi	:+
		lda	eng_timer_select
		bne	:++ ; if (course_no == no_08 && eng_lives >= 0 && !eng_timer_select) {
			lda	#$30
			sta	eng_timer_select
			lda	#sfx_pulse2::oneup
			sta	apu_pulse2_queue
			dec	eng_lives
			lda	#1
			sta	STACK_BASE+$35
			jmp	actor_proc_course_end_stats
		: ; } else if (course_no != no_08 || eng_lives < 0) {
			inc	eng_gameplay_mode
		: ; }
	.endif

	victory_end_rts:
		rts

	.if	.defined(SMB)
		: ; } else {
			lda	joypad_p1
			ora	joypad_p2
			and	#joypad_button::face_b
			beq	:+ ; if (joypad_face_b) {
				lda	#1
				sta	eng_course_sel_on
				lda	#255
				sta	eng_lives
				jsr	eng_next_game
			: ; }

			rts
		; }
	.endif
; -----------------------------------------------------------
	.if	.defined(VS_SMB)
sub_864C:
	jsr	sub_8552

	lda	eng_timer_actor+1
	bne	sub_865D_rts ; if (!eng_timer_actor+1) {
		inc	eng_gameplay_mode
		lda	#$D8
		sta	eng_timer_select
		rts
	; } else rts;
; -----------------------------------------------------------
sub_865D:
	jsr	sub_8552

	lda	eng_timer_select
	bne	:+
	lda	snd_ram+1
	bne	:+ ; if (!eng_timer_select && !snd_ram[1]) {
		sta	byte_7FC
		lda	#255
		sta	eng_lives
		lda	#game_mode::game_over
		sta	eng_game_mode
		lda	#gameplay_mode::vs_init
		sta	eng_gameplay_mode
	: ; }

sub_865D_rts:
	rts
	.endif
; -----------------------------------------------------------
SCORE_METASPR_W_TILES	= 2
SCORE_DIGIT_MASK	= $0F

screen_score_disp_tiles:
	.byte	$FF, $FF

	.byte	$F6, $FB
	.byte	$F7, $FB
	.byte	$F8, $FB
	.byte	$F9, $FB
	.byte	$FA, $FB
	.byte	$F6, $50
	.byte	$F7, $50
	.byte	$F8, $50
	.byte	$F9, $50
	.byte	$FA, $50

	.byte	$FD, $FE

	.if	.defined(VS_SMB)
		.byte	$FA, $50
	.endif
screen_score_disp_tiles_end:

screen_score_disp_incs:
	.byte	$FF

	.byte	$41
	.byte	$42
	.byte	$44
	.byte	$45
	.byte	$48
	.byte	$31
	.byte	$32
	.byte	$34
	.byte	$35
	.byte	$38

	.byte	$00

	.if	.defined(VS_SMB)
		.byte	$38
	.endif
screen_score_disp_incs_end:
; ----------------------------
	.export screen_score_disp, screen_score_disp_end
screen_score_disp:
	lda	STACK_BASE+$10, x
	.if	.defined(CONS)
		beq	victory_end_rts
	.elseif	.defined(VS)
		beq	sub_865D_rts
	.endif
	cmp	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-1
	bcc	:+ ; if (stack[0x10] >= sizeof (disp_tiles))) {
		lda	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-1
		sta	STACK_BASE+$10, x
	: ; }
	tay

	lda	STACK_BASE+$2C, x
	bne	:+ ; if (!stack[0x2C]) {
		sta	STACK_BASE+$10, x
		rts
	: ; }

	dec	STACK_BASE+$2C, x
	cmp	#$2B
	bne	:++ ; if (stack[0x2C] == 0x2B) {
		.if	.defined(CONS)
			cpy	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-1
		.elseif	.defined(VS)
			cpy	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-2
		.endif
		bne	:+ ; if (stack[0x10] == 1UP) {
			inc	eng_lives
			lda	#sfx_pulse2::oneup
			sta	apu_pulse2_queue
		: ; }

		lda	screen_score_disp_incs, y
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		tax
		lda	screen_score_disp_incs, y
		and	#SCORE_DIGIT_MASK
		sta	STACK_BASE+$34, x
		jsr	obj_misc_update_score
	: ; }

	ldy	obj_data_offset_enemy, x
	lda	actor_id, x
	cmp	#actor::spiny
	beq	:++
	cmp	#actor::piranha_plant
	beq	:++
	cmp	#actor::hammer_bro
	beq	:+
	cmp	#actor::cheep_grey
	beq	:++
	cmp	#actor::cheep_red
	beq	:++
	cmp	#actor::div_height
	bcs	:+
	lda	state_actor, x
	cmp	#actor_states::state_2
	bcs	:++
	: ; if (actor.id == hammer_bro || actor.id >= div_height || actor.state < 2) {
		ldx	obj_data_offset_ctl
		ldy	obj_data_offset_block, x
		ldx	actor_index
	: ; }

	lda	STACK_BASE+$1E, x
	cmp	#$18
	bcc	:+ ; if (stack[0x1E] >= 0x18) {
		sbc	#1
		sta	STACK_BASE+$1E, x
	: ; }

	lda	STACK_BASE+$1E, x
	sbc	#8
	jsr	sub_E5C1
	lda	STACK_BASE+$17, x
	sta	OAM_DMA_BUFFER+OBJ_POS_H, y
	clc
	adc	#PPU_TILE_HEIGHT_PX
	sta	OAM_DMA_BUFFER+OBJ_POS_H+OBJ_SIZE, y
	lda	#(obj_attr::priority_high|obj_attr::color2)
	sta	OAM_DMA_BUFFER+OBJ_ATTR, y
	sta	OAM_DMA_BUFFER+OBJ_ATTR+OBJ_SIZE, y
	lda	STACK_BASE+$10, x
	asl	a
	tax
	lda	screen_score_disp_tiles, x
	sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
	lda	screen_score_disp_tiles+1, x
	sta	OAM_DMA_BUFFER+OBJ_CHR_NO+OBJ_SIZE, y
	ldx	actor_index

screen_score_disp_end:
	rts
