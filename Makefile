#
# Dragon Quest for the Famicom
#
AS		=	ca65
ASFLAGS		=	-U
LD		=	ld65
LDFLAGS		=	-C link.ld

NES		= 	smb.nes

PRG		=	PRG.bin
CHR		=	CHR.bin

ROMS		=	$(PRG) \
			$(CHR)

PRG_OBJS	=	src/start.o \
			src/nmi.o \
			src/lib/oam_init.o \
			data/prg.o

CHR_OBJS	=	data/chr.o

OBJS		=	$(PRG_OBJS) \
			$(CHR_OBJS)

HEADER		=	data/header.bin

$(NES): $(HEADER) $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS)
	cat $(HEADER) $(ROMS) > $(NES)

data/header.bin:
	data/header.sh

clean:
	rm -rf $(NES) $(ROMS) $(OBJS) $(HEADER)
