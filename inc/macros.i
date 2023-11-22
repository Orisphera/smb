.ifndef MACROS_I
MACROS_I = 1

.include	"./system/ppu.i"

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

.endif	; MACROS_I
