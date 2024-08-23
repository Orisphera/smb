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

CHR_PATH_BASE="chr.smb"
CHR_PATH_VS="chr.vs"
CHR_PATH_SMB2="chr.smb2"
CHR_PATH_NSM="chr.ann"

mkdir -p data/chr2.ann data/${CHR_PATH_BASE} data/${CHR_PATH_VS} data/${CHR_PATH_SMB2} data/${CHR_PATH_NSM}

# KYODAKU-
dd if=$1 bs=1 skip=91 count=224 >data/security.bin

# CHR Common
TILE_SIZE=16
BG_BANK=256

# NSMCHAR1
BANKBASE=332
BANKLEN=8192
TILES=`expr $BANKLEN / $TILE_SIZE`

TILE_FLAG_VICTORY_FIRST=84
TILE_FLAG_VICTORY_LAST=87
TILE_PLAT=91
TILE_GOOMBA_A_FIRST=112
TILE_GOOMBA_A_LAST=115
TILE_DOOR_FIRST=118
TILE_DOOR_LAST=121
TILE_NSM_GUY_A_FIRST=122
TILE_NSM_GUY_A_LAST=123
TILE_STAR_A=141
TILE_NSM_GUY_B_FIRST=205
TILE_NSM_GUY_B_LAST=207
TILE_MUSH_NW=216
TILE_MUSH_NE=218
TILE_MUSH_SW=219
TILE_STAR_B=228
TILE_PIRANHA_A_FIRST=229
TILE_PIRANHA_A_LAST=230
TILE_PIRANHA_B_FIRST=235
TILE_PIRANHA_B_LAST=238
TILE_GOOMBA_B=239
TILE_ONEUP_LEFT=253
TILE_ONEUP_RIGHT=254
TILE_MUSH_SE=255

