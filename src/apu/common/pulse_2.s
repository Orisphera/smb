.include	"system/apu.i"

.include	"mem.i"
.include	"sound.i"
.include	"tunables.i"

.if	.definedmacro(APU_PULSE_2_BASE)
APU_PULSE_2_DO_NOTE_LEN	= apu_pulse_2_note_len
APU_PULSE_2_DO_NOTE_LEN_B = apu_pulse_2_note_len_b
APU_PULSE_2_DO_OFFSET	= apu_pulse_2_offset
APU_PULSE_2_DO_1_OFFSET	= apu_pulse_1_offset
APU_PULSE_2_DO_TRI_OFFSET	= apu_triangle_offset
APU_PULSE_2_DO_NOISE_OFFSET	= apu_noise_offset
APU_PULSE_2_DO_TRACK	= apu_track
APU_PULSE_2_DO_MUSIC_CURRENT = apu_music_base_current
APU_PULSE_2_DO_ENV_CTL	= apu_pulse_2_env_ctl
APU_PULSE_2_DO_NOTE_LEN_LOAD = apu_note_length_load
APU_PULSE_2_DO_WRITE_NOTE = apu_write_note_pulse_2
APU_PULSE_2_DO_WRITE_BASE = apu_write_base_pulse_2
.elseif	.definedmacro(APU_PULSE_2_FDS)
APU_PULSE_2_DO_NOTE_LEN	= apu_fds_pulse_2_note_len
APU_PULSE_2_DO_NOTE_LEN_B = apu_fds_pulse_2_note_len_b
APU_PULSE_2_DO_OFFSET	= apu_fds_pulse_2_offset
APU_PULSE_2_DO_1_OFFSET	= apu_fds_pulse_1_offset
APU_PULSE_2_DO_TRI_OFFSET	= apu_fds_triangle_offset
APU_PULSE_2_DO_NOISE_OFFSET	= apu_fds_noise_offset
APU_PULSE_2_DO_TRACK	= apu_fds_track
APU_PULSE_2_DO_MUSIC_CURRENT = apu_fds_music_current
APU_PULSE_2_DO_ENV_CTL	= apu_fds_pulse_2_env_ctl
APU_PULSE_2_DO_NOTE_LEN_LOAD = apu_fds_note_length_load
APU_PULSE_2_DO_WRITE_NOTE = apu_fds_write_note_pulse_2
APU_PULSE_2_DO_WRITE_BASE = apu_fds_write_base_pulse_2
.endif

	dec	APU_PULSE_2_DO_NOTE_LEN
	bne	apu_music_pulse_2_continue ; if (--this.len == 0) {
		ldy	APU_PULSE_2_DO_OFFSET
		inc	APU_PULSE_2_DO_OFFSET
		lda	(APU_PULSE_2_DO_TRACK), y
		beq	apu_music_pulse_2_clear
		bpl	apu_music_pulse_2_note
		bne	apu_music_pulse_2_len
		; if (track[this.offset] == 0) {
		apu_music_pulse_2_clear:
		.if	.definedmacro(APU_PULSE_2_BASE)
			lda	apu_music_event_current
			cmp	#music_event::hurry_up
			bne	apu_pulse_2_is_hurry
			lda	apu_music_base_current_b
			bne	apu_music_base_load_do_b
			apu_pulse_2_is_hurry:
			and	#music_event::victory_ending
			bne	apu_music_event_load_b ; if ((music.event.current != hurry_up || music.base.current.b == none) && music.event.current != victory_ending) {
		.endif
				lda	APU_PULSE_2_DO_MUSIC_CURRENT
			.if	.definedmacro(APU_PULSE_2_BASE)
				and	#<~(music_base::none|music_base::pipe_intro)
			.endif
				bne	apu_music_base_load_do_b ; if (music.base.current != pipe_intro) {
				.if	.definedmacro(APU_PULSE_2_BASE)
					.export apu_music_silence
				apu_music_silence:
				.elseif	.definedmacro(APU_PULSE_2_FDS)
					.export	apu_fds_music_silence
				apu_fds_music_silence:
				.endif
					lda	#0
					sta	APU_PULSE_2_DO_MUSIC_CURRENT
	
				.if	.definedmacro(APU_PULSE_2_BASE)	
					sta	apu_music_event_current
				.endif
		
					sta	TRIANGLE_VOL

				.if	.definedmacro(APU_PULSE_2_FDS)
					sta	APU_PULSE_2_DO_TRACK+1
					sta	APU_PULSE_2_DO_TRACK
					sta	APU_PULSE_2_DO_OFFSET
					sta	APU_PULSE_2_DO_1_OFFSET
					sta	APU_PULSE_2_DO_TRI_OFFSET
					sta	APU_PULSE_2_DO_NOISE_OFFSET
				.endif
		
					lda	#channel_vol::duty_500|channel_vol::constant_vol|0
					sta	PULSE1_VOL
					sta	PULSE2_VOL

				.if	.definedmacro(APU_PULSE_2_FDS)
					lda	#fds_snd_vol_env::off|fds_snd_vol_env::dec|0
					sta	FDS_SND_VOL
				.endif
		
					rts
				; }
			; } else if (APU_BASE && (music.event.current == hurry_up && music.base.current.b != none) || music.base.current == pipe_intro) {
			apu_music_base_load_do_b:
			.if	.definedmacro(APU_PULSE_2_BASE)
				jmp	apu_music_base_load_do
			.endif
			; } else {
			apu_music_event_load_b:
			.if	.definedmacro(APU_PULSE_2_BASE)
				.if	.defined(CONS)
					jmp	apu_music_event_load
				.elseif	.defined(VS)
					jmp	apu_music_timer_load
				.endif
			.elseif	.definedmacro(APU_PULSE_2_FDS)
				jmp	apu_fds_next
			.endif
			; }
		; } else if ((track[this.offset] & SND_TRACK_NOTE_LEN)) {
		apu_music_pulse_2_len:
			jsr	APU_PULSE_2_DO_NOTE_LEN_LOAD
			sta	APU_PULSE_2_DO_NOTE_LEN_B
			ldy	APU_PULSE_2_DO_OFFSET
			inc	APU_PULSE_2_DO_OFFSET
			lda	(APU_PULSE_2_DO_TRACK), y
		; }

	apu_music_pulse_2_note:
		ldx	apu_sfx_pulse_2_current
		bne	apu_music_pulse_2_note_skip ; if (sfx.pulse_2.current == null) {
			jsr	APU_PULSE_2_DO_WRITE_NOTE
			beq	apu_pulse_2_write_note_finish ; if (this.write_note() != 0) {
			.if	.definedmacro(APU_PULSE_2_BASE)
				jsr	apu_next_state
			.elseif	.definedmacro(APU_PULSE_2_FDS)
				lda     #SND_FDS_ENV_CTL_COUNTER
				ldx     #channel_vol::duty_500|channel_vol::envelope|2
				ldy     #pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
			.endif
			apu_pulse_2_write_note_finish:
			; }
			sta	APU_PULSE_2_DO_ENV_CTL
	
			jsr	APU_PULSE_2_DO_WRITE_BASE
		apu_music_pulse_2_note_skip:
		; }
	
		lda	APU_PULSE_2_DO_NOTE_LEN_B
		sta	APU_PULSE_2_DO_NOTE_LEN
	apu_music_pulse_2_continue:
	; }

	lda	apu_sfx_pulse_2_current
	bne	apu_music_pulse_2_end ; if (sfx.pulse_2.current == none) {
		.if	.definedmacro(APU_PULSE_2_BASE)
		lda	apu_music_event_current
		.if	.defined(CONS)
			and	#music_event::none|music_event::game_over_alt|music_event::death
		.elseif	.defined(VS)
			and	#music_event::none|music_event::death
		.endif
		bne	apu_music_pulse_2_end ; if (!APU_BASE || music.event == death || (CONS && music.event == game_over_alt)) {
		.endif
			ldy	APU_PULSE_2_DO_ENV_CTL
			beq	apu_music_pulse_2_dec_env ; if (this.env_ctl > 0) {
				dec	APU_PULSE_2_DO_ENV_CTL
			apu_music_pulse_2_dec_env:
			; }

			.if	.definedmacro(APU_PULSE_2_BASE)
				jsr	apu_next_volume
			.elseif	.definedmacro(APU_PULSE_2_FDS)
				lda	apu_fds_envelope, y
			.endif
			sta	PULSE2_VOL
	
			.if	.definedmacro(APU_PULSE_2_BASE)
				ldx	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
				stx	PULSE2_SWEEP
			.endif
		; }
	apu_music_pulse_2_end:
	; }
