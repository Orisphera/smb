.include	"sys/apu.i"
.include	"sys/fds.i"

.include	"mem.i"
.include	"sound.i"

.segment	"DATA3"

	.export	apu_fds_wave_proc
apu_fds_wave_proc:
	lda	apu_fds_wave_id
	bne	:+
	rts ; if (apu_fds_wave_id != 0) {
		: ldy	#0
		: ; while (!((apu_fds_wave_id>>1)&1)) {
			iny
			lsr	a
			bcc	:-
		; }
	
		lda	apu_fds_wave_offsets-1, y
		tay
		lda	apu_fds_wave_offsets, y
		sta	apu_fds_wave_addr
		lda	apu_fds_wave_offsets+1, y
		sta	apu_fds_wave_addr+1
		lda	apu_fds_wave_offsets+2, y
		sta	apu_fds_wave_env_start
		lda	apu_fds_wave_offsets+3, y
		sta	apu_fds_wave_vol_addr
		lda	apu_fds_wave_offsets+4, y
		sta	apu_fds_wave_vol_addr+1
		lda	apu_fds_wave_offsets+5, y
		sta	apu_fds_wave_mod_addr
		lda	apu_fds_wave_offsets+6, y
		sta	apu_fds_wave_mod_addr+1
		lda	apu_fds_wave_offsets+7, y
		sta	apu_fds_wave_mod_offset
		jsr	apu_fds_wave_get
		lda	#fds_snd_wave_vol::bus_rel|fds_snd_wave_vol::vol_one_half
		sta	FDS_SND_WAVE_VOL
		rts
	; }
; -----------------------------
apu_fds_wave_get:
	lda	#fds_snd_wave_vol::bus_req|fds_snd_wave_vol::vol_full
	sta	FDS_SND_WAVE_VOL
	lda	#0
	sta	FDS_SND_RAM

	ldy	#0
	ldx	#(FDS_SND_RAM_END-FDS_SND_RAM)-1
	: ; for (y = 0; y < SND_WAVE_SAMPLES_LEN; y++) {
		lda	(apu_fds_wave_addr), y
		sta	FDS_SND_RAM+1, y

		iny
		cpy	#SND_WAVE_SAMPLES_LEN
		beq	:+
		sta	FDS_SND_RAM, x
		dex
		bne	:-
	: ; }

	lda	apu_fds_music_current
	and	#SND_FDS_VOL_FULL
	beq	:+ ; if ((music.fds.current & SND_FDS_VOL_FULL)) {
		lda	#fds_snd_wave_vol::bus_rel|fds_snd_wave_vol::vol_full
		beq	:++
	: ; } else {
		lda	#fds_snd_wave_vol::bus_rel|fds_snd_wave_vol::vol_two_fifths
	: ; }
	sta	FDS_SND_WAVE_VOL
; -----------------------------
apu_fds_mod_offset	= zp_byte_02

	.export	apu_fds_mod_get
apu_fds_mod_get:
	lda	#FDS_SND_MOD_ENV_4X
	sta	FDS_SND_MOD_FREQ_HI
	lda	#0
	sta	FDS_SND_MOD_COUNT

	ldx	#SND_WAVE_SAMPLES_LEN
	ldy	apu_fds_wave_mod_offset
	sty	apu_fds_mod_offset
	: ; for (x = SND_WAVE_SAMPLES_LEN; x > 0; x--) {
		lda	apu_fds_mod_offset
		lsr	a
		tay
		lda	apu_fds_mod, y
		bcs	:+ ; if ((apu_fds_mod_offset % 1) == 0) {
			lsr	a
			lsr	a
			lsr	a
			lsr	a
		: ; }
		and	#%00001111
		sta	FDS_SND_MOD_WRITE
	
		inc	apu_fds_mod_offset
		dex
		bne	:--
	; }

	rts
; -----------------------------
	.export	apu_fds_mod
	.export	apu_fds_mod_a
	.export	apu_fds_mod_b
apu_fds_mod:
apu_fds_mod_a:
	.byte	(0<<4)|(7<<0)
	.byte	(0<<4)|(7<<0)
	.byte	(0<<4)|(7<<0)
	.byte	(0<<4)|(7<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(1<<0)
	.byte	(0<<4)|(7<<0)
	.byte	(0<<4)|(7<<0)
	.byte	(0<<4)|(7<<0)
	.byte	(0<<4)|(7<<0)

apu_fds_mod_b:
	.byte	(7<<4)|(7<<0)
	.byte	(7<<4)|(7<<0)
	.byte	(7<<4)|(7<<0)
	.byte	(7<<4)|(7<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(1<<4)|(1<<0)
	.byte	(7<<4)|(7<<0)
	.byte	(7<<4)|(7<<0)
	.byte	(7<<4)|(7<<0)
	.byte	(7<<4)|(7<<0)
