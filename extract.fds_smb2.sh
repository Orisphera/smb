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

CHR_PATH_BASE="chr.smb"
CHR_PATH_VS="chr.vs"
CHR_PATH_SMB2="chr.smb2"

mkdir -p data/chr2.smb2 data/${CHR_PATH_BASE} data/${CHR_PATH_SMB2} data/${CHR_PATH_VS} 

# KYODAKU-
dd if=$1 bs=1 skip=91 count=224 >data/security.bin

# CHR Common
TILE_SIZE=16
BG_BANK=256

# SM2CHAR1
BANKBASE=332
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

TILE_PLAT=91
TILE_NEW_A_FIRST=118
TILE_NEW_A_LAST=123
TILE_BLOCK_LEFT=133
TILE_BLOCK_RIGHT=134
TILE_MUSH_NW=216
TILE_MUSH_NE=218
TILE_MUSH_SW=219
TILE_ONEUP_LEFT=253
TILE_ONEUP_RIGHT=254
TILE_MUSH_SE=255

I=0
while [ $I -ne $BG_BANK ] && [ $I -ne $TILES ]
do
        CHR_PATH=$CHR_PATH_BASE
        if [ $I -eq $TILE_PLAT ] || [ $I -eq $TILE_BLOCK_LEFT ] || [ $I -eq $TILE_BLOCK_RIGHT ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $I -eq $TILE_MUSH_NW ] || [ $I -eq $TILE_MUSH_NE ] || [ $I -eq $TILE_MUSH_SW ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $I -eq $TILE_MUSH_SE ] || [ $I -eq $TILE_ONEUP_LEFT ] || [ $I -eq $TILE_ONEUP_RIGHT ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $I -ge $TILE_NEW_A_FIRST ] && [ $I -le $TILE_NEW_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        fi
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/chr_obj_`printf "%.2X" $I`.bin
        I=`expr $I + 1`
done

FONT_VS_A_FIRST=0
FONT_VS_A_LAST=17
FONT_SMB2_A_FIRST=18
FONT_SMB2_A_LAST=19
FONT_VS_B_FIRST=20
FONT_VS_B_LAST=28
FONT_SMB2_B_FIRST=29
FONT_SMB2_B_LAST=29
FONT_VS_C_FIRST=30
FONT_VS_C_LAST=35
FONT_VS_D_FIRST=40
FONT_VS_D_LAST=41
FONT_VS_E_FIRST=43
FONT_VS_E_LAST=43
PLAT_SMB2_A_FIRST=44
PLAT_SMB2_A_LAST=45
BG_SMB2_A_FIRST=48
BG_SMB2_A_LAST=60
BRICK_SMB2_A=69
BRICK_SMB2_B=71
TREE_LEFT_SMB2_FIRST=75
TREE_LEFT_SMB2_LAST=76
TREE_REST_SMB2_FIRST=78
TREE_REST_SMB2_LAST=82
BRICK_SMB2_C=93
BRICK_SMB2_D=94
TOP_PLAT_SMB2_FIRST=107
TOP_PLAT_SMB2_LAST=118
FENCE_SMB2_A_FIRST=128
FENCE_SMB2_A_LAST=129
DOOR_SMB2_FIRST=155
DOOR_SMB2_LAST=158
FENCE_SMB2_B_FIRST=160
FENCE_SMB2_B_LAST=161
BRICK_SMB2_E=169
BRICK_SMB2_F=170
FONT_VS_F_FIRST=175
FONT_VS_F_LAST=175
GROUND_SMB2_A_FIRST=180
GROUND_SMB2_A_LAST=183
MUSH_TREE_SMB2_FIRST=184
MUSH_TREE_SMB2_LAST=189
BG_SMB2_B_FIRST=192
BG_SMB2_B_LAST=193
COPYRIGHT_SMB2=207
BG_SMB2_C_FIRST=236
BG_SMB2_C_LAST=254

while [ $I -ne $TILES ]
do
	J=`expr $I - $BG_BANK`
        CHR_PATH=$CHR_PATH_BASE
        if [ $J -ge $FONT_VS_A_FIRST ] && [ $J -le $FONT_VS_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -ge $FONT_SMB2_A_FIRST ] && [ $J -le $FONT_SMB2_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $FONT_VS_B_FIRST ] && [ $J -le $FONT_VS_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -ge $FONT_SMB2_B_FIRST ] && [ $J -le $FONT_SMB2_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $FONT_VS_C_FIRST ] && [ $J -le $FONT_VS_C_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -ge $FONT_VS_D_FIRST ] && [ $J -le $FONT_VS_D_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -ge $FONT_VS_E_FIRST ] && [ $J -le $FONT_VS_E_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -ge $PLAT_SMB2_A_FIRST ] && [ $J -le $PLAT_SMB2_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $BG_SMB2_A_FIRST ] && [ $J -le $BG_SMB2_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -eq $BRICK_SMB2_A ] || [ $J -eq $BRICK_SMB2_B ] || [ $J -eq $BRICK_SMB2_C ] || [ $J -eq $BRICK_SMB2_D ] || [ $J -eq $BRICK_SMB2_E ] || [ $J -eq $BRICK_SMB2_F ] || [ $J -eq $COPYRIGHT_SMB2 ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TREE_LEFT_SMB2_FIRST ] && [ $J -le $TREE_LEFT_SMB2_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TREE_REST_SMB2_FIRST ] && [ $J -le $TREE_REST_SMB2_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TOP_PLAT_SMB2_FIRST ] && [ $J -le $TOP_PLAT_SMB2_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $FENCE_SMB2_A_FIRST ] && [ $J -le $FENCE_SMB2_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $DOOR_SMB2_FIRST ] && [ $J -le $DOOR_SMB2_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $FENCE_SMB2_B_FIRST ] && [ $J -le $FENCE_SMB2_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $FONT_VS_F_FIRST ] && [ $J -le $FONT_VS_F_LAST ]
        then
                CHR_PATH=$CHR_PATH_VS
        elif [ $J -ge $GROUND_SMB2_A_FIRST ] && [ $J -le $GROUND_SMB2_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $MUSH_TREE_SMB2_FIRST ] && [ $J -le $MUSH_TREE_SMB2_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $BG_SMB2_B_FIRST ] && [ $J -le $BG_SMB2_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $BG_SMB2_C_FIRST ] && [ $J -le $BG_SMB2_C_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        fi
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/chr_bg_`printf "%.2X" $J`.bin
	I=`expr $I + 1`
done

# SM2CHAR2
BANKBASE=8541
BANKLEN=64
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
J=118
while [ $J -ne $BG_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr2.smb2/chr_obj_`printf "%.2X" $J`.bin
        I=`expr $I + 1`
	J=`expr $J + 1`
done

# SM2DATA2
dd if=$1 bs=1 skip=41487 count=3551 >data/data2.smb2.bin

# SM2DATA3
dd if=$1 bs=1 skip=45055 count=3279 >data/data3.smb2.bin

# SM2DATA4
dd if=$1 bs=1 skip=48351 count=3916 >data/data4.smb2.bin
