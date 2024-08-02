.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/misc.i"
.include	"engine/joypad.i"

; -----------------------------------------------------------
.if	.defined(SMBM)|.defined(VS_SMB)
	KOOPA_GREEN_BOUNCE_VELOC_X	= <-8
.elseif	.defined(SMB2)
	KOOPA_GREEN_BOUNCE_VELOC_X	= <-12
.endif
; -----------------------------------------------------------
	.export actor_init_koopa_green_bounce
actor_init_koopa_green_bounce:
	lda	#MOTION_DIR_LEFT
	sta	motion_dir_actor, x
	lda	#KOOPA_GREEN_BOUNCE_VELOC_X
	sta	veloc_x_actor, x
; ------------------------------
	.export actor_init_col_large_b, actor_init_col_b
actor_init_col_large_b:
	lda	#ACTOR_COL_BOX_LARGE

actor_init_col_b:
	sta	col_box_actor, x
	rts

