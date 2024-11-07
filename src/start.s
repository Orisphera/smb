.include	"system/ppu.i"
.include	"system/apu.i"
.if	.defined(FDS)
	.include	"system/fds.i"
.endif
.if	.defined(VS)
	.include	"system/vs.i"
.endif

.include	"macros.i"
.include	"mem.i"
.include	"tunables.i"
.include	"misc.i"

.segment	"VECTORS"

IRQ_NULL	= $FFF0

	.addr	nmi
	.addr	start
.if	.defined(SMB)
	.addr	IRQ_NULL
.elseif	.defined(VS_SMB)|.defined(SMB2M)
	.addr	irq
.endif

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

        ldy     #RAM_CLEAR_END_COLDBOOT
        ldx     #STAT_LEN_MAX-1
	: ; for (digit of score_top) {
		lda     stats_score_top, x
		cmp     #10
		bcs     :+

		dex
		bpl     :-
	; }
	; if (CONS && isnum(game.score)) {
	.if	.defined(CONS)
		lda     game_boot_flag
		cmp     #START_WARMBOOT_FLAG
		bne     :+ ; if (game.boot_flag == START_WARMBOOT_FLAG) {
			ldy     #RAM_CLEAR_END_WARMBOOT
		; }
	.endif
	: ; }
	jsr     game_init_clearram

        sta     DMCDATA
        sta     proc_id_system

	.if	.defined(SMB2M)
		sta	disk_loader_proc

		pla
		sta	course_no
	.endif

        lda     #START_WARMBOOT_FLAG
	.if	.defined(CONS)
        	sta     game_boot_flag
	.endif
        sta     srand

        lda     #(dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1)
	sta	DMCSTATUS
	lda	#(ppu_ctlr1::objblk_on|ppu_ctlr1::bgblk_on|ppu_ctlr1::objlblk_off|ppu_ctlr1::bglblk_off|ppu_ctlr1::color)
        sta     PPU_CTLR1
        jsr     oam_init
        jsr     nt_init
        inc     nmi_disp_disable

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
		: ; for (byte of memory_page) {
			sta     VS_RAM_ARENA1, x
			sta     VS_RAM_ARENA0, x
			inx
			bne     :-
		; }

		lda     #vs_req::chr_high|vs_req::irq_rel
		sta     VS_REQ
			ppuaddr_m	vs_save_data
			lda     PPU_VRAM_IO
			ldy     #(VS_SAVEDAT-VS_RAM_ARENA0)
			: ; for (byte of vs_savedat) {
				lda     PPU_VRAM_IO
				sta     VS_RAM_ARENA0, y
	
				iny
				bne     :-
			; }
		lda     #vs_req::chr_low|vs_req::irq_rel
		sta     VS_REQ

		ldy     #STAT_LEN_MAX-1
		: ; for (digit of score_top) {
			lda     VS_SAVEDAT_SCORE, y
			sta     stats_score_top, y

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
        jsr     nmi_list_write_ctlr0

	: ; while (1) {
		.if	.defined(SMB2M)
			lda	zp_byte_00
		.endif

		jmp     :-
	; }
