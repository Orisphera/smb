.include	"system/ppu.i"

.include	"mem.i"
.include	"math.i"
.include	"tunables.i"
.include	"chr.i"

; ------------------------------------------------------------
render_actor_data_offset	= zp_byte_EB
render_actor_state_next		= zp_byte_EC
render_actor_state_prev		= zp_byte_ED
render_obj_id_actor			= zp_byte_EF
; ------------------------------------------------------------
	.export render_actor
render_actor:	
	.if	.defined(SMB2M)
		.if	.defined(SMB2)
			lda	#obj_attr::priority_high|obj_attr::color2
			ldy	course_no
			cpy	#course::no_02
			beq	:+
			cpy	#course::no_03
			beq	:+
			cpy	#course::no_07
			bne	:++
			: ; if (course_no.in(2, 3, 7)) {
				lsr	a
			: ; }
		.elseif	.defined(ANN)
			lda	#0
			sta	render_clear_skip
			lda	#$02
	
			ldy	ENG_HARDMODE_VAR
			beq	:+ ; if (game.hard_mode) {
				jsr	game_hard_mode_render_spring
			: ; }
		.endif

		sta	render_actor_attrs_spring+0
		sta	render_actor_attrs_spring+1
		sta	render_actor_attrs_spring+2
	.endif

	lda	pos_y_lo_actor, x
	sta	render_chr_pair_pos_y
	lda	pos_x_rel_actor
	sta	render_chr_pair_pos_x
	ldy	obj_data_offset_actor, x
	sty	render_actor_data_offset
	lda	#0
	sta	render_actor_flipped
	lda	motion_dir_actor, x
	sta	render_chr_pair_color_mod_2
	lda	attr_actor, x
	sta	render_chr_pair_attr
	lda	obj_id_actor, x
	cmp	#actor::piranha_plant
	bne	:+
	ldy	veloc_x_actor, x
	bmi	:+
	ldy	timer_ani_actor, x
	beq	:+ ; if (this.id == piranha_plant && this.veloc_x >= 0 && this.timer_ani != 0) {
		rts
	: ; }

	lda	state_actor, x
	sta	render_actor_state_prev
	and	#<~(actor_states::spawned|actor_states::falling|actor_states::bit_5)
	tay
	lda	obj_id_actor, x ; switch (this.id) {
	cmp	#actor::toad
	bne	:+ ; case "toad":
		ldy	#actor_states::init
		lda	#$01
		sta	render_chr_pair_color_mod_2
		lda	#actor::actors_page_b
	: cmp	#actor::bullet
	bne	:++ ; case "bullet":
		dec	render_chr_pair_pos_y

		lda	#obj_attr::priority_high|obj_attr::color3
		ldy	timer_ani_actor, x
		beq	:+ ; if (this.timer_ani != 0) {
			ora	#obj_attr::priority_low
		: ; }
		sta	render_chr_pair_attr

		ldy	#actor_states::init
		sty	render_actor_state_prev
		lda	#actor::bullet_swarm
	: cmp	#actor::spring
	bne	:+ ; case "spring":
		ldy	#actor_states::state_3
		ldx	player_on_spring
		lda	render_actor_spring_ani_ids, x
	: ; }
	sta	render_obj_id_actor
	sty	render_actor_state_next

	ldx	actor_index
	cmp	#actor::podoboo
	bne	:+
	lda	veloc_y_actor, x
	bmi	:+ ; if (this.id == podoboo && this.veloc_y >= 0) {
		inc	render_actor_flipped
	: ; }

	lda	actor_bowser_ani_frame
	beq	:++ ; if (actor_bowser_ani_frame > 0) {
		ldy	#actor::fireworks
		cmp	#1
		beq	:+ ; if (actor_bowser_ani_frame == 1) {
			iny
		: ; }
		sty	render_obj_id_actor
	: ; }

	ldy	render_obj_id_actor
	cpy	#actor::goomba
	bne	:++ ; if (this.id == goomba) {
		lda	state_actor, x
		cmp	#actor_states::state_2
		bcc	:+ ; if (this.state >= state_2) {
			ldx	#actor_states::state_4
			stx	render_actor_state_next
		: ; }

		and	#actor_states::bit_5
		ora	game_timer_stop
		bne	:+
		lda	frame_count
		and	#MOD_16_8_UP
		bne	:+ ; if ((this.bit_5 || game_timer_stop) && (frame_count & 16) >= 8) {
			lda	render_chr_pair_color_mod_2
			eor	#%00000011
			sta	render_chr_pair_color_mod_2
		; }
	: ; }

	lda	render_actor_attrs, y
	ora	render_chr_pair_attr
	sta	render_chr_pair_attr
	lda	render_actor_tile_offsets, y
	tax
	ldy	render_actor_state_next
	lda	actor_bowser_ani_frame
	beq	:++++++ ; if (actor_bowser_ani_frame > 0) {
		cmp	#1
		bne	:++++ ; if (actor_bowser_ani_frame == 1) {
			lda	actor_bowser_ani_flag
			bpl	:+ ; if (actor_bowser_ani.mouth_closed) {
				ldx	#<(render_actor_tiles_bowser_mouth_closed-render_actor_tile_data)
			: ; }

			lda	render_actor_state_prev
			and	#actor_states::bit_5
			beq	:++
		; }

		: ; if ((this.state & bit_5)) {
			stx	render_actor_flipped
		: ; }
		jmp	render_actor_tiles

		: ; if (actor_bowser_ani_frame > 1) {
			lda	actor_bowser_ani_flag
			and	#actor_bowser_ani::left_step
			beq	:+ ; if (actor_bowser_ani.left_step) {
				ldx	#<(render_actor_tiles_bowser_step_left-render_actor_tile_data)
			: ; }

			lda	render_actor_state_prev
			and	#actor_states::bit_5
			beq	:--- ; if ((this.state & bit_5)) {
				lda	render_chr_pair_pos_y
				sec
				sbc	#16
				sta	render_chr_pair_pos_y
				jmp	:----
			; }
		; }
	: ; }

	cpx	#<(render_actor_tiles_spiny-render_actor_tile_data)
	bne	:++ ; if (this.id == spiny) {
		cpy	#actor_states::state_5
		bne	:+ ; if (this.state_next == state_5) {
			ldx	#<(render_actor_tiles_spiny_egg-render_actor_tile_data)
			lda	#$02
			sta	render_chr_pair_color_mod_2
			lda	#actor_states::state_5
			sta	render_actor_state_next
		: ; }

		jmp	render_actor_ani_check
	: ; }

	cpx	#<(render_actor_tiles_lakitu-render_actor_tile_data)
	bne	:++ ; if (this.id == lakitu) {
		lda	render_actor_state_prev
		and	#actor_states::bit_5
		bne	:+
		lda	timer_swarm
		cmp	#16
		bcs	:+ ; if (!this.bit_5 && this.timer_swarm < 16) {
			ldx	#<(render_actor_tiles_lakitu_duck-render_actor_tile_data)
		: ; }

		jmp	render_actor_ani_do
	: ; }

	lda	render_obj_id_actor
	cmp	#actor::koopa_cutoff
	bcs	:+
	cpy	#actor::buzzy_beetle
	bcc	:+ ; if (this.id < koopa_cutoff && y >= buzzy_beetle) {
		ldx	#<(render_actor_tiles_koopa_stun_flip-render_actor_tile_data)

		ldy	render_obj_id_actor
		cpy	#actor::buzzy_beetle
		bne	:+ ; if (this.id == buzzy_beetle) {
			ldx	#<(render_actor_tiles_buzzy_stun-render_actor_tile_data)
			inc	render_chr_pair_pos_y
		; }
	: ; }

	lda	render_actor_state_next
	cmp	#actor_states::state_4
	bne	:++ ; if (this.state_next == state_4) {
		ldx	#<(render_actor_tiles_buzzy_stun_flip-render_actor_tile_data)
		inc	render_chr_pair_pos_y
		ldy	render_obj_id_actor
		cpy	#actor::buzzy_beetle
		beq	:+ ; if (this.id != buzzy_beetle) {
			ldx	#<(render_actor_tiles_koopa_stun-render_actor_tile_data)
			inc	render_chr_pair_pos_y
		: cpy	#actor::goomba
		bne	:+ ; } else if (this.id == goomba) {
			ldx	#<(render_actor_tiles_goomba-render_actor_tile_data)

			lda	render_actor_state_prev
			and	#actor_states::bit_5
			bne	:+ ; if (!(this.state & bit_5)) {
				ldx	#<(render_actor_tiles_goomba_stomped-render_actor_tile_data)
				dec	render_chr_pair_pos_y
			; }
		; }
	: ; }

