.include	"system/cpu.i"

.include	"math.i"
.include	"mem.i"
.include	"misc.i"
.include	"charmap.i"
.include	"tunables.i"
.include	"chr.i"
.include	"misc.i"
.include	"joypad.i"

; -----------------------------------------------------------
PLAT_ROPE_OFFSET_X	= 8
PLAT_ROPE_OFFSET_X_HARD	= 16
PLAT_ROPE_WIDTH		= 2
PLAT_ROPE_ENTRY_SIZE	= (WORD_SIZE+1+PLAT_ROPE_WIDTH)
PLAT_ROPE_ENTRY_COUNT	= 2

actor_init_plat_rope_addr	= zp_byte_00
; -----------------------------------------------------------
	.export actor_proc_plat_bal
actor_proc_plat_bal:
	lda	pos_y_hi_actor, x
	cmp	#3
	bne	:+ ; if (this.pos_y >= 0x300) {
		jmp	actor_erase
	: lda	state_actor, x
	bpl	:++
	: ; } else if (this.state & spawned || this.id != plat_bal) {
		rts
	: ; }
	tay

	.if	.defined(SMBV2)
		lda	obj_id_actor, y
		cmp	#actor::plat_bal
		bne	:--
	.endif

	lda	actor_plat_col_flag, x
	sta	zp_byte_00
	lda	motion_dir_actor, x
	beq	:+ ; if (this.motion_dir != none) {
		jmp	actor_proc_plat_fall_do
	: lda	#45
	cmp	pos_y_lo_actor, x
	bcc	:++
	cpy	zp_byte_00
	beq	:+ ; } else if (this.pos_y >= 45 && this.state != actor_plat_col_flag) {
		clc
		adc	#2
		sta	pos_y_lo_actor, x
		jmp	actor_proc_plat_stop
	: ; } else if () {
		jmp	actor_init_plat_fall
	: cmp	pos_y_lo_actor, y
	bcc	:+
	cpx	zp_byte_00
	beq	:-- ; } else if () {
		clc
		adc	#2
		sta	pos_y_lo_actor, y
		jmp	actor_proc_plat_stop
	: ; }

	lda	pos_y_lo_actor, x
	pha

	lda	actor_plat_col_flag, x
	bpl	:+
	lda	accel_y_grav_actor, x
	clc
	adc	#5
	sta	zp_byte_00
	lda	veloc_y_actor, x
	adc	#0
	bmi	:++++
	bne	:++
	lda	zp_byte_00
	cmp	#11
	bcc	:+++
	bcs	:++
	: cmp	actor_index
	beq	:+++
	: ; if (
	;	(!(this.plat_col & 0x80) && (this.plat_col != actor_index))
	;	|| ((this.veloc_y > 0) && ((this.accel_y_c + 5) >= 11))
	; ) {
		jsr	motion_platform_up

		jmp	:+++
	: ; } else if (!(actor.plat_col & 0x80) && actor.veloc_y > 0 && ((actor.accel_y_c + 5) < 11) {
		jsr	actor_proc_plat_stop

		jmp	:++
	: ; } else {
		jsr	motion_platform_down
	: ; }

	ldy	state_actor, x

	pla
	sec
	sbc	pos_y_lo_actor, x
	clc
	adc	pos_y_lo_actor, y
	sta	pos_y_lo_actor, y
	lda	actor_plat_col_flag, x
	bmi	:+ ; if (!(actor.plat_col & 0x80)) {
		tax
		jsr	col_plat_player_pos
	: ; }

	ldy	actor_index
	lda	veloc_y_actor, y
	ora	accel_y_grav_actor, y
	beq	:+++++
	ldx	ppu_displist_0_offset
	cpx	#32
	bcs	:+++++ ; if (ppu_displist_0.offset < 32) {
		lda	veloc_y_actor, y
		pha
		pha

		jsr	actor_init_plat_rope
		lda	actor_init_plat_rope_addr+1
		sta	ppu_displist_0_addr_dbyt, x
		lda	actor_init_plat_rope_addr
		sta	ppu_displist_0_addr_dbyt+1, x
		lda	#PLAT_ROPE_WIDTH
		sta	ppu_displist_0_count, x
		lda	veloc_y_actor, y
		bmi	:+ ; if (this.veloc_y >= 0) {
			lda	#chr_bg::pole
			sta	ppu_displist_0_tile, x
			lda	#chr_bg::pole+1
			sta	ppu_displist_0_tile+1, x
	
			jmp	:++
		: ; } else {
			lda	#' '
			sta	ppu_displist_0_tile+0, x
			sta	ppu_displist_0_tile+1, x
		: ; }
	
		lda	state_actor, y
		tay

		pla
		eor	#<-1

		jsr	actor_init_plat_rope
		lda	actor_init_plat_rope_addr+1
		sta	ppu_displist_0_addr_dbyt+(PLAT_ROPE_ENTRY_SIZE), x
		lda	actor_init_plat_rope_addr
		sta	ppu_displist_0_addr_dbyt+1+(PLAT_ROPE_ENTRY_SIZE), x
		lda	#PLAT_ROPE_WIDTH
		sta	ppu_displist_0_count+(PLAT_ROPE_ENTRY_SIZE), x

		pla
		bpl	:+ ; if (this.veloc_y < 0) {
			lda	#chr_bg::pole
			sta	ppu_displist_0_tile+0+(PLAT_ROPE_ENTRY_SIZE), x
			lda	#chr_bg::pole+1
			sta	ppu_displist_0_tile+1+(PLAT_ROPE_ENTRY_SIZE), x
	
			jmp	:++
		: ; } else {
			lda	#' '
			sta	ppu_displist_0_tile+0+(PLAT_ROPE_ENTRY_SIZE), x
			sta	ppu_displist_0_tile+1+(PLAT_ROPE_ENTRY_SIZE), x
		: ; }
	
		lda	#NMI_LIST_END
		sta	ppu_displist_0_data+(PLAT_ROPE_ENTRY_COUNT*PLAT_ROPE_ENTRY_SIZE), x
		lda	ppu_displist_0_offset
		clc
		adc	#PLAT_ROPE_ENTRY_COUNT*PLAT_ROPE_ENTRY_SIZE
		sta	ppu_displist_0_offset
	: ; }

	ldx	actor_index
	rts
; -----------------------------------------------------------
actor_init_plat_rope:
	pha

	lda	pos_x_lo_actor, y
	clc
	adc	#PLAT_ROPE_OFFSET_X
	ldx	game_hard_mode_b
	bne	:+ ; if (!game_hard_mode_b)) {
		clc
		adc	#PLAT_ROPE_OFFSET_X_HARD
	: ; }
	pha

	lda	pos_x_hi_actor, y
	adc	#0
	sta	zp_byte_02

	pla
	and	#CLAMP_16
	lsr	a
	lsr	a
	lsr	a
	sta	zp_byte_00
	ldx	pos_y_lo_actor, y

	pla
	bpl	:+ ; if () {
		txa
		clc
		adc	#8
		tax
	: ; }
	txa
	ldx	ppu_displist_0_offset
	asl	a
	rol	a
	pha

	rol	a
	and	#%00000011
	ora	#%00100000
	sta	actor_init_plat_rope_addr+1
	lda	zp_byte_02
	and	#%00000001
	asl	a
	asl	a
	ora	actor_init_plat_rope_addr+1
	sta	actor_init_plat_rope_addr+1

	pla
	and	#%11100000
	clc
	adc	actor_init_plat_rope_addr
	sta	actor_init_plat_rope_addr
	lda	pos_y_lo_actor, y
	cmp	#232
	bcc	:+ ; if () {
		lda	actor_init_plat_rope_addr
		and	#<~%01000000
		sta	actor_init_plat_rope_addr
	: ; }

	rts
