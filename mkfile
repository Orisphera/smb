#
# Plan9 mkfile for (All Night Nippon) Super Mario Bros. (2) for the (Vs) Famicom (Disk System)
#
# Preprocessor Definitions:
#   FC      - Famicom-specific
#   VS      - Vs. System-specific
#   VS_2C04_0004 - Vs. System 2C04-0004 PPU-specific
#   FDS     - Famicom Disk System-specific
#   CONS    - Home Console-specific
#   SMB     - Super Mario Bros.
#   FC_SMB  - Famicom-specific Super Mario Bros.
#   VS_SMB  - Vs. Super Mario Bros.
#   FDS_SMB - Famicom Disk System-specific Super Mario Bros.
#   SMB2    - Super Mario Bros. 2
#   ANN     - All Night Nippon Super Mario Bros.
#   SMBM    - Super Mario Bros. "Meta" (SMB and ANN-commonalities)
#   SMBV1   - The "V1" Engine (SMB and Vs.)
#   SMBV2   - The "V2" Engine (ANN and SMB2)
#   PAL     - PAL-specific
#   OG_PAD  - Padding in the original is retained
#   OG_FALL - Original fall-throughs (module adjacency for control flow) assumed
AS_TGT		=	ca65
APPFLAGS_TGT	=	-U -I . -I ./include
ASFLAGS_FC	=	-DFC -DCONS -DSMB -DFC_SMB -DSMBM -DSMBV1
ASFLAGS_VS	=	-DVS -DVS_2C04_0004 -DVS_SMB -DSMBV1
ASFLAGS_FDS	=	-DFDS -DCONS -DSMB -DFDS_SMB -DSMBM -DSMBV1
ASFLAGS_SMB2	=	-DFDS -DCONS -DSMB2 -DSMBV2
ASFLAGS_ANN	=	-DFDS -DCONS -DANN -DSMBM -DSMBV2
ASFLAGS_PAL	=	-DPAL
ASFLAGS_HACKS	=	-DOG_PAD -DOG_FALL
ASFLAGS_TGT	=	$ASFLAGS_HACKS $ASFLAGS_FC
LD_TGT		=	ld65
LDFLAGS_FC	=	-C link.fc_smb.ld
LDFLAGS_VS	=	-C link.vs.ld
LDFLAGS_FDS	=	-C link.fds_smb.ld
LDFLAGS_SMB2	=	-C link.fds_smb2.ld
LDFLAGS_ANN	=	-C link.fds_ann.ld
LDFLAGS_SECURITY =	-C link.kyodaku.ld
CHECK		=	rc ./tools/check.rc
BINTOFDF	=	rc ./tools/bintofdf.rc
FDTC		=	rc ./tools/fdtc.rc

FC		= 	smb.nes
PAL		=	smb.nes
VS		=	smb.vs
FDS		=	smb.fds
SMB2		=	smb2.fds
ANN		=	ann.fds

CKSUM_FC_NTSC	=	bb78be9f
CKSUM_FC_PAL	=	43e9e279
CKSUM_FC	= 	$CKSUM_FC_NTSC
CKSUM_VS	=	e0b48e7e
CKSUM_SMMAIN	=	dde87093
CKSUM_SM2MAIN	=	7834b369
CKSUM_SM2DATA2	=	bcf8d028
CKSUM_SM2DATA3	=	17225ad3
CKSUM_SM2DATA4	=	8e750f3f
CKSUM_NSMMAIN	=	b6b58f4e
CKSUM_NSMDATA2	=	27af0171
CKSUM_NSMDATA3	=	c1697078
CKSUM_NSMDATA4	=	245afe59

PRG_FC		=	smmain.fc.bin
CHR_FC		=	smchar.fc.bin

PRG_VS		=	vsmain.vs.bin
CHR_VS		=	vschar0.vs.bin \
			vschar1.vs.bin

PRG_FDS		=	smmain.fds.bin
CHR_FDS		=	smchar.fds.bin
BIN_SMMAIN1	=	smmain1.bin
BIN_SMMAIN2	=	smmain2.bin

PRG_SMB2_MAIN	=	sm2main.bin
PRG_SMB2_DATA2	=	sm2data2.bin
PRG_SMB2_DATA3	=	sm2data3.bin
PRG_SMB2_DATA4	=	sm2data4.bin

