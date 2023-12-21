.ifndef UNK_I
UNK_I = 1

eng_victory		= $838B

title_scr_proc		= $8567

palette_underwater	= $8CA4
palette_day		= $8CC8
palette_underground	= $8CEC
palette_castle		= $8D10
palette_day_snow	= $8D34
palette_night_snow	= $8D3C
palette_mushroom	= $8D44
palette_bowser		= $8D4C
msg_thankyou_mario	= $8D54
msg_thankyou_luigi	= $8D68
msg_thankyou_toad	= $8D7C
msg_thankyou_princess1	= $8DA8
msg_thankyou_princess2	= $8DBF
msg_worldsel_1		= $8DDE
msg_worldsel_2		= $8DEF

eng_farjump		= $8E04
nt_init			= $8E19
joypad_read		= $8E5C
eng_screen_update	= $8EDD
eng_sta_ppu_scc_h_v	= $8EE6
eng_sta_ppu_ctlr0	= $8EED
eng_score_calc		= $8F97
title_init_0		= $8FCF
title_init_1		= $9061
sub_clearram		= $90CC
eng_game_over		= $9218
eng_loadareaptr		= $9C03
eng_game		= $AEDC
game_proc		= $AEEA
apu_cycle		= $F2D0
irq			= $FFF0

zp_byte_00		= $00
eng_screen_update_addr	= $00
eng_frame_count		= $09
game_proc_id		= $0E
apu_sfx_flag_pause	= $FA

OAM_DMA_BUFFER		= $200

ppu_nmi_buffer		= $300

byte_6E0		= $6E0
tbl_6E1			= $6E1
tbl_6E4			= $6E4
tbl_6E9			= $6E9
tbl_6F1			= $6F1
joypad_p1		= $6FC
joypad_p2		= $6FD

title_demo_button_id	= $717
title_demo_button_timer	= $718
eng_screen_left_hi	= $71A
eng_sprite_overlap	= $722
eng_scc_h_b		= $73F
eng_scc_v_b		= $740
eng_timer_ctl		= $747
eng_area_type		= $74E
eng_req_timer		= $757
eng_hidden_one_up	= $75D
eng_course_no		= $75F
eng_course_sub		= $760
eng_hidden_one_up_offscr= $764
eng_course_no_offscr	= $766
eng_course_sub_offscr	= $767
eng_scroll_subpix	= $768
eng_hard_mode		= $76A
title_course_sel_no	= $76B
eng_game_mode		= $770
eng_gameplay_mode	= $772
nmi_addrs_ctl		= $773
eng_disp_disable	= $774
eng_pause_status	= $776
eng_pause_ticks		= $777
ppu_ctlr0_b		= $778
ppu_ctlr1_b		= $779
eng_player_count	= $77A
eng_timer_int		= $77F
eng_timers_nmi		= $780
eng_timer_select	= $780
eng_timer_victory	= $7A1
eng_timer_demo		= $7A2
eng_rand_seed		= $7A7
eng_score		= $7D7
eng_score_end		= $7DD
eng_stats		= $7DD
eng_stats_end		= $7F5
eng_course_sel_on	= $7FC
eng_continue_course	= $7FD
eng_boot_flag		= $7FF

.endif	; UNK_I