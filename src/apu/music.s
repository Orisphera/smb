.include	"system/apu.i"

.include	"engine/mem.i"
.include	"engine/sound.i"

	: jmp	apu_music_pulse_2

	.export	apu_music_play
apu_music_play:
	lda	apu_music_event
	bne	:+ ; if (music.event == null) {
		lda	apu_music_area
		bne	apu_music_area_load
		lda	snd_music_event_current
		ora	apu_music_area_current
		bne	:- ; if (music.area == null) {
			rts
		; } else apu_music_pulse_2();
	: ; }
; --------------
apu_music_event_load:
	.if	.defined(VS)
		ldy	#49
		sty	snd_7CC
	.endif

	sta	snd_music_event_current
	cmp	#music_event::death
	bne	:+ ; if (music.event == death) {
		jsr	apu_sfx_pulse_1_stop
		jsr	apu_sfx_pulse_2_mute

		.if	.defined(VS)
			ldy	#0
			sty	snd_note_len_offset
			sty	apu_music_area_current
			beq	apu_music_header_find
		.endif
	: ; }

	ldx	apu_music_area_current
	stx	snd_music_area_current_b
	ldy	#0
	sty	snd_note_len_offset
	sty	apu_music_area_current
	cmp	#music_area::super_star
	.if	.defined(CONS)
		bne	apu_music_header_find
	.elseif	.defined(VS)
		bne	:+ ; if (music.area == super_star) {
	.endif
		ldx	#<(apu_note_lengths_f-APU_SUPER_STAR_LEN_BASE)
		stx	snd_note_len_offset
		bne	apu_music_header_find
	: ; }

	.if	.defined(VS)
	apu_music_underground_check:
		cmp	#music_area::underground
		bne	apu_music_header_find ; if (music.area == underground) {
		apu_music_timer_load:
			inc	snd_7CC
			ldy	snd_7CC	
			cpy	#55
			bne	apu_music_header_load
			jmp	apu_music_silence
		; }
	.endif
; --------------
apu_music_area_load:
	cmp	#music_area::underground
	bne	:+ ; if (music.area == underground) {
		jsr	apu_sfx_pulse_1_stop
	: ; }

	ldy	#<(apu_music_overworld_offsets-apu_music_offsets)
	: ; while (music.area == overworld) {
		sty	snd_overworld_header_offset

	.if	.defined(VS)
		ldy	#<(apu_music_super_star_vs_loop-apu_music_offsets)
	apu_music_area_load_loop_super_star:	
		sty	snd_super_star_header_offset
	.endif

	apu_music_area_load_do:
		ldy	#music_event::null
		sty	snd_music_event_current
		sta	apu_music_area_current
		cmp	#music_area::overworld
		bne	:+ ; if (music.area == overworld) {
			inc	snd_overworld_header_offset
			ldy	snd_overworld_header_offset
			cpy	#<(apu_music_overworld_loop_end-apu_music_offsets)+1
			bne	apu_music_header_load
			ldy	#<(apu_music_overworld_loop_offset-apu_music_offsets)
			bne	:-
		: ; }

	.if	.defined(VS)
		cmp	#music_area::super_star
		bne	:+ ; if (music.area == super_star) {
			inc	snd_super_star_header_offset
			ldy	snd_super_star_header_offset
			cpy	#<(apu_music_super_star_vs_loop_end-apu_music_offsets)+1
			bne	apu_music_header_load
			ldy	#<(apu_music_super_star_vs_loop-apu_music_offsets)
			bne	apu_music_area_load_loop_super_star
		: ; }
	.endif
	; }

	ldy	#8
	sty	apu_pulse_2_offset
; --------------
apu_music_header_find:
	: ; for (bit of music_current) {
		iny

		lsr	a
		bcc	:-
	; }
; --------------
apu_music_header_load:
	lda	apu_music_offsets-1, y
	tay
	lda	apu_music_offsets+0, y
	sta	apu_note_len_offset

	lda	apu_music_offsets+1, y
	sta	apu_track_addr+0
	lda	apu_music_offsets+2, y
	sta	apu_track_addr+1

	lda	apu_music_offsets+3, y
	sta	apu_triangle_offset
	lda	apu_music_offsets+4, y
	sta	apu_pulse_1_offset
	lda	apu_music_offsets+5, y
	sta	snd_noise_offset
	sta	snd_noise_loop_offset

	lda	#1
	sta	snd_pulse_2_note_len
	sta	snd_pulse_1_note_len
	sta	snd_triangle_note_len
	sta	snd_noise_note_len

	lda	#0
	sta	apu_pulse_2_offset
	sta	snd_pulse_1_ctl_a

	lda	#dmcstatus::noise|dmcstatus::pulse_2|dmcstatus::pulse_1
	sta	DMCSTATUS
	lda	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1
	sta	DMCSTATUS