; -----------------------------------------------------------
actor_init_plat_fall:
	tya
	tax

	jsr	pos_bits_get_actor

	lda	#scores::value_1000
	jsr	col_score_do
	lda	pos_x_rel_player
	sta	bg_score_pos_x, x
	lda	pos_y_lo_player
	sta	bg_score_pos_y, x
	lda	#DIR_RIGHT
	sta	motion_dir_actor, x
; ------------------------------
actor_proc_plat_stop:
	jsr	actor_init_veloc_y
	sta	veloc_y_actor, y
	sta	accel_y_grav_actor, y
	rts
; -----------------------------------------------------------
actor_proc_plat_fall_do:
	tya
	pha

	jsr	motion_y_state_5

	pla
	tax
	jsr	motion_y_state_5

	ldx	actor_index
	lda	actor_plat_col_flag, x
	bmi	:+ ; if (!(actor.plat_col & 0x80)) {
		tax
		jsr	col_plat_player_pos
	: ; }

	ldx	actor_index
	rts
; -----------------------------------------------------------
	.export actor_proc_plat_mov_v
actor_proc_plat_mov_v:
	lda	veloc_y_actor, x
	ora	accel_y_grav_actor, x
	bne	:++
	sta	accel_y_actor, x
	lda	pos_y_lo_actor, x
	cmp	accel_x_actor, x
	bcs	:++ ; if (actor.pos_y < actor.accel_x) {
		lda	frame_count
		and	#%00000111
		bne	:+ ; if (!(frame_count % 8)) {
			inc	pos_y_lo_actor, x
		: ; }
	
		jmp	:+++
	: ; } else {
		lda	pos_y_lo_actor, x
		cmp	veloc_x_actor, x
		bcc	:+ ; if (actor.pos_y >= actor.veloc_x) {
			jsr	motion_platform_up
	
			jmp	:++
		: ; } else {
			jsr	motion_platform_down
		: ; }
	; }
