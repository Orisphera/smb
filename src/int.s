.include	"../inc/system/ppu.i"

.if	.defined(FDS)
	.include	"../inc/system/fds.i"
.elseif	.defined(VS)
	.include	"../inc/system/vs.i"
.endif

.include	"../inc/engine/joypad.i"
.include	"../inc/engine/misc.i"
.include	"../inc/engine/tunables.i"

.include	"../inc/engine/unk.i"

SMB2M_NMI_TIMER	= $1658

.if	.defined(SMB2)
	SMB2M_COURSE_NO_CUTOFF = course::no_0A
.elseif	.defined(ANN)
	SMB2M_COURSE_NO_CUTOFF = course::no_09
.endif

	.export nmi
; -----------------------------------------------------------
	nmi_buffer_0	= (ppu_nmi_buffer+$00)
	nmi_buffer_1	= (ppu_nmi_buffer+$40)

	.if	.defined(SMB)
		nmi_addrs_low:
			.byte	<(nmi_buffer_0+1)
			.byte	<(palette_underwater)
			.byte	<(palette_day)
			.byte	<(palette_underground)
			.byte	<(palette_castle)
			.byte	<(nmi_buffer_0+0)
			.byte	<(nmi_buffer_1+1)
			.byte	<(nmi_buffer_1+1)
			.byte	<(palette_bowser)
			.byte	<(palette_day_snow)
			.byte	<(palette_night_snow)
			.byte	<(palette_mushroom)
			.byte	<(msg_thankyou_mario)
			.byte	<(msg_thankyou_luigi)
			.byte	<(msg_thankyou_toad)
			.byte	<(msg_thankyou_princess1)
			.byte	<(msg_thankyou_princess2)
			.byte	<(msg_worldsel_1)
			.byte	<(msg_worldsel_2)

		nmi_addrs_high:
			.byte   >(nmi_buffer_0+1)
			.byte	>(palette_underwater)
			.byte	>(palette_day)
			.byte	>(palette_underground)
			.byte	>(palette_castle)
			.byte	>(nmi_buffer_0+0)
			.byte	>(nmi_buffer_1+1)
			.byte	>(nmi_buffer_1+1)
			.byte	>(palette_bowser)
			.byte	>(palette_day_snow)
			.byte	>(palette_night_snow)
			.byte	>(palette_mushroom)
			.byte	>(msg_thankyou_mario)
			.byte	>(msg_thankyou_luigi)
			.byte	>(msg_thankyou_toad)
			.byte	>(msg_thankyou_princess1)
			.byte	>(msg_thankyou_princess2)
			.byte	>(msg_worldsel_1)
			.byte	>(msg_worldsel_2)
	.elseif	.defined(SMB2M)
		nmi_addrs:
			.addr   (nmi_buffer_0+1)
			.addr	(palette_underwater)
			.addr	(palette_day)
			.addr	(palette_underground)
			.addr	(palette_castle)
			.addr	(data_C62B)
			.addr	(nmi_buffer_1+1)
			.addr	(nmi_buffer_1+1)
			.addr	(data_6C35)
			.addr	(data_6C1D)
			.addr	(data_6C25)
			.addr	(data_6C2D)
			.addr	(data_6C3D)
			.addr	(data_6C51)
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
			.addr	(data_C149)
			.addr	(data_C10B)
			.addr	(data_C95C)
			.addr	(data_C511)
			.addr	(data_C97D)
			.addr	(data_C9C0)
	.elseif .defined(VS_SMB)
		nmi_addrs_low:
			.byte	<(nmi_buffer_0+1)
			.byte	<(palette_underwater)
			.byte	<(palette_day)
			.byte	<(palette_underground)
			.byte	<(palette_castle)
			.byte	<(nmi_buffer_0+0)
			.byte	<(nmi_buffer_1+1)
			.byte	<(nmi_buffer_1+1)
			.byte	<(nmi_addr_08)
			.byte	<(nmi_addr_09)
			.byte	<(nmi_addr_0A)
			.byte	<(nmi_addr_0B)
			.byte	<(nmi_addr_0C)
			.byte	<(nmi_addr_0D)
			.byte	<(nmi_addr_0E)
			.byte	<(nmi_addr_0F)
			.byte	<(nmi_addr_10)
			.byte	<(nmi_addr_11)
			.byte	<(nmi_addr_12)
			.byte	<(nmi_addr_13)
			.byte	<(nmi_addr_14)
			.byte	<(nmi_addr_15)
			.byte	<(nmi_addr_16)
			.byte	<(nmi_addr_17)
			.byte	<(nmi_addr_18)
			.byte	<(nmi_addr_19)
			.byte	<(nmi_addr_1A)
			.byte	<(nmi_addr_1B)
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

		nmi_addrs_high:
			.byte	>(nmi_buffer_0+1)
			.byte	>(palette_underwater)
			.byte	>(palette_day)
			.byte	>(palette_underground)
			.byte	>(palette_castle)
			.byte	>(nmi_buffer_0+0)
			.byte	>(nmi_buffer_1+1)
			.byte	>(nmi_buffer_1+1)
			.byte	>(nmi_addr_08)
			.byte	>(nmi_addr_09)
			.byte	>(nmi_addr_0A)
			.byte	>(nmi_addr_0B)
			.byte	>(nmi_addr_0C)
			.byte	>(nmi_addr_0D)
			.byte	>(nmi_addr_0E)
			.byte	>(nmi_addr_0F)
			.byte	>(nmi_addr_10)
			.byte	>(nmi_addr_11)
			.byte	>(nmi_addr_12)
			.byte	>(nmi_addr_13)
			.byte	>(nmi_addr_14)
			.byte	>(nmi_addr_15)
			.byte	>(nmi_addr_16)
			.byte	>(nmi_addr_17)
			.byte	>(nmi_addr_18)
			.byte	>(nmi_addr_19)
			.byte	>(nmi_addr_1A)
			.byte	>(nmi_addr_1B)
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

		nmi_addr_1F:
			.byte	PPU_COLOR_LEV3|PPU_COLOR_PITCH, PPU_COLOR_LEV0|PPU_COLOR_MAGENTA, PPU_COLOR_LEV0|PPU_COLOR_MAGENTA, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV3|PPU_COLOR_RED, PPU_COLOR_LEV0|PPU_COLOR_GREEN, PPU_COLOR_LEV2|PPU_COLOR_YELLOW, PPU_COLOR_LEV0|PPU_COLOR_GREY

		nmi_addr_1E:
			.byte	PPU_COLOR_LEV3|PPU_COLOR_PITCH, PPU_COLOR_LEV0|PPU_COLOR_GREY, PPU_COLOR_LEV2|PPU_COLOR_GREY, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV3|PPU_COLOR_RED, PPU_COLOR_LEV0|PPU_COLOR_YELLOW, PPU_COLOR_LEV2|PPU_COLOR_RED, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV3|PPU_COLOR_BLACK, PPU_COLOR_LEV1|PPU_COLOR_BLUE, PPU_COLOR_LEV0|PPU_COLOR_RED, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV0|PPU_COLOR_GREEN, PPU_COLOR_LEV1|PPU_COLOR_BLUE, PPU_COLOR_LEV3|PPU_COLOR_PITCH, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV0|PPU_COLOR_CYAN, PPU_COLOR_LEV0|PPU_COLOR_ORANGE, PPU_COLOR_LEV3|PPU_COLOR_BLUE, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV3|PPU_COLOR_VIOLET, PPU_COLOR_LEV3|PPU_COLOR_YGREEN, PPU_COLOR_LEV0|PPU_COLOR_GREY, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV3|PPU_COLOR_RED, PPU_COLOR_LEV3|PPU_COLOR_YGREEN, PPU_COLOR_LEV1|PPU_COLOR_SPRING, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV0|PPU_COLOR_VSBLACK, PPU_COLOR_LEV3|PPU_COLOR_YGREEN, PPU_COLOR_LEV3|PPU_COLOR_VIOLET, PPU_COLOR_LEV1|PPU_COLOR_MAGENTA
			.byte	PPU_COLOR_LEV3|PPU_COLOR_VIOLET, PPU_COLOR_LEV3|PPU_COLOR_YGREEN, PPU_COLOR_LEV0|PPU_COLOR_GREY, PPU_COLOR_LEV0|PPU_COLOR_GREY
	.endif

	nmi_buffer_offset:
		.byte	<nmi_buffer_0
		.byte	<nmi_buffer_1
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
		lda     nmi_addrs_low,x
		sta     eng_screen_update_addr
		lda     nmi_addrs_high,x
		sta     eng_screen_update_addr+1
		jsr	eng_screen_update
	.elseif	.defined(SMB2M)
		lda     nmi_addrs_ctl
		asl	a
		tax
		lda     nmi_addrs,x
		sta     eng_screen_update_addr
		inx
		lda     nmi_addrs,x
		sta     eng_screen_update_addr+1
		jsr	eng_screen_update
	.endif

	ldy	#0
        ldx     nmi_addrs_ctl
        cpx     #6
        bne     :+ ; if (nmi_addrs_ctl == 6) {
		iny
	: ; }
	ldx     nmi_buffer_offset,y
        lda     #0
        sta     ppu_nmi_buffer,x
        sta     ppu_nmi_buffer+1,x
        sta     nmi_addrs_ctl
        lda     ppu_ctlr1_b
        sta     PPU_CTLR1

	.if	.defined(SMB2M)
		cli
	.endif

        jsr     apu_cycle

	.if	.defined(CONS)
		jsr     joypad_read
		jsr     nmi_pause
	.elseif	.defined(VS)
		jsr     sub_9324
		jsr     sub_9362
		jsr     sub_9389
		jsr     sub_9113
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
			ldx     #$14

			dec     eng_timer_int
			bpl     :+ ; if (--eng_timer_int < 0) {
				lda     #$14
				sta     eng_timer_int
				ldx     #$23
			: ; }

			: ; for (x; x >= 0; x--) {
				lda     eng_timers_nmi,x
				beq     :+ ; if (eng_timers_nmi[x]) {
					dec     eng_timers_nmi,x
				: ; }

				dex
				bpl     :--
			; }
		: ; }

		inc     eng_frame_count
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

		.if	.defined(CONS)
		lda     eng_pause_status
		lsr     a
		bcs     :+ ; if (!CONS || !(eng_pause_status & 0x01)) {
		.endif
			jsr     nmi_gamemode_enter
		: ; }

		lda     PPU_SR
		pla
        	ora     #ppu_ctlr0::int
	.elseif .defined(SMB2M)
		.if	.defined(CONS)
		lda     eng_pause_status
		lsr	a
		bcs	:+++ ; if (!(eng_pause_status & 0x01)) {
		.endif
			lda	eng_sprite_overlap
			beq	:+ ; if (eng_sprite_overlap) {
				jsr	oam_init_nmi
				jsr	nmi_oam_shuffle
			: ; }

			lda	eng_course_no
			cmp	#SMB2M_COURSE_NO_CUTOFF
			bcc	:+ ; if (eng_course_no >= cutoff) {
				jsr	sub_708D
			: ; }

			jsr	nmi_gamemode_enter
		: ; }

		: ; while (byte_77B) {
			lda	byte_77B
			bne	:-
		; }

		lda	PPU_SR
		lda	ppu_ctlr0_b
		ora	#ppu_ctlr0::int
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
				ora	byte_77A
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
		.if	.defined(SMB)
			cmp     #gameplay_mode::proc
		.elseif	.defined(SMB2)
			cmp	#gameplay_mode::mode_4
		.elseif	.defined(ANN)
			cmp	#gameplay_mode::mode_5
		.endif
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
				and     #$80
				bne     :+++ ; if (!(eng_pause_status & 0x80)) {
					lda     #$2B
					sta     eng_pause_ticks
					lda     eng_pause_status
					tay
					iny
					sty     apu_sfx_flag_pause
					eor     #$01
					ora     #$80
					bne     :++
				; }
			: ; } else {
				lda     eng_pause_status
				and     #<~($80)
			: ; }

			sta     eng_pause_status
		: ; }

		rts
	.endif
