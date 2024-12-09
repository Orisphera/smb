.include	"system/ppu.i"
.include	"system/vs.i"

.include	"mem.i"
.include	"chr.i"
.include	"charmap.i"
.include	"joypad.i"
.include	"sound.i"

	.export vs_read_dips
vs_read_dips:
	jsr	vs_setbank_low

	lda	VS_SR
	sta	VS_RAM_ARENA0+$00
	lda	VS_SR2
	sta	VS_RAM_ARENA0+$01
	lda	VS_RAM_ARENA0+$00
	lsr	a
	lsr	a
	lsr	a
	and	#(vs_sr::dips)>>3
	sta	zp_byte_00
	lda	VS_RAM_ARENA0+$01
	and	#(vs_sr2::dips)
	ora	zp_byte_00

	ldy	#8
	: ; for (y = 8; y > 0; y--) {
		asl	a
		ror	zp_byte_01

		dey
		bne	:-
	; }

	lda	zp_byte_01
	pha
	and	#$01
	sta	VS_RAM_ARENA0+$04
	pla
	lsr	a
	pha
	and	#$01
	sta	VS_RAM_ARENA0+$03
	pla
	lsr	a
	pha
	and	#$03
	sta	VS_RAM_ARENA0+$02
	pla
	lsr	a
	lsr	a
	pha
	and	#$01
	sta	VS_RAM_ARENA0+$05
	pla
	lsr	a
	and	#$07
	sta	VS_RAM_ARENA0+$06
	rts
; -----------------------------------------------------------
vs_text_credit_count:
	.byte	(:+++)-(:+)
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_28+PPU_BG_COL_20
	.byte	(:++)-(:+)
	: .byte	"CREDIT 00"
	: .byte	NMI_LIST_END
vs_text_credit_count_end:

vs_text_free_play:
	.byte	(:+++)-(:+)
	: .dbyt	PPU_VRAM_BG1+PPU_BG_ROW_28+PPU_BG_COL_20
	.byte	(:++)-(:+)
	: .byte	"FREE PLAY"
	: .byte	NMI_LIST_END
vs_text_free_play_end:
; ----------------------------
	.export	vs_disp_credit_msg
vs_disp_credit_msg:
	jsr	vs_setbank_low

	ldx	#(vs_text_credit_count_end-vs_text_credit_count)-1
	lda	VS_RAM_ARENA0+$06
	cmp	#7
	bne	:++ ; if (vs_ram_arena0[6] == 7) {
		: ; for (x = 13; x > 0; x--) {
			lda	vs_text_free_play, x
			sta	nmi_list_0, x

			dex
			bpl	:-
		; }

		rts
	: ; } else {
		: ; for (x = 13; x > 0; x--) {
			lda	vs_text_credit_count, x
			sta	nmi_list_0, x

			dex
			bpl	:-
		; }

		lda	VS_RAM_ARENA0+$10
		: ; for (i = vs_ram_arena[16]; i > 16; i -= 16) {
			cmp	#10
			bmi	:+

			inc	nmi_list_0_data+10

			sec
			sbc	#10
			jmp	:-
		: ; }

		sta	nmi_list_0_data+11
		rts
	; }
; -----------------------------------------------------------
sub_93E7_data_0:
	.byte	1, 2, 3, 1, 1, 1, 1
	.byte	$FF

sub_93E7_data_1:
	.byte	1, 1, 1, 2, 3, 4, 5
	.byte	$FF
; -----------------------------------------------------------
	.export sub_9324
