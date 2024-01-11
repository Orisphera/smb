#!/bin/sh

# dd positions of banks in FDS image
# KYODAKU- - skip=91    count=224
# SM2CHAR1 - skip=332   count=8192
# SM2CHAR2 - skip=8541  count=64
# SM2MAIN  - skip=8622  count=32768
# SM2DATA2 - skip=41407 count=3631
# SM2DATA3 - skip=45055 count=3279
# SM2DATA2 - skip=48351 count=3916

if [ -z $1 ]
then
    echo "Usage: extract.sh <image>.fds"
    exit 1
fi

mkdir -p data/chr.smb2 data/chr2.smb2

# KYODAKU-
dd if=$1 bs=1 skip=91 count=224 >data/security.bin

# CHR Common
TILE_SIZE=16
OBJ_BANK=256

# SM2CHAR1
BANKBASE=332
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
while [ $I -ne $OBJ_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb2/tile_bg_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while [ $I -ne $TILES ]
do
	J=`expr $I - $OBJ_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.smb2/tile_obj_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done

# SM2CHAR2
BANKBASE=8541
BANKLEN=64
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
J=133
while [ $J -ne $OBJ_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr2.smb2/tile_bg_`printf "%.2X" $J`.bin
        I=`expr $I + 1`
	J=`expr $J + 1`
done

# SM2MAIN
dd if=$1 bs=1 skip=10150  count=31234 >data/prg.smb2.bin

# SM2DATA2
dd if=$1 bs=1 skip=41407 count=3631 >data/data2.smb2.bin

# SM2DATA3
dd if=$1 bs=1 skip=45055 count=3279 >data/data3.smb2.bin

# SM2DATA4
dd if=$1 bs=1 skip=48351 count=3916 >data/data4.smb2.bin
