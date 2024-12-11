.include	"system/ppu.i"
.include	"system/palette.i"
.if	.defined(FDS)
	.include	"system/fds.i"
.endif
.if	.defined(VS)
	.include	"system/vs.i"
.endif

.include	"mem.i"
.include	"joypad.i"
.include	"modes.i"
.include	"tunables.i"
.include	"misc.i"

.if	.defined(SMBV1)
	nmi_addrs_low:
		.byte	<(ppu_displist_0_data)
		.byte	<(palette_underwater)
		.byte	<(palette_overworld)
		.byte	<(palette_underground)
		.byte	<(palette_castle)
		.byte	<(ppu_displist_0_offset)
		.byte	<(ppu_displist_1_data)
		.byte	<(ppu_displist_1_data)
		.byte	<(palette_bowser)
		.byte	<(palette_snow_day)
		.byte	<(palette_snow_night)
		.byte	<(palette_mushroom)
		.byte	<(msg_thankyou_mario)
		.byte	<(msg_thankyou_luigi)
		.byte	<(msg_thankyou_toad)
	.if	.defined(SMB)
		.byte	<(msg_thankyou_princess1)
		.byte	<(msg_thankyou_princess2)
		.byte	<(msg_worldsel_1)
		.byte	<(msg_worldsel_2)
	.elseif	.defined(VS_SMB)
		.byte	<(nmi_ending_attr)
		.byte	<(nmi_ending_pal)
		.byte	<(msg_thankyou_mario_2)
		.byte	<(msg_thankyou_luigi_2)
		.byte	<(msg_vsend_1)
		.byte	<(msg_vsend_2)
		.byte	<(msg_vsend_3_mario)
		.byte	<(msg_vsend_3_luigi)
		.byte	<(msg_vsend_4)
		.byte	<(msg_vsend_5)
		.byte	<(msg_vsend_6)
		.byte	<(msg_vsend_7)
		.byte	<(msg_vsend_8)
		.byte	<(vs_ppu_displist)
		.byte	<(nmi_addr_1D)
		.byte	<(nmi_addr_1D)
		.byte	<(nmi_addr_1E)
		.byte	<(nmi_addr_1E)
		.byte	<(nmi_addr_1E)
		.byte	<(nmi_addr_1E)
		.byte	<(nmi_addr_1E)
		.byte	<(nmi_addr_1E)
		.byte	<(nmi_addr_1E)
		.byte	<(nmi_addr_1F)
	.endif

	nmi_addrs_high:
		.byte	>(ppu_displist_0_data)
		.byte	>(palette_underwater)
		.byte	>(palette_overworld)
		.byte	>(palette_underground)
		.byte	>(palette_castle)
		.byte	>(ppu_displist_0_offset)
		.byte	>(ppu_displist_1_data)
		.byte	>(ppu_displist_1_data)
		.byte	>(palette_bowser)
		.byte	>(palette_snow_day)
		.byte	>(palette_snow_night)
		.byte	>(palette_mushroom)
		.byte	>(msg_thankyou_mario)
		.byte	>(msg_thankyou_luigi)
		.byte	>(msg_thankyou_toad)
	.if	.defined(SMB)
		.byte	>(msg_thankyou_princess1)
		.byte	>(msg_thankyou_princess2)
		.byte	>(msg_worldsel_1)
		.byte	>(msg_worldsel_2)
	.elseif	.defined(VS_SMB)
		.byte	>(nmi_ending_attr)
		.byte	>(nmi_ending_pal)
		.byte	>(msg_thankyou_mario_2)
		.byte	>(msg_thankyou_luigi_2)
		.byte	>(msg_vsend_1)
		.byte	>(msg_vsend_2)
		.byte	>(msg_vsend_3_mario)
		.byte	>(msg_vsend_3_luigi)
		.byte	>(msg_vsend_4)
		.byte	>(msg_vsend_5)
		.byte	>(msg_vsend_6)
		.byte	>(msg_vsend_7)
		.byte	>(msg_vsend_8)
		.byte	>(vs_ppu_displist)
		.byte	>(nmi_addr_1D)
		.byte	>(nmi_addr_1D)
		.byte	>(nmi_addr_1E)
		.byte	>(nmi_addr_1E)
		.byte	>(nmi_addr_1E)
		.byte	>(nmi_addr_1E)
		.byte	>(nmi_addr_1E)
		.byte	>(nmi_addr_1E)
		.byte	>(nmi_addr_1E)
		.byte	>(nmi_addr_1F)
	.endif