sub_9324:
	jsr	vs_setbank_low

	lda	VS_RAM_ARENA0+$08
	bne	:++ ; if (vs_ram_arena0[8] == 0 || --vs_ram_arena0[19] > 0) {
		lda	VS_RAM_ARENA0+$0C
		beq	:+ ; if (vs_ram_arena0[8] == 0 && vs_ram_arena0[12] != 0) {
			dec	VS_RAM_ARENA0+$0C
			lda	#4
			sta	VS_RAM_ARENA0+$13
			inc	VS_RAM_ARENA0+$08
			lda	#1
			sta	VS_COINS
		: ; }
		rts
	: dec	VS_RAM_ARENA0+$13
	bne	:-- ; } else {
		lda	VS_RAM_ARENA0+$08
		cmp	#1
		bne	:+ ; if (vs_ram_arena0[8] == 1) {
			lda	#0
			sta	VS_COINS
			lda	#6
			sta	VS_RAM_ARENA0+$13
			inc	VS_RAM_ARENA0+$08
			rts
		: ; } else {
			lda	#0
			sta	VS_RAM_ARENA0+$08
			rts
		; }
	; }
; -----------------------------------------------------------
	.export sub_9362
sub_9362:
	jsr	vs_setbank_low

	lda	VS_RAM_ARENA0+$09
	bne	:++ ; if (vs_ram_arena0[9] == 0 || vs_sr_svc) {
		lda	VS_SR
		and	#vs_sr::svc
		beq	:+ ; if (vs_ram_arena0[9] == 0 && !vs_sr_svc) {
			lda	#1
			sta	VS_RAM_ARENA0+$09
		: ; }
		rts
	: lda	VS_SR
	and	#vs_sr::svc
	bne	:-- ; } else {
		ldx	#2
		jsr	sub_93E7
		lda	#0
		sta	VS_RAM_ARENA0+$09
		rts
	; }
; ----------------------------
	.export sub_9389
sub_9389:
	jsr	vs_setbank_low

	lda	VS_RAM_ARENA0+$06
	cmp	#7
	bne	:+ ; if (vs_ram_arena0 == 7) {
		lda	#$20
		sta	VS_RAM_ARENA0+$10
	: ; }

	lda	VS_SR
	sta	zp_byte_00
	ldx	#0
	jsr	sub_9389_do
	ldx	#1
	lsr	zp_byte_00
; ----------------------------
sub_9389_do:
	lda	VS_RAM_ARENA0+$0A, x
	bne	:++ ; if (vs_ram_arena0[10+x] == 0) {
		lda	zp_byte_00
		and	#$20
		beq	:+ ; if (zp_byte_00 & 0x20) {
			lda	#1
			sta	VS_RAM_ARENA0+$0A, x
			lda	#$0F
			sta	VS_RAM_ARENA0+$14, x
		: ; }

		rts
	: lda	zp_byte_00
	and	#$20
	bne	:++ ; } else if (!(zp_byte_00 & 0x20)) {
		lda	VS_RAM_ARENA0+$0A, x
		cmp	#$FF
		beq	:+ ; if (vs_ram_arena0[10+x] != 0xFF) {
			jsr	sub_93E0
			inc	VS_RAM_ARENA0+$0C
		: ; }

		lda	#0
		sta	VS_RAM_ARENA0+$0A, x
		rts
	: ; } else {
		dec	VS_RAM_ARENA0+$14, x
		bne	:+ ; if (--vs_ram_arena[20] == 0) {
			lda	#$FF
			sta	VS_RAM_ARENA0+$0A, x
		: ; }

		rts
	; }
; ----------------------------
sub_93E0:
	jsr	vs_setbank_low

	lda	#sfx_pulse_2::coin_01
	sta	apu_sfx_pulse_2_req
; ----------------------------
sub_93E7:
	lda	VS_RAM_ARENA0+$06
	cmp	#7
	beq	:++ ; if (vs_ram_arena[6] == 7) {
		inc	VS_RAM_ARENA0+$0D, x
		txa
		pha
		lda	#0
		tax
		clc
		adc	VS_RAM_ARENA0+$06
		tay
		pla
		tax
		lda	sub_93E7_data_0, y
		cmp	VS_RAM_ARENA0+$0D, x
		beq	:+
		bpl	:++
		: ; if () {
			lda	#0
			sta	VS_RAM_ARENA0+$0D, x
			lda	VS_RAM_ARENA0+$10
			cmp	#$5C
			bpl	:+ ; if () {
				lda	sub_93E7_data_1, y
				clc
				adc	VS_RAM_ARENA0+$10
				sta	VS_RAM_ARENA0+$10
			; }
		; }
	: ; }
	rts
