.include	"sys/apu.i"

.include	"mem.i"
.include	"sound.i"

APU_VS_COUNTER_START	= 49
APU_VS_COUNTER_END	= 55

	: jmp	apu_music_pulse_2

	.export	apu_music_play
apu_music_play:
	lda	apu_music_event_req
	bne	:+ ; if (music.event.req == null) {
		lda	apu_music_base_req
		bne	apu_music_base_load
		lda	apu_music_event_current
		ora	apu_music_base_current
		bne	:- ; if (music.base.req == null && (music.event.current | music.base.current == null)) {
			rts
		; } else apu_music_pulse_2();
	: ; } else apu_music_event_load();
; --------------
apu_music_event_load:
	.if	.defined(VS)
		ldy	#APU_VS_COUNTER_START
		sty	apu_vs_counter
	.endif

	sta	apu_music_event_current
	cmp	#music_event::death
	bne	:+ ; if (music.event.current == death) {
		jsr	apu_sfx_pulse_1_stop
		jsr	apu_sfx_pulse_2_mute

		.if	.defined(VS)
			ldy	#0
			sty	snd_note_len_offset
			sty	apu_music_base_current
			beq	apu_music_header_find
		.endif
	: ; }

	ldx	apu_music_base_current
	stx	apu_music_base_current_b
	ldy	#0
	sty	snd_note_len_offset
	sty	apu_music_base_current
	cmp	#music_event::hurry_up
	.if	.defined(CONS)
		bne	apu_music_header_find
	.elseif	.defined(VS)
		bne	:+ ; if (music.event.current == hurry_up) {
	.endif
		ldx	#APU_MUSIC_HURRY_UP_LEN
		stx	snd_note_len_offset
		bne	apu_music_header_find
	: ; }

	.if	.defined(VS)
		cmp	#music_event::victory_ending
		bne	apu_music_header_find ; if (music.event.current == victory_ending) {
		apu_music_timer_load:
			inc	apu_vs_counter
			ldy	apu_vs_counter
			cpy	#APU_VS_COUNTER_END
			bne	apu_music_header_load ; if (++apu_vs_counter == counter_end) {
				jmp	apu_music_silence
			; } else apu_music_header_load();
		; }
	.endif
; --------------
apu_music_base_load:
	cmp	#music_event::victory_ending
	bne	:+ ; if (music.event.current == victory_ending) {
		jsr	apu_sfx_pulse_1_stop
	: ; }

	ldy	#<(apu_music_overworld_offsets-apu_music_offsets)
	: ; while (music.base.current == overworld) {
		sty	snd_overworld_header_offset

	.if	.defined(VS)
		ldy	#<(apu_music_super_star_vs_loop-apu_music_offsets)
	apu_music_base_load_loop_super_star:	
		sty	snd_super_star_header_offset
	.endif

	apu_music_base_load_do:
		ldy	#music_event::null
		sty	apu_music_event_current
		sta	apu_music_base_current
		cmp	#music_base::overworld
		bne	:+ ; if (music.base.current == overworld) {
			inc	snd_overworld_header_offset
			ldy	snd_overworld_header_offset
			cpy	#<(apu_music_overworld_loop_end-apu_music_offsets)+1
			bne	apu_music_header_load
			ldy	#<(apu_music_overworld_loop_offset-apu_music_offsets)
			bne	:-
		: ; }

	.if	.defined(VS)
		cmp	#music_base::super_star
		bne	:+ ; if (music.base.current == super_star) {
			inc	snd_super_star_header_offset
			ldy	snd_super_star_header_offset
			cpy	#<(apu_music_super_star_vs_loop_end-apu_music_offsets)+1
			bne	apu_music_header_load
			ldy	#<(apu_music_super_star_vs_loop-apu_music_offsets)
			bne	apu_music_base_load_loop_super_star
		: ; }
	.endif
	; }

	ldy	#<(apu_music_offsets_base_start-apu_music_offsets)
	sty	apu_pulse_2_offset
; --------------
apu_music_header_find:
	: ; for (bit of music.current) {
		iny

		lsr	a
		bcc	:-
	; }
; --------------
apu_music_header_load:
	.macro	APU_HEADER_LOAD_BASE
		1
	.endmacro
	.include	"./common/header_load.s"
	.delmac	APU_HEADER_LOAD_BASE
; --------------
apu_music_pulse_2:
	.macro	APU_PULSE_2_BASE
		1
	.endmacro
	.include	"./common/pulse_2.s"
	.delmac	APU_PULSE_2_BASE
; --------------
apu_music_pulse_1:
	.macro	APU_PULSE_1_BASE
		1
	.endmacro
	.include	"./common/pulse_1.s"
	.delmac APU_PULSE_1_BASE
; --------------
apu_music_triangle:
	.macro	APU_TRIANGLE_BASE
		1
	.endmacro
	.include	"./common/triangle.s"
	.delmac	APU_TRIANGLE_BASE
; --------------
apu_music_noise:
	.macro	APU_NOISE_BASE
		1
	.endmacro
	.include	"./common/noise.s"
	.delmac	APU_NOISE_BASE

	rts
