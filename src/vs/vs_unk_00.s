.include	"../../inc/engine/unk.i"

	.export vs_unk_00
vs_unk_00:
	lda	VS_RAM_ARENA0+$10
	beq	:+ ; if (VS_RAM_ARENA0[0x10]) {
		lda	#0
		sta	eng_gameplay_mode
		sta	eng_sprite_overlap
		inc	eng_game_mode
		lda	#1
		sta	eng_disp_disable
		rts
	: ; } else {
		lda	eng_gameplay_mode
		jsr	eng_farjump
		.addr	sub_82AF
		.addr	sub_9651
		.addr	sub_8748
		.addr	sub_96FF
		.addr	sub_82C3
		.addr	sub_942C
		.addr	sub_9502
		.addr	sub_953B
		.addr	sub_9588
	; }
; ----------------------------
	.export vs_unk_01
vs_unk_01:
	lda	#1
	sta	eng_disp_disable
	lda	#0
	sta	eng_sprite_overlap
	inc	eng_gameplay_mode
	rts