; ------------------------------------------------------------
render_actor_ani_check:
	ldy	actor_index
	lda	render_obj_id_actor
	cmp	#actor::hammer_bro
	bne	:+
	lda	render_actor_state_prev
	beq	:++
	and	#actor_states::bit_3
	beq	render_actor_ani_do
	ldx	#<(render_actor_tiles_hammer_bro_b-render_actor_tile_data)
	bne	:++
	: cpx	#<(render_actor_tiles_cheep-render_actor_tile_data)
	beq	:+
	lda	timer_actor, y
	cmp	#5
	bcs	render_actor_ani_do
	cpx	#<(render_actor_tiles_blooper-render_actor_tile_data)
	bne	:+
	cmp	#1
	beq	render_actor_ani_do ; if () {
		inc	render_chr_pair_pos_y
		inc	render_chr_pair_pos_y
		inc	render_chr_pair_pos_y
		jmp	:+++
	: lda	render_obj_id_actor
	cmp	#actor::goomba
	beq	render_actor_ani_do
	cmp	#actor::bullet_swarm
	beq	render_actor_ani_do
	cmp	#actor::podoboo
	beq	render_actor_ani_do
	cmp	#actor::swarm_stop
	bcs	render_actor_ani_do
	ldy	#0
	cmp	#actor::bowser_flame
	bne	:+ ; } else if () {
		; if () {
			iny

			.if	.defined(SMB2M)
				lda	#actor_states::state_3
				sta	render_actor_state_next
			.endif

			lda	course_no
			cmp	#course::no_08
			bcs	render_actor_ani_do

			.if	.defined(ANN)
				inc	render_clear_skip
			.endif

			ldx	#<(render_actor_tiles_toad-render_actor_tile_data)

			.if	.defined(SMB)|.defined(VS_SMB)
				lda	#actor_states::state_3
				sta	render_actor_state_next
			.endif

			bne	render_actor_ani_do
		: ; }

		lda	frame_count
		and	render_actor_frame_modulos, y
		bne	:++
	; }

	: ; if () {
		lda	render_actor_state_prev
		and	#actor_states::spawned|actor_states::bit_5
		ora	game_timer_stop
		bne	:+ ; if ((this.spawned | this.bit_5) | game_timer_stop) {
			txa
			clc
			adc	#ACTOR_SPR_SIZE
			tax
		; }
	: ; }
