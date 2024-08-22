.include	"system/ppu.i"
.include	"system/palettes.i"

.if	.defined(FDS)
	.include	"system/fds.i"
.elseif	.defined(VS)
	.include	"system/vs.i"
.endif

.include	"engine/mem.i"
.include	"engine/joypad.i"
.include	"engine/misc.i"
.include	"engine/tunables.i"

.include	"engine/unk.i"

SMB2M_NMI_TIMER	= $1658

.if	.defined(SMB2)
	SMB2M_COURSE_NO_CUTOFF = course::no_0A
.elseif	.defined(ANN)
	SMB2M_COURSE_NO_CUTOFF = course::no_09
.endif

	.export nmi
; -----------------------------------------------------------
	.if	.defined(SMB)|.defined(VS_SMB)
		nmi_addrs_low:
			.byte	<(ppu_nmi_buffer_0_data)
			.byte	<(palette_underwater)
			.byte	<(palette_overworld)
			.byte	<(palette_underground)
			.byte	<(palette_castle)
			.byte	<(ppu_nmi_buffer_0_offset)
			.byte	<(ppu_nmi_buffer_1_data)
			.byte	<(ppu_nmi_buffer_1_data)
			.byte	<(palette_koopa)
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
			.byte	<(nmi_addr_0F)
			.byte	<(nmi_addr_10)
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
			.byte	<(nmi_addr_1C)
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
			.byte   >(ppu_nmi_buffer_0_data)
			.byte	>(palette_underwater)
			.byte	>(palette_overworld)
			.byte	>(palette_underground)
			.byte	>(palette_castle)
			.byte	>(ppu_nmi_buffer_0_offset)
			.byte	>(ppu_nmi_buffer_1_data)
			.byte	>(ppu_nmi_buffer_1_data)
			.byte	>(palette_koopa)
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
			.byte	>(nmi_addr_0F)
			.byte	>(nmi_addr_10)
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
			.byte	>(nmi_addr_1C)
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
	.elseif	.defined(SMB2M)
		nmi_addrs:
			.addr   (ppu_nmi_buffer_0_data)
			.addr	(palette_underwater)
			.addr	(palette_overworld)
			.addr	(palette_underground)
			.addr	(palette_castle)
			.addr	(data_C62B)
			.addr	(ppu_nmi_buffer_1_data)
			.addr	(ppu_nmi_buffer_1_data)
			.addr	(palette_koopa)
			.addr	(palette_snow_day)
			.addr	(palette_snow_night)
			.addr	(palette_mushroom)
			.addr	(msg_thankyou_mario)
			.addr	(msg_thankyou_toad)
			.addr	(data_C876)
			.addr	(data_C87F)
			.addr	(data_C893)
			.addr	(data_C8AB)
			.addr	(data_C8C1)
			.addr	(data_C8D7)
			.addr	(data_C8EB)
			.addr	(data_C8FC)
			.addr	(data_C913)
			.addr	(data_C92B)
			.addr	(data_C943)
			.addr	(disk_text_error_buffer)
			.addr	(disk_perror_pal)
			.addr	(data_C95C)
			.addr	(data_C511)
			.addr	(data_C97D)
			.addr	(data_C9C0)
	.endif

	.if .defined(VS_SMB)
	nmi_addr_1F:
		.byte	PPU_COLOR_YGREEN0, PPU_COLOR_PITCH1,  PPU_COLOR_PITCH1, PPU_COLOR_PITCH0
		.byte	PPU_COLOR_GREY3,   PPU_COLOR_YGREEN3, PPU_COLOR_CYAN0,  PPU_COLOR_YELLOW1

	nmi_addr_1E:
		.byte	PPU_COLOR_YGREEN0, PPU_COLOR_YELLOW1, PPU_COLOR_MAGENTA0, PPU_COLOR_PITCH0
		.byte	PPU_COLOR_GREY3,   PPU_COLOR_GREY1,   PPU_COLOR_GREY0,    PPU_COLOR_PITCH0
		.byte	PPU_COLOR_AZURE3,  PPU_COLOR_BLUE1,   PPU_COLOR_AZURE0,   PPU_COLOR_PITCH0
		.byte	PPU_COLOR_YGREEN3, PPU_COLOR_BLUE1,   PPU_COLOR_YGREEN0,  PPU_COLOR_PITCH0
		.byte	PPU_COLOR_RED3,    PPU_COLOR_ORANGE1, PPU_COLOR_GREEN0,   PPU_COLOR_PITCH0
		.byte	PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1,  PPU_COLOR_PITCH0
		.byte	PPU_COLOR_GREY3,   PPU_COLOR_ORANGE2, PPU_COLOR_YGREEN1,  PPU_COLOR_PITCH0
		.byte	PPU_COLOR_ORANGE3, PPU_COLOR_ORANGE2, PPU_COLOR_RED1,     PPU_COLOR_PITCH0
		.byte	PPU_COLOR_RED1,    PPU_COLOR_ORANGE2, PPU_COLOR_YELLOW1,  PPU_COLOR_YELLOW1
	.endif

	nmi_buffer_offset:
		.byte	<ppu_nmi_buffer_0
		.byte	<ppu_nmi_buffer_1
