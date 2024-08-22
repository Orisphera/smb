.include	"system/cpu.i"
.include	"system/ppu.i"

.include	"engine/mem.i"

; ------------------------------------------------------------
player_phys_data:
	.byte	$20, $20, $1E, $28, $28
	.byte	$0D, $04

	.byte	$70, $70, $60, $90, $90
	.byte	$0A, $09

	.byte	$E4, $98, $D0
player_phys_data_a_end:

	.byte	$18, $18, $18, $22, $22
	.byte	$0D, $04

	.byte	$42, $42, $3E, $5D, $5D
	.byte	$0A, $09

	.byte	$B4, $68, $A0
player_phys_data_b_end:
; -----------------------------
	.export player_phys_load, player_phys_load_default
player_phys_load:
	ldx	#RTS_OPCODE
	ldy	#(player_phys_data_b_end-player_phys_data)-1
	lda	player_id
	bne	:+ ; if (player_id == 0) {
	player_phys_load_default:
		ldx	#ASL_ABS_OPCODE
		ldy	#(player_phys_data_a_end-player_phys_data)-1
	: ; }
	stx	game_proc_player_physics_friction_shift

	ldx	#17-1
	: ; for (entry of ptr) {
		lda	player_phys_data, y
		sta	game_proc_player_stats, x

		dey
		dex
		bpl	:-
	; }

	rts
; ------------------------------------------------------------
	.if	.defined(SMB2)
		.res	2, $FF
	.endif
