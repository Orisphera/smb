#!/bin/sh

# magic number
printf "NES\032"

# 32kb PRG (2 banks)
printf "\002"

# 8kb CHR (1 bank)
printf "\001"

# metadata - mapper 00 (NROM), vertical mirroring
printf "\001\000"

# padding
printf "\000\000\000\000\000\000\000\000"
