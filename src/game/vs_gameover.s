.include	"system/ppu.i"

.include	"mem.i"
.include	"joypad.i"
.include	"sound.i"

sub_98DC:
	lda	VS_RAM_ARENA0+$17
	jsr	tbljmp
	.addr	sub_9919
	.addr	sub_995D
	.addr	sub_9A20
	.addr	sub_9A4E
	.addr	sub_9B38
	.addr	sub_9A20
	.addr	sub_953B
	.addr	sub_9E29

sub_98F2:
	lda	VS_RAM_ARENA0+$17
	jsr	tbljmp
	.addr	sub_9919
	.addr	sub_9A20
	.addr	sub_9F3B
	.addr	sub_9FC1
	.addr	sub_A01B
; ----------------------------
sub_9902:
	lda	#0
	sta	nmi_disp_disable
	lda	timer_screen
	bne	:+ ; if (!timer_screen) {
		lda	#music_event::none
		sta	apu_music_event
		inc	game_state
		lda	#0
		sta	VS_RAM_ARENA0+$17
	: ; }

	rts
; ----------------------------
sub_9919:
	lda	#1
	sta	nmi_disp_disable
	inc	VS_RAM_ARENA0+$17
	rts
; ----------------------------
data_9922:
	.byte	$DD, $E3
sub_9924:
	ldx	player_id
	lda	data_9922, x
	sta	zp_addr_04
	lda	#7
	sta	zp_addr_04+1
	rts
; ----------------------------
data_9931:
	.byte	<(VS_RAM_ARENA0+$BA)
	.byte	<(VS_RAM_ARENA0+$C1)
	.byte	<(VS_RAM_ARENA0+$C8)
	.byte	<(VS_RAM_ARENA0+$CF)
	.byte	<(VS_RAM_ARENA0+$D6)
	.byte	<(VS_RAM_ARENA0+$DD)
	.byte	<(VS_RAM_ARENA0+$E4)
	.byte	<(VS_RAM_ARENA0+$EB)
	.byte	<(VS_RAM_ARENA0+$F2)
	.byte	<(VS_RAM_ARENA0+$F9)

data_993B:
	.byte	<(VS_RAM_ARENA0+$75)
	.byte	<(VS_RAM_ARENA0+$78)
	.byte	<(VS_RAM_ARENA0+$7B)
	.byte	<(VS_RAM_ARENA0+$7E)
	.byte	<(VS_RAM_ARENA0+$81)
	.byte	<(VS_RAM_ARENA0+$84)
	.byte	<(VS_RAM_ARENA0+$87)
	.byte	<(VS_RAM_ARENA0+$8A)
	.byte	<(VS_RAM_ARENA0+$8D)
	.byte	<(VS_RAM_ARENA0+$90)

sub_9945:
	lda	data_9931, y
	sta	zp_addr_00
	lda	data_993B, y
	sta	zp_addr_06
	clc
	adc	#<(VS_RAM_ARENA0+$1D)
	sta	zp_byte_02
	lda	#>(VS_RAM_ARENA0)
	sta	zp_addr_00+1
	sta	zp_addr_02+1
	sta	zp_addr_06+1
	rts
