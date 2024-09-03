.include	"system/apu.i"

.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/sound.i"

; ------------------------------------------------------------
	.include	"../data/apu/envelope_stomp.s"
; -----------------------------
apu_pole:
	lda	#64
	sta	snd_sfx_pulse_1_len
	lda	#sound_notes::A3
	jsr	apu_write_note_pulse_1
	ldx	#channel_vol::duty_500|channel_vol::constant_vol|9
	bne	apu_pole_jump_comm_b
; --------------
apu_jump_small:
	lda	#sound_notes::A4
	bne	:+
; --------------
apu_jump_big:
	lda	#sound_notes::D4
; --------------
	: ldx	#channel_vol::duty_500|channel_vol::envelope|2
	ldy	#pulse_sweep::enable|pulse_sweep::period_3hf|pulse_sweep::shift_7
	jsr	apu_write_pulse_1
	lda	#40
	sta	snd_sfx_pulse_1_len
; --------------
apu_jump_continued:
	lda	snd_sfx_pulse_1_len
	cmp	#37
	bne	:+ ; if (this.len == 37) {
		ldx	#channel_vol::duty_250|channel_vol::constant_vol|15
		ldy	#pulse_sweep::enable|pulse_sweep::period_8hf|pulse_sweep::shift_6
		bne	apu_pole_jump_comm
	: ; }
	cmp	#32
	bne	apu_sfx_pulse_1_continued_c ; if (this.len == 32) {
		ldx	#channel_vol::duty_250|channel_vol::envelope|8
	; }
; --------------
apu_pole_jump_comm_b:
	ldy	#pulse_sweep::enable|pulse_sweep::period_4hf|pulse_sweep::negate|pulse_sweep::shift_4
; --------------
apu_pole_jump_comm:
	jsr	apu_write_base_pulse_1
	bne	apu_sfx_pulse_1_continued_c
; --------------
apu_proj:
	lda	#5
	ldy	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::negate|pulse_sweep::shift_1
	bne	:+
; --------------
apu_bump:
	lda	#10
	ldy	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::shift_3
; --------------
	: ldx	#channel_vol::duty_500|channel_vol::constant_vol|14
	sta	snd_sfx_pulse_1_len
	lda	#sound_notes::G3
	jsr	apu_write_pulse_1
; --------------
apu_bump_continued:
	lda	snd_sfx_pulse_1_len
	cmp	#6
	bne	:+ ; if (this.len == 6) {
		lda	#pulse_sweep::enable|pulse_sweep::period_4hf|pulse_sweep::negate|pulse_sweep::shift_3
		sta	PULSE1_SWEEP
	: ; }
; --------------
apu_sfx_pulse_1_continued_c:
	bne	apu_sfx_pulse_1_continued_b
; --------------
	.export	apu_sfx_pulse_1_play
apu_sfx_pulse_1_play:
	ldy	apu_pulse1_queue
	beq	:+
	sty	apu_sfx_pulse_1_current
	bmi	apu_jump_small
	lsr	apu_pulse1_queue
	bcs	apu_jump_big
	lsr	apu_pulse1_queue
	bcs	apu_bump
	lsr	apu_pulse1_queue
	bcs	apu_stomp
	lsr	apu_pulse1_queue
	bcs	apu_smack
	lsr	apu_pulse1_queue
	bcs	apu_pipe_entry
	lsr	apu_pulse1_queue
	bcs	apu_proj
	lsr	apu_pulse1_queue
	bcs	apu_pole
	: lda	apu_sfx_pulse_1_current
	beq	:+
	bmi	apu_jump_continued
	lsr	a
	bcs	apu_jump_continued
	lsr	a
	bcs	apu_bump_continued
	lsr	a
	bcs	apu_stomp_continued
	lsr	a
	bcs	apu_smack_continued
	lsr	a
	bcs	apu_pipe_entry_continued
	lsr	a
	bcs	apu_bump_continued
	lsr	a
	bcs	apu_sfx_pulse_1_continued
	: rts
; --------------
apu_stomp:
	lda	#14
	sta	snd_sfx_pulse_1_len
	ldy	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::negate|pulse_sweep::shift_4
	ldx	#channel_vol::duty_500|channel_vol::constant_vol|14
	lda	#sound_notes::A4
	jsr	apu_write_pulse_1
; --------------
apu_stomp_continued:
	ldy	snd_sfx_pulse_1_len
	lda	apu_stomp_envelope-1, y
	sta	PULSE1_VOL
	cpy	#6
	bne	:+ ; if (this.len == 6) {
		lda	#apu_chromatic_scale::F5-2
		sta	PULSE1_TIMER
	: ; }
; --------------
apu_sfx_pulse_1_continued_b:
	bne	apu_sfx_pulse_1_continued
; --------------
apu_smack:
	lda	#14
	ldy	#pulse_sweep::enable|pulse_sweep::period_5hf|pulse_sweep::negate|pulse_sweep::shift_3
	ldx	#channel_vol::duty_500|channel_vol::constant_vol|15
	sta	snd_sfx_pulse_1_len
	lda	#sound_notes::Ax4
	jsr	apu_write_pulse_1
	bne	apu_sfx_pulse_1_continued
; --------------
apu_smack_continued:
	ldy	snd_sfx_pulse_1_len
	cpy	#8
	bne	:+ ; if (this.len == 8) {
		lda	#apu_chromatic_scale::F5
		sta	PULSE1_TIMER
		lda	#channel_vol::duty_500|channel_vol::constant_vol|15
		bne	:++
	: ; } else {
		lda	#channel_vol::duty_500|channel_vol::constant_vol|0
	: ; }
	sta	PULSE1_VOL
; --------------
apu_sfx_pulse_1_continued:
	dec	snd_sfx_pulse_1_len
	bne	:+
; --------------
	.export	apu_sfx_pulse_1_stop
apu_sfx_pulse_1_stop:
	ldx	#sfx_pulse1::none
	stx	apu_sfx_pulse_1_current
	ldx	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2
	stx	DMCSTATUS
	ldx	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1
	stx	DMCSTATUS
	: rts
; --------------
apu_pipe_entry:
	lda	#47
	sta	snd_sfx_pulse_1_len

apu_pipe_entry_continued:
	lda	snd_sfx_pulse_1_len
	lsr	a
	bcs	:+
	lsr	a
	bcs	:+
	and	#MOD_16_8_UP>>2
	beq	:+ ; if ((this.len % 4) == 0 && ((this.len % 16) >= 8)) {
		ldy	#pulse_sweep::enable|pulse_sweep::period_2hf|pulse_sweep::shift_1
		ldx	#channel_vol::duty_500|channel_vol::constant_vol|10
		lda	#sound_notes::E6
		jsr	apu_write_pulse_1
	: ; }

	jmp	apu_sfx_pulse_1_continued
