.include	"system/apu.i"

.include	"mem.i"
.include	"sound.i"

.if	.definedmacro(APU_TRIANGLE_BASE)
APU_TRIANGLE_DO_OFFSET	= apu_triangle_offset
APU_TRIANGLE_DO_NOTE_LEN = apu_triangle_note_len
APU_TRIANGLE_DO_NOTE_LEN_B = apu_triangle_note_len_b
APU_TRIANGLE_DO_TRACK	= apu_track
APU_TRIANGLE_DO_NOTE_LENGTH_LOAD = apu_note_length_load
APU_TRIANGLE_DO_WRITE_NOTE = apu_write_note_triangle
APU_TRIANGLE_VOL_FADE	= 31
.elseif	.definedmacro(APU_TRIANGLE_FDS)
APU_TRIANGLE_DO_OFFSET	= apu_fds_triangle_offset
APU_TRIANGLE_DO_NOTE_LEN = apu_fds_triangle_note_len
APU_TRIANGLE_DO_NOTE_LEN_B = apu_fds_triangle_note_len_b
APU_TRIANGLE_DO_TRACK	= apu_fds_track
APU_TRIANGLE_DO_NOTE_LENGTH_LOAD = apu_fds_note_length_load
APU_TRIANGLE_DO_WRITE_NOTE = apu_fds_write_note_triangle
APU_TRIANGLE_VOL_FADE	= 24
.endif

APU_TRIANGLE_VOL_FADE_CASTLE	= 15
APU_TRIANGLE_FADE_FRAME	= 18

apu_triangle_do:
	lda	APU_TRIANGLE_OFFSET
	.if	.definedmacro(APU_TRIANGLE_FDS)
	beq	apu_music_triangle_end
	.endif
	dec	APU_TRIANGLE_DO_NOTE_LEN
	bne	apu_music_triangle_end ; if ((APU_BASE || this.offset != 0) && --this.note_len == 0) {
		ldy	APU_TRIANGLE_OFFSET
		inc	APU_TRIANGLE_OFFSET
		lda	(APU_TRIANGLE_DO_TRACK), y
		beq	apu_music_triangle_vol_set
		bpl	apu_music_triangle_skip_len ; if (track[this.offset++] & SND_TRACK_NOTE_LEN)) {
			jsr	APU_TRIANGLE_DO_NOTE_LENGTH_LOAD
			sta	APU_TRIANGLE_DO_NOTE_LEN_B

			.if	.definedmacro(APU_TRIANGLE_BASE)
				lda	#APU_TRIANGLE_VOL_FADE
				sta	TRIANGLE_VOL
			.endif

			ldy	APU_TRIANGLE_OFFSET
			inc	APU_TRIANGLE_OFFSET
			lda	(APU_TRIANGLE_DO_TRACK), y
			beq	apu_music_triangle_vol_set
		apu_music_triangle_skip_len:
		; }
		
		; if ((track[this.offset] & ~SND_TRACK_NOTE_LEN)) {
			jsr	APU_TRIANGLE_DO_WRITE_NOTE
			ldx	APU_TRIANGLE_DO_NOTE_LEN_B
			stx	APU_TRIANGLE_DO_NOTE_LEN

			.if	.definedmacro(APU_TRIANGLE_BASE)
			lda	apu_music_event_current
			.if	.defined(CONS)
				and	#music_event::hurry_up|music_event::level_end|music_event::victory_castle|music_event::victory_ending|music_event::game_over
			.elseif	.defined(VS)
				and	#music_event::hurry_up|music_event::level_end|music_event::victory_castle|music_event::victory_ending|music_event::game_over|music_event::game_over_alt
			.endif
			bne	apu_triangle_fade_set
			lda	apu_music_base_current
			and	#music_base::castle|music_base::underwater
			beq	apu_music_triangle_end
			apu_triangle_fade_set:
			; }
			.endif ; if (APU_FDS || (music.event.current.not_in(hurry_up, level_end, victory, game_over) && music.base.current.in(castle, underwater))) {
				txa
				cmp	#APU_TRIANGLE_FADE_FRAME
				bcs	apu_triangle_full ; if (this.note_len < fade_frame) {
				.if	.definedmacro(APU_TRIANGLE_BASE)
					lda	apu_music_event_current
					and	#music_event::victory_castle
					beq	apu_triangle_fade ; if (APU_BASE && music.event_current == victory_castle) {
						lda	#APU_TRIANGLE_VOL_FADE_CASTLE
						bne	apu_music_triangle_vol_set
					; } else  {
				.endif
					apu_triangle_fade:
						lda	#APU_TRIANGLE_VOL_FADE
						bne	apu_music_triangle_vol_set
					; }
				; } else {
				apu_triangle_full:
					lda	#triangle_vol::counter_halt|triangle_vol::full
				; }
			; }
		; }

	apu_music_triangle_vol_set:
		sta	TRIANGLE_VOL

apu_music_triangle_end:
	; }
