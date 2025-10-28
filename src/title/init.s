.include	"sys/ppu.i"
.include	"sys/palette.i"

.include	"mem.i"
.include	"chr.i"
.include	"charmap.i"
.include	"tunables.i"

; ------------------------------------------------------------
.if	.defined(SMB2)
GAMES_STARS_MAX		= 24
GAMES_STARS_ROW_START	= $33
GAMES_STARS_ROW_INC	= $4D
.elseif	.defined(ANN)
GAMES_STARS_MAX		= 20
GAMES_STARS_ROW_START	= $47
GAMES_STARS_ROW_INC	= $2F
.endif
; ------------------------------------------------------------
title_init_0_star_cutoff	= zp_byte_00

	.export title_init_0
title_init_0:
	lda	#0
	.if	.defined(SMB2)
		sta	game_courses_cleared
	.endif
	sta	ENG_HARDMODE_VAR
	sta	player_id
	jsr	title_patch_player
	jsr	title_cursor_draw_xfer

	ldy	#GAMES_STARS_ROW_START
	lda	#(GAMES_STARS_MAX/2)
	sta	title_init_0_star_cutoff
	ldx	#0
	: ; for (game of completed_games) {
		lda	#chr_bg::blanks+2
		cpx	save
		bcs	:+ ; if (x < save) {
			lda	#chr_bg::star_title
		: ; }
		sta	title_map, y
		iny

		dec	title_init_0_star_cutoff
		bne	:+ ; if (!--title_init_0_star_cutoff) {
			ldy	#GAMES_STARS_ROW_INC
		: ; }

		inx
		cpx	#GAMES_STARS_MAX
		bne	:---
	; }

	ldy	#<RAM_CLEAR_END_GAMEINIT
	jsr	game_init_clearram

	ldy	#(snd_ram_end-snd_ram)-1
	: ; for (byte of sndram) {
		sta	snd_ram, y

		dey
		bpl	:-
	; }

	lda	#TITLE_DEMO_TIMER
	sta	timer_demo
	jsr	course_descriptor_load
	jmp	game_init_0
; -----------------------------
	.export title_init_1
title_init_1:
	lda	#1
	sta	player_first_start
	sta	player_size
	lda	#2
	sta	player_lives
	jmp	game_init_1
; -----------------------------
title_patch_player_name:
	.byte	"MARIO"
title_patch_player_name_a_end:
	.byte	"LUIGI"
title_patch_player_name_b_end:

title_patch_player_palette:
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_RED1, PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1
	.byte	PPU_COLOR_BLUE2, PPU_COLOR_GREY3, PPU_COLOR_ORANGE2, PPU_COLOR_YGREEN1

title_patch_player_name_ends:
	.byte	(title_patch_player_name_a_end-title_patch_player_name)-1
	.byte	(title_patch_player_name_b_end-title_patch_player_name)-1
; -----------------------------
title_patch_player_offset	= zp_byte_00

	.export title_patch_player
title_patch_player:
	ldy	player_id
	lda	title_patch_player_name_ends, y
	pha

	iny
	sty	title_patch_player_offset

	tay
	ldx	#PLAYER_NAME_LENGTH-1
	: ; for (character of player_name) {
		lda	title_patch_player_name, y
		sta	bg_text_header_player_name, x
		sta	msg_thankyou_player_name, x

		dey
		dex
		bpl	:-
	; }

	pla
	sec
	sbc	title_patch_player_offset
	tay
	ldx	#PPU_COLOR_ROW_SIZE-1
	: ; for (entry of palette) {
		lda	title_patch_player_palette, y
		sta	bg_color_player_data, x

		dey
		dex
		bpl	:-
	; }

	rts
