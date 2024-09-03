.include	"system/apu.i"

.include	"engine/sound.i"
; ------------------------------------------------------------
	.export	apu_write_base_pulse_1
	.export	apu_write_pulse_1
	.export	apu_write_note_pulse_1
apu_write_base_pulse_1:
	sty	PULSE1_SWEEP
	stx	PULSE1_VOL
	rts
; --------------
apu_write_pulse_1:
	jsr	apu_write_base_pulse_1
; --------------
apu_write_note_pulse_1:
	ldx	#CHANNEL_PULSE1*CHANNEL_SIZE
; ------------------------------------------------------------
apu_write_note:
	tay
	lda	apu_notes+1, y
	beq	:+ ; if (apu_notes[a] != 0) {
		sta	CHANNEL_TIMER, x
		lda	apu_notes, y
		ora	#channel_counter::length_254
		sta	CHANNEL_COUNTER, x
	: ; }

	rts
; ------------------------------------------------------------
	.export	apu_write_base_pulse_2
	.export	apu_write_pulse_2
	.export	apu_write_note_pulse_2
apu_write_base_pulse_2:
	stx	PULSE2_VOL
	sty	PULSE2_SWEEP
	rts
; --------------
	.export	apu_write_pulse_2
apu_write_pulse_2:
	jsr	apu_write_base_pulse_2
; --------------
	.export	apu_write_note_pulse_2
apu_write_note_pulse_2:
	ldx	#CHANNEL_PULSE2*CHANNEL_SIZE
	bne	apu_write_note
; ------------------------------------------------------------
	.export	apu_write_note_triangle
apu_write_note_triangle:
	ldx	#CHANNEL_TRIANGLE*CHANNEL_SIZE
	bne	apu_write_note
