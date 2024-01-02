#!/bin/sh

# dd positions of banks in iNES ROM
# PRG  - skip=16    count=32768
# CHR  - skip=32784 count=8192

if [ -z $1 ]
then
    echo "Usage: extract.sh <rom>.nes"
    exit 1
fi

mkdir -p data/chr.nes

dd if=$1 bs=1 skip=1499 count=31279 >data/prg.nes.bin

# CHR Common
TILE_SIZE=16
OBJ_BANK=256

# CHR bank 00
BANKBASE=32784
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
while [ $I -ne $OBJ_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.nes/tile_bg_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while [ $I -ne $TILES ]
do
	J=`expr $I - $OBJ_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.nes/tile_obj_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done
