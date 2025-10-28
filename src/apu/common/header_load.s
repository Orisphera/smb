.include	"sys/apu.i"

.include	"mem.i"
.include	"sound.i"

.if	.definedmacro(APU_HEADER_LOAD_FDS)
.segment	"DATA3"
.endif

.if	.definedmacro(APU_HEADER_LOAD_BASE)
APU_MUSIC_OFFSETS	= apu_music_offsets
APU_NOTE_LEN_OFFSET	= apu_note_len_offset
APU_TRACK		= apu_track
APU_TRIANGLE_OFFSET	= apu_triangle_offset
APU_PULSE_2_OFFSET	= apu_pulse_2_offset
APU_PULSE_1_OFFSET	= apu_pulse_1_offset
APU_NOISE_OFFSET	= apu_noise_offset
APU_NOISE_LOOP_OFFSET	= apu_noise_loop_offset
APU_PULSE_2_NOTE_LEN	= apu_pulse_2_note_len
APU_PULSE_1_NOTE_LEN	= apu_pulse_1_note_len
APU_TRIANGLE_NOTE_LEN	= apu_triangle_note_len
APU_NOISE_NOTE_LEN	= apu_noise_note_len
.elseif	.definedmacro(APU_HEADER_LOAD_FDS)
APU_MUSIC_OFFSETS	= apu_fds_music_offsets
APU_NOTE_LEN_OFFSET	= apu_fds_note_len_offset
APU_TRACK		= apu_fds_track
APU_TRIANGLE_OFFSET	= apu_fds_triangle_offset
APU_PULSE_2_OFFSET	= apu_fds_pulse_2_offset
APU_PULSE_1_OFFSET	= apu_fds_pulse_1_offset
APU_NOISE_OFFSET	= apu_fds_noise_offset
APU_NOISE_LOOP_OFFSET	= apu_fds_noise_loop_offset
APU_PULSE_2_NOTE_LEN	= apu_fds_pulse_2_note_len
APU_PULSE_1_NOTE_LEN	= apu_fds_pulse_1_note_len
APU_TRIANGLE_NOTE_LEN	= apu_fds_triangle_note_len
APU_NOISE_NOTE_LEN	= apu_fds_noise_note_len
.endif

	lda	APU_MUSIC_OFFSETS-1, y
	tay
	lda	APU_MUSIC_OFFSETS, y
	sta	APU_NOTE_LEN_OFFSET

	lda	APU_MUSIC_OFFSETS+1, y
	sta	APU_TRACK
	lda	APU_MUSIC_OFFSETS+2, y
	sta	APU_TRACK+1

	lda	APU_MUSIC_OFFSETS+3, y
	sta	APU_TRIANGLE_OFFSET
	lda	APU_MUSIC_OFFSETS+4, y
	sta	APU_PULSE_1_OFFSET
	lda	APU_MUSIC_OFFSETS+5, y
	sta	APU_NOISE_OFFSET
	sta	APU_NOISE_LOOP_OFFSET

	.if	.definedmacro(APU_HEADER_LOAD_FDS)
		lda	APU_MUSIC_OFFSETS+6, y
		sta	apu_fds_wave_offset
		lda	APU_MUSIC_OFFSETS+7, y
		sta	apu_fds_wave_id_b
		sta	apu_fds_wave_id
		jsr	apu_fds_wave_proc
	.endif

	lda	#1
	sta	APU_PULSE_2_NOTE_LEN
	sta	APU_PULSE_1_NOTE_LEN
	sta	APU_TRIANGLE_NOTE_LEN
	sta	APU_NOISE_NOTE_LEN

	.if	.definedmacro(APU_HEADER_LOAD_FDS)
		sta	apu_fds_wave_note_len
	.endif

	lda	#0
	sta	APU_PULSE_2_OFFSET

	.if	.definedmacro(APU_HEADER_LOAD_BASE)
		sta	apu_pulse_1_ctl_a
	.endif

	lda	#dmcstatus::noise|dmcstatus::pulse_2|dmcstatus::pulse_1
	sta	DMCSTATUS
	lda	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1
	sta	DMCSTATUS
