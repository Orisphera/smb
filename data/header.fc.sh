#!/bin/sh

# magic number
printf "NES\x1A"

# 32kb PRG (2 banks)
printf "\x02"

# 8kb CHR (1 bank)
printf "\x01"

# metadata - mapper 00 (NROM), vertical mirroring
printf "\1\0"

# padding
printf "\0\0\0\0\0\0\0\0"