; ----------------------------
sub_995D:
	jsr	sub_9924

	lda	#0
	sta	VS_RAM_ARENA0+$18
	lda	#9
	sta	VS_RAM_ARENA0+$22
	: ; for (vs_ram_arena[0x18] = 0; vs_ram_arena[0x18] < 9; vs_ram_arena[0x18]++) {
		ldy	VS_RAM_ARENA0+$18
		jsr	sub_9945

		ldy	#0
		: ; for (y = 0; zp_addr_04[y] > zp_addr_00[y] && y < 6; y++) {
			lda	(zp_addr_04), y
			cmp	(zp_addr_00), y
			bcc	:+
			bne	:+++

			iny
			cpy	#6
			bne	:-
		: ; }

		lda	VS_RAM_ARENA0+$18
		cmp	#9
		bne	:+ ; if (vs_ram_arena0[0x18] == 9) {
			jmp	sub_9A0C
		: ; }

		inc	VS_RAM_ARENA0+$18
		jmp	:----
	: ; }

        : ; while (vs_ram_arena0[0x22] < vs_ram_arena0[0x18]) {
                ldy	VS_RAM_ARENA0+$22
                cpy	VS_RAM_ARENA0+$18
                beq	:++++
                bcc	:++++

                jsr	sub_9945

                dey
                lda	data_9931, y
                sta	zp_addr_04
                lda	data_993B, y
                sta	zp_addr_ED
                clc
                adc	#$1D
                sta	zp_addr_EB
                lda	#>VS_RAM_ARENA0
                sta	zp_addr_04+1
                sta	zp_addr_EB+1
                sta	zp_addr_ED+1
                sty	VS_RAM_ARENA0+$22

                ldy	#7-1
                : ; for (y = 7-1; y >= 0; y--) {
                        lda	(zp_addr_04), y
                        sta	(zp_addr_00), y

                        dey
                        bpl	:-
                ; }

                ldy	#3-1
                : ; for (y = 3-1; y >=0; y--) {
                        lda	(zp_addr_EB), y
                        sta	(zp_addr_02), y

                        dey
                        bpl	:-
                ; }

                ldy	#2-1
                : ; for (y = 2-1; y >= 0; y--) {
                        lda	(zp_addr_ED), y
                        sta	(zp_addr_06), y

                        dey
                        bpl	:-
                ; }

                jmp	:----
        : ; }

        ldy	VS_RAM_ARENA0+$18
	jsr	sub_9945
	jsr	sub_9924

	ldy	#7-1
	lda	#0
	sta	(zp_addr_00), y
	dey
        : ; for (y = 6-1; y >= 0; y--) {
                lda	(zp_addr_04), y
                sta	(zp_addr_00), y

                dey
                bpl	:-
        ; }

	ldy	#3-1
        : ; for (y = 3-1; y >= 0; y--) {
                lda	#$24
                sta	(zp_addr_02), y

                dey
                bpl	:-
        ; }

	ldy	#course::no_01
	lda	course_no
	clc
	adc	#1
	sta	(zp_addr_06), y
	iny
	lda	player_goals
	clc
	adc	#1
	sta	(zp_addr_06), y
	jsr	sub_9919
	rts
; ----------------------------
sub_9A0C:
        lda	#0
	sta	VS_RAM_ARENA0+$17
	ldx	player_id
	lda	VS_RAM_ARENA0+$28, x
	beq	:+ ; if (vs_ram_arena0[0x28]) {
                inc	game_state
        : ; }
        inc	game_state
	rts
; ----------------------------
sub_9A20:
        jsr	nt_init
	jsr	oam_init
	inc	VS_RAM_ARENA0+$17
	lda	#0
	sta	VS_RAM_ARENA0+$22
	rts
; ----------------------------
data_9A2F:
        .byte	$23
	.byte	$2F
	.byte	$0C
; ----------------------------
sub_9A32:
        ldy	#0
	lda	(zp_addr_06), y
	sta	nmi_list_0_data, x
	inx
	lda	#$20
	sta	nmi_list_0_data, x
	inx
	lda	#$28
	sta	nmi_list_0_data, x
	inx
	iny
	lda	(zp_addr_06), y
	sta	nmi_list_0_data, x
	inx
	rts
; ----------------------------
sub_9A4E:
	lda	VS_RAM_ARENA0+$22
	bne	:+ ; if (!vs_ram_arena0[0x22]) {
                lda	#nmi_addr::addr_1E_F
                sta	nmi_addrs_ctl
                inc	VS_RAM_ARENA0+$22
                rts
        : ; } else if (vs_ram_arena0[0x22].in(1, 2, 3)) {
                cmp	#1
                bne	:+ ; if (vs_ram_arena0[0x22] == 1) {
                        ldy	#vschar1_bg_data::box
                        jmp	:+++
                : cmp	#2
                bne	:+ ; } else if (vs_ram_arena0[0x22] == 2) {
                        ldy	#vschar1_bg_data::name_register
                        jmp	:++
                : cmp	#3
                bne	:++ ; } else {
                        ldy	#vschar1_bg_data::stats
                : ; }
                jsr	screen_vschar1_load
                inc	VS_RAM_ARENA0+$22
                rts
        : ; } else {
                ldy	VS_RAM_ARENA0+$18
                jsr	sub_9945

                ldx	#0
                : ; for (x = 0; x < 3; x++) {
                        lda	data_9A2F, x
                        sta	nmi_list_0_data, x

                        inx
                        cpx	#3
                        bne	:-
                ; }

                jsr	sub_9A32
                jsr	sub_9AFF

                ldy	#0
                lda	(zp_addr_00), y
                bne	:+ ; if (!zp_addr_00) {
                        lda	#>PPU_VRAM_BG2
                : ; }
                sta	nmi_list_0_data, x

                inx
                iny
                : ; for (x = 3, y = 1; y < 7; x++, y++) {
                        lda	(zp_addr_00), y
                        sta	nmi_list_0_data, x

                        inx
                        iny
                        cpy	#7
                        bne	:-
                ; }

                lda	#0
                sta	nmi_list_0_data, x
                sta	VS_RAM_ARENA0+$22
                sta	nmi_disp_disable
                sta	VS_RAM_ARENA0+$1A
                sta	VS_RAM_ARENA0+$20
                sta	VS_RAM_ARENA0+$21
                sta	VS_RAM_ARENA0+$23
                sta	VS_RAM_ARENA0+$24
                inc	VS_RAM_ARENA0+$17

                ldy	#2
                sty	VS_RAM_ARENA0+$19
                : ; for (y = 3-1; y >= 0; y--) {
                        lda	#$24
                        sta	VS_RAM_ARENA0+$1C, y

                        dey
                        bpl	:-
                ; }

                lda	#$10
                sta	VS_RAM_ARENA0+$1F
                lda	#music_area::super_star
                sta	apu_music_area
                sta	VS_RAM_ARENA0+$1B
                rts
        ; }
