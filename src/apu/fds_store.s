.include	"sys/apu.i"
.include	"sys/fds.i"

.segment	"DATA3"

.macro	APU_STORE_FDS
	1
.endmacro
.include	"./common/store.s"
.delmac	APU_STORE_FDS
; ----------------------------------------------------------------------
	.export	apu_fds_write_note_wave
apu_fds_write_note_wave:
	ldx	#FDS_SND_MOD_ENV_4X
	stx	FDS_SND_FREQ+1
	tay
	lda	apu_fds_wave_notes, y
	sta	FDS_SND_FREQ+1
	lda	apu_fds_wave_notes+1, y
	sta	FDS_SND_FREQ
	rts
