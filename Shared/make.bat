del Shared\o\*.o
del Shared\o\*.lst
del Shared\o\*.asm
del Shared\o\*.sym

C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/borderTiles.o Shared/res/tiles/borderTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/fonttiles.o Shared/res/tiles/fontTiles.c

C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/common.o Shared/common.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/fade.o Shared/fade.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/songPlayer.o Shared/songPlayer.c

C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/microgameData.o Shared/database/microgameData.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/microgameData.o Shared/database/microgameData.c

C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o Shared/o/gbt_player.o Shared/gbt_player.s
C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o Shared/o/gbt_player_bank1.o Shared/gbt_player_bank1.s

C:\gbdk\bin\lcc -Wa-l -Wf-bo0 -c -o Shared/o/microgameManagerState.o Shared/states/microgameManagerState.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Shared/o/sharedTemplateMicrogame.o Shared/states/sharedTemplateMicrogame.c

c:\gbdk\bin\lcc -Wa-l -Wf-ba0 -c -o Shared/o/ram.o Shared/ram.c

@REM Engine MVP TODO:
@REM Should probably move mgdex to a different bank
@REM Bomb countdown timer thing
@REM Logic to lose game when timer expires
@REM Pad out time between mgStatus = WON and transition away from microgame
@REM Pad out time between mgStatus = LOST and transition away from microgame
@REM Music
@REM Audio in general
@REM Beautify transition screen
@REM    Score increment animation
@REM    Lives/losing lives animation
@REM    Speed up/difficulty up animations

@REM During/post gamejam TODO broadstrokes:
@REM Title screen
@REM Saving/loading
@REM "Overworld map" thingy where you can select MG groups
@REM Select individual MG screen (grid of MGs, with an icon and byline for each one)
@REM Maybe: store for unlocking new MGs a la SSBM trophy lottery
@REM Maybe: if above, a way to earn currency