; ----------------------------
sub_9AE3:
        iny
	cpy	#$0A
	bne	:+ ; if () {
                lda	#1
                sta	nmi_list_0_data, x
                inx
                lda	#0
                sta	nmi_list_0_data, x
                inx
                jmp	:++
        : ; } else {
                jsr	sub_9B0C
                tya
                sta	nmi_list_0_data, x
                inx
        : ; }

sub_9AFF:
        lda	#$AF
	sta	nmi_list_0_data, x
	inx
	rts
; ----------------------------
sub_9B06:
        lda	#$24
	sta	nmi_list_0_data, x
	inx

sub_9B0C:
        lda	#$24
	sta	nmi_list_0_data, x
	inx
	rts
; ----------------------------
data_9B13:
	.byte	$48, $68, $88

data_9B16:
	.byte	$2C, $3C, $4C, $5C
	.byte	$6C, $7C, $8C, $9C
	.byte	$AC, $BC, $CC

data_9B21:
	.byte	$2C, $3C, $4C, $5C
	.byte	$6C, $7C, $8C, $9C
	.byte	$B0, $C8

data_9B2B:
	.byte	$00, $0B

data_9B2D:
	.byte	$20, $21, $22, $23
	.byte	$2B, $28, $AF, $FA

data_9B35:
        .byte	$22, $F6, $03
