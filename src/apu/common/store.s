.include	"system/apu.i"

.include	"sound.i"

.if	.definedmacro(APU_STORE_FDS)
.segment	"DATA3"
.endif

.if	.definedmacro(APU_STORE_BASE)
APU_WRITE_BASE_PULSE_1	= apu_write_base_pulse_1
APU_WRITE_PULSE_1	= apu_write_pulse_1
APU_WRITE_NOTE_PULSE_1	= apu_write_note_pulse_1
APU_WRITE_NOTE		= apu_write_note
APU_WRITE_BASE_PULSE_2	= apu_write_base_pulse_2
APU_WRITE_PULSE_2	= apu_write_pulse_2
APU_WRITE_NOTE_PULSE_2	= apu_write_note_pulse_2
APU_WRITE_NOTE_TRIANGLE	= apu_write_note_triangle
	.export apu_write_base_pulse_1
	.export apu_write_pulse_1
	.export apu_write_note_pulse_1
	.export apu_write_base_pulse_2
	.export apu_write_pulse_2
	.export apu_write_note_pulse_2
	.export apu_write_note_triangle
.elseif	.definedmacro(APU_STORE_FDS)
APU_WRITE_BASE_PULSE_1	= apu_fds_write_base_pulse_1
APU_WRITE_PULSE_1	= apu_fds_write_pulse_1
APU_WRITE_NOTE_PULSE_1	= apu_fds_write_note_pulse_1
APU_WRITE_NOTE		= apu_fds_write_note
APU_WRITE_BASE_PULSE_2	= apu_fds_write_base_pulse_2
APU_WRITE_PULSE_2	= apu_fds_write_pulse_2
APU_WRITE_NOTE_PULSE_2	= apu_fds_write_note_pulse_2
APU_WRITE_NOTE_TRIANGLE	= apu_fds_write_note_triangle
	.export apu_fds_write_base_pulse_1
	.export apu_fds_write_pulse_1
	.export apu_fds_write_note_pulse_1
	.export apu_fds_write_base_pulse_2
	.export apu_fds_write_pulse_2
	.export apu_fds_write_note_pulse_2
	.export apu_fds_write_note_triangle
.endif

; ------------------------------------------------------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_base_pulse_1:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_base_pulse_1:
.endif
	sty	PULSE1_SWEEP
	stx	PULSE1_VOL
	rts
; --------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_pulse_1:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_pulse_1:
.endif
	jsr	APU_WRITE_BASE_PULSE_1
; --------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_note_pulse_1:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_note_pulse_1:
.endif
	ldx	#CHANNEL_PULSE1*CHANNEL_SIZE
; ------------------------------------------------------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_note:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_note:
.endif
	tay
	lda	apu_notes+1, y
	beq	apu_fds_write_note_end ; if (apu_notes[a] != 0) {
		sta	CHANNEL_TIMER, x
		lda	apu_notes, y
		ora	#channel_counter::length_254
		sta	CHANNEL_COUNTER, x
	; }
apu_fds_write_note_end:

	rts
; ------------------------------------------------------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_base_pulse_2:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_base_pulse_2:
.endif
	stx	PULSE2_VOL
	sty	PULSE2_SWEEP
	rts
; --------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_pulse_2:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_pulse_2:
.endif
	jsr	APU_WRITE_BASE_PULSE_2
; --------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_note_pulse_2:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_note_pulse_2:
.endif
	ldx	#CHANNEL_PULSE2*CHANNEL_SIZE
	bne	APU_WRITE_NOTE
; ------------------------------------------------------------
.if	.definedmacro(APU_STORE_BASE)
apu_write_note_triangle:
.elseif	.definedmacro(APU_STORE_FDS)
apu_fds_write_note_triangle:
.endif
	ldx	#CHANNEL_TRIANGLE*CHANNEL_SIZE
	bne	APU_WRITE_NOTE
