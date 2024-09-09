.include	"engine/mem.i"
.include	"engine/misc.i"

	.export actor_proc_do
actor_proc_do:
	ldx	actor_index
	lda	#0
	ldy	actor_id, x
	cpy	#actor::actors_page_b
	bcc	:+ ; if (actor_id[x] >= page_b) {
		tya
		sbc	#(actor::actors_page_b)-1
	: ; }

	jsr	tbljmp
	.addr	actor_proc_enemy

	.addr	actor_proc_bowser_flame
	.addr	actor_proc_fireworks
	.addr	actor_proc_null
	.addr	actor_proc_null
	.addr	actor_proc_null
	.addr	actor_proc_null
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_firebar
	.addr	actor_proc_null
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_large
	.addr	actor_proc_plat_small
	.addr	actor_proc_plat_small
	.addr	actor_proc_bowser
	.addr	actor_proc_powerup

	.addr	game_proc_vine_do

	.addr	actor_proc_null
	.addr	actor_proc_flag_victory

	.addr	game_proc_spring

	.addr	actor_proc_null

	.addr	game_proc_warp

	.addr	actor_proc_toad
; -----------------------------------------------------------
.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
actor_proc_null:
	rts
.endif

