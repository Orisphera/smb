.ifndef	MEM_I
MEM_I	= 1

.include	"sys/cpu.i"
.include	"sys/vs.i"

.include	"./const.i"

zp_byte_00		= $00
zp_addr_00		= zp_byte_00
zp_byte_01		= $01
zp_byte_02		= $02
zp_addr_02		= zp_byte_02
zp_byte_03		= $03
zp_byte_04		= $04
zp_addr_04		= zp_byte_04
zp_byte_05		= $05
zp_byte_06		= $06
zp_byte_07		= $07
; ----------------
game_buffer		= zp_byte_06
actor_index		= game_buffer+WORD_SIZE
frame_count		= actor_index+1
joypad_a_b		= frame_count+1
joypad_u_d		= joypad_a_b+1
joypad_l_r		= joypad_u_d+1
joypad_a_b_held		= joypad_l_r+1
; ----------------
proc_id_player		= joypad_a_b_held+1
proc_id_actor		= proc_id_player+ENG_PLAYER_OBJ_MAX
proc_id_actor_end	= proc_id_actor+ENG_ACTOR_MAX
obj_id_player		= proc_id_actor_end
obj_id_actor		= obj_id_player+ENG_PLAYER_OBJ_MAX
obj_id_actor_end	= obj_id_actor+ENG_ACTOR_MAX
unused_1C		= obj_id_actor_end
; ----------------
state_player		= unused_1C+1
state_player_end	= state_player+ENG_PLAYER_OBJ_MAX
state_actor		= state_player_end
state_actor_end		= state_actor+ENG_ACTOR_MAX
state_proj		= state_actor_end
state_proj_end		= state_proj+ENG_PROJ_MAX
state_block		= state_proj_end
state_block_end		= state_block+ENG_BLOCK_MAX
state_misc		= state_block_end
state_misc_end		= state_misc+ENG_MISC_MAX
; ----------------
disp_dir_player		= state_misc_end
disp_dir_player_end	= disp_dir_player+ENG_PLAYER_OBJ_MAX
rot_dir_actor		= disp_dir_player_end
rot_dir_actor_end	= rot_dir_actor+ENG_ACTOR_MAX
proj_bounce_flag	= rot_dir_actor_end
timer_hammer_bro_jump	= proj_bounce_flag+ENG_PROJ_MAX
timer_hammer_bro_jump_end = timer_hammer_bro_jump+ENG_ACTOR_MAX
; ----------------
pos_x_hi_victory_right	= rot_dir_actor
victory_proc_ctrl	= pos_x_hi_victory_right+1
actor_powerup_type	= rot_dir_actor_end-1
; ----------------
unused_42		= timer_hammer_bro_jump_end
unused_43		= unused_42+1
unused_44		= unused_43+1
; ----------------
motion_dir_player	= unused_44+1
motion_dir_player_end 	= motion_dir_player+ENG_PLAYER_OBJ_MAX
motion_dir_actor	= motion_dir_player_end
motion_dir_actor_end 	= motion_dir_actor+ENG_ACTOR_MAX
motion_dir_proj		= motion_dir_actor_end
motion_dir_proj_end	= motion_dir_proj+ENG_PROJ_MAX
motion_dir_misc		= motion_dir_proj_end
motion_dir_misc_end	= motion_dir_misc+ENG_MISC_MAX
; ----------------
veloc_x			= motion_dir_misc_end
veloc_x_player		= veloc_x+0
veloc_x_player_end	= veloc_x_player+ENG_PLAYER_OBJ_MAX
veloc_x_actor		= veloc_x_player_end
veloc_x_actor_end	= veloc_x_actor+ENG_ACTOR_MAX
veloc_y_piranha		= veloc_x_actor
veloc_x_proj		= veloc_x_actor_end
veloc_x_proj_end	= veloc_x_proj+ENG_PROJ_MAX
veloc_x_block		= veloc_x_proj_end
veloc_x_block_end	= veloc_x_block+ENG_BLOCK_MAX
veloc_x_misc		= veloc_x_block_end
veloc_x_misc_end	= veloc_x_misc+ENG_MISC_MAX
; ----------------
apu_fds_track		= veloc_x_misc+2
apu_fds_wave_addr	= apu_fds_track+WORD_SIZE
apu_fds_wave_vol_addr	= apu_fds_wave_addr+WORD_SIZE
apu_fds_wave_mod_addr	= apu_fds_wave_vol_addr+WORD_SIZE
; ----------------
pos_x_hi		= veloc_x_misc_end
pos_x_hi_player		= pos_x_hi+0
pos_x_hi_player_end	= pos_x_hi_player+ENG_PLAYER_OBJ_MAX
pos_x_hi_actor		= pos_x_hi_player_end
pos_x_hi_actor_end	= pos_x_hi_actor+ENG_ACTOR_MAX
pos_x_hi_proj		= pos_x_hi_actor_end
pos_x_hi_proj_end	= pos_x_hi_proj+ENG_PROJ_MAX
pos_x_hi_block		= pos_x_hi_proj_end
pos_x_hi_block_end	= pos_x_hi_block+ENG_BLOCK_MAX
pos_x_hi_misc		= pos_x_hi_block_end
pos_x_hi_misc_end	= pos_x_hi_misc+ENG_MISC_MAX
pos_x_hi_bubble		= pos_x_hi_misc_end
pos_x_hi_bubble_end	= pos_x_hi_bubble+ENG_BUBBLE_MAX
; ----------------
pos_x_lo		= pos_x_hi_bubble_end
pos_x_lo_player		= pos_x_lo+0
pos_x_lo_player_end	= pos_x_lo_player+ENG_PLAYER_OBJ_MAX
pos_x_lo_actor		= pos_x_lo_player_end
pos_x_lo_actor_end	= pos_x_lo_actor+ENG_ACTOR_MAX
pos_x_lo_proj		= pos_x_lo_actor_end
pos_x_lo_proj_end	= pos_x_lo_proj+ENG_PROJ_MAX
pos_x_lo_block		= pos_x_lo_proj_end
pos_x_lo_block_end	= pos_x_lo_block+ENG_BLOCK_MAX
pos_x_lo_misc		= pos_x_lo_block_end
pos_x_lo_misc_end	= pos_x_lo_misc+ENG_MISC_MAX
pos_x_lo_bubble		= pos_x_lo_misc_end
pos_x_lo_bubble_end	= pos_x_lo_bubble+ENG_BUBBLE_MAX
; ----------------
veloc_y			= pos_x_lo_bubble_end
veloc_y_player		= veloc_y+0
veloc_y_player_end	= veloc_y_player+ENG_PLAYER_OBJ_MAX
veloc_y_actor		= veloc_y_player_end
veloc_y_actor_end	= veloc_y_actor+ENG_ACTOR_MAX
neg_y_piranha		= veloc_y_actor
veloc_y_proj		= veloc_y_actor_end
veloc_y_proj_end	= veloc_y_proj+ENG_PROJ_MAX
veloc_y_block		= veloc_y_proj_end
veloc_y_block_end	= veloc_y_block+ENG_BLOCK_MAX
veloc_y_misc		= veloc_y_block_end
veloc_y_misc_end	= veloc_y_misc+ENG_MISC_MAX
; ----------------
pos_y_hi		= veloc_y_misc_end
pos_y_hi_player		= pos_y_hi+0
pos_y_hi_player_end	= pos_y_hi_player+ENG_PLAYER_OBJ_MAX
pos_y_hi_actor		= pos_y_hi_player_end
pos_y_hi_actor_end	= pos_y_hi_actor+ENG_ACTOR_MAX
pos_y_hi_proj		= pos_y_hi_actor_end
pos_y_hi_proj_end	= pos_y_hi_proj+ENG_PROJ_MAX
pos_y_hi_block		= pos_y_hi_proj_end
pos_y_hi_block_end	= pos_y_hi_block+ENG_BLOCK_MAX
pos_y_hi_misc		= pos_y_hi_block_end
pos_y_hi_misc_end	= pos_y_hi_misc+ENG_MISC_MAX
pos_y_hi_bubble		= pos_y_hi_misc_end
pos_y_hi_bubble_end	= pos_y_hi_bubble+ENG_BUBBLE_MAX
; ----------------
pos_y_lo		= pos_y_hi_bubble_end
pos_y_lo_player		= pos_y_lo+0
pos_y_lo_player_end	= pos_y_lo_player+ENG_PLAYER_OBJ_MAX
pos_y_lo_actor		= pos_y_lo_player_end
pos_y_lo_actor_end	= pos_y_lo_actor+ENG_ACTOR_MAX
pos_y_lo_proj		= pos_y_lo_actor_end
pos_y_lo_proj_end	= pos_y_lo_proj+ENG_PROJ_MAX
pos_y_lo_block		= pos_y_lo_proj_end
pos_y_lo_block_end	= pos_y_lo_block+ENG_BLOCK_MAX
pos_y_lo_misc		= pos_y_lo_block_end
pos_y_lo_misc_end	= pos_y_lo_misc+ENG_MISC_MAX
pos_y_lo_bubble		= pos_y_lo_misc_end
pos_y_lo_bubble_end	= pos_y_lo_bubble+ENG_BUBBLE_MAX
; ----------------
course_scenery_addr	= pos_y_lo_bubble_end
course_actor_addr	= course_scenery_addr+WORD_SIZE
; ----------------
zp_addr_EB		= course_actor_addr+WORD_SIZE
zp_byte_EB		= zp_addr_EB
zp_byte_EC		= zp_byte_EB+1
zp_addr_ED		= zp_addr_EB+WORD_SIZE
zp_byte_ED		= zp_addr_ED
zp_byte_EF		= zp_addr_ED+WORD_SIZE
; ----------------
apu_note_len_offset	= zp_byte_EF+1
apu_sfx_pulse_1_current	= apu_note_len_offset+1
apu_sfx_pulse_2_current	= apu_sfx_pulse_1_current+1
apu_sfx_noise_current	= apu_sfx_pulse_2_current+1
apu_music_base_current	= apu_sfx_noise_current+1
apu_track		= apu_music_base_current+1
apu_pulse_2_offset	= apu_track+WORD_SIZE
apu_pulse_1_offset	= apu_pulse_2_offset+1
apu_triangle_offset	= apu_pulse_1_offset+1
apu_sfx_flag_pause	= apu_triangle_offset+1
apu_music_base_req	= apu_sfx_flag_pause+1
apu_music_event_req	= apu_music_base_req+1
apu_sfx_noise_req	= apu_music_event_req+1
apu_sfx_pulse_2_req	= apu_sfx_noise_req+1
apu_sfx_pulse_1_req	= apu_sfx_pulse_2_req+1
; ----------------------------------
stack_00			= (STACK_BASE+$00)

