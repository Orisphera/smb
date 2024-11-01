
.if	.defined(SMB2)
	.byte	$1F
	ora	($0E, x)
	adc	#$00
	.byte	$1F
	.byte	$0B
	sei
	and	$1FFF
	ora	($1E, x)
	pla
	asl	$FF
	asl	a:$05, x
	.byte	$FF
	rol	$8F
	ora	$AC
	lsr	$0F
	.byte	$1F
	.byte	$04
	inx
	bpl	LCAD7
	bcc	LCB07
	ora	($FB), y
	.byte	$3C
	.byte	$9B
	.byte	$B7
	.byte	$CB
	sta	$29
	.byte	$87
	sta	$07, x
	.byte	$EB
	.byte	$02
	.byte	$0B
	.byte	$82
	stx	$0E, y
	.byte	$C3
	asl	$1FFF
	ora	($E6, x)
	ora	($FF), y
	.byte	$3B
	stx	$7B
	brk
	.byte	$BB
	.byte	$02
	.byte	$2B
	stx	$057A
	.byte	$57
	.byte	$87
	.byte	$27
	.byte	$8F
	txs
	.byte	$0C
	.byte	$FF
	eor	$31, x
	ora	LCF01
	.byte	$33
	inc	$FE39, x
	.byte	$B2
	.byte	$2E
	.byte	$BE
	inc	$2931, x
	.byte	$8F
	.byte	$9E
	.byte	$43
	inc	$1630, x
	lda	($23), y
	ora	#$4E
	and	($4E), y
	rti
	.byte	$D7
	cpx	#$E6
	adc	($FE, x)
	rol	$62F5, x
	.byte	$FA
	rts
	.byte	$0C
	.byte	$DF
	.byte	$0C
	.byte	$DF
	.byte	$0C
	cmp	($1E), y
	.byte	$3C
	and	$4E40
	.byte	$32
	lsr	$5E36, x
	.byte	$42
	dec	$0D38
	.byte	$0B
	.byte	$8E
	.byte	$36
	stx	$8740
	.byte	$37
	stx	$36, y
	ldx	LCC3A, y
	eor	$BD06, x
	.byte	$07
	rol	$64A8, x
	clv
	.byte	$64
	iny
	.byte	$64
	cld
	.byte	$64
	inx
	.byte	$64
	sed
	.byte	$64
	inc	$0931, x
	sbc	($1A, x)
	rts
	adc	$9F41
	rol	$7D
	.byte	$C7
	sbc	$F100, x
	inc	$0DB5, x
	.byte	$02
	inc	$0734, x
	.byte	$CF
	dec	$0D00
	ora	$8D
	.byte	$47
	sbc	$0250, x
	.byte	$9F
	sec
	inc	$1201
	lda	$7B77, y
	dec	$6D0F, x
	.byte	$C7
	sbc	$FDFD, x
	brk
	lda	($0A, x)
	rts
	ora	$2861, y
	.byte	$62
	and	$5871, y
	.byte	$62
	adc	#$61
	.byte	$7A
	rts
	.byte	$7C
	sbc	$A5, x
	ora	($FE), y
	jsr	L801F
	lsr	$8021, x
	.byte	$3F
	.byte	$8F
	adc	$D6
	.byte	$74
	lsr	$6FA0, x
	ror	$9E
	and	($C3, x)
	.byte	$37
	.byte	$47
	.byte	$F3
	.byte	$9E
	jsr	L21FE
	ora	$5706
	.byte	$32
	.byte	$64
	ora	($66), y
	bpl	LCB0A
	.byte	$A7
	.byte	$87
	.byte	$27
	.byte	$0D
	.byte	$09
	ora	$5F4A, x
	sec
	adc	$AFC1
	rol	$6D
	.byte	$C7
	sbc	$1150, x
	.byte	$D7
	.byte	$73
	inc	$6F1A, x
	.byte	$E2
	.byte	$1F
	sbc	$BF
	.byte	$63
	.byte	$C7
	tay
	.byte	$DF
	adc	($15, x)
	sbc	($7F), y
	.byte	$62
	.byte	$9B
	.byte	$2F
	tay
	.byte	$72
	inc	$6910, x
	sbc	($B7), y
	and	$C5
	adc	($33), y
	ldy	$715F
	sta	$AA4A
	.byte	$14
	cmp	($71), y
	.byte	$17
	sta	$26, x
	.byte	$42
	.byte	$72
	.byte	$42
	.byte	$73
	.byte	$12
	.byte	$7A
	.byte	$14
	dec	$14
	cmp	$42, x
	inc	$7F11, x
	clv
	sta	LCFC1
	rol	$6D
	.byte	$C7
	sbc	a:$57, x
	.byte	$0B
	.byte	$3F
	.byte	$0B
	.byte	$BF
	.byte	$0B
	.byte	$BF
	.byte	$73
	rol	$9A, x
	bmi	LCB8C
	.byte	$64
	ldx	$31, y
	.byte	$D4
	adc	($0B, x)
	.byte	$BF
	.byte	$13
	.byte	$63
	lsr	a
	rts
	.byte	$53
	ror	$A5
	.byte	$34
	.byte	$B3
	.byte	$67
	sbc	$65
	.byte	$F4
	rts
	.byte	$0B
	.byte	$BF
	.byte	$14
	rts
	.byte	$53
	.byte	$67
	.byte	$67
	.byte	$32
	cpy	$62
	.byte	$D4
	and	($F3), y
	adc	($FA, x)
	rts
	.byte	$0B
	.byte	$BF
	.byte	$04
	bmi	LCC1A
	adc	($14, x)
	adc	$63
	adc	$6A
	rts
	.byte	$0B
	.byte	$BF
	.byte	$0F
	sec
	.byte	$0B
	.byte	$BF
	ora	$3E41, x
	.byte	$42
	.byte	$5F
	jsr	L40CE
	.byte	$0B
	.byte	$BF
	and	$FD47, x
.elseif	.defined(ANN)
.endif
; ------------------------------------------------------------
	.res	52, $FF
; ------------------------------------------------------------
