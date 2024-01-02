#!/bin/sh

# magic number
printf "FDS\x1A"

# 1 side
printf "\x01"

# padding
printf "\0\0\0\0\0\0\0\0\0\0\0"
