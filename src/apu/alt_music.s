.include	"system/apu.i"
.include	"system/fds.i"

.include	"mem.i"
.include	"sound.i"

.segment	"DATA3"

.if	.defined(OG_PAD)
.if	.defined(SMB2)
	.res	52, $FF
.elseif	.defined(ANN)
	.res	781, $FF
.endif
.endif
; ------------------------------------------------------------
	.export	apu_alt_cycle
apu_alt_cycle:
	.if	.defined(SMB2)
	lda	nmi_pause_flag
	beq	:+ ; if (SMB2 && paused) {
		lda	#fds_snd_vol_env::off|fds_snd_vol_env::dec|0
		sta	FDS_SND_VOL

		lsr	a
		sta	DMCSTATUS

		rts
	: ; } else {
	.endif
		lda	#$FF
		sta	DMCFRAMECOUNT

		lda	#dmcstatus::noise|dmcstatus::tri|dmcstatus::pulse_2|dmcstatus::pulse_1
		sta	DMCSTATUS

		jsr	apu_sfx_pulse_2_play
		jsr	apu_fds_music_play

		lda	#0
		sta	apu_music_base_req
		sta	apu_sfx_pulse_2_req

		rts
	; }
; ------------------------------------------------------------
	: jmp	:+++
; -----------------------------
	.export	apu_fds_next
apu_fds_music_play:
	lda	apu_music_base_req
	bne	:+
	lda	apu_fds_music_current
	bne	:- ; if (music.base.req == 0 && music.fds.current == 0) {
		rts
	: ; } else if (music.fds.current != 0) {
		ldy	#0
		sty	apu_fds_step
		sta	apu_fds_music_current
	
	apu_fds_next:
		inc	apu_fds_step
		ldy	apu_fds_step
		cpy	#<((apu_fds_music_offsets_end-apu_fds_music_offsets)+1)
		bne	:+ ; if (++this.step == end) {
			jmp	apu_fds_music_silence
		: ; } else {
			.macro	APU_HEADER_LOAD_FDS
				1
			.endmacro
			.include	"./common/header_load.s"
			.delmac	APU_HEADER_LOAD_FDS
		; }
	: ; }
; -----------------------------
apu_fds_music_pulse_2:
	.macro	APU_PULSE_2_FDS
		1
	.endmacro
	.include	"./common/pulse_2.s"
	.delmac	APU_PULSE_2_FDS
; --------------
apu_fds_music_pulse_1:
	.macro	APU_PULSE_1_FDS
		1
	.endmacro
	.include	"./common/pulse_1.s"
	.delmac	APU_PULSE_1_FDS
; --------------
apu_fds_music_triangle:
	.macro	APU_TRIANGLE_FDS
		1
	.endmacro
	.include	"./common/triangle.s"
	.delmac	APU_TRIANGLE_FDS
; --------------
APU_FDS_WAVE_FADE_FRAME	= 2

apu_fds_music_wave:
	lda	apu_fds_wave_offset
	bne	:+
	jmp	apu_fds_music_noise
	: ; if (this.offset != 0) {
		lda	apu_fds_wave_note_len
		cmp	#APU_FDS_WAVE_FADE_FRAME
		bne	:+ ; if (this.note_len == fade_frame) {
			lda	#fds_snd_vol_env::on|fds_snd_vol_env::dec|0
			sta	FDS_SND_VOL
		: dec	apu_fds_wave_note_len
		bne	:++++ ; } else if (--this.note_len == 0) {
			ldy	apu_fds_wave_offset
			inc	apu_fds_wave_offset
			lda	(apu_fds_track), y
			bpl	:+ ; if ((track[this.offset++] & SND_TRACK_NOTE_LEN)) {
				jsr	apu_fds_note_length_load
				sta	apu_fds_wave_note_len_b
				ldy	apu_fds_wave_offset
				inc	apu_fds_wave_offset
				lda	(apu_fds_track), y
			: ; }
		
			jsr	apu_fds_write_note_wave
			tay
			bne	:+ ; if ((y = this.write()) == 0) {
				ldx	#fds_snd_vol_env::off|fds_snd_vol_env::dec|0
				stx	FDS_SND_VOL
				bne	:++
			: ; } else {
				jsr	apu_fds_mod_get
				ldy	apu_fds_wave_env_start
			: ; }
			sty	apu_fds_wave_env_ctl
		
			ldy	#0
			sty	apu_fds_wave_vol_idx
			sty	apu_fds_wave_mod_idx

			lda	(apu_fds_wave_vol_addr), y
			sta	FDS_SND_VOL
			lda	(apu_fds_wave_mod_addr), y
			sta	FDS_SND_MOD_ENV

			lda	#0
			sta	FDS_SND_MOD_COUNT

			iny
			lda	(apu_fds_wave_vol_addr), y
			sta	apu_fds_wave_vol_len
			lda	(apu_fds_wave_mod_addr), y
			sta	apu_fds_wave_mod_len

			sty	apu_fds_wave_vol_idx
			sty	apu_fds_wave_mod_idx

			lda	apu_fds_wave_note_len_b
			sta	apu_fds_wave_note_len
		: ; }
	
		lda	apu_fds_wave_env_ctl
		beq	:++++ ; if (this.env_ctl > 0) {
			dec	apu_fds_wave_env_ctl
			dec	apu_fds_wave_vol_len
			bne	:+++ ; if (--this.vol_len == 0) {
				: ; for (this.vol_idx = 2; ((FDS_SND_VOL = this.vol_addr[this.vol_idx]) & env_off); ++this.vol_idx) {
					inc	apu_fds_wave_vol_idx
					ldy	apu_fds_wave_vol_idx
					lda	(apu_fds_wave_vol_addr), y
					bpl	:+ ; if ((this.vol_addr[this.vol_idx] & env_off)) {
						sta	FDS_SND_VOL
						bne	:-
					; } else break;
				: ; }
				sta	FDS_SND_VOL
			
				iny
				lda	(apu_fds_wave_vol_addr), y
				sta	apu_fds_wave_vol_len
				sty	apu_fds_wave_vol_idx
			: ; }
		
			dec	apu_fds_wave_mod_len
			bne	:+ ; if (--this.mod_len == 0) {
				inc	apu_fds_wave_mod_idx
				ldy	apu_fds_wave_mod_idx
				lda	(apu_fds_wave_mod_addr), y
				sta	FDS_SND_MOD_ENV

				iny
				lda	(apu_fds_wave_mod_addr), y
				sta	FDS_SND_MOD_FREQ_LO
				iny
				lda	(apu_fds_wave_mod_addr), y
				sta	FDS_SND_MOD_FREQ_HI

				iny
				lda	(apu_fds_wave_mod_addr), y
				sta	apu_fds_wave_mod_len
				sty	apu_fds_wave_mod_idx
			; }
		; }
	: ; }
; --------------
apu_fds_music_noise:
	.macro	APU_NOISE_FDS
		1
	.endmacro
	.include	"./common/noise.s"
	.delmac	APU_NOISE_FDS

	rts
