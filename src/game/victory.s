.include	"../../inc/system/cpu.i"
.include	"../../inc/system/ppu.i"

.include	"../../inc/engine/joypad.i"
.include	"../../inc/engine/sound.i"
.include	"../../inc/engine/tunables.i"
.include	"../../inc/engine/misc.i"

.include	"../../inc/engine/unk.i"

	.export eng_victory
eng_victory:
	jsr	victory_enter

	lda	eng_gameplay_mode
	beq	:++
	.if	.defined(SMB2M)
		ldx	eng_course_no
		cpx	#course::no_08
		bne	:+
		cmp	#gameplay_mode::mode_5
		beq	eng_victory-1
		cmp	#gameplay_mode::mode_D
		beq	eng_victory-1
		; NOTE: This assumes this module follows an rts
	.endif
	: ; if (eng_gameplay_mode != bridge && (eng_course_no != course_08 || eng_gameplay_mode.not_in(5, $D))) {
		ldx	#0
		stx	eng_actor_offset
		jsr	actor_proc
	: ; }

	jsr	lib_calc_player_pos
	jmp	eng_player_render
; -----------------------------------------------------------
victory_enter:
	.if	.defined(SMB2M)
		lda	eng_course_no
		cmp	#course::no_08
		beq	victory_course_8 ; if (!SMB2M || eng_course_no != course_8) {
	.endif
		lda	eng_gameplay_mode
		jsr	eng_farjump
		.addr	eng_bowser_ending
		.addr	victory_init
		.addr	victory_proc
		.addr	victory_msg
		.if	.defined(SMB2M)
			.addr	sub_63AF
		.endif
		.addr	victory_end
	.if	.defined(SMB2M)
	victory_course_8: ; } else {
		lda	eng_gameplay_mode
		jsr	eng_farjump
		.addr	eng_bowser_ending
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
	sub_6311:
		lda	eng_goals
		cmp	#3
		bne	:+++
		ldy	byte_7FB
		bne	:+++ ; if (eng_goals == 3 && !byte_7FB) {
			sty	zp_byte_06

			lda	eng_course_no
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
		lda	byte_7FB
		bne	:++
		ldx	eng_course_no
		cpx	#course::no_08
		beq	:++ ; if (!byte_7FB && course_no != course_08) {
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

			lda	#$1D
			sta	nmi_addrs_ctl
		: ; }
	.endif

	ldx	eng_screen_right_hi
	inx
	stx	victory_screen_hi

	.if	.defined(SMB2)
		ldy	eng_course_no
		lda	victory_init_mask, y
		ora	byte_7FA
		sta	byte_7FA
	.endif

	.if	.defined(SMB2M)
		lda	byte_7FB
		beq	:+
		lda	eng_course_no
		cmp	#course::no_04
		bcc	:+ ; if (data_7FB && eng_course_no >= course_04) {
			lda	#course::no_08
			sta	eng_course_no
		: ; }
	.endif

	lda	#music_event::victory_fanfare
	sta	apu_music_event

	.if	.defined(SMB2M)
		.export screen_title_bg
	screen_title_bg_finish:
		inc	eng_gameplay_mode
		rts

	screen_title_bg:
		lda	eng_game_mode
		bne	screen_title_bg_finish

		lda	#5
	.endif

	.if	.defined(SMB)
		jmp	victory_next_2
	.elseif	.defined(SMB2M)
		jmp	screen_color_init_4_end
	.endif
; -----------------------------------------------------------
victory_proc:
	ldy	#0
	sty	victory_proc_ctrl
	lda	eng_player_hi
	cmp	victory_screen_hi
	bne	:+
	lda	eng_player_pos_x_lo
	cmp	#VICTORY_X_POS
	bcs	:++
	: ; if ((eng_player_hi != victory_screen_hi) || eng_player_pos_x_lo < VICTORY_X_POS) {
		inc	victory_proc_ctrl
		iny
	: ; }
	tya
	jsr	player_proc_auto

	lda	eng_screen_left_hi
	cmp	victory_screen_hi
	beq	:+ ; if (eng_screen_left_hi != victory_screen_hi) {
		lda	eng_scroll_subpix
		clc
		adc	#VICTORY_SCROLL
		sta	eng_scroll_subpix
		lda	#1
		adc	#0
		tay
		jsr	game_scroll
		jsr	game_scroll_save
		inc	victory_proc_ctrl
	: ; }
	lda	victory_proc_ctrl
	beq	victory_next
	rts
; -----------------------------------------------------------
victory_msg:
        lda     victory_msg_timer_lo
        bne     victory_msg_dotick
        lda     victory_msg_timer_hi
        beq     victory_msg_do
	cmp     #VICTORY_MSG_TIMER_UPPER
	bcs     victory_msg_dotick

	.if	.defined(SMB)
		ldy     eng_course_no
		cpy     #course::no_08
		bne     :+ ; if (eng_course_no == course_8) {
			cmp     #3
			bcc     victory_msg_dotick
			sbc     #1
			jmp     victory_msg_do
		: ; }
	.endif

	cmp	#VICTORY_MSG_TIMER_LOWER
	bcc	victory_msg_dotick

victory_msg_do:
	tay
	.if	.defined(SMB)
		bne     :+ ; if () {
			lda     eng_player_id
			beq     victory_msg_sound_check
			iny
			bne     victory_msg_sound_check
		: ; }

		iny
		lda     eng_course_no
		cmp     #course::no_08
		beq     victory_msg_sound_check
		dey
	.elseif	.defined(SMB2M)
		beq	victory_msg_finish
	.endif

	cpy     #VICTORY_NOTICK_END
	bcs     victory_msg_notick
	cpy     #VICTORY_DOTICK_END
	bcs     victory_msg_dotick

	.if	.defined(SMB)
	victory_msg_sound_check:
		cpy     #3
		bne     :+ ; if () {
			lda     #4
			sta     apu_music_event
		: ; }
	.endif

victory_msg_finish:
	tya
        clc
        adc     #$0C
        sta     nmi_addrs_ctl

victory_msg_dotick:
	lda     victory_msg_timer_lo
        clc
        adc     #VICTORY_TICK
        sta     victory_msg_timer_lo
        lda     victory_msg_timer_hi
        adc     #0
        sta     victory_msg_timer_hi
        cmp     #VICTORY_MSG_TIMER_END

victory_msg_notick:
	bcc     :+ ; if (victory_msg_timer_hi >= end) {
		lda     #VICTORY_TIMER_SET
		sta     eng_timer_victory

	victory_next:
		inc     eng_gameplay_mode
	: ; }

	rts
; -----------------------------------------------------------
	.if	.defined(SMB2M)
	sub_63AF:
        	lda     eng_timer_victory
		cmp	#6
		bcs	:++ ; if (eng_timer_victory < 6) {
			.if	.defined(SMB2)
				jsr	sub_9F57
			.endif

			lda	byte_7EC
			ora	byte_7ED
			ora	byte_7EE
			.if	.defined(SMB2)
				bne	:++ ; if (!(byte_7EC|byte_7ED|byte_7EE)) {
			.elseif	.defined(ANN)
				beq	:+ ; if (byte_7EC|byte_7ED|byte_7EE) {
					jmp	sub_9F5B
				; } else {
			.endif
			: ; if (!(byte_7EC|byte_7ED|byte_7EE)) {
				lda	#$30
				sta	eng_timer_select
				lda	#6
				sta	eng_timer_victory
				inc	eng_gameplay_mode
			; }
		: ; }

		rts
	.endif
; -----------------------------------------------------------
victory_end:
        lda     eng_timer_victory
        bne     victory_end_rts
	.if	.defined(SMB)
		ldy     eng_course_no
		cpy     #course::no_08
		bcs     :+ ; if (eng_course_no < course_8) {
	.endif

	lda	#0
	sta	eng_course_sub
	sta	eng_goals
	sta	eng_gameplay_mode

	.if	.defined(SMBM)
		inc	eng_course_no
	.elseif	.defined(SMB2)
		lda	eng_course_no
		clc
		adc	#1
		cmp	#course::no_09
		bcc	:+ ; if (eng_course_no >= course_09) {
			lda	#course::no_09
		: ; }
		sta	eng_course_no
	.endif

	jsr	eng_loadareaptr
	inc	eng_req_timer
	lda	#game_mode::normal
	sta	eng_game_mode

	victory_end_rts:
		rts

	.if	.defined(SMB)
		: ; } else {
			lda     joypad_p1
			ora     joypad_p2
			and     #joypad_button::face_b
			beq     :+ ; if (joypad_face_b) {
				lda     #1
				sta     eng_course_sel_on
				lda     #$FF
				sta     eng_lives
				jsr	eng_next_game
			: ; }

			rts
		; }
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
screen_score_disp_incs_end:
; ----------------------------
	.export screen_score_disp, screen_score_disp_end
screen_score_disp:
	lda	STACK_BASE+$10, x
	beq	victory_end_rts
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
		cpy	#((screen_score_disp_tiles_end-screen_score_disp_tiles)/SCORE_METASPR_W_TILES)-1
		bne	:+ ; if (stack[0x10] == 1UP) {
			inc	eng_lives
			lda	#$40
			sta	zp_byte_FE
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
		jsr	sub_BC27
	: ; }

	ldy	tbl_6E5, x
	lda	eng_actor_id, x
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
	lda	eng_actor_state, x
	cmp	#2
	bcs	:++
	: ; if (actor == hammer_bro || actor >= div_height || actor_state < 2) {
		ldx	ppu_nmi_buffer+$EE
		ldy	tbl_6EC, x
		ldx	eng_actor_offset
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
	ldx	eng_actor_offset

screen_score_disp_end:
	rts
