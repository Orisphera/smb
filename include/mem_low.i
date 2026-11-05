.ifndef	MEM_LOW_I
MEM_LOW_I	= 1

.include	"mem.i"

ppu_displist_write_addr		= zp_addr_00

col_player_bullet_diff_pos_x_rel = zp_byte_00

scenery_tbl_base		= zp_byte_00

bg_color_pal_entry		= zp_byte_00

motion_gravity_accel_y_inc	= zp_byte_00
motion_gravity_accel_y_dec	= zp_byte_01
motion_gravity_veloc_y_max_abs	= zp_byte_02

apu_fds_wave_id			= zp_byte_01

pos_y_block_proc		= zp_byte_02

render_oam_idx			= zp_byte_02

render_chr_pair_tile_left	= zp_byte_00
render_chr_pair_tile_right	= zp_byte_01
render_chr_pair_args		= zp_byte_02
render_chr_pair_pos_y		= zp_byte_02
render_chr_pair_color_mod_2 	= zp_byte_03
render_chr_pair_attr		= zp_byte_04
render_chr_pair_pos_x		= zp_byte_05

col_bg_proc_player_halt_dir	= zp_byte_00
col_obj_idx			= zp_byte_01
col_buffer_ptr_idx		= zp_byte_02
col_box_buffer_tbl_offset	= zp_byte_04

meta_clear_put_do_addr		= zp_addr_04

scenery_proc_metatile_id 	= zp_byte_07

.endif	; MEM_LOW_I
