#!/bin/sh

# magic number
printf "NES\x1A"

# 32kb PRG (2 banks)
printf "\x02"

# 16kb CHR (2 banks)
printf "\x02"

# metadata - mapper 03 (CNROM), vertical mirroring
printf "\x31\0"

# padding
printf "\0\0\0\0\0\0\0\0"
