.include	"engine/mem.i"
.include	"engine/misc.i"

.include	"macros.i"
; -----------------------------------------------------------
PLAT_V_INC		= 64
PLAT_SIZE_EASY		= 6
PLAT_SIZE_HARD		= 5
PLAT_ACCEL_Y_ABS	= 16
PLAT_COL_FLAG		= %11111111
PLAT_COL_BOX		= col_boxes::box_4
; -----------------------------------------------------------
	.export actor_init_plat_bal
actor_init_plat_bal:
	dec	pos_y_lo_actor, x
	dec	pos_y_lo_actor, x

	ldy	eng_hard_mode_b
	bne	:+ ; if (!eng_hard_mode_b) {
		ldy	#2
		jsr	actor_plat_pos
	: ; }

	ldy	#$FF
	lda	actor_plat_align
	sta	state_actor, x
	bpl	:+ ; if (actor.state & 0x80) {
		txa
		tay
	: ; }
	sty	actor_plat_align

	lda	#0
	sta	motion_dir_actor, x
	tay
	jsr	actor_plat_pos
; ------------------------------
	.export actor_init_plat_drop
actor_init_plat_drop:
	lda	#PLAT_COL_FLAG
	sta	actor_plat_col_flag, x
	jmp	actor_init_plat_std_do
; ------------------------------
	.export actor_init_plat_std_h
actor_init_plat_std_h:
	lda	#0
	sta	veloc_x_actor, x
	jmp	actor_init_plat_std_do
; ------------------------------
	.export actor_init_plat_std_v
actor_init_plat_std_v:
	ldy	#PLAT_V_INC
	lda	pos_y_lo_actor, x
	bpl	:+ ; if (actor[x].pos_y < 0) {
		neg_m
		ldy	#<-PLAT_V_INC
	: ; }
	sta	accel_x_actor, x

	tya
	clc
	adc	pos_y_lo_actor, x
	sta	veloc_x_actor, x
; ------------------------------
actor_init_plat_std_do:
	jsr	actor_init_veloc_y
; ------------------------------
actor_init_plat_do:
	lda	#PLAT_SIZE_HARD
	ldy	course_type
	cpy	#course_types::castle
	beq	:+
	ldy	eng_hard_mode_b
	bne	:+ ; if (course_type != castle && !eng_hard_mode_b) {
		lda	#PLAT_SIZE_EASY
	: ; }
	sta	col_box_actor, x

	rts
; -----------------------------------------------------------
	.export actor_init_plat_l_up, actor_init_plat_l_down
actor_init_plat_l_up:
	jsr	actor_init_plat_s_up
	jmp	:+
; ------------------------------
actor_init_plat_l_down:
	jsr	actor_init_plat_s_down
; ------------------------------
:
	jmp	actor_init_plat_do
; -----------------------------------------------------------
	.export actor_init_plat_s_up, actor_init_plat_s_down
actor_init_plat_s_up:
	lda	#PLAT_ACCEL_Y_ABS
	sta	accel_y_actor_c, x
	lda	#<-1
	sta	veloc_y_actor, x

	jmp	:+
; ------------------------------
actor_init_plat_s_down:
	lda	#<-PLAT_ACCEL_Y_ABS
	sta	accel_y_actor_c, x
	lda	#0
	sta	veloc_y_actor, x
; ------------------------------
:
	ldy	#1
	jsr	actor_plat_pos
	lda	#PLAT_COL_BOX
	sta	col_box_actor, x
	rts
; -----------------------------------------------------------
actor_plat_pos_data_a:
	.byte	8, 12, <-8

actor_plat_pos_data_b:
	.byte	0, 0, <-1
; ------------------------------
	.export actor_plat_pos_rts
actor_plat_pos:
	lda	pos_x_lo_actor, x
	clc
	adc	actor_plat_pos_data_a, y
	sta	pos_x_lo_actor, x
	lda	pos_x_hi_actor, x
	adc	actor_plat_pos_data_b, y
	sta	pos_x_hi_actor, x
	.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
		rts
	.endif

.if	.defined(ANN)
	.export actor_proc_null, actor_proc_null_b
actor_proc_null:
actor_proc_null_b:
.endif

actor_plat_pos_rts:
	rts

