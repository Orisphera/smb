.include	"system/apu.i"

.include	"engine/mem.i"
.include	"engine/sound.i"

	.if	.defined(ANN)
		.res	1, $FF
	.endif

	.export apu_cycle
apu_cycle:
	lda	eng_game_mode
	bne	:+ ; if (game.mode == title) {
		sta	DMCSTATUS

		.if	.defined(CONS)
			rts
		.elseif	.defined(VS)
			sta	apu_sfx_pulse_1_current
			sta	apu_sfx_pulse_2_current
			sta	apu_noise_current

			sta	snd_music_event_current
			sta	apu_music_area_current
			beq	apu_clear_music
		.endif
	: ; } else {
		lda	#$FF
		sta	DMCFRAMECOUNT
		lda	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1
		sta	DMCSTATUS

		.if	.defined(CONS)
			lda	snd_is_paused
			bne	:+
			lda	apu_sfx_flag_pause
			cmp	#1
			bne	:++++++++
			: lda	snd_pause_buffer
			bne	:++
			lda	apu_sfx_flag_pause
			beq	:++++++++ ; if (pause_buffer != 0 || sfx_flag_pause != 0) {
				; if (sfx_flag_pause != 0) {
					sta	snd_pause_buffer
					sta	snd_is_paused
					lda	#dmcstatus::none
					sta	DMCSTATUS
	
					sta	apu_sfx_pulse_1_current
					sta	apu_sfx_pulse_2_current
					sta	apu_noise_current
	
					lda	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1
					sta	DMCSTATUS
					lda	#42
					sta	snd_sfx_pulse_1_len
					: lda	#sound_notes::E6
					bne	:+++
					: lda	snd_sfx_pulse_1_len
					cmp	#36
					beq	:+
					cmp	#30
					beq	:--
					cmp	#24
					bne	:+++
					: ; if (pause_buffer != 0 && sfx_pulse_1.len.in(24, 30, 36)) {
						; if (sfx_pulse_1.len != 30) {
							lda	#sound_notes::C6
						: ; }
				
						ldx	#channel_vol::duty_500|channel_vol::envelope|4
						ldy	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
						jsr	apu_write_pulse_1
					: ; }
				
					dec	snd_sfx_pulse_1_len
					bne	:+++ ; if (pause_buffer != 0 && --sfx_pulse_1.len == 0) {
						lda	#dmcstatus::none
						sta	DMCSTATUS
						lda	snd_pause_buffer
						cmp	#2
						bne	:+ ; if (pause_buffer == 2) {
							lda	#0
							sta	snd_is_paused
						: ; }
					
						lda	#0
						sta	snd_pause_buffer
						beq	:++
					; }
				: ; } else if (!is_paused && !sfx_flag_pause) {
		.endif

				jsr	apu_sfx_pulse_1_play
				jsr	apu_sfx_pulse_2_play
				jsr	apu_sfx_noise_play
				jsr	apu_music_play

			apu_clear_music:
				lda	#0
				sta	apu_music_area
				sta	apu_music_event
			; }
		: ; }
	
		lda	#0
		sta	apu_pulse1_queue
		sta	apu_pulse2_queue
		sta	apu_noise_event

		.if	.defined(CONS)
		sta	apu_sfx_flag_pause
		.endif
	
		ldy	snd_dac_len
		lda	apu_music_area_current
		and	#music_area::underwater|music_area::overworld
		beq	:+
		inc	snd_dac_len
		cpy	#48
		bcc	:++
		: ; if (music.area.not_in(underwater, overworld) || dac.len++ >= 48) {
			tya
			beq	:+ ; if ((dac.len - 1) != 0) {
				dec	snd_dac_len
			; }
		: ; }
	
		sty	DMCDATA
		rts
	; }
