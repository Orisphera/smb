.include	"system/apu.i"

.include	"mem.i"
.include	"sound.i"

.if	.definedmacro(APU_NOISE_BASE)
APU_NOISE_DO_OFFSET	= apu_noise_offset
APU_NOISE_DO_LOOP_OFFSET = apu_noise_loop_offset
APU_NOISE_DO_NOTE_LEN	= apu_noise_note_len
APU_NOISE_DO_DECOMP	= apu_note_decomp
APU_NOISE_DO_TRACK	= apu_track
APU_NOISE_DO_MUSIC_CURRENT = apu_music_base_current
.elseif	.definedmacro(APU_NOISE_FDS)
APU_NOISE_DO_OFFSET	= apu_fds_noise_offset
APU_NOISE_DO_LOOP_OFFSET = apu_fds_noise_loop_offset
APU_NOISE_DO_NOTE_LEN	= apu_fds_noise_note_len
APU_NOISE_DO_DECOMP	= apu_fds_note_decomp
APU_NOISE_DO_TRACK	= apu_fds_track
APU_NOISE_DO_MUSIC_CURRENT = apu_fds_music_current
.endif

	.if	.definedmacro(APU_NOISE_BASE)
        lda     APU_NOISE_DO_MUSIC_CURRENT
        .if     .defined(CONS)
                and     #<~(music_base::castle|music_base::underground)
        .elseif .defined(VS)
                and     #<~(music_base::none|music_base::castle|music_base::underground)
        .endif
        beq     apu_noise_do_end ; if (!APU_BASE || music.base.current.in(castle, underground)) {
	.endif
		dec	APU_NOISE_DO_NOTE_LEN
		bne	apu_noise_do_end ; if (--this.note_len == 0) {
		apu_noise_loop:
			; for (y = this.offset; track[y] == 0 && y != 0; y++) {
				ldy	APU_NOISE_DO_OFFSET
				inc	APU_NOISE_DO_OFFSET
				lda	(APU_NOISE_DO_TRACK), y
				bne	apu_noise_loop_end
				lda	APU_NOISE_DO_LOOP_OFFSET
				sta	APU_NOISE_DO_OFFSET
				bne	apu_noise_loop
			; }
		apu_noise_loop_end:
		
			jsr	APU_NOISE_DO_DECOMP
			sta	APU_NOISE_DO_NOTE_LEN
			txa
			and	#<~SND_CMP_LEN_MASK
			.if	.definedmacro(APU_NOISE_BASE)
			beq	apu_noise_silence
			.elseif	.definedmacro(APU_NOISE_FDS)
			beq	apu_music_noise_write
			.endif
		
			.if	.definedmacro(APU_NOISE_BASE)
			cmp	#SND_NOISE_HI_LONG
			beq	apu_noise_hi_long
			cmp	#SND_NOISE_LO_SHORT
			beq	apu_noise_lo_short
			and	#SND_NOISE_HI_SHORT
			beq	apu_noise_silence ; if (this.note == hi_short || (APU_NOISE_FDS && this.note != silent)) {
			.endif
				lda	#channel_vol::constant_vol|SND_NOISE_VOL
				ldx	#SND_NOISE_HIGH
				ldy	#SND_NOISE_SHORT_COUNT
			.if	.definedmacro(APU_NOISE_BASE)
				bne	apu_music_noise_write
			; } else if (APU_BASE && this.note == lo_short) {
			apu_noise_lo_short:
				lda	#channel_vol::constant_vol|SND_NOISE_VOL
				ldx	#SND_NOISE_LOW
				ldy	#SND_NOISE_SHORT_COUNT
				bne	apu_music_noise_write
			; } else if (APU_BASE && this.note == hi_long) {
			apu_noise_hi_long:
				lda	#channel_vol::constant_vol|SND_NOISE_VOL
				ldx	#SND_NOISE_HIGH
				ldy	#SND_NOISE_LONG_COUNT
				bne	apu_music_noise_write
			; } else if (APU_BASE && this.note == silent) {
			apu_noise_silence:
				lda	#channel_vol::constant_vol|0
			; }
			.endif
		
		apu_music_noise_write:
			sta	NOISE_VOL
			stx	NOISE_PERIOD
			sty	NOISE_COUNTER
		; }

	apu_noise_do_end:
	; }
