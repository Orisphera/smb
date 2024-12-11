.include	"mem.i"
.include	"tunables.i"
.include	"joypad.i"

	.export actor_init_bullet
	.export	actor_A_08_init
actor_init_bullet:
actor_A_08_init:
	lda	#DIR_LEFT
	sta	motion_dir_actor, x
	lda	#col_boxes::box_9
	sta	col_box_actor, x
	rts

