.include	"system/apu.i"

.include	"engine/mem.i"
.include	"engine/sound.i"

	.export	apu_note_decomp, apu_note_length_load
apu_note_decomp:
	tax
	ror	a
	txa
	rol	a
	rol	a
	rol	a
; --------------
apu_note_length_load:
	and	#SND_NOTE_LEN_MASK
	clc
	adc	apu_note_len_offset
	adc	snd_note_len_offset
	tay
	lda	apu_note_lengths, y
	rts
; ------------------------------------------------------------
APU_ENVELOPE_LENGTH_VICTORY_CASTLE	= 4
APU_ENVELOPE_LENGTH_UNDERWATER		= 40
APU_ENVELOPE_LENGTH_DEFAULT		= 8
; ------------------------------------------------------------
	.export	apu_next_state
apu_next_state:
	lda	snd_music_event_current
	and	#music_event::victory_castle
	beq	:+ ; if (music.event == victory_castle) {
		lda	#APU_ENVELOPE_LENGTH_VICTORY_CASTLE
		bne	:+++
	: lda	apu_music_area_current
	and	#<~(music_area::none|music_area::underwater)
	beq	:+ ; } else if (music.area.not_in(underwater)) {
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
	lda	snd_music_event_current
	and	#music_event::victory_castle
	beq	:+ ; if (music.event == castle) {
		lda	apu_victory_castle_envelope, y
		rts
	: lda	apu_music_area_current
	and	#<~(music_area::none|music_area::underwater)
	beq	:+ ; } else if (music.area.not_in(underwater)) {
		lda	apu_area_envelope, y
		rts
	: ; } else {
		lda	apu_underwater_envelope, y
		rts
	; }
