.include	"system/ppu.i"

.include	"engine/mem.i"
.include	"engine/chr.i"
.include	"engine/joypad.i"

; ------------------------------------------------------------
GAME_OVER_MENU_CURSOR_POS_X	= 72
GAME_OVER_MENU_CURSOR_OPTION_A_POS_Y	= 119
GAME_OVER_MENU_CURSOR_OPTION_B_POS_Y	= 143
; ------------------------------------------------------------
eng_game_over_menu_attrs:
	.byte	tile_obj::plat_norm
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	GAME_OVER_MENU_CURSOR_POS_X
eng_game_over_menu_attrs_end:

eng_game_over_menu_pos_y:
	.byte	GAME_OVER_MENU_CURSOR_OPTION_A_POS_Y
	.byte	GAME_OVER_MENU_CURSOR_OPTION_B_POS_Y
; -----------------------------
	.export eng_game_over_menu
eng_game_over_menu:
	lda	joypad_p1
	and	#joypad_button::start
	bne	:+++ ; if (!joypad_p1.start) {
		lda	joypad_p1
		and	#joypad_button::select
		beq	:+
		ldx	timer_select
		bne	:+ ; if (joypad_p1.select && timer_select == 0) {
			lsr	a
			sta	timer_select
			lda	eng_game_over_choice
			eor	#1
			sta	eng_game_over_choice
		: ; }
	
		ldy	#(eng_game_over_menu_attrs_end-eng_game_over_menu_attrs)-1
		: ; for (entry of attrs) {
			lda	eng_game_over_menu_attrs, y
			sta	OAM_DMA_BUFFER+(0*OBJ_SIZE)+OBJ_CHR_NO, y
			dey
			bpl	:-
		; }
	
		ldy	eng_game_over_choice
		lda	eng_game_over_menu_pos_y, y
		sta	OAM_DMA_BUFFER+(0*OBJ_SIZE)+OBJ_POS_V
		rts
	: lda	eng_game_over_choice
	beq	:+ ; } else if (eng_game_over_choice != 0) {
		.if	.defined(SMB2)
			lda	#0
			sta	game_courses_cleared
		.endif

		jmp	eng_next_game
	: ; } else {
		ldy	#2
		sty	player_lives
		sta	eng_goals
		sta	course_sub
		sta	eng_coins
		ldy	#12-1
		: ; for (y = 12-1; y >= 0; y--) {
			sta	eng_stats, y
	
			dey
			bpl	:-
		; }
	
		inc	eng_hidden_one_up
		jmp	eng_game_continue
	; }