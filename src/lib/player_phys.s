.include	"system/cpu.i"
.include	"system/ppu.i"

.include	"mem.i"

; ------------------------------------------------------------
player_phys_data:
	.include	"../../data/player_a_accel.s"
	.include	"../../data/player_a_friction.s"
player_phys_data_a_end:

	.include	"../../data/player_b_accel.s"
	.include	"../../data/player_b_friction.s"
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
	stx	player_proc_player_physics_friction_shift

	ldx	#17-1
	: ; for (entry of ptr) {
		lda	player_phys_data, y
		sta	player_proc_player_stats, x

		dey
		dex
		bpl	:-
	; }

	rts
; ------------------------------------------------------------
	.if	.defined(SMB2)
		.res	2, $FF
	.endif
