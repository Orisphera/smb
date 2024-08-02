.include	"system/cpu.i"

.include	"engine/math.i"
.include	"engine/mem.i"
.include	"engine/charmap.i"
.include	"engine/tunables.i"
.include	"engine/chr.i"
.include	"engine/misc.i"
.include	"engine/joypad.i"

.include	"engine/unk.i"

; -----------------------------------------------------------
PLAT_ROPE_OFFSET_X	= 8
PLAT_ROPE_OFFSET_X_HARD	= 16
; -----------------------------------------------------------
	.export actor_proc_plat_bal
actor_proc_plat_bal:
	lda	pos_y_hi_actor, x
	cmp	#3
	bne	:+ ; if (actor.pos_y >= 0x300) {
		jmp	actor_erase
	: lda	state_actor, x
	bpl	:++
	: ; } else if (actor.state & spawned || actor.id != plat_bal) {
		rts
	: ; }
	tay

	.if	.defined(SMB2M)
		lda	actor_id, y
		cmp	#actor::plat_bal
		bne	:--
	.endif

	lda	eng_timer_hammer_throw, x
	sta	zp_byte_00
	lda	motion_dir_actor, x
	beq	:+ ; if (actor.motion_dir != 0) {
		jmp	actor_proc_plat_fall_do
	: lda	#45
	cmp	pos_y_lo_actor, x
	bcc	:++
	cpy	zp_byte_00
	beq	:+ ; } else if (actor.pos_y >= 45 && actor.state != eng_timer_hammer_throw) {
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

	lda	eng_timer_hammer_throw, x
	bpl	:+
	lda	accel_y_actor_c, x
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
	: ; if () {
		jsr	motion_platform_up

		jmp	:+++
	: ; } else if () {
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
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if () {
		tax
		jsr	col_DC21
	: ; }

	ldy	actor_index
	lda	veloc_y_actor, y
	ora	accel_y_actor_c, y
	beq	:+++++
	ldx	ppu_nmi_buffer_0_offset
	cpx	#32
	bcs	:+++++ ; if () {
		lda	veloc_y_actor, y
		pha
		pha

		jsr	actor_init_plat_rope
		lda	zp_byte_01
		sta	ppu_nmi_buffer_0_data+0, x
		lda	zp_byte_00
		sta	ppu_nmi_buffer_0_data+1, x
		lda	#2
		sta	ppu_nmi_buffer_0_data+2, x
		lda	veloc_y_actor, y
		bmi	:+ ; if (actor.veloc_y >= 0) {
			lda	#tile_bg::pole
			sta	ppu_nmi_buffer_0_data+3, x
			lda	#tile_bg::pole+1
			sta	ppu_nmi_buffer_0_data+4, x
	
			jmp	:++
		: ; } else {
			lda	#' '
			sta	ppu_nmi_buffer_0_data+3, x
			sta	ppu_nmi_buffer_0_data+4, x
		: ; }
	
		lda	state_actor, y
		tay

		pla
		eor	#<-1
		jsr	actor_init_plat_rope
		lda	zp_byte_01
		sta	ppu_nmi_buffer_0_data+5, x
		lda	zp_byte_00
		sta	ppu_nmi_buffer_0_data+6, x
		lda	#2
		sta	ppu_nmi_buffer_0_data+7, x
	
		pla
		bpl	:+ ; if () {
			lda	#tile_bg::pole
			sta	ppu_nmi_buffer_0_data+8, x
			lda	#tile_bg::pole+1
			sta	ppu_nmi_buffer_0_data+9, x
	
			jmp	:++
		: ; } else {
			lda	#' '
			sta	ppu_nmi_buffer_0_data+8, x
			sta	ppu_nmi_buffer_0_data+9, x
		: ; }
	
		lda	#NMI_DATA_END
		sta	ppu_nmi_buffer_0_data+10, x
		lda	ppu_nmi_buffer_0_offset
		clc
		adc	#2*(WORD_SIZE+1+2)
		sta	ppu_nmi_buffer_0_offset
	: ; }

	ldx	actor_index
	rts
; -----------------------------------------------------------
actor_init_plat_rope:
	pha

	lda	pos_x_lo_actor, y
	clc
	adc	#PLAT_ROPE_OFFSET_X
	ldx	eng_hard_mode_b
	bne	:+ ; if (!eng_hard_mode_b)) {
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
	ldx	ppu_nmi_buffer_0_offset
	asl	a
	rol	a
	pha

	rol	a
	and	#%00000011
	ora	#%00100000
	sta	zp_byte_01
	lda	zp_byte_02
	and	#%00000001
	asl	a
	asl	a
	ora	zp_byte_01
	sta	zp_byte_01

	pla
	and	#%11100000
	clc
	adc	zp_byte_00
	sta	zp_byte_00
	lda	pos_y_lo_actor, y
	cmp	#232
	bcc	:+ ; if () {
		lda	zp_byte_00
		and	#<~%01000000
		sta	zp_byte_00
	: ; }

	rts
; -----------------------------------------------------------
actor_init_plat_fall:
	tya
	tax
	jsr	lib_actor_bits_get
	lda	#6
	jsr	col_DA11
	lda	pos_x_rel_player
	sta	STACK_BASE+$17, x
	lda	pos_y_lo_player
	sta	STACK_BASE+$1E, x
	lda	#MOTION_DIR_RIGHT
	sta	motion_dir_actor, x
; ------------------------------
actor_proc_plat_stop:
	jsr	actor_init_veloc_y
	sta	veloc_y_actor, y
	sta	accel_y_actor_c, y
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
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if (eng_timer_hammer_throw >= 0) {
		tax
		jsr	col_DC21
	: ; }

	ldx	actor_index
	rts
; -----------------------------------------------------------
	.export actor_proc_plat_mov_v
actor_proc_plat_mov_v:
	lda	veloc_y_actor, x
	ora	accel_y_actor_c, x
	bne	:++
	sta	pos_y_actor, x
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
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if (eng_timer_hammer_throw >= 0) {
		jsr	col_DC21
	: ; }

	rts
; -----------------------------------------------------------
	.export actor_proc_plat_move_h
actor_proc_plat_move_h:
	lda	#14
	jsr	actor_floater_do
	jsr	actor_floater_move
	lda	eng_timer_hammer_throw, x
	bmi	:+++ ; if (hammer_throw_timer >= 0) {
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
		jsr	col_DC21
	: ; }

	rts
; -----------------------------------------------------------
	.export actor_proc_plat_drop
actor_proc_plat_drop:
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if () {
		jsr	motion_fall_fast
		jsr	col_DC21
	: ; }

	rts
; -----------------------------------------------------------
	.export actor_proc_plat_right
actor_proc_plat_right:
	jsr	motion_x
	sta	zp_byte_00
	lda	eng_timer_hammer_throw, x
	bmi	:+ ; if () {
		lda	#16
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
	lda	eng_timer_ctl
	bne	actor_proc_plat_lift_col_rts ; if (!eng_timer_ctl) {
		lda	pos_y_actor, x
		clc
		adc	accel_y_actor_c, x
		sta	pos_y_actor, x
		lda	pos_y_lo_actor, x
		adc	veloc_y_actor, x
		sta	pos_y_lo_actor, x
		rts
	; } else rts;
; -----------------------------
actor_proc_plat_lift_col:
	lda	eng_timer_hammer_throw, x
	beq	:+ ; if () {
		jsr	col_DC19
	: ; }

actor_proc_plat_lift_col_rts:
	rts