; -----------------------------------------------------------
	.export sys_vs_player_select
sys_vs_player_select:
	lda	proc_id_game
	jsr	tbljmp
	.addr	vs_player_select_init_0
	.addr	vs_player_select_scr
	.addr	vs_player_select_init_1
	.addr	vs_player_select_do
; ----------------------------
	.export vs_player_select_init_0
vs_player_select_init_0:
	lda	#screen_procs::init
	sta	screen_proc_id
	sta	nmi_sprite_overlap
	jsr	oam_init
	inc	nmi_disp_disable
	inc	proc_id_game
	rts
; ----------------------------
vs_player_select_scr:
	jsr	nt_init
	ldy	#vschar1_bg_data::player_select
	jsr	screen_vschar1_load
	lda	#0
	sta	VS_RAM_ARENA0+$27
	lda	#1
	sta	VS_RAM_ARENA0+$26
	inc	proc_id_game
	rts
; ----------------------------
vs_player_select_init_1:
	inc	proc_id_game

vs_player_select_init_1_do:
	lda	VS_RAM_ARENA0+$10
	cmp	#1
	beq	:+ ; if (vs_ram_arena0[16] != 1) {
		lda	#nmi_addr::addr_1F
		sta	nmi_buffer_ptr
	: ; }

	rts
; ----------------------------
vs_player_select_do_data_0:
	.byte	$0A, $05

vs_player_select_do_text_push:
	.dbyt	PPU_VRAM_BG1+PPU_BG_ROW_7+PPU_BG_COL_10
	.byte	vs_player_select_do_text_push_end-vs_player_select_do_text_push_start
vs_player_select_do_text_push_start:
	.byte	"PUSH BUTTON"
vs_player_select_do_text_push_end:
	.byte	NMI_LIST_END
vs_player_select_do_text_push_def_end:

vs_player_select_do_text_empty:
	.dbyt	PPU_VRAM_BG1+$EA
	.byte	NMI_REPEAT|(vs_player_select_do_text_push_end-vs_player_select_do_text_push_start), " "
	.byte	NMI_LIST_END
vs_player_select_do_text_empty_def_end:
; ----------------------------
vs_player_select_do:
	jsr	vs_setbank_low

	lda	#0
	sta	nmi_disp_disable

	lda	joypad_p1
	and	#joypad_button::select
	beq	:+
	lda	#0
	jmp	:++
	: lda	joypad_p2
	and	#joypad_button::select
	beq	:++
	lda	VS_RAM_ARENA0+$10
	cmp	#1
	beq	:++ ; if ((joypad[0].select || joypad[1].select) && vs_ram_arena0[16] != 1) {
		; if (!joypad[0].select) {
			dec	VS_RAM_ARENA0+$10
			lda	#1
		: ; }
		sta	player_count
		lda	#0
		sta	VS_RAM_ARENA0+$28
		sta	VS_RAM_ARENA0+$29
		dec	VS_RAM_ARENA0+$10
		jsr	game_init_ram
		jsr	game_init_setup
		lda	joypad_p1
		jmp	title_exit
	: ; } else {
		lda	frame_count
		and	#1
		beq	:+++++ ; if (frame_count % 1) {
			jsr	vs_disp_credit_msg
			dec	VS_RAM_ARENA0+$26
			bne	:++++ ; if (--vs_ram_arena0[38] == 0) {
				ldx	VS_RAM_ARENA0+$27
				lda	vs_player_select_do_data_0, x
				sta	VS_RAM_ARENA0+$26

				ldx	#0
				ldy	nmi_list_0_offset
				lda	VS_RAM_ARENA0+$27
				bne	:++ ; if () {
					: ; for (x = 0, y = ppu_nmi_count; x < 16; x++, y++) {
						lda	vs_player_select_do_text_push, x
						sta	nmi_list_0_data+0, y

						iny
						inx
						cpx	#(vs_player_select_do_text_push_def_end-vs_player_select_do_text_push)+1
						bne	:-
					; }
					beq	:++
				; } else {
					: ; for (x = 0, y = ppu_nmi_count; x < 5; x++, y++) {
						lda	vs_player_select_do_text_empty, x
						sta	nmi_list_0_data+0, y

						iny
						inx
						cpx	#(vs_player_select_do_text_empty_def_end-vs_player_select_do_text_empty)
						bne	:-
					; }
				: ; }

				lda	#1
				eor	VS_RAM_ARENA0+$27
				sta	VS_RAM_ARENA0+$27
			: ; }

			rts
		: ; } else {
			jmp	vs_player_select_init_1_do
		; }
	; }