; --------------
apu_music_pulse_2:
	dec	snd_pulse_2_note_len
	bne	apu_music_pulse_2_misc ; if (--this.len == 0) {
		ldy	apu_pulse_2_offset
		inc	apu_pulse_2_offset
		lda	(apu_track_addr), y
		beq	:+
		bpl	apu_music_pulse_2_note
		bne	apu_music_pulse_2_len
		: lda	snd_music_event_current
		cmp	#music_event::hurry_up
		bne	:+
		lda	snd_music_area_current_b
		bne	apu_music_area_load_do_b
		: and	#music_event::victory_normal
		bne	apu_music_event_load_b
		lda	apu_music_area_current
		and	#<~(music_area::none|music_area::pipe_intro)
		bne	:+ ; if (
		;	track[this.offset] == 0
		;	&& (music.event != hurry_up || music.area == null)
		;	&& music.event != victory_normal
		;	&& music.area != pipe_intro
		; ) {
		apu_music_silence:
			lda	#0
			sta	apu_music_area_current
			sta	snd_music_event_current
			sta	TRIANGLE_VOL
			lda	#channel_vol::duty_500|channel_vol::constant_vol|0
			sta	PULSE1_VOL
			sta	PULSE2_VOL
			rts
		: ; } else if ((track[this.offset] & 0x7F) && !(track[this.offset] & 0x80)) apu_music_pulse_2_note();
		; else if ((track[this.offset] & 0x80)) apu_music_pulse_2_len();
		; else if (music.area != null) apu_music_area_load_do_b();
		; else if (music.event == victory_normal) apu_music_event_load_b();
	; } else apu_music_pulse_2_misc();
; --------------
apu_music_area_load_do_b:
	jmp	apu_music_area_load_do
; --------------
apu_music_event_load_b:
	.if	.defined(CONS)
		jmp	apu_music_event_load
	.elseif	.defined(VS)
		jmp	apu_music_timer_load
	.endif
; --------------
apu_music_pulse_2_len:
	jsr	apu_note_length_load
	sta	snd_pulse_2_note_len_b
	ldy	apu_pulse_2_offset
	inc	apu_pulse_2_offset
	lda	(apu_track_addr), y
; --------------
apu_music_pulse_2_note:
	ldx	apu_sfx_pulse_2_current
	bne	:++ ; if (sfx_pulse_2 == null) {
		jsr	apu_write_note_pulse_2
		beq	:+ ; if (apu_write_note_pulse_2()) {
			jsr	apu_next_state
		: ; }
		sta	snd_pulse_2_env_ctl

		jsr	apu_write_base_pulse_2
	: ; }

	lda	snd_pulse_2_note_len_b
	sta	snd_pulse_2_note_len
; --------------
apu_music_pulse_2_misc:
	lda	apu_sfx_pulse_2_current
	bne	:++
	lda	snd_music_event_current
	.if	.defined(CONS)
		and	#music_event::none|music_event::game_over_alt|music_event::death
	.elseif	.defined(VS)
		and	#music_event::none|music_event::death
	.endif
	bne	:++ ; if (music.event == death || (CONS && music.event == game_over_alt)) {
		ldy	snd_pulse_2_env_ctl
		beq	:+ ; if (this.env_ctl > 0) {
			dec	snd_pulse_2_env_ctl
		: ; }
		jsr	apu_next_volume
		sta	PULSE2_VOL

		ldx	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
		stx	PULSE2_SWEEP
	: ; }
; --------------
apu_music_pulse_1:
	ldy	apu_pulse_1_offset
	beq	:++++++++ ; if (this.offset != 0) {
		dec	snd_pulse_1_note_len
		bne	:++++ ; if (--this.len == 0) {
			: ; for () {
				ldy	apu_pulse_1_offset
				inc	apu_pulse_1_offset
				lda	(apu_track_addr), y
				bne	:+ ; if (track[this.offset] == 0) {
					lda	#channel_vol::duty_500|channel_vol::envelope|3
					sta	PULSE1_VOL
					lda	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::shift_4
					sta	PULSE1_SWEEP
					sta	snd_pulse_1_ctl_a
					bne	:-
				; }
			: ; }
		
			jsr	apu_note_decomp
			sta	snd_pulse_1_note_len
; --------------
apu_music_pulse_1_note:
			ldy	apu_sfx_pulse_1_current
			bne	apu_music_triangle
			txa
			and	#<~SND_CMP_LEN_MASK
			jsr	apu_write_note_pulse_1
			beq	:+ ; if (apu_write_note_pulse_1()) {
				jsr	apu_next_state
			: ; }
			sta	snd_pulse_1_env_ctl
		
			jsr	apu_write_base_pulse_1
		: ; }
; --------------
apu_music_pulse_1_misc:	
		lda	apu_sfx_pulse_1_current
		bne	:++++ ; if (sfx_pulse_1 == none) {
			lda	snd_music_event_current
			.if	.defined(CONS)
				and	#music_event::none|music_event::game_over_alt|music_event::death
			.elseif	.defined(VS)
				and	#music_event::none|music_event::death
			.endif
			bne	:++ ; if (music.event != death && (VS || music.event != game_over_alt)) {
				ldy	snd_pulse_1_env_ctl
				beq	:+ ; if (this.env_ctl) {
					dec	snd_pulse_1_env_ctl
				: ; }
			
				jsr	apu_next_volume
				sta	PULSE1_VOL
			: ; }
		
			lda	snd_pulse_1_ctl_a
			bne	:+ ; if (this.ctl_a == 0) {
				lda	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
			: ; }
			sta	PULSE1_SWEEP
		; }
	: ; }
