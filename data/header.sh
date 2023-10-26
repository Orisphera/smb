#!/bin/sh

# magic number
printf "NES\x1A" > data/header.bin

# 32kb PRG (2 banks)
printf "\x02" >> data/header.bin

# 8kb CHR (1 bank)
printf "\x01" >> data/header.bin

# metadata - mapper 00 (NROM), vertical mirroring
printf "\1\0" >> data/header.bin

# padding
printf "\0\0\0\0\0\0\0\0" >> data/header.bin
