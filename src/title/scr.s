.include	"engine/mem.i"

; -----------------------------------------------------------
.if	.defined(CONS)
	LARGEST_DATA_SIZE	= (title_map_end-title_map+9)
	TITLE_NMI_BUFFER_END	= ppu_nmi_buffer_title_end
	TITLE_NMI_ADDR		= ppu_nmi_buffer
.elseif	.defined(VS)
	LARGEST_DATA_SIZE	= $15A
	TITLE_NMI_BUFFER_END	= vs_ppu_nmi_buffer_end
	TITLE_NMI_ADDR		= vs_ppu_nmi_buffer
.endif

SCREEN_TITLE_BG_SIZE	= <((LARGEST_DATA_SIZE)-(TITLE_NMI_BUFFER_END-TITLE_NMI_ADDR))
; -----------------------------------------------------------
screen_title_bg_nmi_addr	= zp_addr_00

.if	.defined(VS)
screen_title_bg_addr_hi:
	.byte	>title_map
	.byte	>vs_player_select_bg
	.byte	>vs_name_register_bg
	.byte	>vs_stats_bg
	.byte	>vs_box_bg
	.byte	>vs_insert_coin_bg
	.byte	>vs_continue_bg
	.byte	>vs_super_players_bg

screen_title_bg_addr_lo:
	.byte	<title_map
	.byte	<vs_player_select_bg
	.byte	<vs_name_register_bg
	.byte	<vs_stats_bg
	.byte	<vs_box_bg
	.byte	<vs_insert_coin_bg
	.byte	<vs_continue_bg
	.byte	<vs_super_players_bg
.endif
; -----------------------------
screen_title_bg:
	lda	eng_game_mode
	bne	screen_title_end

	.if	.defined(CONS)
		lda	#>title_map
		sta	PPU_VRAM_AR
		lda	#<title_map
		sta	PPU_VRAM_AR
	.elseif	.defined(VS)
		ldy	#vschar1_bg_data::map_title

		.export screen_vschar1_load
	screen_vschar1_load:
		lda	#vs_req::chr_high|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
		lda	screen_title_bg_addr_hi, y
		sta	PPU_VRAM_AR
		lda	screen_title_bg_addr_lo, y
		sta	PPU_VRAM_AR
	.endif

	lda	#>(TITLE_NMI_ADDR)
	sta	screen_title_bg_nmi_addr+1
	ldy	#<(TITLE_NMI_ADDR)
	sty	screen_title_bg_nmi_addr
	lda	PPU_VRAM_IO
	: ; for (entry of nmi_buffer) {
		lda	PPU_VRAM_IO
		sta	(screen_title_bg_nmi_addr), y

		iny
		bne	:+
		inc	screen_title_bg_nmi_addr+1
		: lda	screen_title_bg_nmi_addr+1
		cmp	#>(TITLE_NMI_BUFFER_END)
		bne	:--
		cpy	#SCREEN_TITLE_BG_SIZE
		bcc	:--
	; }

	.if	.defined(VS)
		lda	#vs_req::chr_low|vs_req::irq_rel|vs_req::ctrl_rel
		sta	VS_REQ
	.endif

	lda	#PPU_COLOR_ROSE0
	jmp	screen_color_init_4_end
; ----------------------------
screen_title_cursor:
	lda	eng_game_mode
	bne	screen_title_end
	ldx	#0
	: ; for (byte of ppu_nmi_buffer) {
		sta	ppu_nmi_buffer, x
		sta	ppu_nmi_buffer_title_end, x

		dex
		bne	:-
	; }

	.if	.defined(CONS)
		jsr	title_cursor_draw
	.endif
screen_proc_next:
	inc	eng_screen_proc_id
	rts
; ----------------------------
screen_title_score:
	lda	#$FA
	jsr	misc_proc_coin_add_score

	.export screen_title_end
screen_title_end:
	inc	eng_gameplay_mode
	rts