; -----------------------------------------------------------
	.export vs_title_ppu_init
vs_title_ppu_init:
	jsr	oam_init
	jsr	nt_init
	lda	#$FF
	sta	VS_RAM_ARENA0+$16
	lda	#nmi_addr::pal_overworld
	sta	nmi_buffer_ptr
	lda	#0
	sta	VS_RAM_ARENA0+$22
	inc	proc_id_game
	rts
; -----------------------------------------------------------
vs_super_players_oam:
	.byte	$20, chr_obj::player_walk_small, obj_attr::color0, $30
	.byte	$20, chr_obj::player_jump_small+0, obj_attr::color0, $38
	.byte	$28, chr_obj::player_jump_small+1, obj_attr::color0, $30
	.byte	$28, chr_obj::player_jump_small+2, obj_attr::color0, $38

	.byte	$20, chr_obj::player_jump_small+0, obj_attr::h_flip|obj_attr::color1, $C0
	.byte	$20, chr_obj::player_walk_small, obj_attr::h_flip|obj_attr::color1, $C8
	.byte	$28, chr_obj::player_jump_small+2, obj_attr::h_flip|obj_attr::color1, $C0
	.byte	$28, chr_obj::player_jump_small+1, obj_attr::h_flip|obj_attr::color1, $C8
vs_super_players_oam_end:
; ----------------------------
	.export vs_title_super_players
vs_title_super_players:
	lda	VS_RAM_ARENA0+$22
	bne	:+ ; if (vs_ram_arena0[34].in(0, 1)) {
		; if (vs_ram_arena0[34] == 0) {
			lda	#nmi_addr::addr_1E_F
			sta	nmi_buffer_ptr
			jmp	:++
		: cmp	#1
		bne	:++ ; } else {
			ldy	#vschar1_bg_data::super_players
			jsr	screen_vschar1_load
		: ; }

		inc	VS_RAM_ARENA0+$22
		rts
	: ; } else {
		ldx	#0
		stx	zp_byte_04
		: ; for (i = 0; i < 10; i++) {
			lda	zp_byte_04
			cmp	#10
			beq	:+

			jsr	sub_9D62
			jmp	:-
		: ; }

		lda	#0
		sta	VS_RAM, x
		lda	#nmi_addr::addr_1D_B
		sta	nmi_buffer_ptr

		ldy	#(vs_super_players_oam_end-vs_super_players_oam)-1
		: ; for (entry of vs_super_players_oam) {
			lda	vs_super_players_oam, y
			sta	OAM_DMA_BUFFER, y

			dey
			bpl	:-
		; }

		lda	VS_RAM_ARENA0+$17
		cmp	#6
		bne	:+ ; if (vs_ram_arena0[23] == 6) {
			jmp	sub_9DF7
		: ; } else {
			inc	proc_id_game
			rts
		; }
	; }
; -----------------------------------------------------------
	.export vs_title_tick
vs_title_tick:
	lda	#0
	sta	nmi_disp_disable

	lda	frame_count
	and	#1
	bne	:+
	dec	VS_RAM_ARENA0+$16
	bne	:+ ; if (!(frame_count % 1) && --vs_ram_arena0[22] != 0) {
		jmp	title_recycle
	: ; } else {
		rts
	; }
