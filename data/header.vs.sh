#!/bin/sh

# magic number
printf "NES\032"

# 32kb PRG (2 banks)
printf "\002"

# 16kb CHR (2 banks)
printf "\002"

# metadata - mapper 03 (CNROM), vertical mirroring
printf "\061\000"

# padding
printf "\000\000\000\000\000\000\000\000"
