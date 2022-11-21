del SynchingFeeling\o\*.o
del SynchingFeeling\o\*.lst
del SynchingFeeling\o\*.asm
del SynchingFeeling\o\*.sym

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o SynchingFeeling/o/sfx.o SynchingFeeling/sfx.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o SynchingFeeling/o/humptyDumptySong.o SynchingFeeling/res/audio/synchingFeelingHumptyDumptySong.c

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o SynchingFeeling/o/synchingFeelingEggTiles.o SynchingFeeling/res/tiles/synchingFeelingEggTiles.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o SynchingFeeling/o/synchingFeelingEggMaps.o SynchingFeeling/res/maps/synchingFeelingEggMaps.c

C:\gbdk\bin\png2asset SynchingFeeling/res/sprites/synchingFeelingEggSpr.png -spr8x8 -sw 16 -sh 16 -b 3
C:\gbdk\bin\png2asset SynchingFeeling/res/sprites/synchingFeelingBlockSpr.png -spr8x8 -sw 16 -sh 16 -b 3
C:\gbdk\bin\png2asset SynchingFeeling/res/sprites/synchingFeelingCoinSpr.png -spr8x8 -sw 16 -sh 16 -b 3

C:\gbdk\bin\lcc -Wa-l -Wf-bo3 -c -o SynchingFeeling/o/synchingFeelingEggMicrogame.o SynchingFeeling/states/synchingFeelingEggMicrogame.c