PRG_SMB2	=	$PRG_SMB2_MAIN \
			$PRG_SMB2_DATA2 \
			$PRG_SMB2_DATA3 \
			$PRG_SMB2_DATA4 \
			sm2save.bin

CHR_SMB2	=	sm2char1.bin \
			sm2char2.bin

PRG_ANN_MAIN	=	nsmmain.bin
PRG_ANN_DATA2	=	nsmdata2.bin
PRG_ANN_DATA3	=	nsmdata3.bin
PRG_ANN_DATA4	=	nsmdata4.bin

PRG_ANN		=	$PRG_ANN_MAIN \
			$PRG_ANN_DATA2 \
			$PRG_ANN_DATA3 \
			$PRG_ANN_DATA4 \
			nsmsave.bin

CHR_ANN		=	nsmchar1.bin \
			nsmchar2.bin

ROMS_FC		=	$PRG_FC \
			$CHR_FC

ROMS_VS		=	$PRG_VS \
			$CHR_VS

ROMS_FDS	=	$PRG_FDS \
			$CHR_FDS

ROMS_SMB2	=	$PRG_SMB2 \
			$CHR_SMB2

ROMS_ANN	=	$PRG_ANN \
			$CHR_ANN

BASE_OBJS	=	src/start.o \
			src/int.o \
			src/lib/oam_init.o

TITLE_OBJS	=	src/title/base.o \
			src/title/cursor.o \
			src/title/demo.o

TITLE_BG_OBJS	=	src/title/bg.o

TITLE_INIT_OBJS	=	src/title/init.o

CASTLE_VICTORY_OBJS	=	src/game/castle_victory.o

LIB_OBJS	=	src/game/bg.o \
			src/game/metatile.o \
			data/metatiles.o \
			data/nmi_data.o \
			src/lib/tbljmp.o \
			src/lib/nt_init.o \
			src/lib/joypad.o \
			src/lib/ppu_displist_write.o \
			src/game/stats.o

LIB_VS_OBJS	=	src/lib/vs.o

GAME_INIT_OBJS	=	src/game/init.o

PLAYER_LO_OBJS	=	src/obj/player/init.o \
			src/obj/player/lifedown.o

GAME_PROC_OBJS	=	src/game/game_over.o

BG_OBJS		= 	src/obj/scenery/base.o \
			src/obj/scenery/swarm.o \
			src/obj/scenery/ledge_pulley.o \
			src/obj/scenery/castle.o \
			src/obj/scenery/pipe.o \
			src/obj/scenery/alloc.o \
			src/obj/scenery/waterhole.o \
			src/obj/block/bg_q.o \
			src/obj/scenery/bridge.o \
			src/obj/scenery/pole_render.o \
			src/obj/scenery/rope.o \
			src/obj/scenery/coinrow.o \
			src/obj/scenery/castle_bridge.o \
			src/obj/scenery/brick.o \
			src/obj/scenery/cannon.o \
			src/obj/scenery/stairs.o \
			src/obj/scenery/spring.o \
			src/obj/block/bg.o \
			src/obj/scenery/pit.o \
			src/obj/scenery/render_base.o

GAME_OBJS	=	$GAME_INIT_OBJS \
			$PLAYER_LO_OBJS \
			$GAME_PROC_OBJS \
			$BG_OBJS

COURSE_LOOP_OBJS =	data/course_scenery_loop_offsets.o

COURSE_LOOP_SMB2_OBJS =	data/course_scenery_loop_offsets.smb2.o

COURSE_BASE_OBJS =	src/game/course_base.o

COURSE_LOADER_OBJS =	src/game/course_loader_base.o

COURSE_LOADER_EXT_OBJS = src/game/course_loader_ext.o

COURSE_SEQ_OBJS	=	data/course_seq.o

COURSE_SEQ_SMB2_OBJS =	data/course_seq.smb2.o

COURSE_SEQ_EXT_OBJS =	data/course_seq_ext.o

COURSE_PTR_OBJS	=	data/course_ptrs.o

COURSE_PTR_SMB2_OBJS =	data/course_ptrs.smb2.o

COURSE_PTR_EXT_OBJS = data/course_ptrs_ext.o

COURSE_DATA_OBJS =	data/course_data.o

