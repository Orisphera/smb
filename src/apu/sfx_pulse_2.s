.include	"sys/apu.i"

.include	"mem.i"
.include	"sound.i"

; ----------------------------------------------------------------------
	.include	"../data/apu/sfx_data.s"
; ----------------------------------
apu_coin:
	lda	#53
	ldx	#channel_vol::duty_500|channel_vol::envelope|13
	bne	:+
; ----------------
apu_tick:
	lda	#6
	ldx	#channel_vol::duty_500|channel_vol::constant_vol|8
; ----------------
	: sta	snd_sfx_pulse_2_len
	ldy	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
	lda	#sound_notes::B5
	jsr	apu_write_pulse_2
; ----------------
apu_coin_continued_b:
	lda	snd_sfx_pulse_2_len
	cmp	#48
	bne	:+ ; if (this.len == 48) {
		lda	#apu_chromatic_scale::E6-1
		sta	PULSE2_TIMER
	: ; }
	bne	apu_sfx_pulse_2_continued
; ----------------
apu_blast:
	lda	#32
	sta	snd_sfx_pulse_2_len
	ldy	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::shift_4
	lda	#sound_notes::D3
	bne	:+
; ----------------
apu_blast_continued:
	lda	snd_sfx_pulse_2_len
	cmp	#24
	bne	apu_sfx_pulse_2_continued ; if (this.len == 24) {
		ldy	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::shift_3
		lda	#sound_notes::D4
	; }
; ----------------
	: bne	apu_sfx_pulse_2_set_c
; ----------------
apu_powerup:
	lda	#(apu_powerup_data_end-apu_powerup_data)*2
	sta	snd_sfx_pulse_2_len
; ----------------
apu_powerup_continued:
	lda	snd_sfx_pulse_2_len
	lsr	a
	bcs	apu_sfx_pulse_2_continued ; if (!(this.len % 2)) {
		tay
		lda	apu_powerup_data-1, y
		ldx	#channel_vol::duty_250|channel_vol::constant_vol|13
		ldy	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
	; }
; ----------------
apu_sfx_pulse_2_set:
	jsr	apu_write_pulse_2
; ----------------
apu_sfx_pulse_2_continued:
	dec	snd_sfx_pulse_2_len
	bne	:+
; ----------------
apu_sfx_pulse_2_stop:
	ldx	#sfx_pulse_2::none
	stx	apu_sfx_pulse_2_current
; ----------------
	.export	apu_sfx_pulse_2_mute
apu_sfx_pulse_2_mute:
	ldx	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_1
	stx	DMCSTATUS
	ldx	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1
	stx	DMCSTATUS
	: rts
; ----------------
	.export	apu_sfx_pulse_2_play
apu_sfx_pulse_2_play:
	lda	apu_sfx_pulse_2_current
	and	#sfx_pulse_2::oneup
	bne	apu_oneup_continued
	ldy	apu_sfx_pulse_2_req
	beq	:+
	sty	apu_sfx_pulse_2_current
	bmi	apu_bowser_fall
	lsr	apu_sfx_pulse_2_req
	bcs	apu_coin
	lsr	apu_sfx_pulse_2_req
	bcs	apu_spawn_powerup
	lsr	apu_sfx_pulse_2_req
	bcs	apu_spawn_vine
	lsr	apu_sfx_pulse_2_req
	bcs	apu_blast
	lsr	apu_sfx_pulse_2_req
	bcs	apu_tick
	lsr	apu_sfx_pulse_2_req
	bcs	apu_powerup
	lsr	apu_sfx_pulse_2_req
	bcs	apu_oneup
	: lda	apu_sfx_pulse_2_current
	beq	:+
	bmi	apu_bowser_fall_continued
	lsr	a
	bcs	apu_coin_continued
	lsr	a
	bcs	apu_spawn_continued
	lsr	a
	bcs	apu_spawn_continued
	lsr	a
	bcs	apu_blast_continued
	lsr	a
	bcs	apu_coin_continued
	lsr	a
	bcs	apu_powerup_continued
	lsr	a
	bcs	apu_oneup_continued
	: rts
; ----------------
apu_coin_continued:
	jmp	apu_coin_continued_b
; ----------------
apu_sfx_pulse_2_continued_b:
	jmp	apu_sfx_pulse_2_continued
; ----------------
apu_bowser_fall:
	lda	#56
	sta	snd_sfx_pulse_2_len
	ldy	#pulse_sweep::enable|pulse_sweep::period_5hf|pulse_sweep::shift_4
	lda	#sound_notes::D4
; ----------------
apu_sfx_pulse_2_set_c:
	bne	:+
; ----------------
apu_bowser_fall_continued:
	lda	snd_sfx_pulse_2_len
	cmp	#8
	bne	apu_sfx_pulse_2_continued ; if (this.len == 8) {
		ldy	#pulse_sweep::enable|pulse_sweep::period_3hf|pulse_sweep::shift_4
		lda	#sound_notes::G2
	; }
; ----------------
	: ldx	#channel_vol::duty_500|channel_vol::constant_vol|15
; ----------------
apu_sfx_pulse_2_set_b:
	bne	apu_sfx_pulse_2_set
; ----------------
apu_oneup:
	lda	#48
	sta	snd_sfx_pulse_2_len
; ----------------
apu_oneup_continued:
	lda	snd_sfx_pulse_2_len
	ldx	#3
	: ; for (x = 3; x > 0; x--) {
		lsr	a
		bcs	apu_sfx_pulse_2_continued_b

		dex
		bne	:-
	; }

	tay
	lda	apu_oneup_data-1, y
	ldx	#channel_vol::duty_500|channel_vol::envelope|2
	ldy	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
	bne	apu_sfx_pulse_2_set_b
; ----------------
apu_spawn_powerup:
	lda	#(apu_spawn_data_powerup_end-apu_spawn_data)
	bne	:+
; ----------------
apu_spawn_vine:
	lda	#(apu_spawn_data_vine_end-apu_spawn_data)
; ----------------
	: sta	snd_sfx_pulse_2_len
	lda	#pulse_sweep::period_8hf|pulse_sweep::negate|pulse_sweep::shift_7
	sta	PULSE2_SWEEP
	lda	#0
	sta	snd_sfx_counter
; ----------------
apu_spawn_continued:
	inc	snd_sfx_counter
	lda	snd_sfx_counter
	lsr	a
	tay
	cpy	snd_sfx_pulse_2_len
	beq	:+ ; if (this.len != (snd_sfx_counter / 2)) {
		lda	#channel_vol::duty_500|channel_vol::constant_vol|13
		sta	PULSE2_VOL
		lda	apu_spawn_data, y
		jsr	apu_write_note_pulse_2
		rts
	: ; } else {
		jmp	apu_sfx_pulse_2_stop
	; }
