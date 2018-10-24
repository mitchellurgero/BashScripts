#!/bin/bash
## Basic dd command with some type of progress output.
## Note this Only uses basic dd features, feel free to modify as needed (IF YOU KNOW WHAT YOU ARE DOING, DD IS A POWERFUL TOOL.)
##
## By Mitchell Urgero, using https://askubuntu.com/a/620234 as inspiration.
##
## dscript
if [ $# -lt 3 ]
  then
    echo "Use: $0 /path/to/input /path/to/output 4096"
    echo "[Where 4096 is block size for output device]"
    exit 1
fi


dd if=$1 of=$2 conv=sparse bs=$3 & bgid=$!; while true; do sleep 1; kill -USR1 $bgid || break; sleep 4; done