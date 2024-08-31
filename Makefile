#
# (All Night Nippon) Super Mario Bros. (2) for the (Vs) Famicom (Disk System)
#
# Preprocessor Definitions:
#   FC    - Famicom-specific
#   VS    - Vs. System-specific
#   FDS   - Famicom Disk System-specific
#   CONS  - Home Console-specific
#   SMB   - Super Mario Bros.
#   FC_SMB - Famicom-specific Super Mario Bros.
#   VS_SMB - Vs. Super Mario Bros.
#   FDS_SMB - Famicom Disk System-specific Super Mario Bros.
#   SMB2 - Super Mario Bros. 2
#   ANN - All Night Nippon Super Mario Bros.
#   SMBM - Super Mario Bros. "Meta" (SMB and ANN-commonalities)
#   SMB2M - Super Mario Bros. 2 "Meta" (SMB2 and ANN-commonalities)
AS		=	ca65
ASFLAGS_FC	=	-DFC -DCONS -DSMB -DFC_SMB -DSMBM
ASFLAGS_VS	=	-DVS -DVS_SMB
ASFLAGS_FDS	=	-DFDS -DCONS -DSMB -DFDS_SMB -DSMBM
ASFLAGS_SMB2	=	-DFDS -DCONS -DSMB2M -DSMB2
ASFLAGS_ANN	=	-DFDS -DCONS -DSMB2M -DANN -DSMBM
ASFLAGS		=	-U -I ./inc $(ASFLAGS_FC)
LD		=	ld65
LDFLAGS_FC	=	-C link.fc_smb.ld
LDFLAGS_VS	=	-C link.vs.ld
LDFLAGS_FDS	=	-C link.fds_smb.ld
LDFLAGS_SMB2	=	-C link.fds_smb2.ld
LDFLAGS_ANN	=	-C link.fds_ann.ld

BINTOFDF	=	fdtc/bintofdf
FDTC		=	fdtc/fdtc

FC		= 	smb.nes
VS		=	smb.vs
FDS		=	smb.fds
SMB2		=	smb2.fds
ANN		=	ann.fds

PRG_FC		=	smmain.fc.bin
CHR_FC		=	smchar.fc.bin

PRG_VS		=	vsmain.vs.bin
CHR_VS		=	vschar0.vs.bin \
			vschar1.vs.bin

PRG_FDS		=	smmain.fds.bin
CHR_FDS		=	smchar.fds.bin

PRG_SMB2	=	sm2main.bin \
			sm2data2.bin \
			sm2data3.bin \
			sm2data4.bin \
			sm2save.bin

CHR_SMB2	=	sm2char1.bin \
			sm2char2.bin

PRG_ANN		=	nsmmain.bin \
			nsmdata2.bin \
			nsmdata3.bin \
			nsmdata4.bin \
			nsmsave.bin

CHR_ANN		=	nsmchar1.bin \
			nsmchar2.bin

ROMS_FC		=	$(PRG_FC) \
			$(CHR_FC)

ROMS_VS		=	$(PRG_VS) \
			$(CHR_VS)

ROMS_FDS	=	$(PRG_FDS) \
			$(CHR_FDS)

ROMS_SMB2	=	$(PRG_SMB2) \
			$(CHR_SMB2)

ROMS_ANN	=	$(PRG_ANN) \
			$(CHR_ANN)

BASE_OBJS	=	src/start.o \
			src/int.o \
			src/lib/oam_init.o

TITLE_OBJS	=	src/title/base.o \
			src/title/cursor.o \
			src/title/demo.o

TITLE_SCR_OBJS	=	src/title/scr.o

TITLE_INIT_OBJS	=	src/title/init.o

LIB_OBJS	=	src/game/victory.o \
			src/lib/screen.o \
			src/lib/gfx.o \
			data/metatiles.o \
			data/nmi_data.o \
			src/lib/misc.o

LIB_VS_OBJS	=	src/lib/vs.o

GAME_OBJS	=	src/game/init.o \
			src/game/gameover.o \
			src/game/bg.o

COURSE_LOOP_OBJS =	data/course_scenery_loop_offsets.o

COURSE_LOOP_SMB2_OBJS =	data/course_scenery_loop_offsets.smb2.o

COURSES_OBJS	=	src/game/course_base.o \
			src/game/course_loader.o

COURSE_SEQ_OBJS	=	data/course_seq.o

COURSE_SEQ_SMB2_OBJS =	data/course_seq.smb2.o

COURSE_PTR_OBJS	=	data/course_ptrs.o

COURSE_PTR_SMB2_OBJS =	data/course_ptrs.smb2.o

COURSE_DATA_OBJS =	data/course_data.o

MAIN_OBJ	=	src/game/main.o

ENTITY_OBJS	=	src/obj/misc/hammer.o \
			src/obj/misc/coin_init.o \
			src/obj/misc/proc.o \
			src/obj/misc/coin_proc.o \
			src/obj/actor/powerup.o \
			src/obj/block.o \
			src/obj/motion.o \
			src/obj/actor/common_init.o \
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
			src/obj/actor/plat_proc.o