data_9B35_end:
; ----------------------------
sub_9B38:
	lda	VS_RAM_ARENA0+$19
	bne	:+
	lda	VS_RAM_ARENA0+$1A
	bne	:+ ; if () {
		jsr	sub_9919
		jsr	sub_9D3C
		jmp	L9CB0
	: ; } else {
		lda	VS_RAM_ARENA0+$1B
		beq	:+ ; if (vs_ram_arena0[0x1B]) {
			dec	VS_RAM_ARENA0+$1B
			jmp	:+++
		: ; } else {
			lda	#$40
			sta	VS_RAM_ARENA0+$1B

			lda	VS_RAM_ARENA0+$1A
			bne	:+ ; if (!vs_ram_arena0[0x1A]) {
				lda	#9
				sta	VS_RAM_ARENA0+$1A
				dec	VS_RAM_ARENA0+$19

				jmp	:++
			: ; } else {
				dec	VS_RAM_ARENA0+$1A
			; }
		: ; }

		jsr	sub_9D4D
		and	#$0F
		bne	:+ ; if () {
			sta	VS_RAM_ARENA0+$25
			jmp	L9C31
		: ; } else {
			sta	VS_RAM_ARENA0+$25
			and	VS_RAM_ARENA0+$24
			beq	:+
			sta	VS_RAM_ARENA0+$25
			dec	VS_RAM_ARENA0+$1F
			lda	VS_RAM_ARENA0+$1F
			beq	:+
			jmp	L9C31

			: ; if () {
				lda	VS_RAM_ARENA0+$25
				and	#$01
				bne	:+
				lda	VS_RAM_ARENA0+$25
				and	#$02
				bne	:+++++ ; if () {
					lda	VS_RAM_ARENA0+$25
					and	#$08
					sta	VS_RAM_ARENA0+$25
					bne	L9C10
					lda	#4
					sta	VS_RAM_ARENA0+$25
					jmp	L9BCE
				: ; } else if ()_{
					sta	VS_RAM_ARENA0+$25
					inc	VS_RAM_ARENA0+$20
					lda	VS_RAM_ARENA0+$20
					cmp	#$0B
					beq	:+
					cmp	#$0A
					bne	:+++
					lda	VS_RAM_ARENA0+$21
					cmp	#2
					bne	:+++
					: ; if () {
						lda	#0
						sta	VS_RAM_ARENA0+$20
					L9BCE:
						inc	VS_RAM_ARENA0+$21
						lda	VS_RAM_ARENA0+$21
						cmp	#3
						beq	:+
						cmp	#2
						bne	:++
						lda	VS_RAM_ARENA0+$20
						cmp	#$0A
						bne	:++ ; if () {
							lda	#9
							sta	VS_RAM_ARENA0+$20
							jmp	:++
						: ; } else {
							lda	#0
							sta	VS_RAM_ARENA0+$21
						; }
					: ; }
					jmp	:+++++
				: ; } else { 
					sta	VS_RAM_ARENA0+$25
					lda	VS_RAM_ARENA0+$20
					beq	:+ ; if () {
						dec	VS_RAM_ARENA0+$20
						jmp	:++++
					: ; } else {
						lda	#$0A
						sta	VS_RAM_ARENA0+$20
						lda	VS_RAM_ARENA0+$21
						bne	:+ ; if () {
							lda	#9
							sta	VS_RAM_ARENA0+$20
						: ; }

					L9C10:
						lda	VS_RAM_ARENA0+$21
						beq	:+ ; if () {
							dec	VS_RAM_ARENA0+$21
							jmp	:++
						: ; } else {
							lda	#2
							sta	VS_RAM_ARENA0+$21
							lda	VS_RAM_ARENA0+$20
							cmp	#$0A
							bne	:+ ; if () {
								lda	#9
								sta	VS_RAM_ARENA0+$20
							; }
						; }
					; }
				: ; }

				lda	#$10
				sta	VS_RAM_ARENA0+$1F
			; }
		L9C31: ; }

		lda	VS_RAM_ARENA0+$25
		sta	VS_RAM_ARENA0+$24
		jsr	sub_9D4D
		and	#$80
		bne	:+
		sta	VS_RAM_ARENA0+$23
		jmp	:+++++++
		: cmp	VS_RAM_ARENA0+$23
		beq	:++++++ ; if () {
			sta	VS_RAM_ARENA0+$23
			lda	VS_RAM_ARENA0+$21
			cmp	#2
			bne	:+++
			lda	VS_RAM_ARENA0+$20
			cmp	#9
			bne	:+ ; if () {
				jsr	sub_9919
				jsr	sub_9D3C
				rts
			: cmp	#$08
			bne	:++ ; else if () {
				lda	VS_RAM_ARENA0+$22
				beq	:+ ; if () {
					dec	VS_RAM_ARENA0+$22
				: ; }
				ldx	VS_RAM_ARENA0+$22
				lda	#$24
				sta	VS_RAM_ARENA0+$1C, x
				jmp	:++++
			: ; } else {
				ldx	VS_RAM_ARENA0+$22
				cpx	#3
				beq	L9CB0
				ldy	VS_RAM_ARENA0+$21
				cpy	#2
				bne	:+ ; if () {
					ldy	VS_RAM_ARENA0+$20
					lda	data_9B2D, y
					jmp	:++
				: ; } else {
					lda	VS_RAM_ARENA0+$20
					clc
					adc	data_9B2B, y
					clc
					adc	#$0A
				: ; }
				sta	VS_RAM_ARENA0+$1C, x
				inc	VS_RAM_ARENA0+$22
				lda	VS_RAM_ARENA0+$22
				cmp	#3
				bne	:+ ; if () {
					lda	#2
					sta	VS_RAM_ARENA0+$21
					lda	#9
					sta	VS_RAM_ARENA0+$20
				: ; }
			; }
		; }
	; }

L9CB0:
        ldx	VS_RAM_ARENA0+$21
	lda	data_9B13, x
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_V
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_V
	clc
	adc	#PPU_TILE_HEIGHT_PX
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_V
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_V

	lda	#$32
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO
	lda	#$41
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO
	lda	#$42
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_CHR_NO
	lda	#$43
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_CHR_NO

	ldx	VS_RAM_ARENA0+$20
	lda	VS_RAM_ARENA0+$21
	cmp	#2
	bne	:+ ; if (vs_ram_arena0[0x21] == 2) {
                lda	data_9B21, x
                jmp	:++
        : ; } else {
                lda	data_9B16, x
        : ; }
        sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_POS_H
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_POS_H
	clc
	adc	#PPU_TILE_HEIGHT_PX
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_POS_H
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_POS_H

	lda	player_id
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR

	ldx	#(data_9B35_end-data_9B35)-1
        : ; for (x = 3-1; x > 0; x--) {
                lda	data_9B35, x
                sta	nmi_list_0_data+0, x
                lda	VS_RAM_ARENA0+$1C, x
                sta	nmi_list_0_data+3, x

                dex
                bpl	:-
        ; }

	lda	#>(PPU_VRAM_BG1+$305)
	sta	nmi_list_0_data+6
	lda	#<(PPU_VRAM_BG1+$305)
	sta	nmi_list_0_data+7
	lda	#2
	sta	nmi_list_0_data+8
	lda	VS_RAM_ARENA0+$19
	sta	nmi_list_0_data+9
	lda	VS_RAM_ARENA0+$1A
	sta	nmi_list_0_data+10
	lda	#0
	sta	nmi_list_0_data+11
	rts
; ----------------------------
sub_9D3C:
	ldy	VS_RAM_ARENA0+$18
	jsr	sub_9945
	ldy	#3-1
	: ; for (y = 3-1; y >= 0; y--) {
		lda	VS_RAM_ARENA0+$1C, y
		sta	(zp_addr_02), y

		dey
		bpl	:-
	; }

	rts
; ----------------------------
sub_9D4D:
	lda	player_count
	beq	:+ ; if (player_count > 0) {
		ldx	player_id
		lda	joypad_p1, x
		jmp	:++
	: ; } else {
		lda	joypad_p1
		ora	joypad_p2
	: ; }

	rts
; ----------------------------
	.export	sub_9D62
sub_9D62:
	ldy	zp_addr_04
	jsr	sub_9945
	lda	data_9E15, y
	sta	nmi_addr_1D, x
	inx
	lda	data_9E1F, y
	sta	nmi_addr_1D, x
	inx
	lda	#$15
	sta	nmi_addr_1D, x
	inx
	iny
	tya
	cmp	#$0A
	bne	:+ ; if (++zp_addr_04 == 0x0A) {
		lda	#1
		sta	nmi_addr_1D, x
		inx
		lda	#0
		sta	nmi_addr_1D, x
		inx
		jmp	:++
	: ; } else {
		jsr	sub_9DEA_b
		tya
		sta	nmi_addr_1D, x
		inx
	: ; }

	lda	#$AF
	sta	nmi_addr_1D, x
	inx
	jsr	sub_9DEA_b
	ldy	#0
	: ; for (y = 0; y < 3; x++, y++) {
		lda	(zp_addr_02), y
		sta	nmi_addr_1D, x

		inx
		iny
		cpy	#3
		bne	:-
	; }

	jsr	sub_9DEA
	ldy	#0
	lda	(zp_addr_06), y
	sta	nmi_addr_1D, x
	inx
	lda	#$20
	sta	nmi_addr_1D, x
	inx
	lda	#$28
	sta	nmi_addr_1D, x
	inx
	iny
	lda	(zp_addr_06), y
	sta	nmi_addr_1D, x
	inx
	jsr	sub_9DEA_b

	ldy	#0
	lda	(zp_addr_00), y
	bne	:+ ; if () {
		lda	#$24
	: ; }
	sta	nmi_addr_1D, x

	inx
	iny
	: ; for (y = 1; y < 7, x++, y++) {
		lda	(zp_addr_00), y
		sta	nmi_addr_1D, x

		inx
		iny
		cpy	#7
		bne	:-
	; }

	inc	zp_addr_04
	rts
; --------------------------------
sub_9DEA:
	lda	#$24
	sta	nmi_addr_1D, x
	inx
sub_9DEA_b:
	lda	#$24
	sta	nmi_addr_1D, x
	inx
	rts
; -------------------------------
	.export	sub_9DF7
sub_9DF7:
	lda	#0
	sta	nmi_disp_disable
	sta	VS_RAM_ARENA0+$22
	lda	#$14
	sta	VS_RAM_ARENA0+$1F
	inc	VS_RAM_ARENA0+$17
	lda	#$01
	sta	VS_RAM_ARENA0+$19
	lda	#$40
	sta	VS_RAM_ARENA0+$1A
	rts
; -------------------------------
data_9E12:
	.byte	$55, $24, $00

data_9E15:
	.byte	>(PPU_VRAM_BG1+$0E5)
	.byte	>(PPU_VRAM_BG1+$125)
	.byte	>(PPU_VRAM_BG1+$165)
	.byte	>(PPU_VRAM_BG1+$1A5)
	.byte	>(PPU_VRAM_BG1+$1E5)
	.byte	>(PPU_VRAM_BG1+$225)
	.byte	>(PPU_VRAM_BG1+$265)
	.byte	>(PPU_VRAM_BG1+$2A5)
	.byte	>(PPU_VRAM_BG1+$2E5)
	.byte	>(PPU_VRAM_BG1+$325)

data_9E1F:
	.byte	<(PPU_VRAM_BG1+$0E5)
	.byte	<(PPU_VRAM_BG1+$125)
	.byte	<(PPU_VRAM_BG1+$165)
	.byte	<(PPU_VRAM_BG1+$1A5)
	.byte	<(PPU_VRAM_BG1+$1E5)
	.byte	<(PPU_VRAM_BG1+$225)
	.byte	<(PPU_VRAM_BG1+$265)
	.byte	<(PPU_VRAM_BG1+$2A5)
	.byte	<(PPU_VRAM_BG1+$2E5)
	.byte	<(PPU_VRAM_BG1+$325)
; --------------------------------
sub_9E29:
	lda	VS_RAM_ARENA0+$19
	bne	:++
	lda	VS_RAM_ARENA0+$1A
	beq	:+
	and	#$80
	bne	:++
	lda	joypad_p1
	and	#joypad_button::select
	beq	:++
	: ; if (!vs_ram_arena0[0x19] || (!(vs_ram_arena0[0x19] & 0x80) && joypad_p1_select))) {
		lda	#music_area::none
		sta	apu_music_area
		jmp	sub_9A0C
	: ; }

	ldy	VS_RAM_ARENA0+$18
	jsr	sub_9945

	lda	VS_RAM_ARENA0+$1A
	sec
	sbc	#1
	sta	VS_RAM_ARENA0+$1A
	lda	VS_RAM_ARENA0+$19
	sbc	#0
	sta	VS_RAM_ARENA0+$19
	ldx	#0
	lda	data_9E15, y
	sta	nmi_list_0_data, x
	inx
	lda	data_9E1F, y
	sta	nmi_list_0_data, x
	inx
	lda	VS_RAM_ARENA0+$22
	and	#$01
	beq	:+++
	lda	VS_RAM_ARENA0+$1F
	bne	:+ ; if () {
		jsr	sub_9EDA_14
		rts
	: ; } else if () {
		ldy	#0
		: ; for (y = 0; y < 3; x++, y++) {
			lda	data_9E12, y
			sta	nmi_list_0_data, x
	
			inx
			iny
			cpy	#3
			bne	:-
		; }
	
		dec	VS_RAM_ARENA0+$1F
		rts
	: ; } else {
		lda	VS_RAM_ARENA0+$1F
		bne	:+ ; if () {
			jsr	sub_9EDA_0A
			rts
		: ; } else {
			lda	#$15
			sta	nmi_list_0_data, x
			inx
			jsr	sub_9AE3
			jsr	sub_9B0C

			ldy	#0
			: ; for (y = 0; y < 3; x++, y++) {
				lda	(zp_addr_02), y
				sta	nmi_list_0_data, x

				inx
				iny
				cpy	#3
				bne	:-
			; }

			jsr	sub_9B06
			jsr	sub_9A32
			jsr	sub_9B0C

			ldy	#0
			lda	(zp_addr_00), y
			bne	:+ ; if () {
				lda	#$24
			: ; }
			sta	nmi_list_0_data, x

			inx
			iny
			: ; for (y = 1; y < 7; x++, y++) {
				lda	(zp_addr_00), y
				sta	nmi_list_0_data, x

				inx
				iny
				cpy	#7
				bne	:-
			; }

			lda	#0
			sta	nmi_list_0_data, x
			dec	VS_RAM_ARENA0+$1F
			rts
		; }
	; }
