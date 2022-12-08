#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

rm -f teaaaaaaaa/o/*.o
rm -f teaaaaaaaa/o/*.lst
rm -f teaaaaaaaa/o/*.asm
rm -f teaaaaaaaa/o/*.sym

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo8 -c -o teaaaaaaaa/o/WhackMoleSpriteGraphics.o teaaaaaaaa/res/tiles/WhackMoleSpriteGraphics.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo8 -c -o teaaaaaaaa/o/WhackMoleSpriteTileData.o teaaaaaaaa/res/tiles/WhackMoleSpriteTileData.c
$GBDK_DIR/bin/lcc -Wa-l -Wf-bo8 -c -o teaaaaaaaa/o/WhackMoleBGgraphics.o teaaaaaaaa/res/tiles/WhackMoleBGgraphics.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo8 -c -o teaaaaaaaa/o/whackMolesBG.o teaaaaaaaa/res/maps/whackMolesBG.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo8 -Wf-bo8 -c -o teaaaaaaaa/o/whackMolesMusic.o teaaaaaaaa/res/audio/whackMolesMusic.c

$GBDK_DIR/bin/lcc -Wa-l -Wf-bo8 -c -o teaaaaaaaa/o/templateFaceMicrogame.o teaaaaaaaa/states/templateFaceMicrogame.c