; ------------------------------
render_actor_ani_do:
	.if	.defined(SMB2M)
		lda	render_obj_id_actor
		cmp	#actor::piranha_plant_b
		beq	:+
	.endif
	lda	render_actor_state_prev
	and	#actor_states::bit_5
	beq	:++
	lda	render_obj_id_actor
	cmp	#actor::koopa_cutoff
	bcc	:++
	: ; if ((SMB2M && this.id == piranha_plant_b) || ((this.state & bit_5) && this.id >= koopa_cutoff)) {
		ldy	#1
		sty	render_actor_flipped
		dey
		sty	render_actor_state_next
	: ; }
; ------------------------------
render_actor_tiles:
	ldy	render_actor_data_offset
	jsr	render_actor_chr_pair
	jsr	render_actor_chr_pair
	jsr	render_actor_chr_pair
	ldx	actor_index
	ldy	obj_data_offset_actor, x
	lda	render_obj_id_actor
	cmp	#actor::bullet_swarm
	bne	:++
render_actor_clear_b:
	: jmp	render_actor_clear_offscr ; if (this.id != bullet_swarm) {
		: ; if (this.id != bullet_swarm) {
		.if	.defined(ANN)
			lda	render_clear_skip
			bne	:--
		.endif
		lda	render_actor_flipped
		beq	:++ ; if ((!ANN || !render_clear_skip) && this.flipped) {
			lda	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
			ora	#obj_attr::v_flip
			iny
			iny
			jsr	render_set_six_sprites
			dey
			dey
			tya
			tax
			lda	render_obj_id_actor
			cmp	#actor::hammer_bro
			beq	:+
			.if	.defined(SMB2M)
				cmp	#actor::piranha_plant_b
				beq	:+
			.endif
			cmp	#actor::lakitu
			beq	:+
			cmp	#actor::actors_page_b
			bcs	:+ ; if (this.id.not_in(hammer_bro, lakitu) && (!SMB2 || this.id != piranha_plant_b) && this.id < actors_page_b) {
				txa
				clc
				adc	#2*OBJ_SIZE
				tax
			: ; }

			lda	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, x
			pha
			lda	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, x
			pha
			lda	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_CHR_NO, y
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_CHR_NO, x
			lda	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_CHR_NO, y
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_CHR_NO, x
			pla
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_CHR_NO, y
			pla
			sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_CHR_NO, y
		: ; }

		lda	actor_bowser_ani_frame
		bne	render_actor_clear_b
		lda	render_obj_id_actor
		ldx	render_actor_state_next
		cmp	#actor::hammer_bro
		bne	:+
		jmp	render_actor_clear_offscr ; if (this.id != hammer_bro) {
			: cmp	#actor::blooper
			beq	:+++
			cmp	#actor::piranha_plant
			beq	:+++
			.if	.defined(SMB2M)
				cmp	#actor::piranha_plant_b
				beq	:+++
			.endif
			cmp	#actor::podoboo
			beq	:+++
			cmp	#actor::spiny
			bne	:+
			cpx	#actor_states::state_5
			bne	:+++++
			: ; if (this.id.not_in(blooper, piranha_plant, podoboo) && (!SMB2M || this.id != piranha_plant_b) && (this.id != spiny || this.state_next == state_5)) {
				cmp	#actor::bowser_flame
				bne	:+ ; if (this.id == bowser_flame) {
					lda	#obj_attr::h_flip|obj_attr::priority_high|obj_attr::color2
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y
				: ; }

				cpx	#actor_states::state_2
				bcc	:+++
			: ; }

			; if (this.id.in(blooper, piranha_plant, podoboo) || (this.id == spiny && this.state_next >= state_2)) {
				lda	actor_bowser_ani_frame
				bne	:++ ; if (actor_bowser_ani_frame == 0) {
					lda	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
					and	#obj_attr::v_flip|obj_attr::priority_bit|obj_attr::color_bits
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
					ora	#obj_attr::h_flip
					cpx	#actor_states::state_5
					bne	:+ ; if (this.state_next == 5) {
						ora	#obj_attr::v_flip
					: ; }
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR, y
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y

					cpx	#actor_states::state_4
					bne	:+ ; if (this.state_next == 4) {
						lda	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
						ora	#obj_attr::v_flip
						sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
						sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
						ora	#obj_attr::h_flip
						sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR, y
						sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y
					; }
				; }
			: ; }

			lda	render_obj_id_actor
			cmp	#actor::lakitu
			bne	:++ ; if (this.id == lakitu) {
				lda	render_actor_flipped
				bne	:+ ; if (!this.flipped) {
					lda	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
					and	#obj_attr::v_flip|obj_attr::color1
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
					lda	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y
					ora	#obj_attr::h_flip|obj_attr::color1
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y

					ldx	timer_swarm
					cpx	#16
					bcs	:+++ ; if (timer_swarm < 16) {
						sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR, y
						and	#obj_attr::v_flip|obj_attr::color1
						sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
						bcc	:+++
					; }
				: ; } else {
					lda	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
					and	#obj_attr::v_flip|obj_attr::color1
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*0)+OBJ_ATTR, y
					lda	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
					ora	#obj_attr::h_flip|obj_attr::color1
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*1)+OBJ_ATTR, y
				; }
			: ; }

			; if (this.id != lakitu || this.flipped) {
				lda	render_obj_id_actor
				cmp	#actor::swarm_stop
				bcc	:+ ; if (this.id >= swarm_stop) {
					.if	.defined(SMB)|.defined(VS_SMB)
						lda	#obj_attr::v_flip|obj_attr::color2
					.elseif	.defined(SMB2M)
						lda	#obj_attr::v_flip
						ora	render_actor_attrs_spring
					.endif

					sta	OAM_DMA_BUFFER+(OBJ_SIZE*2)+OBJ_ATTR, y
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_ATTR, y
					ora	#obj_attr::h_flip|obj_attr::color0
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*3)+OBJ_ATTR, y
					sta	OAM_DMA_BUFFER+(OBJ_SIZE*5)+OBJ_ATTR, y
				; }
			; }
		; }
	: ; }