COURSE_DATA_SMB2_OBJS =	data/course_data.smb2.o

COURSE_DATA_2_SMB2_OBJS = data/course_data_2.smb2.o

COURSE_DATA_2_ANN_OBJS = data/course_data_2.ann.o

COURSE_DATA_3_SMB2_OBJS = data/course_data_3.smb2.o

COURSE_DATA_EXT_OBJS = data/course_data_ext.o

GAME_CORE_OBJS	=	src/game/core.o

PLAYER_OBJS	=	src/obj/player/proc.o

ENTITY_OBJS	=	src/obj/proj.o \
			src/obj/bubble.o \
			src/game/timer.o \
			src/obj/whirlpool.o \
			src/obj/scenery/pole_proc.o \
			src/obj/actor/spring.o \
			src/obj/actor/vine.o \
			src/obj/cannon.o \
			src/obj/misc/hammer.o \
			src/obj/misc/coin_init.o \
			src/obj/misc/proc.o \
			src/obj/misc/coin_proc.o \
			src/obj/actor/powerup.o \
			src/obj/block/proc.o \
			src/obj/motion.o

ACTOR_OBJS	=	src/obj/actor/common_init.o \
			src/obj/actor/goomba_init.o \
			src/obj/actor/podoboo_init.o \
			src/obj/actor/toad_init.o \
			src/obj/actor/base_init.o \
			src/obj/actor/koopa_red_init.o \
			src/obj/actor/hammer_bro_init.o \
			src/obj/actor/veloc_x_none_init.o \
			src/obj/actor/blooper_para_red_col_init.o \
			src/obj/actor/bullet_init.o \
			src/obj/actor/cheep_init.o \
			src/obj/actor/lakitu_spiny_firebar_cheep_fly_init.o \
			src/obj/actor/bowser_init.o \
			src/obj/actor/dup_bowser_flame_init.o \
			src/obj/actor/fireworks_init.o \
			src/obj/actor/bullet_cheep_init.o \
			src/obj/actor/piranha_plant_init.o \
			src/obj/actor/swarm_base_init.o \
			src/obj/actor/koopa_green_bounce_init.o \
			src/obj/actor/plat_init.o \
			src/obj/actor/common_proc.o \
			src/obj/actor/toad_proc.o \
			src/obj/actor/enemy_proc.o \
			src/obj/actor/bowser_flame_vec.o \
			src/obj/actor/firebar_proc_vec.o \
			src/obj/actor/plat_proc_vec.o \
			src/obj/actor/erase_proc.o \
			src/obj/actor/podoboo_proc.o \
			src/obj/actor/hammer_bro_base_proc.o \
			src/obj/actor/koopa_para_proc.o \
			src/obj/actor/floater_proc.o \
			src/obj/actor/blooper_proc.o \
			src/obj/actor/bullet_proc.o \
			src/obj/actor/cheep_proc.o \
			src/obj/actor/firebar_proc.o \
			src/obj/actor/cheep_fly_proc.o \
			src/obj/actor/lakitu_proc.o \
			src/obj/actor/bowser_proc.o \
			src/obj/actor/bowser_flame_proc.o \
			src/obj/actor/fireworks_proc.o \
			src/obj/actor/flag_victory.o \
			src/obj/actor/piranha_plant_proc.o \
			src/obj/actor/firebar_spin_proc.o \
			src/obj/actor/plat_proc.o \
			src/obj/actor/oob_proc.o

ACTOR_SUPPORT_OBJS =	src/obj/collision.o \
			src/obj/actor/vine_render.o \
			src/obj/misc/hammer_render.o \
			src/obj/actor/flag_enemy_render.o \
			src/obj/actor/plat_large_render.o \
			src/obj/misc/coin_score_render.o \
			src/obj/actor/powerup_render.o \
			data/sprites_actor.o \
			src/obj/actor/common_render.o \
			src/obj/block/obj.o \
			src/obj/actor/proj_firebar_render.o \
			src/obj/actor/plat_small_render.o \
			src/obj/bubble_render.o \
			data/sprites_player.o \
			src/obj/player/render.o \
			src/obj/pos.o

LIB_FDS_OBJS	=	src/lib/disk.o \
			src/game/game_over_menu.o \
			src/game/player_phys.o

TITLE_MAP_OBJS	=	data/title_map.o