.elseif	.defined(SMBV2)
	nmi_addrs:
		.addr	(ppu_displist_0_data)
		.addr	(palette_underwater)
		.addr	(palette_overworld)
		.addr	(palette_underground)
		.addr	(palette_castle)
		.addr	(title_map)
		.addr	(ppu_displist_1_data)
		.addr	(ppu_displist_1_data)
		.addr	(palette_bowser)
		.addr	(palette_snow_day)
		.addr	(palette_snow_night)
		.addr	(palette_mushroom)
		.addr	(msg_thankyou_mario)
		.addr	(msg_thankyou_toad)
		.addr	(nmi_ending_attr)
		.addr	(nmi_ending_pal)
		.addr	(msg_thankyou_mario_2)
		.addr	(msg_vsend_1)
		.addr	(msg_vsend_2)
		.addr	(msg_vsend_3_mario)
		.addr	(msg_vsend_4)
		.addr	(msg_vsend_5)
		.addr	(msg_vsend_6)
		.addr	(msg_vsend_7)
		.addr	(msg_vsend_8)
		.addr	(disk_text_error_buffer)
		.addr	(disk_perror_pal)
		.addr	(ending_throneroom_map)
		.addr	(title_cursor_data)
		.if	.defined(SMB2)
			.addr	(ending_course_plus_txt)
			.addr	(ending_super_player_txt)
		.elseif	.defined(ANN)
			.addr	(ann_toad_pal_common)
			.addr	(ending_pal_ext)
		.endif
.endif

.if .defined(VS_SMB)
nmi_addr_1F:
	.byte	PPU_COLOR_YGREEN0, PPU_COLOR_PITCH1, PPU_COLOR_PITCH1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_GREY3, PPU_COLOR_YGREEN3, PPU_COLOR_CYAN0, PPU_COLOR_YELLOW1

nmi_addr_1E:
	.byte	PPU_COLOR_YGREEN0, PPU_COLOR_YELLOW1, PPU_COLOR_MAGENTA0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_GREY3, PPU_COLOR_GREY1, PPU_COLOR_GREY0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_AZURE3, PPU_COLOR_BLUE1, PPU_COLOR_AZURE0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_YGREEN3, PPU_COLOR_BLUE1, PPU_COLOR_YGREEN0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_RED3, PPU_COLOR_ORANGE1, PPU_COLOR_GREEN0, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_RED1, PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_GREY3, PPU_COLOR_ORANGE2, PPU_COLOR_YGREEN1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_ORANGE3, PPU_COLOR_ORANGE2, PPU_COLOR_RED1, PPU_COLOR_PITCH0
	.byte	PPU_COLOR_RED1,	PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1, PPU_COLOR_YELLOW1
.endif

ppu_displist_offset:
	.byte	<ppu_displist_0
	.byte	<ppu_displist_1
; ----------------------------
.if	.defined(SMBV2)
	SMBV2_NMI_TIMER_3_19594_MS	= 5720

	.if	.defined(SMB2)
		SMBV2_COURSE_NO_CUTOFF = course::no_0A
	.elseif	.defined(ANN)
		SMBV2_COURSE_NO_CUTOFF = course::no_09
	.endif
.endif

nmi_rand_buffer	= zp_byte_00

	.export nmi
	.export	nmi_apu_call
	.export nmi_timer_int_init
