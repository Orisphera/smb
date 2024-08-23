ACTORDIS	=	actordis65
SCENERYDIS	=	scenerydis65

ACTORDIS_OBJS	=	actordis65.o
SCENERYDIS_OBJS	=	scenerydis65.o

BINS		=	$(ACTORDIS) \
			$(SCENERYDIS)

OBJS		=	$(ACTORDIS_OBJS) \
			$(SCENERYDIS_OBJS)

all: $(ACTORDIS) $(SCENERYDIS)

$(ACTORDIS): $(ACTORDIS_OBJS)
	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)

$(SCENERYDIS): $(SCENERYDIS_OBJS)
	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)

clean:
	rm -rf $(BINS) $(OBJS)
