.include	"../../inc/engine/joypad.i"

.include	"../../inc/engine/unk.i"

; -----------------------------------------------------------
title_demo_buttons:
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
	.byte	0

title_demo_timers:
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

	rts