; -------------------------------------------
sub_9EDA_0A:
	lda	#$0A
	sta	VS_RAM_ARENA0+$1F
	inc	VS_RAM_ARENA0+$22
	rts
; -------------------------------------------
sub_9EDA_14:
	lda	#$14
	sta	VS_RAM_ARENA0+$1F
	inc	VS_RAM_ARENA0+$22
	rts
; -------------------------------------------
data_9EEC:
	.byte	$21, $2A
	.byte	$0B, $12
	.byte	$17, $1C
	.byte	$0E, $1B
	.byte	$1D, $24
	.byte	$0C, $18
	.byte	$12, $17

data_9EFA:
	.byte	$20, $EA
	.byte	$0B, $19
	.byte	$1E, $1C
	.byte	$11, $24
	.byte	$0B, $1E
	.byte	$1D, $1D
	.byte	$18, $17

data_9F08:
	.byte	$22, $71, $02

data_9F0B:
	.byte	$21, $2A, $4B, $24

data_9F0F:
	.byte	$20, $EA, $4B, $24

data_9F13:
	.byte	$3F, $08
	.byte	$04, $14
	.byte	$36, $12
	.byte	$26, $00

data_9F1B:
	.byte	$23, $C0
	.byte	$60, $AA
	.byte	$23, $E0
	.byte	$60, $AA
	.byte	$00
