.include	"system/cpu.i"
.include	"system/ppu.i"

.include	"mem.i"
.include	"math.i"
.include	"tunables.i"
.include	"chr.i"
.include	"sound.i"

; ------------------------------------------------------------
PLAYER_START_SCREEN_POS_X	= 96
PLAYER_START_SCREEN_POS_Y	= 88
PLAYER_RESIZE_FRAME_COUNT	= 10
; ------------------------------------------------------------
render_player_ani_frames	= zp_byte_00
render_player_do_bits		= zp_byte_00
render_player_row		= zp_byte_07
; ------------------------------------------------------------
	.export render_player
render_player:
	.if	.defined(VS_SMB)
		lda	#$FF
		nop
		nop
		nop
		nop
		nop
		nop
	.endif

	lda	timer_player_injury
	beq	:+
	lda	frame_count
	lsr	a
	bcs	render_player_rts
	: ; if (this.timer_injury == 0 || !(frame_count % 2)) {
		lda	player_proc_id
		cmp	#player_procs::death
		beq	render_player_death
		lda	player_resizing
		bne	render_player_resizing
		ldy	player_swimming
		beq	render_player_normal
		lda	state_player
		cmp	#player_state::ground
		beq	render_player_normal ; if (
		;	game.proc_id != death
		;	&& !this.resizing
		;	&& this.swimming
		;	&& this.state != ground
		; ) {
			jsr	render_player_normal

			lda	frame_count
			and	#MOD_8_4_UP
			bne	render_player_rts ; if ((frame_count % 8) < 4) {
				tax
				ldy	obj_data_offset_player
				lda	disp_dir_player
				lsr	a
				bcs	:+ ; if (this.disp_dir == left) {
					iny
					iny
					iny
					iny
				: ; }

				lda	player_size
				beq	:+
				lda	OAM_DMA_BUFFER+(OBJ_SIZE*PLAYER_SPR_OFFSET_FOOT_LEFT)+OBJ_CHR_NO, y
				cmp	render_player_tile_swim_small+(PLAYER_SPR_SIZE*PLAYER_SPR_SWIM_FOOT_ALTER_FRAME)+PLAYER_SPR_OFFSET_FOOT_LEFT
				beq	:++ ; if (player_size == large || obj[foot_l_offset].chr_no != foot_left_swim_small_2) {
					; if (player_size == small && obj[foot_l_offset].chr_no != foot_left_swim_small_2) {
						inx
					: ; }

					lda	render_player_swim_foot_left, x
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*PLAYER_SPR_OFFSET_FOOT_LEFT)+OBJ_CHR_NO, y
				: ; }
			; }
		; }
	; }

render_player_rts:
	rts
; -----------------------------
render_player_normal:
	jsr	render_player_action
	jmp	render_player_do
; -----------------------------
render_player_resizing:
	jsr	render_player_resize
	jmp	render_player_do
; -----------------------------
render_player_death:
	ldy	#<(render_player_tile_offset_death-render_player_tile_offsets)
	lda	render_player_tile_offsets, y
; -----------------------------
render_player_do:
	sta	render_player_spr_group
	lda	#PLAYER_ROW_COUNT
	jsr	render_player_tiles_init
	jsr	render_player_tiles_mirror
	lda	eng_timer_fireball_throw
	beq	:++ ; if (eng_timer_fireball_throw != 0) {
		ldy	#0
		lda	timer_ani_proj
		cmp	eng_timer_fireball_throw
		sty	eng_timer_fireball_throw
		bcs	:++ ; if (timer_ani_proj < eng_timer_fireball_throw) {
			sta	eng_timer_fireball_throw
			ldy	#<(render_player_tile_offset_proj-render_player_tile_offsets)
			lda	render_player_tile_offsets, y
			sta	render_player_spr_group

			ldy	#PLAYER_ROW_COUNT
			lda	veloc_x_player
			ora	joypad_l_r
			beq	:+ ; if (player.veloc_x != 0 || joypad_l_r.in(left, right)) {
				dey
			: ; }
			tya
			jsr	render_player_tiles_init
		; }
	: ; }

	lda	bits_offscr_player
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	sta	render_player_do_bits
	ldx	#PLAYER_ROW_COUNT-1
	lda	obj_data_offset_player
	clc
	adc	#(OBJ_SIZE*(((PLAYER_ROW_COUNT-1)*PLAYER_ROW_SIZE)))
	tay
	: ; for (row of this.sprite) {
		lda	#ENG_OAM_CLEAR_SCANLINE
		lsr	render_player_do_bits
		bcc	:+ ; if (this.bits_offscr & row_bit) {
			jsr	render_set_two_sprites_v
		: ; }

		tya
		sec
		sbc	#(PLAYER_ROW_SIZE*OBJ_SIZE)
		tay
		dex
		bpl	:--
	; }

	rts