VS_PPU_OBJS	=	data/vs_ppu_data.o

ANN_TOADS_A_OBJS =	data/ann_toads_a.o

ANN_TOADS_B_OBJS =	data/ann_toads_b.o

APU_OBJS	=	src/apu/proc.o \
			src/apu/store.o \
			src/apu/sfx_pulse_1.o \
			src/apu/sfx_pulse_2.o \
			src/apu/sfx_noise.o \
			src/apu/music.o \
			src/apu/load.o \
			data/apu/offsets.o \

APU_MUSIC_VS_A_OBJS =	data/apu/music/vs_super_star.o

APU_MUSIC_OBJS =	data/apu/music/super_star.o \
			data/apu/music/overworld.o \
			data/apu/music/castle.o \
			data/apu/music/game_over.o \
			data/apu/music/hurry_up.o \
			data/apu/music/level_end.o \
			data/apu/music/underground.o \
			data/apu/music/underwater.o \
			data/apu/music/victory_castle.o

APU_MUSIC_VICTORY_ENDING_OBJS = data/apu/music/victory_ending.o

APU_MUSIC_VS_B_OBJS =	data/apu/music/vs_game_over.o

APU_DATA_OBJS	=	data/apu/notes.o \
			data/apu/lengths_misc.o \
			data/apu/envelopes_misc.o

APU_FDS_OBJS	=	src/apu/alt_music.o \
			src/apu/fds_wave.o \
			src/apu/fds_load.o

APU_FDS_STORE_OBJS =	src/apu/fds_store.o

APU_FDS_OFFSET_OBJS =	data/apu/fds_offsets.o

APU_FDS_MUSIC_OBJS =	data/apu/music/fds_song_a.o \
			data/apu/music/fds_song_b.o \
			data/apu/music/fds_song_c.o

APU_FDS_MISC_OBJS =	data/apu/fds_data.o \
			data/apu/fds_wave_data.o \
			data/apu/lengths_fds.o

APU_FDS_DATA_OBJS =	$APU_FDS_OFFSET_OBJS \
			$APU_FDS_MUSIC_OBJS \
			$APU_FDS_MISC_OBJS

PIPE_FLIPPED_BASE_OBJS = src/obj/scenery/pipe_flipped_base.o \
			src/obj/actor/piranha_plant_b_proc_base.o

PIPE_FLIPPED_EXT_OBJS =	src/obj/scenery/pipe_flipped_ext.o \
			src/obj/actor/piranha_plant_b_proc_ext.o

WIND_BASE_OBJS	=	src/obj/scenery/wind_base.o

WIND_EXT_OBJS	=	src/obj/scenery/wind_ext.o

HARD_MODE_SPRING_BASE_OBJS = src/game/hard_mode_spring_base.o

HARD_MODE_SPRING_EXT_OBJS = src/game/hard_mode_spring_ext.o

ENDING_OBJS	=	src/game/ending.o

LIFEDOWN_EXT_OBJS =	src/game/lifedown_ext_init.o

BIN_SECURITY	=	kyodaku_.bin
OBJS_SECURITY	=	data/security.o

SAVE_VS_OBJS	=	data/save.vs.o

SAVE_FDS_OBJS	=	data/save.fds.o

SAVE_B_FDS_OBJS	=	data/save_b.fds.o

CHR_BASE_OBJS	=	data/chr.o

HEADER_FC	=	data/header.fc.bin
HEADER_VS	=	data/header.vs.bin
HEADER_FDS	=	data/header.fds.bin

PRG_OBJS_FC	=	$BASE_OBJS \
			$TITLE_OBJS \
			$CASTLE_VICTORY_OBJS \
			$LIB_OBJS \
			$GAME_OBJS \
			$COURSE_LOOP_OBJS \
			$COURSE_BASE_OBJS \
			$COURSE_LOADER_OBJS \
			$COURSE_SEQ_OBJS \
			$COURSE_PTR_OBJS \
			$COURSE_DATA_OBJS \
			$GAME_CORE_OBJS \
			$PLAYER_OBJS \
			$ENTITY_OBJS \
			$ACTOR_OBJS \
			$ACTOR_SUPPORT_OBJS \
			$APU_OBJS \
			$APU_MUSIC_OBJS \
			$APU_MUSIC_VICTORY_ENDING_OBJS \
			$APU_DATA_OBJS

