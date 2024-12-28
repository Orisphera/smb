#!/bin/sh

# magic number
printf "FDS\032"

# 1 side
printf "\001"

# padding
printf "\000\000\000\000\000\000\000\000\000\000\000"
