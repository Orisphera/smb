.include	"engine/mem.i"
.include	"engine/tunables.i"
.include	"engine/joypad.i"

	.export actor_init_bullet
actor_init_bullet:
	lda	#DIR_LEFT
	sta	motion_dir_actor, x
	lda	#col_boxes::box_9
	sta	col_box_actor, x
	rts

