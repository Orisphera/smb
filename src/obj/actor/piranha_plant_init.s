.include	"engine/mem.i"
.include	"engine/misc.i"

.include	"engine/unk.i"

; -----------------------------------------------------------
PIRANHA_PLANT_VELOC_X_1	= 1
PIRANHA_PLANT_OFFSET_Y	= 24
PIRANHA_PLANT_COL_BOX	= col_boxes::box_9
; -----------------------------------------------------------
	.export actor_init_piranha_plant
actor_init_piranha_plant:
	.if	.defined(SMB2)
	        lda     #$22
	        sta     zp_byte_00
	        lda     #$13
	        sta     zp_byte_01

	        lda     byte_7FB
	        bne     :+
	        lda     course_no
	        cmp     #course::no_04
	        bcs     :+ ; if (!byte_7FB && course_no < no_04) {
		        dec     zp_byte_00
		        lda     #$21
		        sta     zp_byte_01
		: ; }

	        lda     zp_byte_00
	        sta     data_B517
	        lda     zp_byte_01
	        sta     actor_proc_piranha_plant_smb2_cmp+1
	.endif

	lda	#PIRANHA_PLANT_VELOC_X_1
	sta	veloc_x_actor, x
	lsr	a
	sta	state_actor, x
	sta	veloc_y_actor, x
	lda	pos_y_lo_actor, x
	sta	accel_y_actor_c, x
	sec
	sbc	#PIRANHA_PLANT_OFFSET_Y
	sta	pos_y_actor, x
	lda	#PIRANHA_PLANT_COL_BOX
	jmp	actor_init_col_b

