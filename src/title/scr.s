.include	"mem.i"
.include	"macros.i"

.if	.defined(SMB)|.defined(VS_SMB)
; -----------------------------------------------------------
	.if	.defined(CONS)
		LARGEST_DATA_SIZE	= (title_map_end-title_map+9)
		TITLE_NMI_BUFFER_END	= ppu_displist_title_end
		TITLE_NMI_ADDR		= ppu_displist
	.elseif	.defined(VS)
		LARGEST_DATA_SIZE	= (title_map_end-title_map+29)
		TITLE_NMI_BUFFER_END	= vs_ppu_displist_end
		TITLE_NMI_ADDR		= vs_ppu_displist
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
		.export screen_title_bg
	screen_title_bg:
		lda	proc_id_system
		bne	screen_title_proc_id_inc

		.if	.defined(CONS)
			ppuaddr_m	title_map
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
.endif
; ----------------------------
	.export	screen_title_cursor
screen_title_cursor:
	lda	proc_id_system
	bne	screen_title_proc_id_inc
	ldx	#0
	: ; for (byte of ppu_displist) {
		sta	ppu_displist, x
		sta	ppu_displist_title_end, x

		dex
		bne	:-
	; }

	.if	.defined(CONS)
		jsr	title_cursor_draw
	.endif
screen_proc_next:
	inc	screen_proc_id
	rts
; ----------------------------
	.export screen_title_score
screen_title_score:
	lda	#$FA
	jsr	misc_proc_coin_add_score

	.export screen_title_proc_id_inc
screen_title_proc_id_inc:
.if	.defined(SMB)|.defined(VS_SMB)
	inc	proc_id_game
	rts
.elseif	.defined(SMBV2)
	jmp	screen_title_bg_finish
.endif
