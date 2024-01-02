#!/bin/sh

# dd positions of banks in FDS image
# security - skip=91    count=224
# CHR      - skip=332   count=8192
# PRG low  - skip=8558  count=16384
# PRG high - skip=24942 count=16384

if [ -z $1 ]
then
    echo "Usage: extract.sh <image>.fds"
    exit 1
fi

mkdir -p data/chr.fds

# KYODAKU-
dd if=$1 bs=1 skip=91 count=224 >data/security.bin

# CHR Common
TILE_SIZE=16
OBJ_BANK=256

# SMCHAR
BANKBASE=332
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
while [ $I -ne $OBJ_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.fds/tile_bg_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while [ $I -ne $TILES ]
do
	J=`expr $I - $OBJ_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.fds/tile_obj_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done

# SMMAIN1
dd if=$1 bs=1 skip=8636 count=16289 >data/prg0.fds.bin

# SMMAIN2
dd if=$1 bs=1 skip=24942 count=16378 >data/prg1.fds.bin
