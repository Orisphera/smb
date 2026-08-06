#!/bin/sh

# dd positions of banks in VS ROM
# PRG  - skip=16    count=32768
# CHR0 - skip=32784 count=8192
# CHR1 - skip=40976 count=8192

INFILE="$1"

if test -z "$INFILE"
then
	INFILE=/dev/zero
fi

# Directory structure
CHR_PATH_BASE="chr.smb"
CHR_PATH_VS="chr.vs"

mkdir -p data/${CHR_PATH_BASE} data/${CHR_PATH_VS} data/chr2.vs

# CHR Common
TILE_SIZE=16
BG_BANK=256

# CHR bank 00
BANKBASE=32784
BANKLEN=8176
TILES=`expr $BANKLEN / $TILE_SIZE`

TILE_ONEUP_LEFT=253
TILE_ONEUP_RIGHT=254

I=0
while test $I -ne $BG_BANK && test $I -ne $TILES
do
        CHR_PATH=$CHR_PATH_BASE
        if test $I -eq $TILE_ONEUP_LEFT || test $I -eq $TILE_ONEUP_RIGHT
        then
                CHR_PATH=$CHR_PATH_VS
        fi
        dd if="$INFILE" bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/chr_obj_`printf "%.2X" $I`.bin
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

while test $I -ne $TILES
do
	J=`expr $I - $BG_BANK`
        CHR_PATH=$CHR_PATH_BASE
        if test $J -ge $FONT_FIRST && test $J -le $FONT_LAST
        then
                CHR_PATH=$CHR_PATH_VS
        elif test $J -eq $FONT_DASH || test $J -eq $FONT_X || test $J -eq $FONT_EX || test $J -eq $FONT_PER || test $J -eq $ICON_MUSH
        then
                CHR_PATH=$CHR_PATH_VS
        elif test $J -ge $VS_NEWBG_FIRST && test $J -le $VS_NEWBG_LAST
        then
                CHR_PATH=$CHR_PATH_VS
        fi
        dd if="$INFILE" bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/chr_bg_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done