CHR_OBJS_FC	=	$CHR_BASE_OBJS \
			$TITLE_MAP_OBJS

OBJS_FC		=	$PRG_OBJS_FC \
			$CHR_OBJS_FC

PRG_OBJS_VS	=	$BASE_OBJS \
			$TITLE_OBJS \
			$CASTLE_VICTORY_OBJS \
			$LIB_OBJS \
			$LIB_VS_OBJS \
			$GAME_OBJS \
			$COURSE_BASE_OBJS \
			$COURSE_LOADER_OBJS \
			$COURSE_SEQ_OBJS \
			$COURSE_PTR_OBJS \
			$GAME_CORE_OBJS \
			$PLAYER_OBJS \
			$ENTITY_OBJS \
			$ACTOR_OBJS \
			$ACTOR_SUPPORT_OBJS \
			$APU_OBJS \
			$APU_MUSIC_VS_A_OBJS \
			$APU_MUSIC_OBJS \
			$APU_MUSIC_VICTORY_ENDING_OBJS \
			$APU_MUSIC_VS_B_OBJS \
			$APU_DATA_OBJS

CHR_OBJS_VS	=	$CHR_BASE_OBJS \
			$COURSE_LOOP_OBJS \
			$COURSE_DATA_OBJS \
			$VS_PPU_OBJS \
			$SAVE_VS_OBJS \
			$TITLE_MAP_OBJS

OBJS_VS		=	$PRG_OBJS_VS \
			$CHR_OBJS_VS

PRG_OBJS_FDS	=	$BASE_OBJS \
			$TITLE_OBJS \
			$CASTLE_VICTORY_OBJS \
			$LIB_OBJS \
			$GAME_OBJS \
			$COURSE_LOOP_OBJS \
			$COURSE_BASE_OBJS \
			$COURSE_LOADER_OBJS \
			$COURSE_SEQ_OBJS \
			$COURSE_PTR_OBJS \
			$COURSE_DATA_OBJS \
			$GAME_CORE_OBJS \
			$PLAYER_OBJS \
			$ENTITY_OBJS \
			$ACTOR_OBJS \
			$ACTOR_SUPPORT_OBJS \
			$APU_OBJS \
			$APU_MUSIC_OBJS \
			$APU_MUSIC_VICTORY_ENDING_OBJS \
			$APU_DATA_OBJS

CHR_OBJS_FDS	=	$CHR_BASE_OBJS \
			$TITLE_MAP_OBJS

BINS_FDS	=	$PRG_FDS \
			$CHR_FDS

OBJS_FDS	=	$PRG_OBJS_FDS \
			$CHR_OBJS_FDS

FDFS_FDS	=	kyodaku_.fdf \
			smchar.fds.fdf \
			smmain1.fdf \
			smmain2.fdf

DEF_FDS		=	data/fs/superblock_smb.def

FDT_FDS		=	smb.fdt

PRG_OBJS_SMB2	=	$BASE_OBJS \
			$CASTLE_VICTORY_OBJS \
			$LIB_OBJS \
			$GAME_OBJS \
			$GAME_CORE_OBJS \
			$PLAYER_OBJS \
			$ENTITY_OBJS \
			$ACTOR_OBJS \
			$ACTOR_SUPPORT_OBJS \
			$LIB_FDS_OBJS \
			$COURSE_BASE_OBJS \
			$COURSE_LOADER_OBJS \
			$COURSE_SEQ_SMB2_OBJS \
			$COURSE_LOOP_SMB2_OBJS \
			$COURSE_PTR_SMB2_OBJS \
			$TITLE_OBJS \
			$TITLE_BG_OBJS \
			$TITLE_INIT_OBJS \
			$TITLE_MAP_OBJS \
			$COURSE_DATA_SMB2_OBJS \
			$SAVE_B_FDS_OBJS \
			$APU_OBJS \
			$APU_MUSIC_OBJS \
			$APU_DATA_OBJS \
			$PIPE_FLIPPED_BASE_OBJS \
			$WIND_BASE_OBJS \
			$COURSE_DATA_2_SMB2_OBJS \
			$ENDING_OBJS \
			$COURSE_DATA_3_SMB2_OBJS \
			$APU_FDS_OBJS \
			$APU_FDS_STORE_OBJS \
			$APU_FDS_DATA_OBJS \
			$COURSE_LOADER_EXT_OBJS \
			$COURSE_SEQ_EXT_OBJS \
			$COURSE_PTR_EXT_OBJS \
			$LIFEDOWN_EXT_OBJS \
			$PIPE_FLIPPED_EXT_OBJS \
			$WIND_EXT_OBJS \
			$COURSE_DATA_EXT_OBJS \
			$SAVE_FDS_OBJS

