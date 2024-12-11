.include	"mem.i"
.include	"misc.i"

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
	.export	actor_B_0F_init
actor_init_plat_bal:
actor_B_0F_init:
	dec	pos_y_lo_actor, x
	dec	pos_y_lo_actor, x

	ldy	game_hard_mode_b
	bne	:+ ; if (!game_hard_mode_b) {
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
	.export	actor_B_14_init
actor_init_plat_drop:
actor_B_14_init:
	lda	#PLAT_COL_FLAG
	sta	actor_plat_col_flag, x
	jmp	actor_init_plat_std_do
; ------------------------------
	.export actor_init_plat_std_h
	.export	actor_B_13_init
	.export	actor_B_15_init
actor_init_plat_std_h:
actor_B_13_init:
actor_B_15_init:
	lda	#0
	sta	veloc_x_actor, x
	jmp	actor_init_plat_std_do
; ------------------------------
	.export actor_init_plat_std_v
	.export	actor_B_10_init
actor_init_plat_std_v:
actor_B_10_init:
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
	ldy	game_hard_mode_b
	bne	:+ ; if (course_type != castle && !game_hard_mode_b) {
		lda	#PLAT_SIZE_EASY
	: ; }
	sta	col_box_actor, x

	rts
; -----------------------------------------------------------
	.export actor_init_plat_l_up, actor_init_plat_l_down
	.export	actor_B_11_init, actor_B_12_init
actor_init_plat_l_up:
actor_B_11_init:
	jsr	actor_init_plat_s_up
	jmp	:+
; ------------------------------
actor_init_plat_l_down:
actor_B_12_init:
	jsr	actor_init_plat_s_down
; ------------------------------
:
	jmp	actor_init_plat_do
; -----------------------------------------------------------
	.export actor_init_plat_s_up, actor_init_plat_s_down
	.export	actor_B_16_init, actor_B_17_init
actor_init_plat_s_up:
actor_B_16_init:
	lda	#PLAT_ACCEL_Y_ABS
	sta	accel_y2_actor, x
	lda	#<-1
	sta	veloc_y_actor, x

	jmp	:+
; ------------------------------
actor_init_plat_s_down:
actor_B_17_init:
	lda	#<-PLAT_ACCEL_Y_ABS
	sta	accel_y2_actor, x
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
	.export	actor_B_36_init
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
	.export	actor_A_09_proc, actor_A_13_proc
	.export	actor_B_02_proc, actor_B_03_proc
	.export	actor_B_04_proc, actor_B_05_proc
	.export	actor_B_0E_proc
	.export	actor_B_1B_proc, actor_B_1E_proc
actor_proc_null:
actor_proc_null_b:
actor_A_09_proc:
actor_A_13_proc:
actor_B_02_proc:
actor_B_03_proc:
actor_B_04_proc:
actor_B_05_proc:
actor_B_0E_proc:
actor_B_1B_proc:
actor_B_1E_proc:
.endif

actor_plat_pos_rts:
actor_B_36_init:
	rts

