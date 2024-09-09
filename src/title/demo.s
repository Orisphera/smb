.include	"mem.i"
.include	"joypad.i"

; -----------------------------------------------------------
title_demo_buttons:
.if	.defined(SMB)|.defined(VS_SMB)
	.byte	joypad_button::right
	.byte	joypad_button::face_a
	.byte	joypad_button::left
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_a
	.byte	joypad_button::right
	.byte	joypad_button::face_b|joypad_button::left
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::left
	.byte	joypad_button::left
	.byte	joypad_button::face_a
	.byte	joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_b|joypad_button::face_a|joypad_button::right
	.byte	joypad_button::right
	.byte	joypad_button::face_b|joypad_button::face_a|joypad_button::right
	.byte	joypad_button::right
	.byte	joypad_button::left
	.byte	joypad_button::face_a
	.byte	joypad_button::none
.elseif	.defined(SMB2)
	.byte	joypad_button::right
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::right
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::right
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::left
	.byte	joypad_button::right
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::none
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::none
	.byte	joypad_button::face_a
	.byte	joypad_button::right
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::right
	.byte	joypad_button::none
.elseif	.defined(ANN)
	.byte	joypad_button::right
	.byte	joypad_button::none
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::right
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::face_b|joypad_button::left
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::left
	.byte	joypad_button::right
	.byte	joypad_button::face_a|joypad_button::right
	.byte	joypad_button::none
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::left
	.byte	joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::right
	.byte	joypad_button::face_b|joypad_button::left
	.byte	joypad_button::face_a|joypad_button::face_b|joypad_button::left
	.byte	joypad_button::none
.endif

title_demo_timers:
.if	.defined(SMB)|.defined(VS_SMB)
	.byte	$9B
	.byte	$10
	.byte	$18
	.byte	$05
	.byte	$2C
	.byte	$20
	.byte	$24
	.byte	$15
	.byte	$5A
	.byte	$10
	.byte	$20
	.byte	$28
	.byte	$30
	.byte	$20
	.byte	$10
	.byte	$80
	.byte	$20
	.byte	$30
	.byte	$30
	.byte	$01
	.byte	$FF
	.byte	$00
.elseif	.defined(SMB2)
	.byte	$B0
	.byte	$10
	.byte	$10
	.byte	$10
	.byte	$28
	.byte	$10
	.byte	$28
	.byte	$06
	.byte	$10
	.byte	$10
	.byte	$0C
	.byte	$80
	.byte	$10
	.byte	$28
	.byte	$08
	.byte	$90
	.byte	$FF
	.byte	$00
.elseif	.defined(ANN)
	.byte	$90
	.byte	$70
	.byte	$40
	.byte	$18
	.byte	$20
	.byte	$10
	.byte	$2C
	.byte	$10
	.byte	$1C
	.byte	$70
	.byte	$78
	.byte	$08
	.byte	$40
	.byte	$20
	.byte	$20
	.byte	$40
	.byte	$40
	.byte	$20
	.byte	$B0
	.byte	$00
.endif
; ----------------------------
	.export title_demo
title_demo:
	ldx     title_demo_button_id
	lda	title_demo_button_timer
        bne     :+ ; if (!title_demo_button_timer) {
		inx
		inc     title_demo_button_id
		sec
		lda     title_demo_timers-1,x
		sta     title_demo_button_timer
		beq     :++
	: ; } if (title_demo_button_timer) {
		lda     title_demo_buttons-1,x
		sta     joypad_p1
		dec     title_demo_button_timer
		clc
	: ; }

	.if	.defined(VS)
		lda	#0
		sta	joypad_p2
	.endif

	rts