; ------------------------------------------------------------
render_player_course_card_spr_desc:
	.byte	PLAYER_START_SCREEN_POS_Y
	.byte	1
	.byte	obj_attr::priority_high|obj_attr::color0
	.byte	PLAYER_START_SCREEN_POS_X
	.addr	bg_buffer_0-1
; -----------------------------
	.export render_player_course_card
render_player_course_card:
	ldx	#((render_chr_pair_arg_count+WORD_SIZE)-1)
	: ; for (arg of render_chr_pair_args) {
		lda	render_player_course_card_spr_desc, x
		sta	render_chr_pair_args, x

		dex
		bpl	:-
	; }

	ldx	#<(render_player_tile_stand_small-render_player_tile_data)
	ldy	#PLAYER_ROW_COUNT
	jsr	render_player_tiles
	lda	OAM_DMA_BUFFER+(OBJ_SIZE*9)+OBJ_ATTR
	ora	#obj_attr::h_flip
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*8)+OBJ_ATTR
	rts
; ------------------------------------------------------------
render_player_tiles_init:
	sta	render_player_row
	lda	pos_x_rel_player
	sta	player_scroll_x_b
	sta	render_chr_pair_pos_x
	lda	pos_y_rel_player
	sta	render_chr_pair_pos_y
	lda	disp_dir_player
	sta	render_chr_pair_color_mod_2
	lda	attr_player
	sta	render_chr_pair_attr
	ldx	render_player_spr_group
	ldy	obj_data_offset_player
; -----------------------------
render_player_tiles:
	: ; for (row of this.sprite) {
		lda	render_player_tile_data, x
		sta	render_chr_pair_tile_left
		lda	render_player_tile_data+1, x
		jsr	render_chr_pair
		dec	render_player_row
		bne	:-
	; }

	rts
; ------------------------------------------------------------
render_player_action:
	lda	state_player
	cmp	#player_state::climb
	beq	:++++++
	cmp	#player_state::fall
	beq	:++++
	cmp	#player_state::jump_swim
	bne	:+
	lda	player_swimming
	bne	:+++++++
	ldy	#<(render_player_tile_offset_crouch-render_player_tile_offsets)
	lda	player_crouch
	bne	:+++ ; if (this.state == jump && !this.crouch) {
		ldy	#PLAYER_TILES_OFFSET_JUMP
		jmp	:+++
	; }
	: ldy	#<(render_player_tile_offset_crouch-render_player_tile_offsets)
	lda	player_crouch
	bne	:++
	ldy	#PLAYER_TILES_OFFSET_STAND
	lda	veloc_x_player
	ora	joypad_l_r
	beq	:++
	lda	veloc_x_player_abs
	cmp	#PLAYER_SKID_VELOC_X_CUTOFF
	bcc	:++++
	lda	motion_dir_player
	and	disp_dir_player
	bne	:++++
	;	this.state == jump
	;	|| (this.state == ground && not_running)
	; ) {
		; if (this.state == ground && && skidding) {
			.if	.defined(SMB2M)
				lda	player_proc_id
				cmp	#player_procs::size_chg
				bcs	:+ ; if (this.proc_id < size_chg) {
					lda	#sfx_noise::skid
					sta	apu_noise_event
				: ; }
			.elseif	.defined(SMB)|.defined(VS_SMB)
				:
			.endif

			iny
		: ; }

	render_player_action_no_ani:
		jsr	render_player_get_size_offset
		lda	#0
		sta	player_ani_frame
		lda	render_player_tile_offsets, y
		rts
	: ; } else if (this.state == fall) {
		ldy	#PLAYER_TILES_OFFSET_WALK
		jsr	render_player_get_size_offset
		jmp	render_player_fall
	: ; } else if (this.state == ground && running) {
		ldy	#PLAYER_TILES_OFFSET_WALK
		jsr	render_player_get_size_offset
		jmp	render_player_ani_frames_3
	: ; } else if (this.state == climb) {
		ldy	#PLAYER_TILES_OFFSET_CLIMB
		lda	veloc_y_player
		beq	render_player_action_no_ani ; if (this.veloc_y != 0) {
			jsr	render_player_get_size_offset
			jmp	render_player_ani_frames_2
		; } else render_player_action_no_ani();
	: ; } else if (this.state == swimming) {
		ldy	#PLAYER_TILES_OFFSET_SWIM
		jsr	render_player_get_size_offset
		lda	timer_player_jump_swim
		ora	player_ani_frame
		bne	render_player_ani_frames_3
		lda	joypad_a_b
		asl	a
		bcs	render_player_ani_frames_3
	; }
