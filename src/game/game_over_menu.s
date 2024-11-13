.include	"system/ppu.i"

.include	"mem.i"
.include	"chr.i"
.include	"joypad.i"

; ------------------------------------------------------------
GAME_OVER_MENU_CURSOR_POS_X	= 72
GAME_OVER_MENU_CURSOR_OPTION_A_POS_Y	= 119
GAME_OVER_MENU_CURSOR_OPTION_B_POS_Y	= 143
; ------------------------------------------------------------
game_over_menu_attrs:
	.byte	chr_obj::plat_norm
	.byte	obj_attr::priority_high|obj_attr::color2
	.byte	GAME_OVER_MENU_CURSOR_POS_X
game_over_menu_attrs_end:

game_over_menu_pos_y:
	.byte	GAME_OVER_MENU_CURSOR_OPTION_A_POS_Y
	.byte	GAME_OVER_MENU_CURSOR_OPTION_B_POS_Y
; -----------------------------
	.export game_over_menu
game_over_menu:
	lda	joypad_p1
	and	#joypad_button::start
	bne	:+++ ; if (!joypad[0].start) {
		lda	joypad_p1
		and	#joypad_button::select
		beq	:+
		ldx	timer_select
		bne	:+ ; if (joypad[0].select && timer_select == 0) {
			lsr	a
			sta	timer_select
			lda	game_over_choice
			eor	#1
			sta	game_over_choice
		: ; }
	
		ldy	#(game_over_menu_attrs_end-game_over_menu_attrs)-1
		: ; for (entry of attrs) {
			lda	game_over_menu_attrs, y
			sta	OAM_DMA_BUFFER+(0*OBJ_SIZE)+OBJ_CHR_NO, y
			dey
			bpl	:-
		; }
	
		ldy	game_over_choice
		lda	game_over_menu_pos_y, y
		sta	OAM_DMA_BUFFER+(0*OBJ_SIZE)+OBJ_POS_V
		rts
	: lda	game_over_choice
	beq	:+ ; } else if (game_over_choice != 0) {
		.if	.defined(SMB2)
			lda	#0
			sta	game_courses_cleared
		.endif

		jmp	game_over_next_game
	: ; } else {
		ldy	#2
		sty	player_lives
		sta	player_goals
		sta	course_sub
		sta	player_coins
		ldy	#(2*STAT_LEN_MAX)-1
		: ; for (digit of player.stats) {
			sta	stats_player, y
	
			dey
			bpl	:-
		; }
	
		inc	bg_hidden_one_up_req
		jmp	game_over_continue
	; }