nmi:
	.if	.defined(FDS_SMB)
		cli
	.endif

	.if	.defined(SMBV1)
		lda	ppu_ctlr0_b
		and	#<~(ppu_ctlr0::int)
		sta	ppu_ctlr0_b
		and	#<~(ppu_ctlr0::int|ppu_ctlr0::bg_odd)
		sta	PPU_CTLR0
	.elseif	.defined(SMBV2)
		lda	ppu_ctlr0_b
		and	#<~(ppu_ctlr0::int|ppu_ctlr0::bg_odd)
		sta	ppu_ctlr0_b
		sta	PPU_CTLR0
	.endif

	.if	.defined(SMBV2)
		sei
		lda	nmi_sprite_overlap
		beq	:+ ; if (sprite_overlap) {
			lda	#<(SMBV2_NMI_TIMER_3_19594_MS)
			sta	FDS_TIMER_DATA_LO
			lda	#>(SMBV2_NMI_TIMER_3_19594_MS)
			sta	FDS_TIMER_DATA_HI
			lda	#fds_timer_ctlr::irq
			sta	FDS_TIMER_CTLR
			inc	fds_sprite_overlap_hit
		: ; }
	.endif

	lda	ppu_ctlr1_b
	and	#<~(ppu_ctlr1::objblk_off|ppu_ctlr1::bgblk_off|ppu_ctlr1::monotone)
	ldy	nmi_disp_disable
	bne	:+ ; if (!nmi_disp_disable) {
		lda	ppu_ctlr1_b
		ora	#(ppu_ctlr1::objblk_off|ppu_ctlr1::bgblk_off|ppu_ctlr1::objlblk_off|ppu_ctlr1::bglblk_off|ppu_ctlr1::color)
	: ; }
	sta	ppu_ctlr1_b
	and	#<~(ppu_ctlr1::objblk_off|ppu_ctlr1::bgblk_off)
	sta	PPU_CTLR1

	ldx	PPU_SR
	lda	#0
	jsr	ppu_displist_write_scc_h_v
	sta	PPU_OAM_AR
	lda	#>(oam_buffer)
	sta	OBJ_DMA

	.if	.defined(SMBV1)
		ldx	nmi_buffer_ptr
		lda	nmi_addrs_low, x
		sta	ppu_displist_write_addr
		lda	nmi_addrs_high, x
		sta	ppu_displist_write_addr+1
		jsr	ppu_displist_write
	.elseif	.defined(SMBV2)
		lda	nmi_buffer_ptr
		asl	a
		tax
		lda	nmi_addrs, x
		sta	ppu_displist_write_addr
		inx
		lda	nmi_addrs, x
		sta	ppu_displist_write_addr+1
		jsr	ppu_displist_write
	.endif

	ldy	#0
	ldx	nmi_buffer_ptr
	cpx	#nmi_addr::buffer_11_A
	bne	:+ ; if (nmi_buffer_ptr == buffer_11_A) {
		iny
	: ; }
	ldx	ppu_displist_offset, y
	lda	#nmi_addr::buffer_01_A
	sta	ppu_displist, x
	sta	ppu_displist+1, x
	sta	nmi_buffer_ptr
	lda	ppu_ctlr1_b
	sta	PPU_CTLR1

	.if	.defined(SMBV2)
		cli
	.endif

nmi_apu_call:
	jsr	apu_cycle

	.if	.defined(VS)
		jsr	sub_9324
		jsr	sub_9362
		jsr	sub_9389
	.endif

	jsr	joypad_read

	.if	.defined(CONS)
		jsr	nmi_pause
	.endif

	jsr	stats_score_hi_check
; -----------------------------
	.if	.defined(CONS)
	lda	nmi_pause_flag
	lsr	a
	bcs	:++++++ ; if (!CONS || !paused) {
	.endif
		lda	game_timer_stop
		beq	:+
		dec	game_timer_stop
		bne	:+++++
		: ; if (game_timer_stop-- <= 0) {
		nmi_timers_tick:
			ldx	#(timer_scroll-timers_nmi)-1

			dec	timer_nmi_tick
			bpl	:+ ; if (--timer_nmi_tick < 0) {
			nmi_timer_int_init:
				lda	#TIMERS_ALL_FRAME_COUNT
				sta	timer_nmi_tick
				ldx	#(timers_nmi_end-timers_nmi)-1
			: ; }

			: ; for (timer of timers) {
				lda	timers_nmi, x
				beq	:+ ; if (timers_nmi[x]) {
					dec	timers_nmi, x
				: ; }

				dex
				bpl	:--
			; }
		: ; }

		inc	frame_count
	: ; }