; ------------------------------
actor_proc_plat_lift_player:
	lda	actor_plat_col_flag, x
	bmi	:+ ; if (!(actor.plat_col & 0x80)) {
		jsr	col_plat_player_pos
	: ; }

	rts
; -----------------------------------------------------------
	.export actor_proc_plat_move_h
actor_proc_plat_move_h:
	lda	#14
	jsr	actor_floater_do
	jsr	actor_floater_move
	lda	actor_plat_col_flag, x
	bmi	:+++ ; if (!(actor.plat_col & 0x80)) {
	actor_proc_plat_move_player_h:
		lda	pos_x_lo_player
		clc
		adc	zp_byte_00
		sta	pos_x_lo_player
		lda	pos_x_hi_player
		ldy	zp_byte_00
		bmi	:+ ; if (zp_byte_00 >= 0) {
			adc	#0
	
			jmp	:++
		: ; } else {
			sbc	#0
		: ; }
		sta	pos_x_hi_player
		sty	actor_plat_scroll_x
		jsr	col_plat_player_pos
	: ; }

	rts
; -----------------------------------------------------------
	.export actor_proc_plat_drop
actor_proc_plat_drop:
	lda	actor_plat_col_flag, x
	bmi	:+ ; if (!(actor.plat_col & 0x80)) {
		jsr	motion_fall_fast
		jsr	col_plat_player_pos
	: ; }

	rts
; -----------------------------------------------------------
	.export actor_proc_plat_right
actor_proc_plat_right:
	jsr	motion_x
	sta	zp_byte_00
	lda	actor_plat_col_flag, x
	bmi	:+ ; if (!(actor.plat_col & 0x80)) {
		lda	#PLAT_RIGHT_VELOC_X
		sta	veloc_x_actor, x
		jsr	actor_proc_plat_move_player_h
	: ; }

	rts
; -----------------------------------------------------------
	.export actor_proc_plat_lift
actor_proc_plat_lift:
	jsr	actor_proc_plat_lift_move
	jmp	actor_proc_plat_lift_player
; -----------------------------------------------------------
	.export actor_proc_plat_small_do
actor_proc_plat_small_do:
	jsr	actor_proc_plat_lift_move
	jmp	actor_proc_plat_lift_col
; -----------------------------------------------------------
actor_proc_plat_lift_move:
	lda	game_timer_stop
	bne	actor_proc_plat_lift_col_rts ; if (!game_timer_stop) {
		lda	accel_y_actor, x
		clc
		adc	accel_y_grav_actor, x
		sta	accel_y_actor, x
		lda	pos_y_lo_actor, x
		adc	veloc_y_actor, x
		sta	pos_y_lo_actor, x
		rts
	; } else rts;
; -----------------------------
actor_proc_plat_lift_col:
	lda	actor_plat_col_flag, x
	beq	:+ ; if (actor.plat_col != 0) {
		jsr	col_plat_s_player_pos
	: ; }

actor_proc_plat_lift_col_rts:
	rts
