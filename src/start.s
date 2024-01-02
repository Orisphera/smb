.include	"../inc/system/ppu.i"
.include	"../inc/system/apu.i"

.ifdef	FDS
.include	"../inc/system/fds.i"
.endif

.include	"../inc/engine/tunables.i"

.include	"../inc/engine/unk.i"

.segment	"VECTORS"

	.addr	nmi
	.addr	start
	.addr	irq

.code

	.export start
start:
	.ifdef	FC
		sei
	.endif

	.if	.defined(FC_SMB)|.defined(FDS_SMB)
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
	.elseif .defined(SMB2)
		lda	$FA
		and	#$F7
		sta	FDS_CTLR

		lda	$075F
		pha
	.elseif .defined(ANN)
		nop
		nop
		nop

		lda	$075F
		pha

		lda	#$27
		sta	$FA
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
        lda     eng_boot_flag
        cmp     #START_WARMBOOT_FLAG
        bne     :+ ; if (eng_score == number && eng_boot_flag == START_WARMBOOT_FLAG) {
		ldy     #START_WARMBOOT_VAL
	: ; }

	jsr     sub_clearram
        sta     DMCDATA
        sta     eng_game_mode

	.if	.defined(SMB2)|.defined(ANN)
		sta	$07FC
		pla
		sta	$075F
	.endif

        lda     #START_WARMBOOT_FLAG
        sta     eng_boot_flag
        sta     eng_rand_seed
        lda     #(dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1)
	sta	DMCSTATUS
	lda	#(ppu_ctlr1::objblk_on|ppu_ctlr1::bgblk_on|ppu_ctlr1::objlblk_off|ppu_ctlr1::bglblk_off|ppu_ctlr1::color)
        sta     PPU_CTLR1
        jsr     oam_init
        jsr     nt_init
        inc     eng_disp_disable

	.ifdef	FDS_SMB
		lda	#$27
		sta	FDS_CTLR
	.elseif	.defined(SMB2)|.defined(ANN)
		lda	#$C0
		sta	$0101
	.endif

	.ifdef	FDS
		cli
	.endif

        lda     ppu_ctlr0_b
        ora     #ppu_ctlr0::int
        jsr     eng_sta_ppu_ctlr0

start_loop:
	.if	.defined(SMB2)|.defined(ANN)
		lda	zp_byte_00
	.endif
	jmp     start_loop
