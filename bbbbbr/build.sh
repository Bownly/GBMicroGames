#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

mkdir -p bbbbbr/o
rm -rf bbbbbr/o/*.o
rm -rf bbbbbr/o/*.lst
rm -rf bbbbbr/o/*.asm
rm -rf bbbbbr/o/*.sym

# No music for now
# $GBDK_DIR/bin/lcc -Wa-l -Wf-bo13 -c -o bbbbbr/o/bbbbbrSomeSong.o bbbbbr/res/audio/bbbbbrSomeSong.c

# $GBDK_DIR/bin/png2asset bbbbbr/res/maps/bbbbbr_getstars_map.png -map -noflip -b 13
$GBDK_DIR/bin/lcc -Wa-l -c -o bbbbbr/o/bbbbbr_getstars_map.o bbbbbr/res/maps/bbbbbr_getstars_map.c

# -px -8 -py -16 to cancel out GB sprite offsets so upper left coord of metasprites match screen
# Only need to run once when changed (easier in a makefile)
# $GBDK_DIR/bin/png2asset bbbbbr/res/sprites/bbbbbr_stars.png            -spr8x8 -sw 16 -sh 48 -b 13 -px -8 -py -16
# $GBDK_DIR/bin/png2asset bbbbbr/res/sprites/bbbbbr_singlestar.png       -spr8x8 -sw 16 -sh 16 -b 13 -px -8 -py -16
# $GBDK_DIR/bin/png2asset bbbbbr/res/sprites/bbbbbr_bomb.png             -spr8x8 -sw 16 -sh 16 -b 13 -px -8 -py -16
# $GBDK_DIR/bin/png2asset bbbbbr/res/sprites/bbbbbr_getstars_player.png  -spr8x8 -sw 24 -sh 32 -b 13 -px -8 -py -16 -pw 10 -ph 28
$GBDK_DIR/bin/lcc -Wa-l -c -o bbbbbr/o/bbbbbr_stars.o bbbbbr/res/sprites/bbbbbr_stars.c
$GBDK_DIR/bin/lcc -Wa-l -c -o bbbbbr/o/bbbbbr_singlestar.o bbbbbr/res/sprites/bbbbbr_singlestar.c
$GBDK_DIR/bin/lcc -Wa-l -c -o bbbbbr/o/bbbbbr_bomb.o bbbbbr/res/sprites/bbbbbr_bomb.c
$GBDK_DIR/bin/lcc -Wa-l -c -o bbbbbr/o/bbbbbr_getstars_player.o bbbbbr/res/sprites/bbbbbr_getstars_player.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo13 -c -o bbbbbr/o/bbbbbrGetstarsMicrogame.o bbbbbr/states/bbbbbrGetstarsMicrogame.c