; -----------------------------
nmi_rand:
	ldx	#0
	ldy	#srand_end-srand

	lda	srand
	and	#%00000010
	sta	nmi_rand_buffer
	lda	srand+1
	and	#%00000010
	eor	nmi_rand_buffer
	clc
	beq	:+ ; if () {
		sec
	: ; }
	: ; for (byte of srand) {
		ror	srand, x

		inx
		dey
		bne	:-
	; }
; -----------------------------
	.if	.defined(SMBV1)
		lda	nmi_sprite_overlap
		beq	:+++++ ; if (sprite_overlap) {
			: ; while (PPU_SR & strike) {
				lda	PPU_SR
				and	#ppu_sr::strike
				bne	:-
			; }

			.if	.defined(CONS)
			lda	nmi_pause_flag
			lsr	a
			bcs	:+ ; if (!CONS || !paused) {
			.endif
				jsr	oam_init_all
				jsr	nmi_oam_shuffle
			: ; }

			: ; while (PPU_SR & strike) {
				lda	PPU_SR
				and	#ppu_sr::strike
				beq	:-
			; }

			ldy	#PPU_NMI_HBLANK_DELAY
			: ; for (y = PPU_NMI_HBLANK_DELAY; y > 0; y--) {
				dey
				bne	:-
			; }
		: ; }

		lda	ppu_scc_h_b
		sta	PPU_SCC_H_V
		lda	ppu_scc_v_b
		sta	PPU_SCC_H_V
		lda	ppu_ctlr0_b
		pha

		sta	PPU_CTLR0
	.endif

	.if	.defined(CONS)
	lda	nmi_pause_flag
	lsr	a
	bcs	:+++ ; if (!CONS || !paused) {

	.endif
		.if	.defined(SMBV2)
			lda	nmi_sprite_overlap
			beq	:+ ; if (sprite_overlap) {
				jsr	oam_init_all
				jsr	nmi_oam_shuffle
			: ; }

			lda	course_no
			cmp	#SMBV2_COURSE_NO_CUTOFF
			bcc	:+ ; if (course_no >= cutoff) {
				jsr	game_over_next_game
			: ; }
		.else
			:
			:
		.endif

		jsr	nmi_system_enter
	: ; }

	.if	.defined(SMBV2)
	: ; while (SMBV2 && fds_sprite_overlap_hit) {
		lda	fds_sprite_overlap_hit
		bne	:-
	; }
	.endif

	lda	PPU_SR

	.if	.defined(SMBV1)
		pla
	.elseif	.defined(SMBV2)
		lda	ppu_ctlr0_b
	.endif
	ora	#ppu_ctlr0::int
	.if	.defined(SMBV2)
		sta	ppu_ctlr0_b
	.endif
	sta	PPU_CTLR0

	rti
; -----------------------------------------------------------
.if	.defined(SMBV2)
	.export irq
irq:
	sei
	php
	pha
	txa
	pha
	tya
	pha

	lda	FDS_MEDIA_SR
	pha

	and	#fds_media_sr::tx_complete
	bne	:+ ; if (!fds_tx_complete) {
		pla

		and	#fds_media_sr::timer_irq
		beq	:++ ; if (fds_timer_irq) {
			lda	ppu_ctlr0_b
			and	#<~(ppu_ctlr0::obj_seg1)
			ora	ppu_ctlr0_bg
			sta	ppu_ctlr0_b
			sta	PPU_CTLR0
			lda	#0
			sta	FDS_TIMER_CTLR

			lda	ppu_scc_h_b
			sta	PPU_SCC_H_V
			lda	ppu_scc_v_b
			sta	PPU_SCC_H_V

			lda	#0
			sta	fds_sprite_overlap_hit

			jmp	:++
		; }
	: ; } else {
		pla

		jsr	fdsbios_sleep_short
	: ; }

	pla
	tay
	pla
	tax
	pla
	plp
	cli
	rti
.elseif	.defined(VS)
	.export irq
irq:
	lda	VS_SR
	bmi	:+ ; if (VS_SR & game_sub) {
		lda	#vs_req::chr_low|vs_req::irq_rel
		sta	VS_REQ
	: ; }

	pla
	pla
	pla
	rts
.endif
; -----------------------------------------------------------
.if	.defined(VS)
	.export vs_setbank_low
vs_setbank_low:
	lda	#vs_req::chr_low|vs_req::irq_rel
	sta	VS_REQ
	rts