; ----------------------------
	.export nmi
nmi:
	.if	.defined(FDS_SMB)
		cli
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		lda     ppu_ctlr0_b
		and     #<~(ppu_ctlr0::int)
		sta     ppu_ctlr0_b
		and     #<~(ppu_ctlr0::int|ppu_ctlr0::bg_odd)
		sta     PPU_CTLR0
	.elseif	.defined(SMB2M)
		lda     ppu_ctlr0_b
		and     #<~(ppu_ctlr0::int|ppu_ctlr0::bg_odd)
		sta     ppu_ctlr0_b
		sta     PPU_CTLR0
	.endif

	.if	.defined(SMB2M)
		sei
		lda	eng_sprite_overlap
		beq	:+ ; if (eng_sprite_overlap) {
			lda	#<(SMB2M_NMI_TIMER)
			sta	FDS_TIMER_DATA_LO
			lda	#>(SMB2M_NMI_TIMER)
			sta	FDS_TIMER_DATA_HI
			lda	#fds_timer_ctlr::irq
			sta	FDS_TIMER_CTLR
			inc	byte_77B
		: ; }
	.endif

        lda     ppu_ctlr1_b
        and     #<~(ppu_ctlr1::objblk_off|ppu_ctlr1::bgblk_off|ppu_ctlr1::monotone)
        ldy     eng_disp_disable
        bne     :+ ; if (!eng_disp_disable) {
		lda     ppu_ctlr1_b
		ora     #(ppu_ctlr1::objblk_off|ppu_ctlr1::bgblk_off|ppu_ctlr1::objlblk_off|ppu_ctlr1::bglblk_off|ppu_ctlr1::color)
	: ; }
	sta     ppu_ctlr1_b
        and     #<~(ppu_ctlr1::objblk_off|ppu_ctlr1::bgblk_off)
        sta     PPU_CTLR1

        ldx     PPU_SR
        lda     #0
        jsr     eng_sta_ppu_scc_h_v
        sta     PPU_OAM_AR
        lda     #>(OAM_DMA_BUFFER)
        sta     OBJ_DMA

	.if	.defined(SMB)|.defined(VS_SMB)
		ldx     nmi_addrs_ctl
		lda     nmi_addrs_low, x
		sta     eng_screen_update_addr
		lda     nmi_addrs_high, x
		sta     eng_screen_update_addr+1
		jsr	eng_screen_update
	.elseif	.defined(SMB2M)
		lda     nmi_addrs_ctl
		asl	a
		tax
		lda     nmi_addrs, x
		sta     eng_screen_update_addr
		inx
		lda     nmi_addrs, x
		sta     eng_screen_update_addr+1
		jsr	eng_screen_update
	.endif

	ldy	#0
        ldx     nmi_addrs_ctl
        cpx     #nmi_addr::buffer_11_A
        bne     :+ ; if (nmi_addrs_ctl == buffer_11_A) {
		iny
	: ; }
	ldx     nmi_buffer_offset, y
        lda     #nmi_addr::buffer_01_A
        sta     ppu_nmi_buffer, x
        sta     ppu_nmi_buffer+1, x
        sta     nmi_addrs_ctl
        lda     ppu_ctlr1_b
        sta     PPU_CTLR1

	.if	.defined(SMB2M)
		cli
	.endif

        jsr     apu_cycle

	.if	.defined(VS)
		jsr     sub_9324
		jsr     sub_9362
		jsr     sub_9389
	.endif

	jsr     joypad_read

	.if	.defined(CONS)
		jsr	nmi_pause
	.endif

        jsr     eng_score_calc

	.if	.defined(CONS)
        lda     eng_pause_status
        lsr     a
        bcs     :++++++ ; if (!CONS || !(eng_pause_status & 0x01)) {
	.endif
		lda     eng_timer_ctl
		beq     :+
		dec     eng_timer_ctl
		bne     :+++++
		: ; if (!(eng_timer_ctl--) || !eng_timer_ctl) {
			ldx     #(timer_scroll-timers_nmi)-1

			dec     timer_nmi_tick
			bpl     :+ ; if (--timer_nmi_tick < 0) {
				.export nmi_timer_int_init
			nmi_timer_int_init:
				lda     #TIMERS_ALL_FRAME_COUNT
				sta     timer_nmi_tick
				ldx     #(timers_nmi_end-timers_nmi)-1
			: ; }

			: ; for (x; x >= 0; x--) {
				lda     timers_nmi, x
				beq     :+ ; if (timers_nmi[x]) {
					dec     timers_nmi, x
				: ; }

				dex
				bpl     :--
			; }
		: ; }

		inc     frame_count
	: ; }

	ldx     #0
        ldy     #7
        lda     eng_rand_seed
        and     #$02
        sta     zp_byte_00
        lda     eng_rand_seed+1
        and     #$02
        eor     zp_byte_00
        clc
        beq     :+ ; if () {
		sec
	: ; }
	: ; for (y = 7, x = 0; y > 0; y--, x++) {
		ror     eng_rand_seed, x
		inx

		dey
		bne     :-
	; }

	.if	.defined(SMB)|.defined(VS_SMB)
		lda     eng_sprite_overlap
		beq     :+++++ ; if (eng_sprite_overlap) {
			: ; while (PPU_SR & 0x40) {
				lda     PPU_SR
				and     #$40
				bne     :-
			; }

			.if	.defined(CONS)
			lda     eng_pause_status
			lsr     a
			bcs     :+ ; if (!CONS || !(eng_pause_status & 0x01)) {
			.endif
				jsr     oam_init_nmi
				jsr     nmi_oam_shuffle
			: ; }

			: ; while (PPU_SR & 0x40) {
				lda     PPU_SR
				and     #$40
				beq     :-
			; }

			ldy     #PPU_NMI_HBLANK_DELAY
			: ; for (y = PPU_NMI_HBLANK_DELAY; y > 0; y--) {
				dey
				bne     :-
			; }
		: ; }

		lda     eng_scc_h_b
		sta     PPU_SCC_H_V
		lda     eng_scc_v_b
		sta     PPU_SCC_H_V
		lda     ppu_ctlr0_b
		pha

		sta     PPU_CTLR0
	.endif

	.if	.defined(CONS)
	lda     eng_pause_status
	lsr     a
	bcs     :+++ ; if (!CONS && !(eng_pause_status & 0x01)) {
	.endif
		.if	.defined(SMB2M)
			lda	eng_sprite_overlap
			beq	:+ ; if (eng_sprite_overlap) {
				jsr	oam_init_nmi
				jsr	nmi_oam_shuffle
			: ; }

			lda	course_no
			cmp	#SMB2M_COURSE_NO_CUTOFF
			bcc	:+ ; if (course_no >= cutoff) {
				jsr	eng_next_game
			: ; }
		.else
			:
			:
		.endif

		jsr     nmi_gamemode_enter
	: ; }

	.if	.defined(SMB2M)
		: ; while (byte_77B) {
			lda	byte_77B
			bne	:-
		; }
	.endif

	lda     PPU_SR

	.if	.defined(SMB)|.defined(VS_SMB)
		pla
	.elseif	.defined(SMB2M)
		lda	ppu_ctlr0_b
	.endif
	ora	#ppu_ctlr0::int
	.if	.defined(SMB2M)
		sta	ppu_ctlr0_b
	.endif
        sta     PPU_CTLR0

        rti
