.include	"system/apu.i"

.include	"engine/mem.i"
.include	"engine/sound.i"

; ------------------------------------------------------------
APU_NOISE_LEN_SKID		= 6
APU_NOISE_LEN_BLOCK_BREAK	= 32
APU_NOISE_LEN_FLAME		= 64
APU_NOISE_LEN_WIND		= 192
; ------------------------------------------------------------
	.if	.defined(SMB2)
	.include	"../data/apu/data_wind.s"
	.endif

	.include	"../data/apu/periods_block_break.s"

	.if	.defined(SMB2M)
	.include	"../data/apu/notes_skid.s"
	.endif
; --------------
.if	.defined(SMB2M)
apu_skid:
	sty	apu_noise_current
	lda	#APU_NOISE_LEN_SKID
	sta	snd_sfx_noise_len

apu_skid_continued:
	lda	snd_sfx_noise_len
	tay
	lda	apu_notes_skid-1, y
	sta	TRIANGLE_TIMER
	lda	#channel_counter::length_2
	sta	TRIANGLE_VOL
	sta	TRIANGLE_COUNTER
	bne	:+
.endif
; --------------
apu_block_break:
	.if	.defined(SMB2M)
		sty	apu_noise_current
	.endif

	lda	#APU_NOISE_LEN_BLOCK_BREAK
	sta	snd_sfx_noise_len
; --------------
apu_block_break_continued:
	lda	snd_sfx_noise_len
	lsr	a
	bcc	:+
	tay
	ldx	apu_block_break_periods, y
	lda	apu_block_break_envelope, y
; --------------
apu_sfx_noise_continued:
	sta	NOISE_VOL
	stx	NOISE_PERIOD
	lda	#channel_counter::length_2
	sta	NOISE_COUNTER
; --------------
	: dec	snd_sfx_noise_len
	bne	:+ ; if (--snd_sfx_noise_len == 0) {
		lda	#NOISE_VOL_HI_BITS|channel_vol::counter_halt|channel_vol::constant_vol|0
		sta	NOISE_VOL

		.if	.defined(SMB2M)
			lda	#0
			sta	TRIANGLE_VOL
		.endif

		lda	#sfx_noise::null
		sta	apu_noise_current
	: ; }

apu_sfx_noise_end:
	rts
; ------------------------------------------------------------
	.export	apu_sfx_noise_play
apu_sfx_noise_play:
	.if	.defined(SMB)|.defined(VS_SMB)
		ldy	apu_noise_event
		beq	:+ ; if (apu_noise_event != none) {
			sty	apu_noise_current
			lsr	apu_noise_event
			bcs	apu_block_break
			lsr	apu_noise_event
			bcs	apu_flame
		: ; }
	.endif

	lda	apu_noise_current
	.if	.defined(SMB)|.defined(VS_SMB)
		beq	:+ ; if (apu_noise_current != none) {
			lsr	a
			bcs	apu_block_break_continued
			lsr	a
			bcs	apu_flame_continued
		: ; }
	.elseif	.defined(SMB2M)
		bmi	apu_skid_continued
		ldy	apu_noise_event
		bmi	apu_skid
		lsr	apu_noise_event
		bcs	apu_block_break
		lsr	a
		bcs	apu_block_break_continued
		lsr	apu_noise_event
		bcs	apu_flame
		lsr	a
		bcs	apu_flame_continued

		.if	.defined(SMB2)
			lsr	a
			bcs	apu_wind_continued
			lsr	apu_noise_event
			bcs	apu_wind
		.endif
	.endif

	rts
; ------------------------------------------------------------
apu_flame:
	.if	.defined(SMB2M)
		sty	apu_noise_current
	.endif

	lda	#APU_NOISE_LEN_FLAME
	sta	snd_sfx_noise_len
; --------------
apu_flame_continued:
	lda	snd_sfx_noise_len
	lsr	a
	tay
	ldx	#noise_period::D10
	lda	apu_flame_envelope-1, y
	: bne	apu_sfx_noise_continued
; ------------------------------------------------------------
.if	.defined(SMB2)
apu_wind:
	sty	apu_noise_current

	lda	#APU_NOISE_LEN_WIND
	sta	snd_sfx_noise_len

apu_wind_continued:
	lsr	apu_noise_event
	bcc	apu_sfx_noise_end ; if () {
		lda	snd_sfx_noise_len
		lsr	a
		lsr	a
		lsr	a
		tay

		lda	apu_wind_data, y
		and	#NOISE_PERIOD_MASK
		ora	#noise_period::loop
		tax

		lda	apu_wind_data, y
		lsr	a
		lsr	a
		lsr	a
		lsr	a
		ora	#channel_vol::constant_vol
		bne	:-
	; }
.endif