.endif
; -----------------------------------------------------------
.if	.defined(CONS)
NMI_PAUSE_DEBOUNCE_FLAG	= %10000000
NMI_PAUSE_DEBOUNCE_VALUE	= 43

nmi_pause:
	lda	proc_id_system
	cmp	#system_modes::castle_victory
	beq	:+
	cmp	#system_modes::game
	bne	:+++++
	lda	proc_id_game
	cmp	#game_modes::proc
	bne	:+++++
	: ; if (this.proc_id == castle_victory || (this.proc_id == game && game.proc_id == proc)) {
		lda	nmi_pause_debounce
		beq	:+ ; if (debounce > 0) {
			dec	nmi_pause_debounce
			rts
		: ; } else {
			lda	joypad_p1
			and	#joypad_button::start
			beq	:+ ; if (joypad[0].start) {
				lda	nmi_pause_flag
				and	#NMI_PAUSE_DEBOUNCE_FLAG
				bne	:+++ ; if (!debounced) {
					lda	#NMI_PAUSE_DEBOUNCE_VALUE
					sta	nmi_pause_debounce
					lda	nmi_pause_flag
					tay
					iny
					sty	apu_sfx_flag_pause
					eor	#1
					ora	#NMI_PAUSE_DEBOUNCE_FLAG
					bne	:++
				; }
			: ; } else {
				lda	nmi_pause_flag
				and	#<~NMI_PAUSE_DEBOUNCE_FLAG
			: ; }

			; if (!joypad[0].start || !debounced) {
				sta	nmi_pause_flag
			; }
		; }
	: ; }

	rts
.endif
; ----------------------------
nmi_oam_shuffle_offset	= zp_byte_00

nmi_oam_shuffle:
	ldy	course_type
	lda	#$28
	sta	nmi_oam_shuffle_offset
	ldx	#$0F-1
	: ; for (x = 0xF-1; x >= 0; x--) {
		lda	obj_data_offset_player, x
		cmp	nmi_oam_shuffle_offset
		bcc	:++ ; if (player.obj_data_offset >= nmi_oam_shuffle_offset) {
			ldy	sprite_strobe_offset
			clc
			adc	sprite_strobe_amount, y
			bcc	:+ ; if ((player.obj_data_offset + strobe_amount) > 255) {
				clc
				adc	nmi_oam_shuffle_offset
			: ; }

			sta	obj_data_offset_player, x
		: ; }

		dex
		bpl	:---
	; }

	ldx	sprite_strobe_offset
	inx
	cpx	#3
	bne	:+ ; if (++sprite_strobe_offset == 3) {
		ldx	#0
	: ; }
	stx	sprite_strobe_offset

	ldx	#(3*3)-1
	ldy	#3-1
	: ; for (x = 8, y = 3-1; y >= 0; x -= 3, y--) {
		lda	obj_data_offset_actor+4, y
		sta	obj_data_offset_proj+0, x
		clc
		adc	#2*4
		sta	obj_data_offset_proj+1, x
		clc
		adc	#2*4
		sta	obj_data_offset_proj+2, x

		dex
		dex
		dex
		dey
		bpl	:-
	; }

	rts
; ------------------------------------------------------------
	.export	nmi_system_enter_tbl
	.export	nmi_system_enter_game
	.export	nmi_system_enter_castle_victory
	.export	nmi_system_enter_game_over
nmi_system_enter:
	lda	proc_id_system
	jsr	tbljmp

nmi_system_enter_tbl:
	.if	.defined(SMBV1)
		.export	nmi_system_enter_title
	nmi_system_enter_title:
		.addr	sys_title
	.elseif	.defined(SMBV2)
		.export	nmi_system_enter_disk_loader
	nmi_system_enter_disk_loader:
		.addr	sys_disk_loader
	.endif

	.if	.defined(VS_SMB)
		.export	nmi_system_enter_player_select
	nmi_system_enter_player_select:
		.addr	sys_vs_player_select
	.endif

nmi_system_enter_game:
	.addr	sys_game

nmi_system_enter_castle_victory:
	.addr	sys_castle_victory

nmi_system_enter_game_over:
	.addr	sys_game_over
