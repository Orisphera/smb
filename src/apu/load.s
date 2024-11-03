.include	"system/apu.i"

.include	"mem.i"
.include	"sound.i"

.macro	APU_LOAD_BASE
	1
.endmacro
.include	"./common/load.s"
.delmac	APU_LOAD_BASE
; ------------------------------------------------------------
APU_ENVELOPE_LENGTH_VICTORY_CASTLE	= 4
APU_ENVELOPE_LENGTH_UNDERWATER		= 40
APU_ENVELOPE_LENGTH_DEFAULT		= 8
; ------------------------------------------------------------
	.export	apu_next_state
apu_next_state:
	lda	apu_music_event_current
	and	#music_event::victory_castle
	beq	:+ ; if (music.event.current == victory_castle) {
		lda	#APU_ENVELOPE_LENGTH_VICTORY_CASTLE
		bne	:+++
	: lda	apu_music_base_current
	and	#<~(music_base::none|music_base::underwater)
	beq	:+ ; } else if (music.base.current != underwater) {
		lda	#APU_ENVELOPE_LENGTH_DEFAULT
		bne	:++
	: ; } else {
		lda	#APU_ENVELOPE_LENGTH_UNDERWATER
	: ; }

	ldx	#channel_vol::duty_500|channel_vol::envelope|2
	ldy	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
	rts
; ------------------------------------------------------------
	.export apu_next_volume
apu_next_volume:
	lda	apu_music_event_current
	and	#music_event::victory_castle
	beq	:+ ; if (music.event.current == victory_castle) {
		lda	apu_victory_castle_envelope, y
		rts
	: lda	apu_music_base_current
	and	#<~(music_base::none|music_base::underwater)
	beq	:+ ; } else if (music.base.current != underwater) {
		lda	apu_area_envelope, y
		rts
	: ; } else {
		lda	apu_underwater_envelope, y
		rts
	; }
