.include	"mem.i"
.include	"mem_low.i"
.include	"tiles.i"
.include	"const.i"

; ----------------------------------
	.export	scenery_ledge
	.export scenery_ledge_tbl
	.export scenery_ledge_tbl_tree
	.export scenery_ledge_tbl_mushroom
	.export scenery_ledge_tbl_cannon
scenery_ledge:
	lda	course_ledge_type
	jsr	tbljmp

scenery_ledge_tbl:
scenery_ledge_tbl_tree:
	.addr	scenery_ledge_tree

scenery_ledge_tbl_mushroom:
	.addr	scenery_ledge_mushroom

scenery_ledge_tbl_cannon:
	.addr	scenery_cannon
; ----------------
scenery_ledge_tree:
	jsr	scenery_attr
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
				jmp	scenery_ledge_no_base
			; }
		: ; }

		ldx	scenery_proc_metatile_id
		lda	#metatile_0::plat_b_b
		sta	scenery_metatile, x
		lda	#metatile_1::plat_b
		jmp	scenery_ledge_base
	: ; } else {
		lda	#metatile_0::plat_b_c
		jmp	scenery_ledge_no_base
	; }
; ----------------
scenery_ledge_mushroom:
	jsr	scenery_len
	sty	game_buffer
	bcc	:+ ; if (scenery_len()) {
		lda	scenery_length, x
		lsr	a
		sta	scenery_ledge_dims, x
		lda	#METATILE_PLAT_A_A
		jmp	scenery_ledge_no_base
	: ; } else {
		lda	#METATILE_PLAT_A_C
		ldy	scenery_length, x
		beq	scenery_ledge_no_base ; if (scenery_length) {
			lda	scenery_ledge_dims, x
			sta	game_buffer
			ldx	scenery_proc_metatile_id
			lda	#METATILE_PLAT_A_B
			sta	scenery_metatile, x
			.if	.defined(SMBM)|.defined(VS_SMB)
				cpy	game_buffer
				bne	scenery_pulley_rts ; if (scenery_length == tbl_736_obj) {
					inx
					lda	#metatile_1::tree_a
					sta	scenery_metatile, x
					lda	#metatile_1::tree_b
			.elseif	.defined(SMB2)
				rts
			.endif

			scenery_ledge_base:
				inx
				ldy	#15
				jmp	scenery_render
			; } else rts;
		; }
	; }

scenery_ledge_no_base:
	ldx	scenery_proc_metatile_id
	ldy	#0
	jmp	scenery_render
; ----------------------------------
scenery_pulley_tiles:
	.byte	metatile_1::pulley_c
	.byte	metatile_1::pulley_b
	.byte	metatile_1::pulley_d
; ----------------
	.export	scenery_pulley
scenery_pulley:
	jsr	scenery_len
	ldy	#0
	bcs	:+ ; if (!scenery_len()) {
		iny

		lda	scenery_length, x
		bne	:+ ; if (!scenery_length) {
			iny
		; }
	: ; }
	lda	scenery_pulley_tiles, y
	sta	scenery_metatile

scenery_pulley_rts:
	rts