I=0
while [ $I -ne $BG_BANK ] && [ $I -ne $TILES ]
do
        CHR_PATH=$CHR_PATH_BASE
        if [ $I -ge $TILE_FLAG_VICTORY_FIRST ] && [ $I -le $TILE_FLAG_VICTORY_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $I -eq $TILE_PLAT ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $I -ge $TILE_GOOMBA_A_FIRST ] && [ $I -le $TILE_GOOMBA_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $I -ge $TILE_DOOR_FIRST ] && [ $I -le $TILE_DOOR_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $I -ge $TILE_NSM_GUY_A_FIRST ] && [ $I -le $TILE_NSM_GUY_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $I -ge $TILE_NSM_GUY_B_FIRST ] && [ $I -le $TILE_NSM_GUY_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $I -eq $TILE_STAR_A ] || [ $I -eq $TILE_STAR_B ] || [ $I -eq $TILE_GOOMBA_B ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $I -eq $TILE_MUSH_NW ] || [ $I -eq $TILE_MUSH_NE ] || [ $I -eq $TILE_MUSH_SW ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $I -eq $TILE_MUSH_SE ] || [ $I -eq $TILE_ONEUP_LEFT ] || [ $I -eq $TILE_ONEUP_RIGHT ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $I -ge $TILE_PIRANHA_A_FIRST ] && [ $I -le $TILE_PIRANHA_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $I -ge $TILE_PIRANHA_B_FIRST ] && [ $I -le $TILE_PIRANHA_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        fi
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/tile_obj_`printf "%.2X" $I`.bin
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
TILE_SMB2_GFX_A_FIRST=52
TILE_SMB2_GFX_A_LAST=60
TREE_LEFT_SMB2_FIRST=75
TREE_LEFT_SMB2_LAST=76
TREE_REST_SMB2_FIRST=78
TREE_REST_SMB2_LAST=82
BRICK_SMB2_C_FIRST=93
BRICK_SMB2_C_LAST=94
TILE_EDGE_NSM_FIRST=117
TILE_EDGE_NSM_LAST=118
TILE_AXE_NSM_FIRST=123
TILE_AXE_NSM_LAST=126
FENCE_NSM_A_FIRST=128
FENCE_NSM_A_LAST=129
FENCE_NSM_B_FIRST=160
FENCE_NSM_B_LAST=161
FONT_VS_F_FIRST=175
FONT_VS_F_LAST=175
GROUND_SMB2_A_FIRST=180
GROUND_SMB2_A_LAST=183
MUSH_TREE_SMB2_FIRST=184
MUSH_TREE_SMB2_LAST=189
BG_SMB2_B_FIRST=192
BG_SMB2_B_LAST=193
COPYRIGHT_SMB2=207
TEXT_NSM_A_FIRST=236
TEXT_NSM_A_LAST=239
BG_SMB2_C_FIRST=240
BG_SMB2_C_LAST=242
TEXT_NSM_B_FIRST=243
TEXT_NSM_B_LAST=248
TEXT_NSM_QUOTES_FIRST=249
TEXT_NSM_QUOTES_LAST=250
TEXT_NSM_C_FIRST=251
TEXT_NSM_C_LAST=254

while [ $I -ne $TILES ]
do
	J=`expr $I - $BG_BANK`
        CHR_PATH=$CHR_PATH_BASE
        DID_READ=0
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
        elif [ $J -ge $TILE_SMB2_GFX_A_FIRST ] && [ $J -le $TILE_SMB2_GFX_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TREE_LEFT_SMB2_FIRST ] && [ $J -le $TREE_LEFT_SMB2_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TREE_REST_SMB2_FIRST ] && [ $J -le $TREE_REST_SMB2_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $BRICK_SMB2_C_FIRST ] && [ $J -le $BRICK_SMB2_C_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TILE_EDGE_NSM_FIRST ] && [ $J -le $TILE_EDGE_NSM_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $J -ge $TILE_AXE_NSM_FIRST ] && [ $J -le $TILE_AXE_NSM_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $J -ge $FENCE_NSM_A_FIRST ] && [ $J -le $FENCE_NSM_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $J -ge $FENCE_NSM_B_FIRST ] && [ $J -le $FENCE_NSM_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
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
        elif [ $J -eq $COPYRIGHT_SMB2 ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TEXT_NSM_A_FIRST ] && [ $J -le $TEXT_NSM_A_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $J -ge $BG_SMB2_C_FIRST ] && [ $J -le $BG_SMB2_C_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
        elif [ $J -ge $TEXT_NSM_B_FIRST ] && [ $J -le $TEXT_NSM_B_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        elif [ $J -eq $TEXT_NSM_QUOTES_FIRST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
                
                dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/tile_bg_75.bin

                DID_READ=1
        elif [ $J -eq $TEXT_NSM_QUOTES_LAST ]
        then
                CHR_PATH=$CHR_PATH_SMB2
                
                dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/tile_bg_76.bin

                DID_READ=1
        elif [ $J -ge $TEXT_NSM_C_FIRST ] && [ $J -le $TEXT_NSM_C_LAST ]
        then
                CHR_PATH=$CHR_PATH_NSM
        fi

        if [ $DID_READ -eq 0 ]
        then
                dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/${CHR_PATH}/tile_bg_`printf "%.2X" $J`.bin
	fi
        I=`expr $I + 1`
done

# NSMCHAR2
BANKBASE=8541
BANKLEN=736
TILES=`expr $BANKLEN / $TILE_SIZE`

I=0
J=118
while [ $J -ne $BG_BANK ] && [ $I -ne $TILES ]
do
        dd if=$1 bs=1 count=$TILE_SIZE skip=`expr $I \* $TILE_SIZE + $BANKBASE` >data/chr2.ann/tile_obj_`printf "%.2X" $J`.bin
        I=`expr $I + 1`
	J=`expr $J + 1`
done

# NSMMAIN
dd if=$1 bs=1 skip=34916 count=7524 >data/prg.ann.bin

# NSMDATA2
dd if=$1 bs=1 skip=42447 count=3584 >data/data2.ann.bin

# NSMDATA3
dd if=$1 bs=1 skip=46048 count=3346 >data/data3.ann.bin

# NSMDATA4
dd if=$1 bs=1 skip=49411 count=3568 >data/data4.ann.bin