stack_04			= (STACK_BASE+$04)

render_actor_flipped		= (STACK_BASE+$09)
.if	.defined(FC_SMB)|.defined(VS_SMB)
cpu_stack_work			= stack_00
.elseif	.defined(FDS_SMB)
cpu_stack_work			= stack_04
.elseif	.defined(SMBV2)
cpu_stack_work			= render_actor_flipped
.endif

render_flag_score_pos_y		= (STACK_BASE+$0D)
render_flag_score_pos_y_b	= (STACK_BASE+$0E)
render_flag_score_val		= (STACK_BASE+$0F)

bg_score_ctl			= (STACK_BASE+$10)
bg_score_pos_x			= (STACK_BASE+$17)
bg_score_pos_y			= (STACK_BASE+$1E)
stomp_counter			= (STACK_BASE+$25)
timer_score			= (STACK_BASE+$2C)
score_digit_mod			= (STACK_BASE+$33)
ending_player_live		= (STACK_BASE+$35)

cpu_stack_work_end		= (STACK_BASE+$60)
; ----------------------------------
oam_buffer			= (STACK_BASE+STACK_SIZE)
oam_buffer_END			= (oam_buffer+(OBJ_MAX*OBJ_SIZE))
; ----------------------------------
ppu_displist			= oam_buffer_END
ppu_displist_offset		= ppu_displist
ppu_displist_data		= ppu_displist_offset+NMI_BUFFER_ENTRY_OFFSET_SIZE
ppu_displist_addr_dbyt		= ppu_displist_data
ppu_displist_special		= ppu_displist_addr_dbyt+WORD_SIZE
ppu_displist_count		= ppu_displist_special
ppu_displist_payload		= ppu_displist_count+1
ppu_displist_end		= ppu_displist_data+((NMI_BUFFER_ENTRY_MAX-1)*NMI_BUFFER_ENTRY_SIZE)
ppu_displist_meta		= ppu_displist_end
ppu_displist_meta_offset	= ppu_displist_meta
ppu_displist_meta_data		= ppu_displist_meta_offset+NMI_BUFFER_ENTRY_OFFSET_SIZE
ppu_displist_meta_addr_dbyt	= ppu_displist_meta_data
ppu_displist_meta_special	= ppu_displist_meta_addr_dbyt+WORD_SIZE
ppu_displist_meta_count		= ppu_displist_meta_special
ppu_displist_meta_payload	= ppu_displist_meta_count+1
ppu_displist_meta_end		= ppu_displist_meta_data+((NMI_BUFFER_ENTRY_MAX-1)*NMI_BUFFER_ENTRY_SIZE)
; ----------------
actor_bowser_ani_flag	= ppu_displist_meta_data+$22
timer_ani_bowser	= actor_bowser_ani_flag+1
veloc_x_bowser		= timer_ani_bowser+1
pos_x_prev_bowser	= veloc_x_bowser+1
actor_bowser_flame_timer_idx = pos_x_prev_bowser+1
actor_index_bowser	= actor_bowser_flame_timer_idx+1
actor_bowser_ending_clear_frame = actor_index_bowser+1
actor_bowser_ani_frame	= actor_bowser_ending_clear_frame+1
; ----------------------------------
unused_380		= ppu_displist_meta_end
unused_381		= unused_380+1
unused_382		= unused_381+1
unused_383		= unused_382+1
unused_384		= unused_383+1
unused_385		= unused_384+1
unused_386		= unused_385+1
unused_387		= unused_386+1
; ----------------
veloc_ang_actor		= unused_387+1
veloc_ang_actor_end	= veloc_ang_actor+ENG_ACTOR_MAX
; ----------------
unused_38E		= veloc_ang_actor_end
unused_38F		= unused_38E+1
unused_390		= unused_38F+1
unused_391		= unused_390+1
unused_392		= unused_391+1
unused_393		= unused_392+1
unused_394		= unused_393+1
unused_395		= unused_394+1
unused_396		= unused_395+1
unused_397		= unused_396+1
; ----------------
actor_vine_flag		= unused_397+1
height_vine		= actor_vine_flag+1
actor_vine_offset	= height_vine+1
pos_y_vine		= actor_vine_offset+(ENG_ACTOR_MAX-3)
; ----------------
unused_39E		= pos_y_vine+1
unused_39F		= unused_39E+1
; ----------------
actor_plat_align	= unused_39F+1
actor_plat_scroll_x	= actor_plat_align+1
actor_plat_col_flag	= actor_plat_scroll_x+1
timer_hammer_throw	= actor_plat_col_flag
actor_plat_col_flag_end	= actor_plat_col_flag+ENG_ACTOR_MAX
; ----------------
unused_3A8		= actor_plat_col_flag_end
unused_3A9		= unused_3A8+1
unused_3AA		= unused_3A9+1
unused_3AB		= unused_3AA+1
unused_3AC		= unused_3AB+1
; ----------------
pos_x_rel_player	= unused_3AC+1
pos_x_rel_actor		= pos_x_rel_player+ENG_PLAYER_OBJ_MAX
pos_x_rel_proj		= pos_x_rel_actor+(ENG_ACTOR_MAX-5)
pos_x_rel_bubble	= pos_x_rel_proj+(ENG_PROJ_MAX-1)
pos_x_rel_block		= pos_x_rel_bubble+(ENG_BUBBLE_MAX-2)
pos_x_rel_misc		= pos_x_rel_block+(ENG_BLOCK_MAX-2)
; ----------------
pos_y_rel_player	= pos_x_rel_misc+(ENG_MISC_MAX-4)
pos_y_rel_actor		= pos_y_rel_player+ENG_PLAYER_OBJ_MAX
pos_y_rel_proj		= pos_y_rel_actor+(ENG_ACTOR_MAX-5)
pos_y_rel_bubble	= pos_y_rel_proj+(ENG_PROJ_MAX-1)
pos_y_rel_block		= pos_y_rel_bubble+(ENG_BUBBLE_MAX-2)
pos_y_rel_misc		= pos_y_rel_block+(ENG_BLOCK_MAX-2)
pos_y_rel_misc_end	= pos_y_rel_misc+(ENG_MISC_MAX-4)
; ----------------
unused_3C3		= pos_y_rel_misc_end
; ----------------
attr_player		= unused_3C3+1
attr_actor		= attr_player+ENG_PLAYER_OBJ_MAX
attr_actor_end		= attr_actor+ENG_ACTOR_MAX
; ----------------
unused_3CB		= attr_actor_end
unused_3CC		= unused_3CB+1
unused_3CD		= unused_3CC+1
unused_3CE		= unused_3CD+1
unused_3CF		= unused_3CE+1
; ----------------
bits_offscr_player	= unused_3CF+1
bits_offscr_actor	= bits_offscr_player+1
bits_offscr_proj	= bits_offscr_actor+1
bits_offscr_bubble	= bits_offscr_proj+1
bits_offscr_block	= bits_offscr_bubble+1
unused_3D5		= bits_offscr_block+1
bits_offscr_misc	= unused_3D5+1
unused_3D7		= bits_offscr_misc+1
actor_bits_mask		= unused_3D7+1
actor_bits_mask_end	= actor_bits_mask+ENG_ACTOR_MAX
; ----------------
unused_3DE		= actor_bits_mask_end
unused_3DF		= unused_3DE+1
unused_3E0		= unused_3DF+1
unused_3E1		= unused_3E0+1
unused_3E2		= unused_3E1+1
unused_3E3		= unused_3E2+1
; ----------------
pos_y_orig_block	= unused_3E3+1
block_buffer_idx	= pos_y_orig_block+(ENG_BLOCK_MAX-2)
block_tile		= block_buffer_idx+(ENG_BLOCK_MAX-2)
block_page_loc		= block_tile+(ENG_BLOCK_MAX-2)
block_rep_flag		= block_page_loc+(ENG_BLOCK_MAX-2)
block_id		= block_rep_flag+(ENG_BLOCK_MAX-2)
unused_3EF		= block_id+1
block_counter_res	= unused_3EF+1
pos_x_orig_block	= block_counter_res+1
pos_x_orig_block_end	= pos_x_orig_block+(ENG_BLOCK_MAX-2)
; ----------------
unused_3F3		= pos_x_orig_block_end
unused_3F4		= unused_3F3+1
unused_3F5		= unused_3F4+1
unused_3F6		= unused_3F5+1
unused_3F7		= unused_3F6+1
unused_3F8		= unused_3F7+1
; ----------------
bg_attr_buffer		= unused_3F8+1
; ----------------------------------
accel_x			= bg_attr_buffer+BG_ATTR_COUNT
accel_x_player		= accel_x+0
ppu_displist_title_end	= accel_x_player
accel_x_actor		= accel_x_player+ENG_PLAYER_OBJ_MAX
accel_x_proj		= accel_x_actor+ENG_ACTOR_MAX
accel_x_block		= accel_x_proj+ENG_PROJ_MAX
accel_x_misc		= accel_x_block+ENG_BLOCK_MAX
; ----------------
accel_y			= accel_x_misc+ENG_MISC_MAX
accel_y_player		= accel_y+0
accel_y_actor		= accel_y_player+ENG_PLAYER_OBJ_MAX
pos_y_bottom_piranha	= accel_y_actor
accel_y_proj		= accel_y_actor+ENG_ACTOR_MAX
accel_y_block		= accel_y_proj+ENG_PROJ_MAX
accel_y_misc		= accel_y_block+ENG_BLOCK_MAX
accel_y_bubble		= accel_y_misc+ENG_MISC_MAX
; ----------------
unused_42F		= accel_y_bubble+ENG_BUBBLE_MAX
unused_430		= unused_42F+1
unused_431		= unused_430+1
unused_432		= unused_431+1
; ----------------
accel_y_grav		= unused_432+1
accel_y_grav_player		= accel_y_grav+0
accel_y_grav_actor		= accel_y_grav_player+ENG_PLAYER_OBJ_MAX
pos_y_top_piranha	= accel_y_grav_actor
accel_y_grav_proj		= accel_y_grav_actor+ENG_ACTOR_MAX
accel_y_grav_block		= accel_y_grav_proj+ENG_PROJ_MAX
accel_y_grav_misc		= accel_y_grav_block+ENG_BLOCK_MAX
accel_y_grav_bubble		= accel_y_grav_misc+ENG_MISC_MAX
; ----------------
unused_44C		= accel_y_grav_bubble+ENG_BUBBLE_MAX
unused_44D		= unused_44C+1
unused_44E		= unused_44D+1
unused_44F		= unused_44E+1
; ----------------
player_max_veloc_left 	= unused_44F+1
unused_451		= player_max_veloc_left+1
unused_452		= unused_451+1
unused_453		= unused_452+1
unused_454		= unused_453+1
unused_455		= unused_454+1
player_max_veloc_right 	= unused_455+1
unused_457		= player_max_veloc_right+1
unused_458		= unused_457+1
unused_459		= unused_458+1
unused_45A		= unused_459+1
unused_45B		= unused_45A+1
; ----------------
unused_45C		= unused_45B+1
unused_45D		= unused_45C+1
unused_45E		= unused_45D+1
unused_45F		= unused_45E+1
unused_460		= unused_45F+1
unused_461		= unused_460+1
unused_462		= unused_461+1
unused_463		= unused_462+1
unused_464		= unused_463+1
unused_465		= unused_464+1
unused_466		= unused_465+1
unused_467		= unused_466+1
unused_468		= unused_467+1
unused_469		= unused_468+1
; ----------------
actor_cannon_offset	= unused_469+1
pos_y_hi_cannon		= actor_cannon_offset+1
pos_x_lo_cannon		= pos_y_hi_cannon+ENG_ACTOR_MAX
pos_y_lo_cannon		= pos_x_lo_cannon+ENG_ACTOR_MAX
timer_cannon		= pos_y_lo_cannon+ENG_ACTOR_MAX
game_whirlpool_flag	= timer_cannon
hp_bowser		= timer_cannon+ENG_ACTOR_MAX
counter_stomps		= hp_bowser+1
; ----------------
unused_485		= counter_stomps+1
unused_486		= unused_485+1
unused_487		= unused_486+1
unused_488		= unused_487+1
unused_489		= unused_488+1
unused_48A		= unused_489+1
unused_48B		= unused_48A+1
unused_48C		= unused_48B+1
unused_48D		= unused_48C+1
unused_48E		= unused_48D+1
unused_48F		= unused_48E+1
; ----------------
collision_player	= unused_48F+1
collision_actor		= collision_player+ENG_PLAYER_OBJ_MAX
collision_proj		= collision_actor+ENG_ACTOR_MAX
col_box_player		= collision_proj+ENG_PROJ_MAX
col_box_actor		= col_box_player+ENG_PLAYER_OBJ_MAX
col_box_actor_end	= col_box_actor+ENG_ACTOR_MAX
col_box_proj		= col_box_actor_end
col_box_misc		= col_box_proj+ENG_PROJ_MAX
unused_4AB		= col_box_misc+ENG_MISC_MAX
pos_x_col_box_nw	= unused_4AB+1
pos_y_col_box_nw	= pos_x_col_box_nw+1
pos_x_col_box_se	= pos_y_col_box_nw+1
pos_y_col_box_se	= pos_x_col_box_se+1
pos_x_col_box_nw_actor	= pos_y_col_box_se+1
pos_y_col_box_nw_actor	= pos_x_col_box_nw_actor+1
pos_x_col_box_se_actor	= pos_y_col_box_nw_actor+1
pos_y_col_box_se_actor	= pos_x_col_box_se_actor+1
; ----------------------------------
bg_buffer_0		= $500
bg_buffer_1		= bg_buffer_0+BG_BUFFER_SIZE
; ----------------
apu_fds_wave_note_len	= bg_buffer_1+$21
apu_fds_wave_note_len_b	= bg_buffer_1+$22
apu_fds_wave_env_ctl	= bg_buffer_1+$23
apu_fds_wave_mod_offset	= bg_buffer_1+$26
apu_fds_wave_env_start	= bg_buffer_1+$27
apu_fds_wave_vol_len	= bg_buffer_1+$28
apu_fds_wave_vol_idx	= bg_buffer_1+$29
apu_fds_wave_mod_len	= bg_buffer_1+$2A
apu_fds_wave_mod_idx	= bg_buffer_1+$2B
apu_fds_music_current	= bg_buffer_1+$38
apu_fds_note_len_offset	= bg_buffer_1+$39
apu_fds_pulse_2_offset	= bg_buffer_1+$3A
apu_fds_pulse_1_offset	= bg_buffer_1+$3B
apu_fds_triangle_offset	= bg_buffer_1+$3C
apu_fds_noise_offset	= bg_buffer_1+$3D
apu_fds_wave_id_b	= bg_buffer_1+$3E
apu_fds_pulse_2_note_len_b = bg_buffer_1+$40
apu_fds_pulse_2_note_len = bg_buffer_1+$41
apu_fds_pulse_2_env_ctl = bg_buffer_1+$42
apu_fds_pulse_1_note_len = bg_buffer_1+$43
apu_fds_pulse_1_env_ctl = bg_buffer_1+$44
apu_fds_triangle_note_len_b = bg_buffer_1+$45
apu_fds_triangle_note_len = bg_buffer_1+$46
apu_fds_noise_note_len	= bg_buffer_1+$47
apu_fds_noise_loop_offset = bg_buffer_1+$4B
apu_fds_step		= bg_buffer_1+$4D
apu_fds_wave_offset	= bg_buffer_1+$4F
; ----------------------------------
disp_buff_col		= bg_buffer_1+BG_BUFFER_SIZE
scenery_metatile		= disp_buff_col+1
scenery_metatile_end	= scenery_metatile+METATILE_MAX
; ----------------
misc_obj_id_actor	= scenery_metatile_end
misc_block_id		= misc_obj_id_actor+ENG_MISC_MAX
; ----------------
unused_6B8		= misc_block_id+1
unused_6B9		= unused_6B8+1
unused_6BA		= unused_6B9+1
unused_6BB		= unused_6BA+1
; ----------------
block_invis_req		= unused_6BB+1
; ----------------
unused_6BD		= block_invis_req+1
; ----------------
misc_col_flag		= unused_6BD+1
misc_col_flag_end	= misc_col_flag+ENG_MISC_MAX
; ----------------
unused_6C7		= misc_col_flag_end
unused_6C8		= unused_6C7+1
; ----------------
byte_6C9		= unused_6C8+1
; ----------------
unused_6CA		= byte_6C9+1
; ----------------
actor_swarm_buffer	= unused_6CA+1
game_hard_mode_b	= actor_swarm_buffer+1
actor_swarm_queue	= game_hard_mode_b+1
proj_counter		= actor_swarm_queue+1
actor_dup_offset	= proj_counter+1
; ----------------
unused_6D0		= actor_dup_offset+1
; ----------------
timer_lakitu_new	= unused_6D0+1
; ----------------
unused_6D2		= timer_lakitu_new+1
; ----------------
actor_group_count	= unused_6D2+1
meta_color_rotate_off	= actor_group_count+1
render_player_spr_group	= meta_color_rotate_off+1
game_warp_ctrl		= render_player_spr_group+1
actor_firework_counter	= game_warp_ctrl+1
; ----------------
unused_6D8		= actor_firework_counter+1
; ----------------
actor_loop_counter_real	= unused_6D8+1
actor_loop_counter	= actor_loop_counter_real+1
accel_y_spring		= actor_loop_counter+1
actor_bowser_rand_offset = accel_y_spring+1
actor_bullet_cheep_mask	= actor_bowser_rand_offset+1
timer_scene_trans	= actor_bullet_cheep_mask+1
; ----------------
unused_6DF		= timer_scene_trans+1
; ----------------
sprite_strobe_offset	= unused_6DF+1
sprite_strobe_amount	= sprite_strobe_offset+1
obj_data_offset_player	= sprite_strobe_amount+3
obj_data_offset_actor	= obj_data_offset_player+ENG_PLAYER_OBJ_MAX
obj_data_offset_leaf	= obj_data_offset_actor+ENG_ACTOR_MAX
obj_data_offset_block	= obj_data_offset_leaf+1
obj_data_offset_bubble	= obj_data_offset_block+(ENG_BLOCK_MAX-2)
obj_data_offset_proj	= obj_data_offset_bubble+ENG_BUBBLE_MAX
obj_data_offset_misc	= obj_data_offset_proj+ENG_PROJ_MAX
joypad_bits		= obj_data_offset_misc+ENG_MISC_MAX
joypad_p1		= joypad_bits
joypad_p2		= joypad_p1+1
; ----------------
unused_6FE		= joypad_p2+1
; ----------------
scroll_x_player		= unused_6FE+1
veloc_x_player_abs	= scroll_x_player+1
accel_x_friction	= veloc_x_player_abs+1
veloc_x_player_run	= accel_x_friction+2
player_swimming		= veloc_x_player_run+1
veloc_x_player_hi	= player_swimming+1
offset_y_player_jump	= veloc_x_player_hi+1
pos_y_player_jump	= offset_y_player_jump+1
accel_y_player_spring	= pos_y_player_jump+2
accel_y_gravity		= accel_y_player_spring+1
player_resizing		= accel_y_gravity+1
timer_ani_player	= player_resizing+1
player_ani_frame	= timer_ani_player+1
player_on_spring	= player_ani_frame+1
pos_y_goal		= player_on_spring+1
course_pos_y_start	= pos_y_goal+1
timer_proj_throw	= course_pos_y_start+1
music_event_death_flag	= timer_proj_throw+1
music_event_goal_flag	= music_event_death_flag+1
player_crouching	= music_event_goal_flag+1
course_timer		= player_crouching+1
col_disable		= course_timer+1
title_demo_button_id	= col_disable+1
title_demo_button_timer	= title_demo_button_id+1
victory_msg_id		= title_demo_button_timer+1
; ----------------
pos_x_hi_screen_left	= victory_msg_id+1
pos_x_hi_screen_right	= pos_x_hi_screen_left+1
pos_x_lo_screen_left	= pos_x_hi_screen_right+1
pos_x_lo_screen_right	= pos_x_lo_screen_left+1
bg_scenery_counter	= pos_x_lo_screen_right+1
bg_scenery_proc_id	= bg_scenery_counter+1
bg_addr			= bg_scenery_proc_id+1
nmi_sprite_overlap	= bg_addr+WORD_SIZE
game_scroll_lock	= nmi_sprite_overlap+1
unused_724		= game_scroll_lock+1
pos_x_hi_game		= unused_724+1
pos_x_lo_game		= pos_x_hi_game+1
course_floor_mask_id	= pos_x_lo_game+1
course_page_loaded	= course_floor_mask_id+1
course_page_calc	= course_page_loaded+1
scenery_page_loc	= course_page_calc+1
scenery_page_on		= scenery_page_loc+1
scenery_offset_base	= scenery_page_on+1
scenery_offset		= scenery_offset_base+1
scenery_length		= scenery_offset+SCENERY_ACTIVE_MAX
course_ledge_type	= scenery_length+SCENERY_ACTIVE_MAX
scenery_step_no		= course_ledge_type+1
scenery_height		= scenery_step_no+1
scenery_ledge_dims	= scenery_height+1
actor_offset		= scenery_ledge_dims+SCENERY_ACTIVE_MAX
actor_page_loc		= actor_offset+1
actor_page_on		= actor_page_loc+1
bg_proc_id		= actor_page_on+1
game_scroll_h		= bg_proc_id+1
unused_73E		= game_scroll_h+1
ppu_scc_h_b		= unused_73E+1
ppu_scc_v_b		= ppu_scc_h_b+1
course_fg_id		= ppu_scc_v_b+1
course_bg_id		= course_fg_id+1
course_type_cloud	= course_bg_id+1
course_bg_col		= course_type_cloud+1
course_loop_flag	= course_bg_col+1
proc_id_flag_victory 	= course_loop_flag+1
game_timer_stop		= proc_id_flag_victory+1
game_bonus_counter	= game_timer_stop+1
timer_victory_msg	= game_bonus_counter+1
joypad_mask		= timer_victory_msg+1
joypad_mask_p1		= joypad_mask+0
joypad_mask_p2		= joypad_mask+1
RAM_CLEAR_END_GAMERESET	= joypad_mask_p2
; ----------------------------------
unused_74C		= RAM_CLEAR_END_GAMERESET+1
unused_74D		= unused_74C+1
; ----------------------------------
course_type		= unused_74D+1
course_page_offset	= course_type+1
course_descriptor	= course_page_offset+1
pos_x_hi_init_game	= course_descriptor+1
game_start_type		= pos_x_hi_init_game+1
player_id		= game_start_type+1
player_size		= player_id+1
scroll_x_player_b	= player_size+1
player_status		= scroll_x_player_b+1
player_first_start	= player_status+1
game_joypad_override	= player_first_start+1
game_time_up		= game_joypad_override+1
; ----------------
player_lives		= game_time_up+1
pos_x_hi_alt_game	= player_lives+1
player_goals		= pos_x_hi_alt_game+1
scenery_hidden_one_up_req	= player_goals+1
player_coins		= scenery_hidden_one_up_req+1
course_no		= player_coins+1
course_sub		= course_no+1
; ----------------
player_lives_b		= course_sub+1
pos_x_hi_alt_game_b	= player_lives_b+1
player_goals_b		= pos_x_hi_alt_game_b+1
scenery_hidden_one_up_req_b	= player_goals_b+1
player_coins_b		= scenery_hidden_one_up_req_b+1
course_no_b		= player_coins_b+1
course_sub_b		= course_no_b+1
.if	.defined(SMBV2)
timer_ending		= player_lives_b
ending_toad_offset	= pos_x_hi_alt_game_b
ending_palcycle_step	= pos_x_hi_alt_game_b
ending_toad_cycling	= player_goals_b
ending_palcycle_delay	= player_goals_b
ending_toad_delay	= scenery_hidden_one_up_req_b
.endif
; ----------------
pos_x_victory_scroll	= course_sub_b+1
bg_msg_disable		= pos_x_victory_scroll+1

