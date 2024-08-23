#!/bin/bash

# Parse command line flags
while [ "$1" != "" ]; do
        OPT="${1,,}"
       case "$OPT" in
            -h | --help ) Usage                 # Usage
            ;;
            -v | --ver* ) echo "Version : 123"  # Report version
            ;;
            -c |--color ) echo "Color ON"       # Force color support ON
            ;;
         -nc |--nocolor ) echo "Color OFF"      # Force color support OFF
            ;;
                      * ) echo " USAGE : "      # Var for undefined
            ;;
       esac
       shift
done
