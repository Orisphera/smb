#!/bin/sh

# dd positions of banks in iNES ROM
# PRG  - skip=16    count=32768
# CHR  - skip=32784 count=8192

INFILE="$1"

if test -z "$INFILE"
then
	INFILE=/dev/zero
fi

# Directory structure
mkdir -p data/chr.smb

# CHR Common
TILE_SIZE=16
BG_BANK=256

# CHR bank 00
BANKBASE=32784
BANKLEN=7872
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
while test $I -ne $BG_BANK && test $I -ne $TILES
do
	dd if="$INFILE" bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb/chr_obj_`printf "%.2X" $I`.bin
	I=`expr $I + 1`
done

while test $I -ne $TILES
do
	J=`expr $I - $BG_BANK`
	dd if="$INFILE" bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb/chr_bg_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done
