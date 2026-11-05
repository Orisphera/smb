.ifndef	CPU_I
CPU_I	= 1

BITS_IN_BYTE	= 8	; number of bits in a byte
BITS_IN_NIBBLE	= (BITS_IN_BYTE/2)	; number of bits in a nibble (half byte)
NIBBLES_IN_BYTE	= (BITS_IN_BYTE/BITS_IN_NIBBLE)	; number of nibbles in a byte
BYTE_MASK_LO	= $00FF	; low byte in word
BYTE_MASK_HI	= $FF00	; high byte in word
CHAR_MAX	= $FF	; maximum value of a byte
NIBBLE_MASK_LO	= $0F	; mask for low nibble
NIBBLE_MASK_HI	= $F0	; mask for high nibble
SIGN_BIT	= (1<<(BITS_IN_BYTE-1))		; sign bit
NIBBLE_SIGN_BIT	= (1<<((BITS_IN_NIBBLE-1)))	; nibble sign bit
OP_SIZE		= 1	; sizeof (opcode)
WORD_SIZE	= 2	; sizeof (addr)
PAGE_SIZE	= $100	; sizeof (page)
RAM_BASE	= $000	; origin of RAM
STACK_BASE	= (RAM_BASE+PAGE_SIZE)	; origin of stack
STACK_SIZE	= PAGE_SIZE		; sizeof (stack)
STACK_END	= (STACK_BASE+STACK_SIZE) ; end of stack
RAM_END		= (STACK_BASE+STACK_SIZE)+(6*PAGE_SIZE)	; end of RAM
RAM_MASK	= %0000011111111111	; mask for RAM address
MIRROR_MASK	= %0001100000000000	; mask for mirrored space
ROM_BASE	= $8000			; start of ROM
NMI		= $FFFA			; non-maskable interrupt vector
RESET		= $FFFC			; reset vector
IRQ		= $FFFE			; interrupt request vector

CPU_OPCODE_ASL_ABS	= $0E		; opcode for asl(absolute)
CPU_OPCODE_BIT_ABS	= $2C		; opcode for bit(absolute)
CPU_OPCODE_JMP		= $4C		; opcode for jmp
CPU_OPCODE_RTS		= $60		; opcode for rts
CPU_OPCODE_BCC		= $90		; opcode for bcc
CPU_OPCODE_BCS		= $B0		; opcode for bcs
CPU_OPCODE_LDA_AY	= $B9		; opcode for lda(absolute[y])
CPU_OPCODE_NOP		= $EA		; opcode for nop

.if	.defined(PAL)
CLOCK_FREQ_HZ	= 1662607		; PAL CPU frequency (Hz)
.else
CLOCK_FREQ_HZ	= 1789773		; NTSC CPU frequency (Hz)
.endif

.endif	; CPU_I
