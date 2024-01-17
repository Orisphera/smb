#!/bin/sh

# dd positions of banks in iNES ROM
# PRG  - skip=16    count=32768
# CHR  - skip=32784 count=8192

if [ -z $1 ]
then
    echo "Usage: extract.sh <rom>.nes"
    exit 1
fi

mkdir -p data/chr.smb

dd if=$1 bs=1 skip=1890 count=38 >data/screen_text_line_1.bin
dd if=$1 bs=1 skip=1929 count=30 >data/screen_text_line_2.bin
dd if=$1 bs=1 skip=1960 count=8 >data/screen_text_line_3_a.bin
dd if=$1 bs=1 skip=1968 count=10 >data/screen_text_line_3_b.bin
dd if=$1 bs=1 skip=1979 count=20 >data/screen_text_line_4.bin
dd if=$1 bs=1 skip=2000 count=44 >data/screen_text_line_5.bin

dd if=$1 bs=1 skip=2221 count=30557 >data/prg.fc.bin

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
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb/tile_bg_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while [ $I -ne $TILES ]
do
	J=`expr $I - $OBJ_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb/tile_obj_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done
