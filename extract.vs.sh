#!/bin/sh

# dd positions of banks in VS ROM
# PRG  - skip=16    count=32768
# CHR0 - skip=32784 count=8192
# CHR1 - skip=40976 count=8192

if [ -z $1 ]
then
    echo "Usage: extract.sh <rom>.nes"
    exit 1
fi

mkdir -p data/chr.vs data/chr2.vs

dd if=$1 bs=1 skip=2751 count=30027 >data/prg.vs.bin

# CHR Common
TILE_SIZE=16
BG_BANK=256

# CHR bank 00
BANKBASE=32784
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
while [ $I -ne $BG_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.vs/tile_obj_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while [ $I -ne $TILES ]
do
	J=`expr $I - $BG_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.vs/tile_bg_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done

# CHR bank 01
BANKBASE=40976
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
while [ $I -ne $BG_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr2.vs/tile_obj_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while [ $I -ne $TILES ]
do
	J=`expr $I - $BG_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr2.vs/tile_bg_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done