; ------------------------------------------------------------
render_player_fall:
	lda	player_ani_frame
	jmp	render_player_spr_next
; ------------------------------------------------------------
render_player_ani_frames_3:
	lda	#3
	jmp	:+
; -----------------------------
render_player_ani_frames_2:
	lda	#2
; -----------------------------
render_player_animation:
	:
	sta	render_player_ani_frames
	jsr	render_player_fall
	pha

	lda	timer_ani_proj
	bne	:++ ; if (proj.timer_ani == 0) {
		lda	timer_player_ani
		sta	timer_ani_proj
		lda	player_ani_frame
		clc
		adc	#1
		cmp	render_player_ani_frames
		bcc	:+ ; if ((this.ani.frame + 1) >= render_player_ani_frames) {
			lda	#0
		: ; }
		sta	player_ani_frame
	: ; }

	pla
	rts
; ------------------------------------------------------------
render_player_get_size_offset:
	lda	player_size
	beq	:+ ; if (this.size != large) {
		tya
		clc
		adc	#<(render_player_tile_offset_small-render_player_tile_offsets)
		tay
	: ; }

	rts
; ------------------------------------------------------------
render_player_resize_frames:
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_medium-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_medium-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_medium-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_large-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_medium-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_large-render_player_tile_stand)/PLAYER_SPR_SIZE

	.byte	<(render_player_tile_stand_large-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_large-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_large-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_large-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_large-render_player_tile_stand)/PLAYER_SPR_SIZE
	.byte	<(render_player_tile_stand_small-render_player_tile_stand)/PLAYER_SPR_SIZE
; -----------------------------
render_player_resize:
	ldy	player_ani_frame
	lda	frame_count
	and	#MOD_4
	bne	:++ ; if (!(frame_count % 4)) {
		iny
		cpy	#PLAYER_RESIZE_FRAME_COUNT
		bcc	:+ ; if (this.ani_frame >= 10) {
			ldy	#0
			sty	player_resizing
		: ; }
		sty	player_ani_frame
	: ; }

	lda	player_size
	bne	:+ ; if (this.size == large) {
		lda	render_player_resize_frames, y
		ldy	#<(render_player_tile_offset_stand_small_b-render_player_tile_offsets)

	render_player_spr_next:
		asl	a
		asl	a
		asl	a
		adc	render_player_tile_offsets, y
		rts
	: ; } else {
		tya
		clc
		adc	#PLAYER_RESIZE_FRAME_COUNT
		tax

		ldy	#(PLAYER_TILES_OFFSET_SWIM+<(render_player_tile_offset_small-render_player_tile_offsets))
		lda	render_player_resize_frames, x
		bne	:+ ; if (render_player_resize_frames[x] == 0) {
			ldy	#(PLAYER_TILES_OFFSET_SWIM+<(render_player_tile_offset_large-render_player_tile_offsets))
		: ; }
		lda	render_player_tile_offsets, y
		rts
	; }
; ------------------------------------------------------------
render_player_tiles_mirror:
	ldy	obj_data_offset_player
	lda	player_proc_id
	cmp	#player_procs::death
	beq	:+
	lda	render_player_spr_group
	cmp	#<(render_player_tile_crouch_large-render_player_tile_data)
	beq	:++
	cmp	#<(render_player_tile_stand_small-render_player_tile_data)
	beq	:++
	cmp	#<(render_player_tile_stand_medium-render_player_tile_data)
	beq	:++
	cmp	#<(render_player_tile_stand_large-render_player_tile_data)
	bne	:+++ ; if ((this.proc_id == death) || (render_player_spr_group.in(crouch, stand))) {
		: ; if (this.proc_id == death) {
			lda	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
			and	#<~(obj_attr::v_flip|obj_attr::h_flip)
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
			lda	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y
			and	#<~(obj_attr::v_flip|obj_attr::h_flip)
			ora	#obj_attr::h_flip
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y
		: ; }

		lda	OAM_DMA_BUFFER+(OBJ_SIZE*6)+OBJ_ATTR, y
		and	#<~(obj_attr::v_flip|obj_attr::h_flip)
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*6)+OBJ_ATTR, y
		lda	OAM_DMA_BUFFER+(OBJ_SIZE*7)+OBJ_ATTR, y
		and	#<~(obj_attr::v_flip|obj_attr::h_flip)
		ora	#obj_attr::h_flip
		sta	OAM_DMA_BUFFER+(OBJ_SIZE*7)+OBJ_ATTR, y
	: ; }

	rts
