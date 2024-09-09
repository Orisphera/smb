.include	"system/ctrl.i"
.if	.defined(VS)
	.include	"system/vs.i"
.endif

.include	"mem.i"
.include	"joypad.i"

joypad_read_buffer	= zp_byte_00

	.export joypad_read
joypad_read:
	.if	.defined(CONS)
		lda	#1
		sta	CTRL0
		lsr	a
		tax
		sta	CTRL0
	.elseif	.defined(VS)
		lda	#vs_req::irq_rel|vs_req::ctrl_raise
		sta	VS_REQ
		lda	#vs_req::irq_rel|vs_req::ctrl_rel
		ldx	#0
		sta	VS_REQ
		lda	#0
	.endif

	jsr	joypad_read_do
	inx
; ----------------------------
joypad_read_do:
	ldy	#CTRL_BIT_COUNT
	: ; for (bit of ctrl[x].bits) {
		pha
		lda	CTRL0, x
		sta	joypad_read_buffer

		.if	.defined(CONS)
			lsr	a
			ora	joypad_read_buffer
		.endif

		lsr	a
		pla
		rol	a

		dey
		bne	:-
	; }

	sta	joypad_bits, x
	pha
	and	#joypad_button::select|joypad_button::start
	and	joypad_mask, x
	beq	:+ ; if ((joypad[x].val & joypad[x].mask).contains(select, start)) {
		pla
		and	#<~(joypad_button::select|joypad_button::start)
		sta	joypad_bits, x
		rts
	: ; } else {
		pla
		sta	joypad_mask, x
		rts
	; }
