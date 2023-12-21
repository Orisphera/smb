.include	"../inc/system/ppu.i"

.include	"../inc/engine/joypad.i"
.include	"../inc/engine/misc.i"
.include	"../inc/engine/tunables.i"

.include	"../inc/engine/unk.i"

	.export nmi
; -----------------------------------------------------------
	nmi_buffer_0	= (ppu_nmi_buffer+$00)
	nmi_buffer_1	= (ppu_nmi_buffer+$40)
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

nmi_buffer_offset:
	.byte	<nmi_buffer_0
	.byte	<nmi_buffer_1
; ----------------------------
nmi:
        lda     ppu_ctlr0_b
        and     #<~(ppu_ctlr0::int)
        sta     ppu_ctlr0_b
        and     #<~(ppu_ctlr0::int|ppu_ctlr0::bg_odd)
        sta     PPU_CTLR0

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

        ldx     nmi_addrs_ctl
        lda     nmi_addrs_low,x
        sta     eng_screen_update_addr
        lda     nmi_addrs_high,x
        sta     eng_screen_update_addr+1
	jsr	eng_screen_update

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
        jsr     apu_cycle
        jsr     joypad_read
        jsr     nmi_pause
        jsr     eng_score_calc

        lda     eng_pause_status
        lsr     a
        bcs     :++++++ ; if (!(eng_pause_status & 0x01)) {
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

        lda     eng_sprite_overlap
        beq     :+++++ ; if (eng_sprite_overlap) {
		: ; while (PPU_SR & 0x40) {
			lda     PPU_SR
			and     #$40
			bne     :-
		; }

		lda     eng_pause_status
		lsr     a
		bcs     :+ ; if (!(eng_pause_status & 0x01)) {
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
        lda     eng_pause_status
        lsr     a
        bcs     :+ ; if (!(eng_pause_status & 0x01)) {
		jsr     nmi_gamemode_enter
	: ; }

	lda     PPU_SR
        pla
        ora     #ppu_ctlr0::int
        sta     PPU_CTLR0
        rti
; ----------------------------
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
			and     #$7F
		: ; }

		sta     eng_pause_status
	: ; }

	rts
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
	.addr	eng_victory
	.addr	eng_game_over
