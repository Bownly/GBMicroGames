#!/bin/sh

BIN=/Users/dovesam/Documents/Development/gbdk/bin

source Engine/build.sh
source Bownly/build.sh
source Template/build.sh
source dovesam/build.sh

$BIN/lcc -Wa-l -c -o Engine/o/main.o main.c
$BIN/lcc -Wl-yt3 -Wl-yo8 -Wl-ya4 -o GBMicroGames.gb \
    hUGETracker/hUGEDriver.obj.o                \
    Engine/o/*.o Engine/res/sprites/*.c         \
    Bownly/o/*.o Bownly/res/sprites/*.c         \
    Template/o/*.o                              \
    dovesam/o/*.o dovesam/res/assets/*.c