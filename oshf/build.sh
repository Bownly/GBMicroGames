#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f oshf/o/*.o
rm -f oshf/o/*.lst
rm -f oshf/o/*.asm
rm -f oshf/o/*.sym

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfTwilightDriveSong.o oshf/res/audio/oshfTwilightDriveSong.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSTiles.o oshf/res/tiles/oshfRPSTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSArrow.o oshf/res/tiles/oshfRPSArrow.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSLCloud.o oshf/res/tiles/oshfRPSLCloud.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSRCloud.o oshf/res/tiles/oshfRPSRCloud.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSNinjaR.o oshf/res/tiles/oshfRPSNinjaR.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSNinjaP.o oshf/res/tiles/oshfRPSNinjaP.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSNinjaS.o oshf/res/tiles/oshfRPSNinjaS.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSNinjaDefeat.o oshf/res/tiles/oshfRPSNinjaDefeat.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSNinjaWin.o oshf/res/tiles/oshfRPSNinjaWin.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSMap.o oshf/res/maps/oshfRPSMap.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSR.o oshf/res/maps/oshfRPSR.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSP.o oshf/res/maps/oshfRPSP.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSS.o oshf/res/maps/oshfRPSS.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfRPSMicrogame.o oshf/states/oshfRPSMicrogame.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBTiles.o oshf/res/tiles/oshfHBTiles.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBBird.o oshf/res/tiles/oshfHBBird.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBSad.o oshf/res/tiles/oshfHBSad.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBHappy.o oshf/res/tiles/oshfHBHappy.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBJump.o oshf/res/tiles/oshfHBJump.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBWorm.o oshf/res/tiles/oshfHBWorm.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBMap.o oshf/res/maps/oshfHBMap.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo1 -c -o oshf/o/oshfHBMicrogame.o oshf/states/oshfHBMicrogame.c