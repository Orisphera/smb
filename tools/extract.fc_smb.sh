#!/bin/sh

# dd positions of banks in iNES ROM
# PRG  - skip=16    count=32768
# CHR  - skip=32784 count=8192

if test -z $1
then
    echo "Usage: extract.sh <rom>.nes"
    exit 1
fi

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
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb/chr_obj_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while test $I -ne $TILES
do
	J=`expr $I - $BG_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb/chr_bg_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done
