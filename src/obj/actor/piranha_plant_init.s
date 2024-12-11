.include	"mem.i"
.include	"misc.i"

; -----------------------------------------------------------
PIRANHA_PLANT_VELOC_Y_1		= 1
PIRANHA_PLANT_POS_Y_BOTTOM	= 24
PIRANHA_PLANT_COL_BOX		= col_boxes::box_9
; -----------------------------------------------------------
actor_init_piranha_plant_attr	= zp_byte_00

	.export actor_init_piranha_plant
	.export	actor_A_0D_init
actor_init_piranha_plant:
actor_A_0D_init:

.if	.defined(SMBV2)
	.export	actor_A_04_init
actor_A_04_init:
.endif

	.if	.defined(SMB2)
	        lda     #obj_attr::priority_low|obj_attr::color2
	        sta     actor_init_piranha_plant_attr
	        lda     #$13
	        sta     zp_byte_01

	        lda     ENG_HARDMODE_VAR
	        bne     :+
	        lda     course_no
	        cmp     #course::no_04
	        bcs     :+ ; if (!game.hard_mode && course_no < no_04) {
		        dec     actor_init_piranha_plant_attr
		        lda     #$21
		        sta     zp_byte_01
		: ; }

	        lda     actor_init_piranha_plant_attr
	        sta     render_actor_attrs_piranha_plant
	        lda     zp_byte_01
	        sta     actor_proc_piranha_plant_smb2_cmp+1
	.endif

	lda	#PIRANHA_PLANT_VELOC_Y_1
	sta	veloc_y_piranha, x
	lsr	a
	sta	state_actor, x
	sta	neg_y_piranha, x
	lda	pos_y_lo_actor, x
	sta	pos_y_top_piranha, x
	sec
	sbc	#PIRANHA_PLANT_POS_Y_BOTTOM
	sta	pos_y_bottom_piranha, x
	lda	#PIRANHA_PLANT_COL_BOX
	jmp	actor_init_col_b

