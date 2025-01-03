#!/bin/sh

FILE_REF=$1
CHECKSUM_REF=$2

CHECKSUM_FILE=`cksum $FILE_REF | awk '{ print $1 }'`

if test "$CHECKSUM_FILE" != "$CHECKSUM_REF"
then
	echo "CRC mismatch for "$FILE_REF
	exit 1
fi
