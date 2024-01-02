#
# (All Night Nippon) Super Mario Bros. (2) for the Famicom (Disk System)
#
AS		=	ca65
ASFLAGS_FC	=	-DFC -DFC_SMB
ASFLAGS_FDS	=	-DFDS -DFDS_SMB
ASFLAGS_SMB2	=	-DFDS -DSMB2
ASFLAGS_ANN	=	-DFDS -DANN
ASFLAGS		=	-U $(ASFLAGS_FC)
LD		=	ld65
LDFLAGS_FC	=	-C link.fc_smb.ld
LDFLAGS_FDS	=	-C link.fds_smb.ld
LDFLAGS_SMB2	=	-C link.fds_smb2.ld
LDFLAGS_ANN	=	-C link.fds_ann.ld

BINTOFDF	=	bintofdf
FDTC		=	fdtc

FC		= 	smb.nes
FDS		=	smb.fds
SMB2		=	smb2.fds
ANN		=	ann_smb.fds

PRG_FC		=	smmain.fc.bin
CHR_FC		=	smchar.fc.bin

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

ROMS_FDS	=	$(PRG_FDS) \
			$(CHR_FDS)

ROMS_SMB2	=	$(PRG_SMB2) \
			$(CHR_SMB2)

ROMS_ANN	=	$(PRG_ANN) \
			$(CHR_ANN)

START_OBJS	=	src/start.o

BASE_OBJS	=	$(START_OBJS) \
			src/nmi.o \
			src/lib/oam_init.o

TITLE_BASE_OBJS	=	src/title/base.o \
			src/title/cursor.o \
			src/title/demo.o

GAME_BASE_OBJS	=	src/game/victory.o \
			src/lib/screen.o

SECURITY_OBJS	=	data/security.o

SAVE_OBJS	=	data/save.o

HEADER_FC	=	data/header.fc.bin
HEADER_FDS	=	data/header.fds.bin

PRG_OBJS_FC	=	$(BASE_OBJS) \
			$(TITLE_BASE_OBJS) \
			$(GAME_BASE_OBJS) \
			data/prg.fc.o

CHR_OBJS_FC	=	data/chr.fc.o

OBJS_FC		=	$(PRG_OBJS_FC) \
			$(CHR_OBJS_FC)

PRG_OBJS_FDS	=	$(START_OBJS) \
			data/prg.fds.o

CHR_OBJS_FDS	=	data/chr.fds.o

OBJS_FDS	=	$(PRG_OBJS_FDS) \
			$(CHR_OBJS_FDS) \
			$(SECURITY_OBJS)

FDFS_FDS	=	kyodaku_.fdf \
			smchar.fds.fdf \
			smmain1.fdf \
			smmain2.fdf

DEF_FDS		=	data/fs/superblock_smb.def

FDT_FDS		=	smb.fdt

PRG_OBJS_SMB2	=	$(START_OBJS) \
			data/prg.smb2.o \
			data/data2.smb2.o \
			data/data3.smb2.o \
			data/data4.smb2.o \
			$(SECURITY_OBJS) \
			$(SAVE_OBJS)

CHR_OBJS_SMB2	=	data/chr.smb2.o \
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

IMAGES		=	$(FC) \
			$(FDS) \
			$(SMB2) \
			$(ANN)

ROMS		=	$(ROMS_FC) \
			$(ROMS_FDS) \
			$(ROMS_SMB2) \
			$(ROMS_ANN)

OBJS		=	$(OBJS_FC) \
			$(OBJS_FDS) \
			$(OBJS_SMB2) \
			$(OBJS_ANN)

HEADERS		=	$(HEADER_FC) \
			$(HEADER_FDS) \
			$(HEADER_SMB2) \
			$(HEADER_ANN)

FDFS		=	$(FDFS_FDS)

FDTS		=	$(FDT_FDS)

.SUFFIXES : .bin .fdf .fdt .fds .sh

$(FC): $(HEADER_FC) $(OBJS_FC)
	$(LD) $(OBJS_FC) $(LDFLAGS_FC)
	cat $(HEADER_FC) $(ROMS_FC) > $(FC)

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

.bin.fdf:
	$(BINTOFDF) $< <data/fs/files/$<.def >$@

.sh.bin:
	$< >$@

clean:
	rm -rf $(IMAGES) *.bin $(ROMS) $(OBJS) $(HEADERS) $(FDFS) $(FDTS)
