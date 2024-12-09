.include	"mem.i"
.include	"chr.i"
.include	"math.i"
.include	"sound.i"

; ------------------------------------------------------------
WIND_PLAYER_OFFSET	= 1

bg_scenery_wind_col_mod		= zp_byte_00

.if	.definedmacro(WIND_BASE)
	.export	bg_scenery_wind_col
.endif
bg_scenery_wind_col:
	lda	bg_scenery_wind_flag
	beq	:++
	lda	course_type
	cmp	#course_types::overworld
	bne	:++ ; if (wind && course.type == overworld) {
		ldy	#MOD_2
		lda	frame_count
		asl	a
		bcs	:+ ; if (!(frame_count & 0x80)) {
			ldy	#MOD_4
		: ; }
		sty	bg_scenery_wind_col_mod
		lda	frame_count
		and	bg_scenery_wind_col_mod
		bne	:+ ; if ((frame_count % mod_val) == 0) {
			lda	pos_x_lo_player
			clc
			adc	#<WIND_PLAYER_OFFSET
			sta	pos_x_lo_player
			lda	pos_x_hi_player
			adc	#>WIND_PLAYER_OFFSET
			sta	pos_x_hi_player
			inc	scroll_x_player
		; }
	: ; }

	rts
; -----------------------------
LEAF_COUNT	= 12

bg_scenery_wind_leaf_pos_y:
	.byte	48, 112, 184, 80
	.byte	152, 48, 112, 184
	.byte	80, 152, 48, 112

bg_scenery_wind_leaf_pos_x:
	.byte	48, 48, 48, 96
	.byte	96, 160, 160, 160
	.byte	208, 208, 208, 96

bg_scenery_wind_leaf_chr:
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+0
	.byte	chr_obj::leaf+0
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+0
	.byte	chr_obj::leaf+1
	.byte	chr_obj::leaf+0
; -----------------------------
.if	.definedmacro(WIND_BASE)
	.export	bg_scenery_wind_proc
.endif
bg_scenery_wind_proc:
	lda	bg_scenery_wind_flag
	beq	:+++ ; if (bg_scenery_wind_flag != 0) {
		lda	#sfx_noise::wind
		sta	apu_sfx_noise_req
		jsr	bg_scenery_wind_leaf_proc
		ldx	#0
		ldy	obj_data_offset_leaf
		: ; for (frame of this.frames) {
			lda	bg_scenery_wind_leaf_pos_y, x
			sta	OAM_DMA_BUFFER+OBJ_POS_V, y
			lda	bg_scenery_wind_leaf_chr, x
			sta	OAM_DMA_BUFFER+OBJ_CHR_NO, y
			lda	#obj_attr::h_flip|obj_attr::color1
			sta	OAM_DMA_BUFFER+OBJ_ATTR, y
			lda	bg_scenery_wind_leaf_pos_x, x
			sta	OAM_DMA_BUFFER+OBJ_POS_H, y
			iny
			iny
			iny
			iny
			inx
			cpx	#(LEAF_COUNT/2)
			bne	:+ ; if (x == half_way) {
				ldy	obj_data_offset_leaf+1
			: ; }
	
			cpx	#LEAF_COUNT
			bne	:--
		; }
	: ; }

	rts
; -----------------------------
bg_scenery_wind_leaf_offset:
	.byte	87, 87, 86, 86
	.byte	88, 88, 86, 86
	.byte	87, 88, 87, 88
	.byte	89, 89, 88, 88
	.byte	90, 90, 88, 88
	.byte	89, 90, 89, 90
; -----------------------------
bg_scenery_wind_leaf_proc:
	ldx	#LEAF_COUNT-1
	: ; for (frame of this.frames) {
		lda	bg_scenery_wind_leaf_pos_x, x
		clc
		adc	bg_scenery_wind_leaf_offset, x
		adc	bg_scenery_wind_leaf_offset, x
		sta	bg_scenery_wind_leaf_pos_x, x
		lda	bg_scenery_wind_leaf_pos_y, x
		clc
		adc	bg_scenery_wind_leaf_offset, x
		sta	bg_scenery_wind_leaf_pos_y, x

		dex
		bpl	:-
	; }

	rts
; -----------------------------
.if	.definedmacro(WIND_BASE)
	.export	bg_scenery_wind_on, bg_scenery_wind_off
.endif
bg_scenery_wind_on:
	lda	#1
	bne	:+

bg_scenery_wind_off:
	lda	#0
; -----------------------------
	: sta	bg_scenery_wind_flag
	rts
