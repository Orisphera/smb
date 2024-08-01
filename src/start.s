.include	"system/ppu.i"
.include	"system/apu.i"

.if	.defined(FDS)
	.include	"system/fds.i"
.elseif	.defined(VS)
	.include	"system/vs.i"
.endif

.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

.segment	"VECTORS"

	.addr	nmi
	.addr	start
	.addr	irq

.code

	.export start
start:
	.if	.defined(FC)|.defined(VS)
		sei
	.endif

	.if	.defined(SMB)|.defined(VS_SMB)
		cld
		lda     #(ppu_ctlr0::sprite_8|ppu_ctlr0::bg_seg1|ppu_ctlr0::obj_seg0|ppu_ctlr0::inc_1|ppu_ctlr0::bg1)
		sta     PPU_CTLR0
		ldx     #$FF
		txs
		: ; while (!vblank) {
			lda     PPU_SR
			bpl     :-
		; }
		: ; while (!vblank) {
			lda     PPU_SR
			bpl     :-
		; }
	.endif

	.if	.defined(SMB2)
		lda	fds_ctlr_b
		and	#<~(fds_ctlr::mirror_h)
		sta	FDS_CTLR
	.elseif	.defined(ANN)
		nop
		nop
		nop
	.endif

	.if	.defined(SMB2M)
		lda	course_no
		pha
	.endif

	.if	.defined(ANN)
		lda	#(fds_ctlr::mask|fds_ctlr::io_mode_r|fds_ctlr::transfer_reset|fds_ctlr::motor_on)
		sta	fds_ctlr_b
		sta	FDS_CTLR
	.endif

        ldy     #START_COLDBOOT_VAL
        ldx     #(eng_score_end-eng_score)-1
	: ; for (digit of eng_score) {
		lda     eng_score, x
		cmp     #10
		bcs     :+

		dex
		bpl     :-
	; }

	; if (eng_score == number) {
	.if	.defined(CONS)
		lda     eng_boot_flag
		cmp     #START_WARMBOOT_FLAG
		bne     :+ ; if (eng_boot_flag == START_WARMBOOT_FLAG) {
			ldy     #START_WARMBOOT_VAL
		; }
	.endif
	: ; }

	jsr     sub_clearram
        sta     DMCDATA
        sta     eng_game_mode

	.if	.defined(SMB2M)
		sta	byte_7FC
		pla
		sta	course_no
	.endif

        lda     #START_WARMBOOT_FLAG
	.if	.defined(CONS)
        	sta     eng_boot_flag
	.endif
        sta     eng_rand_seed

        lda     #(dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1)
	sta	DMCSTATUS
	lda	#(ppu_ctlr1::objblk_on|ppu_ctlr1::bgblk_on|ppu_ctlr1::objlblk_off|ppu_ctlr1::bglblk_off|ppu_ctlr1::color)
        sta     PPU_CTLR1
        jsr     oam_init
        jsr     nt_init
        inc     eng_disp_disable

	.if	.defined(FDS_SMB)
		lda	#(fds_ctlr::mask|fds_ctlr::io_mode_r|fds_ctlr::transfer_reset|fds_ctlr::motor_on)
		sta	FDS_CTLR
	.elseif	.defined(SMB2M)
		lda	#fds_irqmode::game_vec
		sta	FDS_STACK_IRQMODE
	.elseif	.defined(VS_SMB)
		jsr     vs_setbank_low
		lda     #0
		ldx     #0
		: ; for (x = 0; x < 0x100, x++) {
			sta     VS_RAM_ARENA1, x
			sta     VS_RAM_ARENA0, x
			inx
			bne     :-
		; }

		lda     #vs_req::chr_high|vs_req::irq_rel
		sta     VS_REQ
		lda     #>(VS_SAVEDAT_ADDR)
		sta     PPU_VRAM_AR
		lda     #<(VS_SAVEDAT_ADDR)
		sta     PPU_VRAM_AR
		lda     PPU_VRAM_IO
		ldy     #(VS_SAVEDAT-VS_RAM_ARENA0)
		: ; for (y = 0x74; y < 0x100, y++) {
			lda     PPU_VRAM_IO
			sta     VS_RAM_ARENA0, y

			iny
			bne     :-
		; }

		lda     #vs_req::chr_low|vs_req::irq_rel
		sta     VS_REQ
		ldy     #(eng_score_end-eng_score)-1
		: ; for (byte of score) {
			lda     VS_SAVEDAT_SCORE, y
			sta     eng_score, y

			dey
			bpl     :-
		; }

		jsr     vs_read_dips
	.endif

	.if	.defined(FDS)
		cli
	.endif

        lda     ppu_ctlr0_b
        ora     #ppu_ctlr0::int
        jsr     eng_sta_ppu_ctlr0

start_loop:
	.if	.defined(SMB2M)
		lda	zp_byte_00
	.endif
	jmp     start_loop
