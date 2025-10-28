.ifndef MACROS_I
MACROS_I = 1

.include	"sys/ppu.i"

; move the zeropage-addressed word into the dest address
.macro	movwz_m		src, dest
	lda	src
	sta	dest
	lda	src+1
	sta	dest+1
.endmacro

;  move the source word into the dest address
.macro	movw_m		src, dest
	lda	#.lobyte(src)
	sta	dest
	lda	#.hibyte(src)
	sta	dest+1
.endmacro

; set the PPU_VRAM_AR to the given word
.macro	ppuaddr_m	addr
	lda	#.hibyte(addr)
	sta	PPU_VRAM_AR
	lda	#.lobyte(addr)
	sta	PPU_VRAM_AR
.endmacro

; negate the accumulator
.macro	neg_m
	eor	#<-1
	clc
	adc	#1
.endmacro

; negate the accumulator, assuming carry is clear
.macro	neg_m_cc
	eor	#<-1
	adc	#1
.endmacro

.endif	; MACROS_I
