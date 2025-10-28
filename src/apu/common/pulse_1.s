.include	"sys/apu.i"

.include	"mem.i"
.include	"sound.i"
.include	"tunables.i"

.if	.definedmacro(APU_PULSE_1_BASE)
APU_PULSE_1_DO_OFFSET	= apu_pulse_1_offset
APU_PULSE_1_DO_NOTE_LEN	= apu_pulse_1_note_len
APU_PULSE_1_DO_TRACK	= apu_track
APU_PULSE_1_DO_ENV_CTL	= apu_pulse_1_env_ctl
APU_PULSE_1_DO_NOTE_DECOMP = apu_note_decomp
APU_PULSE_1_DO_WRITE_NOTE = apu_write_note_pulse_1
APU_PULSE_1_DO_WRITE_BASE = apu_write_base_pulse_1
.elseif	.definedMACRO(APU_PULSE_1_FDS)
APU_PULSE_1_DO_OFFSET	= apu_fds_pulse_1_offset
APU_PULSE_1_DO_NOTE_LEN	= apu_fds_pulse_1_note_len
APU_PULSE_1_DO_TRACK	= apu_fds_track
APU_PULSE_1_DO_ENV_CTL	= apu_fds_pulse_1_env_ctl
APU_PULSE_1_DO_NOTE_DECOMP = apu_fds_note_decomp
APU_PULSE_1_DO_WRITE_NOTE = apu_fds_write_note_pulse_1
APU_PULSE_1_DO_WRITE_BASE = apu_fds_write_base_pulse_1
.endif

	ldy	APU_PULSE_1_DO_OFFSET
	beq	apu_music_pulse_1_end ; if (this.offset != 0) {
		dec	APU_PULSE_1_DO_NOTE_LEN
		bne	apu_music_pulse_1_continue ; if (--this.len == 0) {
			apu_music_pulse_1_zero_loop:
			; for (this.offset; APU_BASE && track[this.offset] == 0; this.offset++) {
				ldy	APU_PULSE_1_DO_OFFSET
				inc	APU_PULSE_1_DO_OFFSET
				lda	(APU_PULSE_1_DO_TRACK), y
			.if	.definedmacro(APU_PULSE_1_BASE)
				bne	apu_music_pulse_1_note_found ; if (track[this.offset] == pulse_sweep) {
					lda	#channel_vol::duty_500|channel_vol::envelope|3
					sta	PULSE1_VOL
					lda	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::shift_4
					sta	PULSE1_SWEEP
					sta	apu_pulse_1_ctl_a
					bne	apu_music_pulse_1_zero_loop
				; }
			apu_music_pulse_1_note_found:
			.endif
			; }
		
			jsr	APU_PULSE_1_DO_NOTE_DECOMP
			sta	APU_PULSE_1_DO_NOTE_LEN

			.if	.definedmacro(APU_PULSE_1_BASE)
			ldy	apu_sfx_pulse_1_current
			bne	apu_music_pulse_1_end ; if (!APU_BASE || sfx.pulse_1.current == none) {
			.endif
				txa
				and	#SND_CMP_NOTE_MASK
	
				jsr	APU_PULSE_1_DO_WRITE_NOTE
				beq	apu_write_pulse_1_finish ; if (this.write_note() != 0) {
				.if	.definedmacro(APU_PULSE_1_BASE)
					jsr	apu_next_state
				.elseif	.definedmacro(APU_PULSE_1_FDS)
					lda	#SND_FDS_ENV_CTL_COUNTER
					ldx	#channel_vol::duty_500|channel_vol::envelope|2
					ldy	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
				.endif
				apu_write_pulse_1_finish:
				; }
				sta	APU_PULSE_1_DO_ENV_CTL
			
				jsr	APU_PULSE_1_DO_WRITE_BASE
			; }
		apu_music_pulse_1_continue:
		; }

		.if	.definedmacro(APU_PULSE_1_BASE)
		lda	apu_sfx_pulse_1_current
		bne	apu_music_pulse_1_end ; if (sfx.pulse_1.current == none) {
			lda	apu_music_event_current
			.if	.defined(CONS)
				and	#music_event::none|music_event::game_over_alt|music_event::death
			.elseif	.defined(VS)
				and	#music_event::none|music_event::death
			.endif
			bne	apu_music_pulse_1_skip_env ; if (music.event.current != death && (VS || music.event.current != game_over_alt)) {
		.endif
				ldy	APU_PULSE_1_DO_ENV_CTL
				beq	apu_music_pulse_1_dec_env ; if (this.env_ctl) {
					dec	APU_PULSE_1_DO_ENV_CTL
				apu_music_pulse_1_dec_env:
				; }
			
				.if	.definedmacro(APU_PULSE_1_BASE)
					jsr	apu_next_volume
				.elseif	.definedmacro(APU_PULSE_1_FDS)
					lda	apu_fds_envelope, y
				.endif
				sta	PULSE1_VOL
			apu_music_pulse_1_skip_env:
			; }

			.if	.definedmacro(APU_PULSE_1_BASE)
			lda	apu_pulse_1_ctl_a
			bne	apu_music_pulse_1_has_sweep ; if (this.ctl_a == 0) {
			.endif
				lda	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
			apu_music_pulse_1_has_sweep:
			; }
			sta	PULSE1_SWEEP
		; }

	apu_music_pulse_1_end:
	; }