; --------------------------------
sub_9F24:
	ldx	#9-1
	: ; for (x = 9-1; x >= 0; x--) {
		lda	data_9F1B, x
		sta	nmi_list_0_data, x

		dex
		bpl	:-
	; }

	inc	VS_RAM_ARENA0+$22
	rts
; -----------------------------------
data_9F33:
	.byte	$00
	.byte	$01
	.byte	$4C
	.byte	$4D
	.byte	$4A
	.byte	obj_attr::v_flip|$4A
	.byte	$4B
	.byte	obj_attr::v_flip|$4B
; -----------------------------------
sub_9F3B:
	lda	VS_RAM_ARENA0+$22 ; switch (vs_ram_arena0[0x22]) {
	bne	:+ ; case 0:
		lda	#nmi_addr::addr_1E_F
		sta	nmi_addrs_ctl
		inc	VS_RAM_ARENA0+$22
		rts
	: cmp	#1
	bne	:++ ; case 1:
		ldx	#7
		: ; for (x = 8-1; x >= 0; x--) {
			lda	data_9F13, x
			sta	nmi_list_0_data, x

			dex
			bpl	:-
		; }

		inc	VS_RAM_ARENA0+$22
		rts
	: cmp	#2
	bne	:+ ; case 2:
		jmp	sub_9F24
	: cmp	#3
	bne	:+ ; case 3: 
		ldy	#vschar1_bg_data::insert_coin
		jsr	screen_vschar1_load
		inc	VS_RAM_ARENA0+$22
		rts
	: ; default:
		jsr	sub_9DF7
		lda	#0
		sta	VS_RAM_ARENA0+$1A
		sta	VS_RAM_ARENA0+$18

		lda	#$80
		sta	zp_addr_00
		ldy	#7
		ldx	#$1F
		: ; for (i = 0x80; i > 0x60; i -= 8) {
			lda	#$80
			sta	zp_addr_00+1	
			lda	#2
			sta	zp_byte_02
			: ; for (j = 2; j > 0; j--) {
				lda	zp_addr_00+1
				sta	OAM_DMA_BUFFER+OBJ_POS_H-3, x
				sec
				sbc	#PPU_TILE_HEIGHT_PX
				sta	zp_addr_00+1
				dex
				lda	data_9F33, y
				and	#obj_attr::v_flip
				lsr	a
				ora	player_id
				sta	OAM_DMA_BUFFER+OBJ_ATTR-2, x
				dex
				lda	data_9F33, y
				and	#$7F
				sta	OAM_DMA_BUFFER+OBJ_CHR_NO-1, x
				dex
				lda	zp_addr_00
				sta	OAM_DMA_BUFFER+OBJ_POS_V, x
	
				dex
				dey
				dec	zp_byte_02
				bne	:-
			; }
	
			sec
			sbc	#8
			sta	zp_addr_00
			cmp	#$60
			bne	:--
		; }

		rts
	; }
