.include	"mem.i"
.include	"tiles.i"
.include	"tunables.i"

; -----------------------------
	.export	bg_scenery_ledge
	.export bg_scenery_ledge_tbl
	.export bg_scenery_ledge_tbl_tree
	.export bg_scenery_ledge_tbl_mushroom
	.export bg_scenery_ledge_tbl_cannon
bg_scenery_ledge:
	lda	course_ledge_type
	jsr	tbljmp

bg_scenery_ledge_tbl:
bg_scenery_ledge_tbl_tree:
	.addr	bg_scenery_ledge_tree

bg_scenery_ledge_tbl_mushroom:
	.addr	bg_scenery_ledge_mushroom

bg_scenery_ledge_tbl_cannon:
	.addr	bg_scenery_cannon
; --------------
bg_scenery_ledge_tree:
	jsr	bg_scenery_attr
	lda	scenery_length, x
	beq	:++	
	bpl	:+ ; if (scenery_length) {
		; if (scenery_length_bit_7) {
			tya
			sta	scenery_length, x
			lda	pos_x_hi_game
			ora	pos_x_lo_game
			beq	:+ ; if (game.pos_x > 0) {
				lda	#metatile_0::plat_b_a
				jmp	bg_scenery_ledge_no_base
			; }
		: ; }

		ldx	bg_proc_metatile_id
		lda	#metatile_0::plat_b_b
		sta	gfx_metatile, x
		lda	#metatile_1::plat_b
		jmp	bg_scenery_ledge_base
	: ; } else {
		lda	#metatile_0::plat_b_c
		jmp	bg_scenery_ledge_no_base
	; }
; --------------
bg_scenery_ledge_mushroom:
	jsr	bg_scenery_len
	sty	game_buffer
	bcc	:+ ; if (bg_scenery_len()) {
		lda	scenery_length, x
		lsr	a
		sta	scenery_ledge_dims, x
		lda	#METATILE_PLAT_A_A
		jmp	bg_scenery_ledge_no_base
	: ; } else {
		lda	#METATILE_PLAT_A_C
		ldy	scenery_length, x
		beq	bg_scenery_ledge_no_base ; if (scenery_length) {
			lda	scenery_ledge_dims, x
			sta	game_buffer
			ldx	bg_proc_metatile_id
			lda	#METATILE_PLAT_A_B
			sta	gfx_metatile, x
			.if	.defined(SMBM)|.defined(VS_SMB)
				cpy	game_buffer
				bne	bg_scenery_pulley_rts ; if (scenery_length == tbl_736_obj) {
					inx
					lda	#metatile_1::tree_a
					sta	gfx_metatile, x
					lda	#metatile_1::tree_b
			.elseif	.defined(SMB2)
				rts
			.endif

			bg_scenery_ledge_base:
				inx
				ldy	#15
				jmp	bg_scenery_render
			; } else rts;
		; }
	; }

bg_scenery_ledge_no_base:
	ldx	bg_proc_metatile_id
	ldy	#0
	jmp	bg_scenery_render
; -----------------------------
bg_scenery_pulley_tiles:
	.byte	metatile_1::pulley_c
	.byte	metatile_1::pulley_b
	.byte	metatile_1::pulley_d
; --------------
	.export	bg_scenery_pulley
bg_scenery_pulley:
	jsr	bg_scenery_len
	ldy	#0
	bcs	:+ ; if (!bg_scenery_len()) {
		iny

		lda	scenery_length, x
		bne	:+ ; if (!scenery_length) {
			iny
		; }
	: ; }
	lda	bg_scenery_pulley_tiles, y
	sta	gfx_metatile

bg_scenery_pulley_rts:
	rts