; -----------------------------------------------------------
	.if	.defined(SMB2M)
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
				lda	eng_scc_h_b
				sta	PPU_SCC_H_V
				lda	eng_scc_v_b
				sta	PPU_SCC_H_V
				lda	#0
				sta	byte_77B

				jmp	:++
			; }
		: ; } else {
			pla

			jsr	sub_E149
		: ; }

		pla
		tay
		pla
		tax
		pla
		plp
		cli
		rti
	.elseif	.defined(VS_SMB)
		.export irq
	irq:
		lda	VS_SR
		bmi	:+ ; if (VS_SR & game_sub) {
			lda     #vs_req::chr_low|vs_req::irq_rel
			sta     VS_REQ
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
		lda     #vs_req::chr_low|vs_req::irq_rel
		sta     VS_REQ
		rts
.endif
; -----------------------------------------------------------
	.if	.defined(CONS)
	nmi_pause:
		lda     eng_game_mode
		cmp     #game_mode::victory
		beq     :+
		cmp     #game_mode::normal
		bne     :+++++
		lda     eng_gameplay_mode
		cmp     #gameplay_mode::proc
		bne     :+++++
		: ; if (game_mode == victory || (game_mode == normal && eng_gameplay_mode == proc)) {
			lda     eng_pause_ticks
			beq     :+ ; if (eng_pause_ticks) {
				dec     eng_pause_ticks
				rts
			: ; }

			lda     joypad_p1
			and     #joypad_button::start
			beq     :+ ; if (joypad1_start) {
				lda     eng_pause_status
				and     #%10000000
				bne     :+++ ; if (!(eng_pause_status & 0x80)) {
					lda     #$2B
					sta     eng_pause_ticks
					lda     eng_pause_status
					tay
					iny
					sty     apu_sfx_flag_pause
					eor     #1
					ora     #%10000000
					bne     :++
				; }
			: ; } else {
				lda     eng_pause_status
				and     #<~(%10000000)
			: ; }

			sta     eng_pause_status
		: ; }

		rts
	.endif
; ----------------------------
nmi_oam_shuffle:
	ldy	course_type
        lda     #$28
        sta     zp_byte_00
        ldx     #$0F-1
	: ; for (x = 0xF-1; x >= 0; x--) {
		lda     obj_data_offset_player, x
		cmp     zp_byte_00
		bcc     :++ ; if () {
			ldy     sprite_strobe_offset
			clc
			adc     sprite_strobe_amount, y
			bcc     :+ ; if () {
				clc
				adc     zp_byte_00
			: ; }

			sta     obj_data_offset_player, x
		: ; }

		dex
		bpl     :---
	; }

        ldx     sprite_strobe_offset
        inx
        cpx     #3
        bne     :+ ; if (++sprite_strobe_offset == 3) {
		ldx     #0
	: ; }
	stx     sprite_strobe_offset

        ldx     #(3*3)-1
        ldy     #3-1
	: ; for (x = 8, y = 3-1; y >= 0; x -= 3, y--) {
		lda     obj_data_offset_actor+4, y
		sta     obj_data_offset_proj+0, x
		clc
		adc     #8
		sta     obj_data_offset_proj+1, x
		clc
		adc     #8
		sta     obj_data_offset_proj+2, x

		dex
		dex
		dex
		dey
		bpl     :-
	; }

        rts
; ----------------------------
nmi_gamemode_enter:
	lda     eng_game_mode
        jsr     eng_farjump
	.if	.defined(SMB)|.defined(VS_SMB)
		.addr	eng_title
	.elseif	.defined(SMB2M)
		.addr	disk_loader
	.endif

	.if	.defined(VS_SMB)
		.addr	sub_941E
	.endif

	.addr	eng_game
	.addr	eng_victory
	.addr	eng_game_over
