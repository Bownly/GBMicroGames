del Engine\o\*.o
del Engine\o\*.lst
del Engine\o\*.asm
del Engine\o\*.sym

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/borderTiles.o Engine/res/tiles/borderTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/fontTiles.o Engine/res/tiles/fontTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/timerTiles.o Engine/res/tiles/timerTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGTiles.o Engine/res/tiles/engineDMGTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineCursorTiles.o Engine/res/tiles/engineCursorTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineMixBorderTiles.o Engine/res/tiles/engineMixBorderTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineScrollBkgTiles.o Engine/res/tiles/engineScrollBkgTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat0Map.o Engine/res/maps/engineDMGBat0Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat1Map.o Engine/res/maps/engineDMGBat1Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat2Map.o Engine/res/maps/engineDMGBat2Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat3Map.o Engine/res/maps/engineDMGBat3Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat4Map.o Engine/res/maps/engineDMGBat4Map.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wf-bo14 -c -o Engine/o/premgJingle.o Engine/res/audio/premgJingle.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wf-bo14 -c -o Engine/o/lostJingle.o Engine/res/audio/lostJingle.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wf-bo14 -c -o Engine/o/wonJingle.o Engine/res/audio/wonJingle.c

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/common.o Engine/common.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/fade.o Engine/fade.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/songPlayer.o Engine/songPlayer.c

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/microgameData.o Engine/database/microgameData.c

C:\gbdk\bin\png2asset Engine/res/sprites/engineGBCart.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 64 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineDMGBezel.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 144 -noflip

C:\gbdk\bin\png2asset Engine/res/sprites/engineGBPrinter.png -spr8x8 -sw 8 -sh 8 -b 4 -map -tile_origin 64 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineGBPrintout.png -spr8x8 -sw 8 -sh 8 -b 4 -map -tile_origin 144 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineCartArts.png -spr8x8 -sw 16 -sh 16 -b 4 -map -tile_origin 64 -noflip -keep_duplicate_tiles

C:\gbdk\bin\lcc -Wa-l -Wf-bo0 -c -o Engine/o/microgameManagerState.o Engine/states/microgameManagerState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/titleState.o Engine/states/titleState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/gameoverState.o Engine/states/gameoverState.c

c:\gbdk\bin\lcc -Wa-l -Wf-ba0 -c -o Engine/o/ram.o Engine/ram.c


@REM Post-jam TODO:
@REM ✖️ Title screen
@REM ✖️ Main menu screen
@REM    ✖️ Main play mode
@REM    ✖️ Custom play
@REM    ✖️ Credits
@REM △ Lobby screen
@REM    ◯ Add level up animations
@REM    ✖️ Add level up song
@REM    ◯ Change the level up algorithm for individual MG play sessions
@REM    ✖️ Multiple random options for pre MG jingle
@REM    ◯ Refine algorithm for increasing speed/difficulty
@REM    ✖️ Change palette on instruction text
@REM    ◯ Add algorithm to avoid the same MG twice in a row (history queue of microgame_count/2 size)
@REM △ Saving/loading
@REM    △ Main play mode high score
@REM    △ Individual MG scores
@REM    ◯ Individual MG toggles
@REM    ✖️ Add option to wipe all save data
@REM ◯ Custom mix screen
@REM    ◯ Microgames grid
@REM        ◯ 5 x 4 grid
@REM        ◯ Cursor movement + wrapping
@REM        ◯ Play remix button will be to the right and will remember vert index 
@REM    ◯ A to play individual MG
@REM    ◯ Select to toggle an individual MG on/off
@REM    ◯ Play remix button
@REM    ◯ Hover over MG -> display name, author, info, score
@REM    ◯ ? game shows instructions, but doubles as a random pick
@REM    ◯ Music
@REM ✖️ Game over screen
@REM    ✖️ Pretty up the art/presentation
@REM    ✖️ Score score and high score
@REM ✖️ Add pausing
@REM △ Fix bugs and stuff
@REM    ✖️ Music glitches out again (after 24 points?)
@REM    ◯(?) Remix state MG select glitches out (due to bank shenanigans)
@REM    ✖️ Janken -> gameover results in tile glitch

@REM ◯ = done
@REM △ = wip or next in line
@REM ✖️ = not yet started