CHR_OBJS_SMB2	=	$CHR_BASE_OBJS \
			data/chr2.smb2.o

OBJS_SMB2	=	$PRG_OBJS_SMB2 \
			$CHR_OBJS_SMB2

BINS_SMB2	=	sm2char1.bin \
			sm2char2.bin \
			$PRG_SMB2_MAIN \
			$PRG_SMB2_DATA2 \
			$PRG_SMB2_DATA3 \
			$PRG_SMB2_DATA4 \
			sm2save.bin

FDFS_SMB2	=	kyodaku_.fdf \
			sm2char1.fdf \
			sm2char2.fdf \
			sm2main.fdf \
			sm2data2.fdf \
			sm2data3.fdf \
			sm2data4.fdf \
			sm2save.fdf

DEF_SMB2	=	data/fs/superblock_smb2.def

FDT_SMB2	=	smb2.fdt

PRG_OBJS_ANN	=	$BASE_OBJS \
			$CASTLE_VICTORY_OBJS \
			$LIB_OBJS \
			$GAME_OBJS \
			$GAME_CORE_OBJS \
			$PLAYER_OBJS \
			$ENTITY_OBJS \
			$ACTOR_OBJS \
			$ACTOR_SUPPORT_OBJS \
			$LIB_FDS_OBJS \
			$COURSE_BASE_OBJS \
			$COURSE_LOADER_OBJS \
			$COURSE_SEQ_OBJS \
			$COURSE_LOOP_OBJS \
			$COURSE_PTR_OBJS \
			$TITLE_OBJS \
			$TITLE_BG_OBJS \
			$TITLE_INIT_OBJS \
			$TITLE_MAP_OBJS \
			$COURSE_DATA_OBJS \
			$ANN_TOADS_A_OBJS \
			$SAVE_B_FDS_OBJS \
			$APU_OBJS \
			$APU_MUSIC_OBJS \
			$APU_DATA_OBJS \
			$PIPE_FLIPPED_BASE_OBJS \
			$HARD_MODE_SPRING_BASE_OBJS \
			$COURSE_DATA_2_ANN_OBJS \
			$ANN_TOADS_B_OBJS \
			$ENDING_OBJS \
			$APU_FDS_OBJS \
			$APU_FDS_DATA_OBJS \
			$APU_FDS_STORE_OBJS \
			$COURSE_LOADER_EXT_OBJS \
			$COURSE_SEQ_EXT_OBJS \
			$COURSE_PTR_EXT_OBJS \
			$LIFEDOWN_EXT_OBJS \
			$PIPE_FLIPPED_EXT_OBJS \
			$HARD_MODE_SPRING_EXT_OBJS \
			$COURSE_DATA_EXT_OBJS \
			$SAVE_FDS_OBJS

CHR_OBJS_ANN	=	$CHR_BASE_OBJS \
			data/chr2.ann.o

OBJS_ANN	=	$PRG_OBJS_ANN \
			$CHR_OBJS_ANN

FDFS_ANN	=	kyodaku_.fdf \
			nsmchar1.fdf \
			nsmchar2.fdf \
			nsmmain.fdf \
			nsmdata2.fdf \
			nsmdata3.fdf \
			nsmdata4.fdf \
			nsmsave.fdf

DEF_ANN		=	data/fs/superblock_ann.def

FDT_ANN		=	ann.fdt

IMAGES		=	$FC \
			$VS \
			$FDS \
			$SMB2 \
			$ANN

ROMS		=	$ROMS_FC \
			$ROMS_VS \
			$ROMS_FDS \
			$ROMS_SMB2 \
			$ROMS_ANN

OBJS		=	$OBJS_FC \
			$OBJS_VS \
			$OBJS_FDS \
			$OBJS_SMB2 \
			$OBJS_ANN \
			$OBJS_SECURITY