ACTOR_SUPPORT_OBJS =	src/obj/collision.o \
			src/obj/actor/vine_render.o \
			src/obj/misc/hammer_render.o \
			src/obj/actor/flag_enemy_render.o \
			src/obj/actor/plat_large_render.o \
			src/obj/misc/coin_score_render.o \
			src/obj/actor/powerup_render.o \
			data/sprites_actor.o \
			src/obj/actor/common_render.o \
			src/obj/block_render.o \
			src/obj/actor/proj_firebar_render.o \
			src/obj/actor/plat_small_render.o \
			src/obj/bubble_render.o \
			data/sprites_player.o \
			src/obj/player_render.o \
			src/obj/lib_bits.o

LIB_FDS_OBJS	=	src/lib/disk.o \
			src/game/fds_gameover.o \
			src/lib/player_phys.o

TITLE_MAP_OBJS	=	data/title_map.o

VS_PPU_OBJS	=	data/vs_ppu_data.o

ANN_TOADS_A_OBJS =	data/ann_toads_a.o

SECURITY_OBJS	=	data/security.o

SAVE_VS_OBJS	=	data/save.vs.o

SAVE_FDS_OBJS	=	data/save.fds.o

HEADER_FC	=	data/header.fc.bin
HEADER_VS	=	data/header.vs.bin
HEADER_FDS	=	data/header.fds.bin

PRG_OBJS_FC	=	$(BASE_OBJS) \
			$(TITLE_OBJS) \
			$(LIB_OBJS) \
			$(GAME_OBJS) \
			$(COURSE_LOOP_OBJS) \
			$(COURSES_OBJS) \
			$(COURSE_SEQ_OBJS) \
			$(COURSE_PTR_OBJS) \
			$(COURSE_DATA_OBJS) \
			$(MAIN_OBJ) \
			$(ENTITY_OBJS) \
			$(ACTOR_SUPPORT_OBJS) \
			data/prg.fc.o

CHR_OBJS_FC	=	data/chr.o \
			$(TITLE_MAP_OBJS)

OBJS_FC		=	$(PRG_OBJS_FC) \
			$(CHR_OBJS_FC)

PRG_OBJS_VS	=	$(BASE_OBJS) \
			$(TITLE_OBJS) \
			$(LIB_OBJS) \
			$(LIB_VS_OBJS) \
			$(GAME_OBJS) \
			$(COURSES_OBJS) \
			$(COURSE_SEQ_OBJS) \
			$(COURSE_PTR_OBJS) \
			$(MAIN_OBJ) \
			$(ENTITY_OBJS) \
			$(ACTOR_SUPPORT_OBJS) \
			data/prg.vs.o

CHR_OBJS_VS	=	data/chr.o \
			$(COURSE_LOOP_OBJS) \
			$(COURSE_DATA_OBJS) \
			$(VS_PPU_OBJS) \
			$(SAVE_VS_OBJS) \
			$(TITLE_MAP_OBJS)

OBJS_VS		=	$(PRG_OBJS_VS) \
			$(CHR_OBJS_VS)

PRG_OBJS_FDS	=	$(BASE_OBJS) \
			$(TITLE_OBJS) \
			$(LIB_OBJS) \
			$(GAME_OBJS) \
			$(COURSE_LOOP_OBJS) \
			$(COURSES_OBJS) \
			$(COURSE_SEQ_OBJS) \
			$(COURSE_PTR_OBJS) \
			$(COURSE_DATA_OBJS) \
			$(MAIN_OBJ) \
			$(ENTITY_OBJS) \
			$(ACTOR_SUPPORT_OBJS) \
			data/prg.fds.o

CHR_OBJS_FDS	=	data/chr.o \
			$(TITLE_MAP_OBJS)

OBJS_FDS	=	$(PRG_OBJS_FDS) \
			$(CHR_OBJS_FDS) \
			$(SECURITY_OBJS)

FDFS_FDS	=	kyodaku_.fdf \
			smchar.fds.fdf \
			smmain1.fdf \
			smmain2.fdf

DEF_FDS		=	data/fs/superblock_smb.def

FDT_FDS		=	smb.fdt

PRG_OBJS_SMB2	=	$(BASE_OBJS) \
			$(LIB_OBJS) \
			$(GAME_OBJS) \
			$(MAIN_OBJ) \
			$(ENTITY_OBJS) \
			$(ACTOR_SUPPORT_OBJS) \
			$(LIB_FDS_OBJS) \
			$(COURSES_OBJS) \
			$(COURSE_SEQ_SMB2_OBJS) \
			$(COURSE_LOOP_SMB2_OBJS) \
			$(COURSE_PTR_SMB2_OBJS) \
			$(TITLE_OBJS) \
			$(TITLE_SCR_OBJS) \
			$(TITLE_INIT_OBJS) \
			$(TITLE_MAP_OBJS) \
			data/prg.smb2.o \
			data/data2.smb2.o \
			data/data3.smb2.o \
			data/data4.smb2.o \
			$(SECURITY_OBJS) \
			$(SAVE_FDS_OBJS)

