.include	"mem.i"
.include	"sound.i"

.if	.definedmacro(APU_LOAD_FDS)
.segment	"DATA3"
.endif

.if	.definedmacro(APU_LOAD_BASE)
	.export	apu_note_decomp
apu_note_decomp:
.elseif	.definedmacro(APU_LOAD_FDS)
	.export	apu_fds_note_decomp
apu_fds_note_decomp:
.endif
	tax
	ror	a
	txa
	rol	a
	rol	a
	rol	a
; ----------------
.if	.definedmacro(APU_LOAD_BASE)
APU_NOTE_LEN_OFFSET	= apu_note_len_offset
APU_NOTE_LENGTHS	= apu_note_lengths
.elseif	.definedmacro(APU_LOAD_FDS)
APU_NOTE_LEN_OFFSET	= apu_fds_note_len_offset
APU_NOTE_LENGTHS	= apu_fds_note_lengths
.endif

.if	.definedmacro(APU_LOAD_BASE)
	.export	apu_note_length_load
apu_note_length_load:
.elseif	.definedmacro(APU_LOAD_FDS)
	.export	apu_fds_note_length_load
apu_fds_note_length_load:
.endif
	and	#SND_NOTE_LEN_MASK
	clc
	adc	APU_NOTE_LEN_OFFSET

	.if	.definedmacro(APU_LOAD_BASE)
		adc	snd_note_len_offset
	.endif

	tay
	lda	APU_NOTE_LENGTHS, y
	rts
