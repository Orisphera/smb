#
# (All Night Nippon) Super Mario Bros. (2) for the Famicom (Disk System)
#
AS		=	ca65
ASFLAGS_NES	=	-DFAMI -DFAMI_SMB
ASFLAGS_FDS	=	-DFDS -DFDS_SMB
ASFLAGS_FDS2	=	-DFDS -DFDS2
ASFLAGS_ANN	=	-DFDS -DANN
ASFLAGS		=	-U $(ASFLAGS_NES)
LD		=	ld65
LDFLAGS_NES	=	-C link.fc_smb.ld
LDFLAGS_FDS	=	-C link.fds_smb.ld
LDFLAGS_FDS2	=	-C link.fds_smb2.ld
LDFLAGS_ANN	=	-C link.fds_ann.ld

BINTOFDF	=	bintofdf
FDTC		=	fdtc

NES		= 	smb.nes
FDS		=	smb.fds
FDS2		=	smb2.fds
ANN		=	ann_smb.fds

PRG_NES		=	PRG_fc.bin
CHR_NES		=	CHR_fc.bin

PRG_FDS		=	smmain.bin
CHR_FDS		=	smchar.bin

PRG_FDS2	=	SM2MAIN.bin \
			SM2DATA2.bin \
			SM2DATA3.bin \
			SM2DATA4.bin \
			SM2SAVE.bin

CHR_FDS2	=	SM2CHAR1.bin \
			SM2CHAR2.bin

PRG_ANN		=	NSMMAIN.bin \
			NSMDATA2.bin \
			NSMDATA3.bin \
			NSMDATA4.bin \
			NSMSAVE.bin

CHR_ANN		=	NSMCHAR1.bin \
			NSMCHAR2.bin

ROMS_NES	=	$(PRG_NES) \
			$(CHR_NES)

ROMS_FDS	=	$(PRG_FDS) \
			$(CHR_FDS)

ROMS_FDS2	=	$(PRG_FDS2) \
			$(CHR_FDS2)

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

HEADER_NES	=	data/header.fc.bin
HEADER_FDS	=	data/header.fds.bin

PRG_OBJS_NES	=	$(BASE_OBJS) \
			$(TITLE_BASE_OBJS) \
			$(GAME_BASE_OBJS) \
			data/prg.nes.o

CHR_OBJS_NES	=	data/chr.nes.o

OBJS_NES	=	$(PRG_OBJS_NES) \
			$(CHR_OBJS_NES)

PRG_OBJS_FDS	=	$(START_OBJS) \
			data/prg.fds.o

CHR_OBJS_FDS	=	data/chr.fds.o

OBJS_FDS	=	$(PRG_OBJS_FDS) \
			$(CHR_OBJS_FDS) \
			data/security.o

FDS_FDFS	=	kyodaku_.fdf \
			smchar.fdf \
			smmain1.fdf \
			smmain2.fdf

FDS_DEF		=	data/fs/superblock_smb.def

FDS_FDT		=	fds.fdt

IMAGES		=	$(NES) \
			$(FDS) \
			$(FDS2) \
			$(ANN)

ROMS		=	$(ROMS_NES) \
			$(ROMS_FDS) \
			$(ROMS_FDS2) \
			$(ROMS_ANN)

OBJS		=	$(OBJS_NES) \
			$(OBJS_FDS) \
			$(OBJS_FDS2) \
			$(OBJS_ANN)

HEADERS		=	$(HEADER_NES) \
			$(HEADER_FDS) \
			$(HEADER_FDS2) \
			$(HEADER_ANN)

FDFS		=	$(FDS_FDFS)

FDTS		=	$(FDS_FDT)

.SUFFIXES : .bin .fdf .fdt .fds .sh

$(NES): $(HEADER_NES) $(OBJS_NES)
	$(LD) $(OBJS_NES) $(LDFLAGS_NES)
	cat $(HEADER_NES) $(ROMS_NES) > $(NES)

$(FDS): $(HEADER_FDS) $(FDS_FDT)
	cat $(HEADER_FDS) $(FDS_FDT) > $(FDS)

$(FDS_FDT): smmain.bin $(FDS_FDFS) 
	$(FDTC) $(FDS_FDFS) <$(FDS_DEF) | cat - /dev/zero | dd of=$@ bs=1 count=65500 2>/dev/null

smmain1.bin: smmain.bin
	dd if=$< bs=1 count=16384 skip=0 >$@

smmain2.bin: smmain.bin
	dd if=$< bs=1 count=16384 skip=16384 >$@

smmain.bin: $(OBJS_FDS)
	$(LD) $(OBJS_FDS) $(LDFLAGS_FDS)

.bin.fdf:
	$(BINTOFDF) $< <data/fs/files/$<.def >$@

.sh.bin:
	$< >$@

clean:
	rm -rf $(IMAGES) *.bin $(ROMS) $(OBJS) $(HEADERS) $(FDFS) $(FDTS)