.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
game_hard_mode		= bg_msg_disable+1
.endif

.if	.defined(SMB)|.defined(VS_SMB)|.defined(SMB2)
title_course_sel_no	= game_hard_mode+1
.elseif	.defined(ANN)
unused_76A		= bg_msg_disable+1
title_course_sel_no	= unused_76A+1
.endif
unused_76C		= title_course_sel_no+1
unused_76D		= unused_76C+1
unused_76E		= unused_76D+1
unused_76F		= unused_76E+1
RAM_CLEAR_END_GAMEINIT	= unused_76F
; ----------------------------------
proc_id_system		= RAM_CLEAR_END_GAMEINIT+1
unused_771		= proc_id_system+1
proc_id_game		= unused_771+1
nmi_buffer_ptr		= proc_id_game+1
nmi_disp_disable	= nmi_buffer_ptr+1
game_scroll_amount	= nmi_disp_disable+1
nmi_pause_flag		= game_scroll_amount+1
nmi_pause_debounce	= nmi_pause_flag+1
ppu_ctlr0_b		= nmi_pause_debounce+1
ppu_ctlr1_b		= ppu_ctlr0_b+1

.if	.defined(SMBV1)
player_count		= ppu_ctlr1_b+1
.endif

.if	.defined(SMBV1)
ppu_ctlr0_bg		= player_count+1
.elseif	.defined(SMBV2)
ppu_ctlr0_bg		= ppu_ctlr1_b+1
.endif
fds_sprite_overlap_hit	= ppu_ctlr0_bg+1
render_clear_skip	= fds_sprite_overlap_hit+1
; ----------------------------------
.if	.defined(SMB2)
unused_77D		= render_clear_skip+1
.elseif	.defined(ANN)
game_hard_mode		= render_clear_skip+1
.endif
; ----------------
.if	.defined(SMBV1)
unused_77E		= render_clear_skip+1
.elseif	.defined(SMB2)
unused_77E		= unused_77D+1
.elseif	.defined(ANN)
unused_77E		= game_hard_mode+1
.endif
; ----------------------------------
timer_nmi_tick		= unused_77E+1
timers_nmi		= timer_nmi_tick+1
timer_select		= timers_nmi
timer_ani_proj		= timer_select+1
timer_player_jump_swim	= timer_ani_proj+1
timer_player_run	= timer_player_jump_swim+1
timer_block_bounce	= timer_player_run+1
timer_col_x		= timer_block_bounce+1
timer_spring		= timer_col_x+1
timer_game_ctrl		= timer_spring+1
timer_unk_a		= timer_game_ctrl+1
timer_player_climb	= timer_unk_a+1
timer_ani_actor		= timer_player_climb+1
timer_swarm		= timer_ani_actor+(ENG_ACTOR_MAX-1)
timer_bowser_flame	= timer_ani_actor+ENG_ACTOR_MAX
timer_actor_stun	= timer_bowser_flame+1
timer_bubble		= timer_actor_stun+1

