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

CHR_PATH_BASE="chr.smb"
CHR_PATH_VS="chr.vs"

mkdir -p data/${CHR_PATH_BASE} data/${CHR_PATH_VS} data/chr2.vs

dd if=$1 bs=1 skip=25504 count=7274 >data/prg.vs.bin

# CHR Common
TILE_SIZE=16
BG_BANK=256

# CHR bank 00
BANKBASE=32784
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

TILE_ONEUP_LEFT=253
TILE_ONEUP_RIGHT=254

I=0
while [ $I -ne $BG_BANK ] && [ $I -ne $TILES ]
do
        CHR_PATH=$CHR_PATH_BASE
        if [ $I -eq $TILE_ONEUP_LEFT ] || [ $I -eq $TILE_ONEUP_RIGHT ]
        then
                CHR_PATH=$CHR_PATH_VS
        fi
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/tile_obj_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

FONT_FIRST=0
FONT_LAST=35
FONT_DASH=40
FONT_X=41
FONT_EX=43
FONT_PER=175
ICON_MUSH=206
VS_NEWBG_FIRST=236
VS_NEWBG_LAST=254

while [ $I -ne $TILES ]
do
	J=`expr $I - $BG_BANK`
        CHR_PATH=$CHR_PATH_BASE
        if [ $J -ge $FONT_FIRST ] && [ $J -le $FONT_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -eq $FONT_DASH ] || [ $J -eq $FONT_X ] || [ $J -eq $FONT_EX ] || [ $J -eq $FONT_PER ] || [ $J -eq $ICON_MUSH ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -ge $VS_NEWBG_FIRST ] && [ $J -le $VS_NEWBG_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        fi
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/tile_bg_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done

# CHR bank 01
dd if=$1 bs=1 skip=47632 count=1536 >data/chr2.vs.bin