CHR_OBJS_SMB2	=	data/chr.o \
			data/chr2.smb2.o

OBJS_SMB2	=	$(PRG_OBJS_SMB2) \
			$(CHR_OBJS_SMB2)

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

PRG_OBJS_ANN	=	$(BASE_OBJS) \
			$(LIB_OBJS) \
			$(GAME_OBJS) \
			$(MAIN_OBJ) \
			$(ENTITY_OBJS) \
			$(ACTOR_SUPPORT_OBJS) \
			$(LIB_FDS_OBJS) \
			$(COURSES_OBJS) \
			$(COURSE_SEQ_OBJS) \
			$(COURSE_LOOP_OBJS) \
			$(COURSE_PTR_OBJS) \
			$(TITLE_OBJS) \
			$(TITLE_SCR_OBJS) \
			$(TITLE_INIT_OBJS) \
			$(TITLE_MAP_OBJS) \
			$(COURSE_DATA_OBJS) \
			$(ANN_TOADS_A_OBJS) \
			data/prg.ann.o \
			data/data2.ann.o \
			data/data3.ann.o \
			data/data4.ann.o \
			$(SECURITY_OBJS) \
			$(SAVE_FDS_OBJS)

CHR_OBJS_ANN	=	data/chr.o \
			data/chr2.ann.o

OBJS_ANN	=	$(PRG_OBJS_ANN) \
			$(CHR_OBJS_ANN)

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

IMAGES		=	$(FC) \
			$(VS) \
			$(FDS) \
			$(SMB2) \
			$(ANN)

ROMS		=	$(ROMS_FC) \
			$(ROMS_VS) \
			$(ROMS_FDS) \
			$(ROMS_SMB2) \
			$(ROMS_ANN)

OBJS		=	$(OBJS_FC) \
			$(OBJS_VS) \
			$(OBJS_FDS) \
			$(OBJS_SMB2) \
			$(OBJS_ANN)

HEADERS		=	$(HEADER_FC) \
			$(HEADER_VS) \
			$(HEADER_FDS) \
			$(HEADER_SMB2) \
			$(HEADER_ANN)

FDFS		=	$(FDFS_FDS) \
			$(FDFS_SMB2) \
			$(FDFS_ANN)

FDTS		=	$(FDT_FDS) \
			$(FDT_SMB2) \
			$(FDT_ANN)

.SUFFIXES : .bin .fdf .fdt .fds .sh

$(FC): $(HEADER_FC) $(OBJS_FC)
	$(LD) $(OBJS_FC) $(LDFLAGS_FC)
	cat $(HEADER_FC) $(ROMS_FC) > $(FC)

$(VS): $(HEADER_VS) $(OBJS_VS)
	$(LD) $(OBJS_VS) $(LDFLAGS_VS)
	cat $(HEADER_VS) $(ROMS_VS) > $(VS)

$(FDS): $(HEADER_FDS) $(FDT_FDS)
	cat $(HEADER_FDS) $(FDT_FDS) > $(FDS)

$(FDT_FDS): smmain.fds.bin $(FDFS_FDS) 
	$(FDTC) $(FDFS_FDS) <$(DEF_FDS) | cat - /dev/zero | dd of=$@ bs=1 count=65500 2>/dev/null

smmain1.bin: smmain.fds.bin
	dd if=$< bs=1 count=16384 skip=0 >$@

smmain2.bin: smmain.fds.bin
	dd if=$< bs=1 count=16384 skip=16384 >$@

smmain.fds.bin: $(OBJS_FDS)
	$(LD) $(OBJS_FDS) $(LDFLAGS_FDS)

$(SMB2): $(HEADER_FDS) $(FDT_SMB2)
	cat $(HEADER_FDS) $(FDT_SMB2) > $(SMB2)

$(FDT_SMB2): sm2main.bin $(FDFS_SMB2) 
	$(FDTC) $(FDFS_SMB2) <$(DEF_SMB2) | cat - /dev/zero | dd of=$@ bs=1 count=65500 2>/dev/null

sm2main.bin: $(OBJS_SMB2)
	$(LD) $(OBJS_SMB2) $(LDFLAGS_SMB2)

$(ANN): $(HEADER_FDS) $(FDT_ANN)
	cat $(HEADER_FDS) $(FDT_ANN) > $(ANN)

$(FDT_ANN): nsmmain.bin $(FDFS_ANN) 
	$(FDTC) $(FDFS_ANN) <$(DEF_ANN) | cat - /dev/zero | dd of=$@ bs=1 count=65500 2>/dev/null

nsmmain.bin: $(OBJS_ANN)
	$(LD) $(OBJS_ANN) $(LDFLAGS_ANN)

.bin.fdf:
	$(BINTOFDF) $< <data/fs/files/$<.def >$@

.sh.bin:
	$< >$@

clean:
	rm -rf $(IMAGES) *.bin $(ROMS) $(OBJS) $(HEADERS) $(FDFS) $(FDTS)
