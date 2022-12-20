del Engine\o\*.o
del Engine\o\*.lst
del Engine\o\*.asm
del Engine\o\*.sym

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/borderTiles.o Engine/res/tiles/borderTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/fontTiles.o Engine/res/tiles/fontTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/alBhedFontTiles.o Engine/res/tiles/alBhedFontTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/timerTiles.o Engine/res/tiles/timerTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/engineScrollBkgTiles.o Engine/res/tiles/engineScrollBkgTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGTiles.o Engine/res/tiles/engineDMGTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/darkBorderTiles.o Engine/res/tiles/darkBorderTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineCursorTiles.o Engine/res/tiles/engineCursorTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineMixBorderTiles.o Engine/res/tiles/engineMixBorderTiles.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat0Map.o Engine/res/maps/engineDMGBat0Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat1Map.o Engine/res/maps/engineDMGBat1Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat2Map.o Engine/res/maps/engineDMGBat2Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat3Map.o Engine/res/maps/engineDMGBat3Map.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineDMGBat4Map.o Engine/res/maps/engineDMGBat4Map.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/engineSloopygoopResults.o Engine/res/audio/engineSloopygoopResults.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo5 -c -o Engine/o/engineSloopygoopBoogieWoogieEx.o Engine/res/audio/engineSloopygoopBoogieWoogieEx.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/engineSloopygoopPartyTheme.o Engine/res/audio/engineSloopygoopPartyTheme.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo14 -c -o Engine/o/engineLevelUpJingle.o Engine/res/audio/engineLevelUpJingle.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo14 -c -o Engine/o/lostJingle.o Engine/res/audio/lostJingle.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle1.o Engine/res/audio/premgJingle1.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle2.o Engine/res/audio/premgJingle2.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle3.o Engine/res/audio/premgJingle3.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo14 -c -o Engine/o/premgJingle4.o Engine/res/audio/premgJingle4.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo14 -c -o Engine/o/wonJingle.o Engine/res/audio/wonJingle.c

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/common.o Engine/common.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/fade.o Engine/fade.c
C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/songPlayer.o Engine/songPlayer.c

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/microgameData.o Engine/database/microgameData.c

C:\gbdk\bin\png2asset Engine/res/sprites/engineGBCart.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 64 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineDMGBezel.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 144 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineGBPrinter.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 64 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineGBPrintout.png -spr8x8 -sw 8 -sh 8 -b 1 -map -tile_origin 96 -noflip

C:\gbdk\bin\png2asset Engine/res/sprites/engineTitleCornerGarnish.png -spr8x8 -sw 32 -sh 32 -px 0 -py 0 -b 4
C:\gbdk\bin\png2asset Engine/res/sprites/engineTitleLogo.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 48 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineCartArts.png -spr8x8 -sw 16 -sh 16 -b 4 -map -tile_origin 64 -noflip -keep_duplicate_tiles
C:\gbdk\bin\png2asset Engine/res/sprites/engineWordPlay.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 48 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineWordRemix.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 80 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineWordCredits.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 128 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineABWordPlay.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 48 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineABWordRemix.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 80 -noflip
C:\gbdk\bin\png2asset Engine/res/sprites/engineABWordCredits.png -spr8x8 -sw 8 -sh 16 -b 4 -map -tile_origin 128 -noflip

C:\gbdk\bin\lcc -Wa-l -Wf-bo0 -c -o Engine/o/microgameManagerState.o Engine/states/microgameManagerState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo1 -c -o Engine/o/gameoverState.o Engine/states/gameoverState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/titleState.o Engine/states/titleState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/creditsState.o Engine/states/creditsState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/deleteSaveState.o Engine/states/deleteSaveState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/mainMenuState.o Engine/states/mainMenuState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo4 -c -o Engine/o/remixState.o Engine/states/remixState.c

C:\gbdk\bin\lcc -Wa-l -Wf-ba0 -c -o Engine/o/ram.o Engine/ram.c