; ---------------------------------------
sub_9FC1:
	lda	VS_RAM_ARENA0+$10
	beq	:++
	lda	VS_RAM_ARENA0+$18
	bne	:+ ; if () {
		lda	#1
		sta	nmi_disp_disable
		inc	VS_RAM_ARENA0+$18
		rts
	: ; else if () {
		ldy	#vschar1_bg_data::continue
		jsr	screen_vschar1_load
		jsr	sub_9DF7
		lda	#0
		sta	VS_RAM_ARENA0+$1A
		rts
	: ; } else {
		jsr	sub_A075
		ldx	#0
		lda	VS_RAM_ARENA0+$22
		and	#$01
		bne	:++
		lda	VS_RAM_ARENA0+$1F
		beq	:+ ; if () {
			jsr	sub_A0D7
			dec	VS_RAM_ARENA0+$1F
			jmp	sub_A0B2
		: ; else if () {
			jsr	sub_9EDA_0A
			jmp	sub_A0B2
		: ; } else {
			jsr	sub_A006
			rts
		; }
	; }
; --------------------------
sub_A006:
	lda	VS_RAM_ARENA0+$1F
	beq	:+ ; if (vs_ram_arena0[0x1F]) {
		jsr	sub_A0D7_b
		dec	VS_RAM_ARENA0+$1F
		jmp	:++
	: ; } else {
		jsr	sub_9EDA_14
	: ; }

	jsr	sub_A0B2
	rts
; -----------------------------
sub_A01B:
	lda	joypad_p1
	and	#joypad_button::select
	beq	:++++ ; if (joypad_p1_select) {
		lda	VS_RAM_ARENA0+$04
		beq	:+ ; if () {
			lda	#2
			bne	:++
		: ; } else {
			lda	#3
		: ; }
		sta	player_lives
	
		lda	#0
		sta	VS_RAM_ARENA0+$17
		sta	player_goals
		sta	course_sub
		inc	game_state
		jsr	sub_9924
	
		ldy	#6-1
		: ; for (y = 6-1; y >= 0; y--) {
			lda	#0
			sta	(zp_addr_04), y
	
			dey
			bpl	:-
		; }
	
		dec	VS_RAM_ARENA0+$10
		rts
	: ; } else {
		jsr	sub_A075
		jsr	vs_disp_credit_msg
		ldx	#$0C

		lda	VS_RAM_ARENA0+$22
		and	#$01
		bne	:++	
		lda	VS_RAM_ARENA0+$1F
		beq	:+ ; if (!(vs_ram_arena0[0x22] & 0x01) && vs_ram_arena0[0x1F]) {
			jsr	sub_A0D7
			dec	VS_RAM_ARENA0+$1F
			jmp	sub_A0B2
		: ; } else if (!(vs_ram_arena0[0x22] & 0x01)) {
			jsr	sub_9EDA_0A
			jmp	sub_A0B2
		: ; } else {
			jmp	sub_A006
			rts
		; }
	; }
; ------------------------------------
sub_A075:
	lda	VS_RAM_ARENA0+$19
	bne	:+	
	lda	VS_RAM_ARENA0+$1A
	bne	:+ ; if () {
		lda	#0
		sta	VS_RAM_ARENA0+$17
		sta	title_course_sel_on
		sta	ENG_HARDMODE_VAR
		inc	game_state
		rts
	: lda	VS_RAM_ARENA0+$1B
	beq	:+ ; } else if () {
		dec	VS_RAM_ARENA0+$1B
		jmp	:+++
	: ; } else {
		lda	#$48
		sta	VS_RAM_ARENA0+$1B

		lda	VS_RAM_ARENA0+$1A
		bne	:+ ; if () {
			lda	#9
			sta	VS_RAM_ARENA0+$1A
			dec	VS_RAM_ARENA0+$19
			jmp	:++
		: ; } else {
			dec	VS_RAM_ARENA0+$1A
		; }
	: ; }

	rts
; ---------------------------------
sub_A0B2:
	ldy	#0
	: ; for (y = 0; y < 3; x++, y++) {
		lda	data_9F08, y
		sta	nmi_list_0_data, x

		inx
		iny
		cpy	#3
		bne	:-
	; }

	ldy	#0
	: ; for (y = 0; y < 2; y++) {
		lda	VS_RAM_ARENA0+$19, y
		sta	nmi_list_0_data, x

		inx
		iny
		cpy	#2
		bne	:-
	; }

	lda	#0
	sta	nmi_list_0_data, x
	stx	nmi_list_0_offset
	rts
; ----------------------------------
sub_A0D7:
	ldy	#0
	: ; for (y = 0; y < 0x0E; x++, y++) {
		lda	VS_RAM_ARENA0+$17
		cmp	#3
		bne	:+ ; if (vs_ram_arena[0x17] == 3) {
			lda	data_9EEC, y
			jmp	:++
		: ; } else {
			lda	data_9EFA, y
		: ; }
		sta	nmi_list_0_data, x

		inx
		iny
		cpy	#$0E
		bne	:---
	; }

	rts
; -------------------------------
sub_A0D7_b:
	ldy	#0
	: ; for (y = 0; y < 4; y++) {
		lda	VS_RAM_ARENA0+$17
		cmp	#3
		bne	:+ ; if (vs_ram_arena[0x17] == 3) {
			lda	data_9F0B, y
			jmp	:++
		: ; } else {
			lda	data_9F0F, y
		: ; }
		sta	nmi_list_0_data, x

		inx
		iny
		cpy	#4
		bne	:---
	; }

	rts
