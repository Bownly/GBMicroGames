#!/bin/bash

if [ -z "$GBDK_DIR" ]
then
      echo "Error: Please set GBDK_DIR environment variable. For example: /"export GBDK_DIR=/opt/gbdk/""
      exit
else
      echo "GBDK_DIR=$GBDK_DIR"
fi

source Engine/build.sh
source Bownly/build.sh
source Template/build.sh
source teaaaaaaaa/build.sh
source dovesam/build.sh
source joaomakesgames/build.sh
source oshf/build.sh
source AdrianJG/build.sh
source SynchingFeeling/build.sh
source bbbbbr/build.sh

$GBDK_DIR/bin/lcc -Wa-l -c -o Engine/o/main.o main.c
$GBDK_DIR/bin/lcc -Wl-yt0x1B -Wl-yoA -Wl-ya4 -o "Microgames Jam Pak.gb" \
	hUGETracker/hUGEDriver.obj.o                          \
	Engine/o/*.o Engine/res/sprites/*.c                   \
	Bownly/o/*.o Bownly/res/sprites/*.c                   \
	teaaaaaaaa/o/*.o                                      \
	dovesam/o/*.o dovesam/res/assets/*.c                  \
	joaomakesgames/o/*.o                                  \
	oshf/o/*.o                                            \
	AdrianJG/o/*.o                                        \
	SynchingFeeling/o/*.o SynchingFeeling/res/sprites/*.c \
	Template/o/*.o                                        \
	bbbbbr/o/*.o