HEADERS		=	$HEADER_FC \
			$HEADER_VS \
			$HEADER_FDS \
			$HEADER_SMB2 \
			$HEADER_ANN

FDFS		=	$FDFS_FDS \
			$FDFS_SMB2 \
			$FDFS_ANN

FDTS		=	$FDT_FDS \
			$FDT_SMB2 \
			$FDT_ANN

all:V: base

base:V: $FC

pal:V: $FC

vs:V: $VS

fds:V: $FDS

smb2:V: $SMB2

ann:V: $ANN

check:V: check_base

check_base:V: $FC
	$CHECK $FC $CKSUM_FC

check_pal:V: check_base

check_vs:V: $VS
	$CHECK $VS $CKSUM_VS

check_fds:V: $PRG_FDS
	$CHECK $PRG_FDS $CKSUM_SMMAIN

check_smb2:V: $PRG_SMB2_MAIN
	$CHECK $PRG_SMB2_MAIN $CKSUM_SM2MAIN
	$CHECK $PRG_SMB2_DATA2 $CKSUM_SM2DATA2
	$CHECK $PRG_SMB2_DATA3 $CKSUM_SM2DATA3
	$CHECK $PRG_SMB2_DATA4 $CKSUM_SM2DATA4

check_ann:V: $PRG_ANN_MAIN
	$CHECK $PRG_ANN_MAIN $CKSUM_NSMMAIN
	$CHECK $PRG_ANN_DATA2 $CKSUM_NSMDATA2
	$CHECK $PRG_ANN_DATA3 $CKSUM_NSMDATA3
	$CHECK $PRG_ANN_DATA4 $CKSUM_NSMDATA4

$FC: $HEADER_FC $OBJS_FC
	$LD_TGT $OBJS_FC $LDFLAGS_FC
	cat $HEADER_FC $ROMS_FC >$target

$VS: $HEADER_VS $OBJS_VS
	$LD_TGT $OBJS_VS $LDFLAGS_VS
	cat $HEADER_VS $ROMS_VS >$target

$FDS: $HEADER_FDS $FDT_FDS
	cat $prereq >$target

$FDT_FDS: $BINS_FDS $BIN_SECURITY $FDFS_FDS
	rc -c '{$FDTC $FDFS_FDS <$DEF_FDS; cat /dev/zero} | dd -of $target -bs 1 -count 65500' || echo pipe closed

$BIN_SMMAIN1: $PRG_FDS
	dd -if $prereq -bs 1 -count 16384 -skip 0 >$target

$BIN_SMMAIN2: $PRG_FDS
	dd -if $prereq -bs 1 -count 16384 -skip 16384 >$target

$BINS_FDS: $OBJS_FDS
	$LD_TGT $prereq $LDFLAGS_FDS

$SMB2: $HEADER_FDS $FDT_SMB2
	cat $prereq >$target

$FDT_SMB2: $BINS_SMB2 $BIN_SECURITY $FDFS_SMB2
	rc -c '{$FDTC $FDFS_SMB2 <$DEF_SMB2; cat /dev/zero} | dd -of $target -bs 1 -count 65500' || echo pipe closed

$BINS_SMB2: $OBJS_SMB2
	$LD_TGT $prereq $LDFLAGS_SMB2

$ANN: $HEADER_FDS $FDT_ANN
	cat $prereq >$target

$FDT_ANN: $PRG_ANN_MAIN $FDFS_ANN
	rc -c '{$FDTC $FDFS_ANN <$DEF_ANN; cat /dev/zero} | dd -of $target -bs 1 -count 65500' || echo pipe closed

$PRG_ANN_MAIN: $OBJS_ANN
	$LD_TGT $prereq $LDFLAGS_ANN

$BIN_SECURITY: $OBJS_SECURITY
	$LD_TGT $prereq $LDFLAGS_SECURITY

%.o: %.s
	$AS_TGT $APPFLAGS_TGT $ASFLAGS_TGT -o $stem.o $stem.s

%.fdf: %.bin
	$BINTOFDF $stem.bin <data/fs/files/$stem.bin.def >$stem.fdf

%.bin: %.rc
	rc ./$stem.rc >$stem.bin

clean:V:
	rm -rf $IMAGES *.bin $ROMS $HEADERS $FDFS $FDTS
	rm -rf $OBJS