; ----------------------------
nmi_oam_shuffle:
	ldy     eng_area_type
        lda     #$28
        sta     zp_byte_00
        ldx     #$0F-1
	: ; for (x = 0xF-1; x >= 0; x--) {
		lda     tbl_6E4, x
		cmp     zp_byte_00
		bcc     :++ ; if () {
			ldy     byte_6E0
			clc
			adc     tbl_6E1, y
			bcc     :+ ; if () {
				clc
				adc     zp_byte_00
			: ; }

			sta     tbl_6E4, x
		: ; }

		dex
		bpl     :---
	; }

        ldx     byte_6E0
        inx
        cpx     #3
        bne     :+ ; if (++byte_6E0 == 3) {
		ldx     #0
	: ; }
	stx     byte_6E0

        ldx     #(3*3)-1
        ldy     #3-1
	: ; for (x = 8, y = 3-1; y >= 0; x -= 3, y--) {
		lda     tbl_6E9, y
		sta     tbl_6F1+0, x
		clc
		adc     #8
		sta     tbl_6F1+1, x
		clc
		adc     #8
		sta     tbl_6F1+2, x

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
	.addr	eng_title
	.addr	eng_game
	.if	.defined(VS_SMB)
		.addr	sub_AD50
	.endif
	.addr	eng_victory
	.addr	eng_game_over