timer_scroll		= timer_bubble+ENG_BUBBLE_MAX
timer_actor		= timer_scroll+1
timer_unk_b		= timer_actor+ENG_ACTOR_MAX
timer_block_invis	= timer_unk_b+1
timer_player_injury	= timer_block_invis+1
timer_player_star	= timer_player_injury+1
timer_screen		= timer_player_star+1
timer_victory		= timer_screen+1
timer_demo		= timer_victory+1
timer_unk_c		= timer_demo+1
timer_unk_d		= timer_unk_c+1
timers_nmi_end		= timer_unk_d
; ----------------------------------
unused_7A4	= timers_nmi_end
unused_7A5	= unused_7A4+1
unused_7A6	= unused_7A5+1
; ----------------------------------
srand		= unused_7A6+1
srand_end	= srand+SRAND_SIZE
unused_7AE	= srand_end
unused_7AF	= unused_7AE+1
; ----------------------------------
snd_ram			= unused_7AF+1
apu_noise_offset	= snd_ram
apu_music_event_current = apu_noise_offset+1
snd_pause_buffer	= apu_music_event_current+1
apu_pulse_2_note_len_b	= snd_pause_buffer+1
apu_pulse_2_note_len	= apu_pulse_2_note_len_b+1
apu_pulse_2_env_ctl	= apu_pulse_2_note_len+1
apu_pulse_1_note_len	= apu_pulse_2_env_ctl+1
apu_pulse_1_env_ctl	= apu_pulse_1_note_len+1
apu_triangle_note_len_b	= apu_pulse_1_env_ctl+1
apu_triangle_note_len	= apu_triangle_note_len_b+1
apu_noise_note_len	= apu_triangle_note_len+1
snd_sfx_pulse_1_len	= apu_noise_note_len+1
unused_7BC		= snd_sfx_pulse_1_len+1
snd_sfx_pulse_2_len	= unused_7BC+1
snd_sfx_counter		= snd_sfx_pulse_2_len+1
snd_sfx_noise_len	= snd_sfx_counter+1
snd_dac_len		= snd_sfx_noise_len+1
apu_noise_loop_offset	= snd_dac_len+1
unused_7C2		= apu_noise_loop_offset+1
unused_7C3		= unused_7C2+1
snd_note_len_offset	= unused_7C3+1
apu_music_base_current_b = snd_note_len_offset+1
snd_is_paused		= apu_music_base_current_b+1
snd_overworld_header_offset = snd_is_paused+1
unused_7C8		= snd_overworld_header_offset+1
snd_super_star_header_offset = unused_7C8+1
apu_pulse_1_ctl_a	= snd_super_star_header_offset+1
unused_7CB		= apu_pulse_1_ctl_a+1
apu_vs_counter		= unused_7CB+1
unused_7CD		= apu_vs_counter+1
unused_7CE		= unused_7CD+1
unused_7CF		= unused_7CE+1
snd_ram_end		= unused_7CF+1
; ----------------------------------
unused_7D0		= snd_ram_end
unused_7D1		= unused_7D0+1
unused_7D2		= unused_7D1+1
unused_7D3		= unused_7D2+1
unused_7D4		= unused_7D3+1
unused_7D5		= unused_7D4+1
unused_7D6		= unused_7D5+1
RAM_CLEAR_END_WARMBOOT	= unused_7D6
; ----------------------------------
stats_tbl		= RAM_CLEAR_END_WARMBOOT+1
stats_score_top		= stats_tbl
stats_score_top_end	= (stats_score_top+STAT_LEN_MAX)
; ----------------
stats_player			= stats_score_top_end
stats_score_player		= stats_player
stats_score_player_a		= stats_score_player
stats_score_player_a_end	= (stats_score_player_a+STAT_LEN_MAX)
.if	.defined(SMBV1)
stats_score_player_b		= stats_score_player_a_end
stats_score_player_b_end	= (stats_score_player_b+STAT_LEN_MAX)
stats_score_player_end		= stats_score_player_b_end
.elseif	.defined(SMBV2)
stats_score_player_end		= stats_score_player_a_end
.endif
; ----------------
stats_coin_player	= stats_score_player_end
stats_coin_player_a	= stats_coin_player
stats_coin_player_a_end	= (stats_coin_player_a+STAT_LEN_MAX)
.if	.defined(SMBV1)
stats_coin_player_b	= stats_coin_player_a_end
stats_coin_player_b_end	= (stats_coin_player_b+STAT_LEN_MAX)
stats_coin_player_end	= stats_coin_player_b_end
.elseif	.defined(SMBV2)
stats_coin_player_end	= stats_coin_player_a_end
.endif
stats_player_end	= stats_coin_player_end
stats_time		= stats_player_end
stats_time_end		= (stats_time+STAT_LEN_MAX)
; ----------------------------------
.if    .defined(SMBV2)
unused_7EF		= stats_time_end
unused_7F0		= unused_7EF+1
unused_7F1		= unused_7F0+1
unused_7F2		= unused_7F1+1
unused_7F3		= unused_7F2+1
unused_7F4		= unused_7F3+1
course_plus_msg_flg	= unused_7F4+1
game_level_end_apu_on	= course_plus_msg_flg+1
disk_loader_file_id	= game_level_end_apu_on+1
game_over_choice	= disk_loader_file_id+1
scenery_wind_flag	= game_over_choice+1
game_courses_cleared	= scenery_wind_flag+1
.endif

