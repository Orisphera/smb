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
	beq	:+ ; if (eng_gameplay_mode != bridge) {
		ldx	#0
		stx	eng_actor_offset
		jsr	actor_proc
	: ; }

	jsr	lib_calc_player_pos
	jmp	eng_player_render
; -----------------------------------------------------------
victory_enter:
	lda	eng_gameplay_mode
	jsr	eng_farjump
	.addr	eng_bowser_ending
	.addr	victory_init
	.addr	victory_proc
	.addr	victory_msg
	.addr	victory_end
; -----------------------------------------------------------
victory_init:
	ldx	eng_screen_right_hi
	inx
	stx	victory_screen_hi
	lda	#music_event::victory_fanfare
	sta	apu_music_event
	jmp	victory_next
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
		adc	#$80
		sta	eng_scroll_subpix
		lda	#1
		adc	#0
		tay
		jsr	game_scroll
		jsr	game_scroll_save
		inc	victory_proc_ctrl
	: ; }
	lda	victory_proc_ctrl
	beq	victory_next_2
	rts
; -----------------------------------------------------------
victory_msg:
        lda     victory_msg_count_inner
        bne     victory_msg_dotick
        lda     victory_msg_count_outer
        beq     victory_msg_do
        cmp     #9
        bcs     victory_msg_dotick
        ldy     eng_course_no
	cpy     #7
        bne     victory_normal
        cmp     #3
        bcc     victory_msg_dotick
        sbc     #1
        jmp     victory_msg_do

victory_normal:
	cmp     #2
        bcc     victory_msg_dotick

victory_msg_do:
	tay
        bne     victory_msg_do_more
        lda     eng_player_id
        beq     victory_msg_sound_check
        iny
        bne     victory_msg_sound_check

victory_msg_do_more:
	iny
        lda     eng_course_no
        cmp     #7
        beq     victory_msg_sound_check
        dey
        cpy     #4
        bcs     victory_msg_notick
        cpy     #3
        bcs     victory_msg_dotick

victory_msg_sound_check:
	cpy     #3
        bne     :+ ; if () {
		lda     #4
		sta     apu_music_event
	: ; }

	tya
        clc
        adc     #$0C
        sta     nmi_addrs_ctl

victory_msg_dotick:
	lda     victory_msg_count_inner
        clc
        adc     #4
        sta     victory_msg_count_inner
        lda     victory_msg_count_outer
        adc     #0
        sta     victory_msg_count_outer
        cmp     #7

victory_msg_notick:
	bcc     :+ ; if (victory_msg_count_outer >= 7) {
		lda     #6
		sta     eng_timer_victory

	victory_next_2:
		inc     eng_gameplay_mode
	: ; }

	rts
; -----------------------------------------------------------
victory_end:
        lda     eng_timer_victory
        bne     victory_end_rts
        ldy     eng_course_no
        cpy     #7
        bcs     :+ ; if (eng_course_no < 7) {
		lda	#0
		sta	eng_course_sub
		sta	eng_goals
		sta	eng_gameplay_mode
		inc	eng_course_no
		jsr	eng_loadareaptr
		inc	eng_req_timer
		lda	#game_mode::normal
		sta	eng_game_mode

	victory_end_rts:
		rts
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
	.export screen_score_disp
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
	rts