; --------------
apu_music_triangle:
	lda	apu_triangle_offset
	dec	snd_triangle_note_len
	bne	:++++++ ; if (--this.len == 0) {
		ldy	apu_triangle_offset
		inc	apu_triangle_offset
		lda	(apu_track_addr), y
		beq	:+++++ ; if (track[this.offset] != 0) {
			bpl	:+ ; if (track[this.offset] & length_bit) {
				jsr	apu_note_length_load
				sta	snd_triangle_note_len_b
				lda	#31
				sta	TRIANGLE_VOL
				ldy	apu_triangle_offset
				inc	apu_triangle_offset

				lda	(apu_track_addr), y
				beq	apu_music_triangle_vol_set
			: ; }
		
			; if (track[this.offset] != 0) {
				jsr	apu_write_note_triangle

				ldx	snd_triangle_note_len_b
				stx	snd_triangle_note_len
	
				lda	snd_music_event_current
				.if	.defined(CONS)
					and	#music_event::hurry_up|music_event::level_end|music_event::victory_castle|music_event::victory_normal|music_event::game_over
				.elseif	.defined(VS)
					and	#music_event::hurry_up|music_event::level_end|music_event::victory_castle|music_event::victory_normal|music_event::game_over|music_event::game_over_alt
				.endif
				bne	:+ ; if (music.event.not_in(hurry_up, level_end, victory, game_over) && (CONS || music.event != game_over_alt)) {
					lda	apu_music_area_current
					and	#music_area::castle|music_area::underwater
					beq	apu_music_noise
				: ; }
			
				txa
				cmp	#18
				bcs	:++
				lda	snd_music_event_current
				and	#music_event::victory_castle
				beq	:+
				lda	#15
				bne	:+++
				: lda	#31
				bne	:++
				: lda	#triangle_vol::counter_halt|127
			; }
		: ; }

	apu_music_triangle_vol_set:
		sta	TRIANGLE_VOL
	: ; }
; --------------
apu_music_noise:
	lda	apu_music_area_current
	.if	.defined(CONS)
		and	#<~(music_area::castle|music_area::underground)
	.elseif	.defined(VS)
		and	#<~(music_area::none|music_area::castle|music_area::underground)
	.endif
	beq	:+++++++
	dec	snd_noise_note_len
	bne	:+++++++ ; if (music.area.not_in(castle, underground) && --this.len > 0) {
		: ; for (y = this.offset; track[y] == 0; y++) {
			ldy	snd_noise_offset
			inc	snd_noise_offset
	
			lda	(apu_track_addr), y
			bne	:+ ; if (track[this.offset] == 0) {
				lda	snd_noise_loop_offset
				sta	snd_noise_offset
				bne	:-
			; }
		: ; }
	
		jsr	apu_note_decomp
		sta	snd_noise_note_len
		txa
		and	#<~SND_CMP_LEN_MASK
		beq	:+++
		cmp	#SND_NOISE_HI_LONG
		beq	:++
		cmp	#SND_NOISE_LO_SHORT
		beq	:+
		and	#SND_NOISE_HI_SHORT
		beq	:+++ ; if (this.note == hi_short) {
			lda	#channel_vol::constant_vol|SND_NOISE_VOL
			ldx	#SND_NOISE_HIGH
			ldy	#SND_NOISE_SHORT_COUNT
			bne	:++++
		: ; } else if (this.note == lo_short) {
			lda	#channel_vol::constant_vol|SND_NOISE_VOL
			ldx	#SND_NOISE_LOW
			ldy	#SND_NOISE_SHORT_COUNT
			bne	:+++
		: ; } else if (this.note == hi_long) {
			lda	#channel_vol::constant_vol|SND_NOISE_VOL
			ldx	#SND_NOISE_HIGH
			ldy	#SND_NOISE_LONG_COUNT
			bne	:++
		: ; } else {
			lda	#channel_vol::constant_vol|0
		: ; }

		sta	NOISE_VOL
		stx	NOISE_PERIOD
		sty	NOISE_COUNTER
	: ; }

	rts
