#!/bin/sh

# dd positions of banks in FDS image
# KYODAKU- - skip=91    count=224
# NSMCHAR1 - skip=332   count=8192
# NSMCHAR2 - skip=8541  count=1120
# NSMMAIN  - skip=8622  count=32768
# NSMDATA2 - skip=41407 count=3631
# NSMDATA3 - skip=45055 count=3279
# NSMDATA2 - skip=48351 count=3916

if [ -z $1 ]
then
    echo "Usage: extract.sh <image>.fds"
    exit 1
fi

mkdir -p data/chr.ann data/chr2.ann

# KYODAKU-
dd if=$1 bs=1 skip=91 count=224 >data/security.bin

# CHR Common
TILE_SIZE=16
OBJ_BANK=256

# NSMCHAR1
BANKBASE=332
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
while [ $I -ne $OBJ_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.ann/tile_bg_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

while [ $I -ne $TILES ]
do
	J=`expr $I - $OBJ_BANK`
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.ann/tile_obj_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done

# NSMCHAR2
BANKBASE=8541
BANKLEN=1120
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
J=133
while [ $J -ne $OBJ_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr2.ann/tile_bg_`printf "%.2X" $J`.bin
        I=`expr $I + 1`
	J=`expr $J + 1`
done

J=0
while [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr.ann/tile_obj_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
	J=`expr $J + 1`
done

# NSMMAIN
dd if=$1 bs=1 skip=10345  count=32095 >data/prg.ann.bin

# NSMDATA2
dd if=$1 bs=1 skip=42447 count=3584 >data/data2.ann.bin

# NSMDATA3
dd if=$1 bs=1 skip=46048 count=3346 >data/data3.ann.bin

# NSMDATA4
dd if=$1 bs=1 skip=49411 count=3568 >data/data4.ann.bin