; ------------------------------
	.export render_actor_clear_offscr
render_actor_clear_offscr:
	ldx	actor_index
	lda	bits_offscr_actor
	lsr	a
	lsr	a
	lsr	a
	pha

	bcc	:+ ; if (this.bits_offscr & 0x04) {
		lda	#$04
		jsr	render_actor_clear_chr_pair_h
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if (this.bits_offscr & 0x08) {
		lda	#$00
		jsr	render_actor_clear_chr_pair_h
	: ; }

	pla
	lsr	a
	lsr	a
	pha

	bcc	:+ ; if (this.bits_offscr & 0x20) {
		lda	#$10
		jsr	render_actor_clear_chr_pair_v
	: ; }

	pla
	lsr	a
	pha

	bcc	:+ ; if (this.bits_offscr & 0x40) {
		lda	#$08
		jsr	render_actor_clear_chr_pair_v
	: ; }

	pla
	lsr	a
	bcc	:+ ; if (this.bits_offscr & 0x80) {
		jsr	render_actor_clear_chr_pair_v

		lda	obj_id_actor, x
		cmp	#actor::podoboo
		beq	:+
		lda	pos_y_hi_actor, x
		cmp	#2
		bne	:+ ; if (actor.id == podoboo && actor.pos_y.hi == 2) {
			jsr	actor_erase
		; }
	: ; }

	rts
; ------------------------------------------------------------
render_actor_chr_pair:
	lda	render_actor_tile_data, x
	sta	render_chr_pair_tile_left
	lda	render_actor_tile_data+1, x

	.export render_chr_pair
render_chr_pair:
	sta	render_chr_pair_tile_right
	jmp	render_chr_pair_do
; ------------------------------------------------------------
render_actor_clear_chr_pair_v:
	clc
	adc	obj_data_offset_actor, x
	tay
	lda	#ENG_OAM_CLEAR_SCANLINE
	jmp	render_set_two_sprites_v
; ------------------------------------------------------------
render_actor_clear_chr_pair_h:
	clc
	adc	obj_data_offset_actor, x
	tay
	jsr	render_offscr_top_clear
	sta	OAM_DMA_BUFFER+(OBJ_SIZE*4)+OBJ_POS_V, y
	rts