.if	.defined(SMBV1)
game_hard_mode_new	= stats_time_end
.elseif	.defined(SMBV2)
game_hard_mode_new	= game_courses_cleared+1
.endif

title_course_sel_on	= game_hard_mode_new+1
course_no_continued	= title_course_sel_on+1

.if	.defined(SMBV2)
disk_loader_proc	= title_course_sel_on
disk_loader_main_req	= course_no_continued
.endif

unused_7FE		= course_no_continued+1
RAM_CLEAR_END_COLDBOOT	= unused_7FE
; ----------------------------------
game_boot_flag		= RAM_CLEAR_END_COLDBOOT+1
; ----------------------------------
.if	.defined(VS_SMB)
	nmi_addr_1D	= VS_RAM+$000
	vs_actor_data	= VS_RAM+$100
	vs_scenery_data	= VS_RAM+$200
	vs_ppu_displist	= VS_RAM+$300
	vs_ppu_displist_end	= vs_ppu_displist+$100
	title_tbl_400	= VS_RAM+$400

	VS_RAM_ARENA0           = (VS_RAM+$600)

	VS_SAVEDAT              = (VS_RAM_ARENA0+$74)
	VS_SAVEDAT_SCORE        = (VS_SAVEDAT+$46)

	VS_RAM_ARENA1           = (VS_RAM+$700)
.endif

.if	.defined(SMBV1)
	ENG_HARDMODE_VAR	= game_hard_mode
.elseif	.defined(SMBV2)
	ENG_HARDMODE_VAR	= game_hard_mode_new
.endif

.endif
