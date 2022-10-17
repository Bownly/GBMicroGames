C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/borderTiles.o Shared/res/tiles/borderTiles.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/fonttiles.o Shared/res/tiles/fontTiles.c

C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/common.o Shared/common.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/fade.o Shared/fade.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/songPlayer.o Shared/songPlayer.c

C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/mgBankData.o Shared/database/mgBankData.c
C:\gbdk\bin\lcc -Wa-l -c -o Shared/o/mgInstructionData.o Shared/database/mgInstructionData.c

C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o Shared/o/gbt_player.o Shared/gbt_player.s
C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o Shared/o/gbt_player_bank1.o Shared/gbt_player_bank1.s

C:\gbdk\bin\lcc -Wa-l -Wf-bo2 -c -o Shared/o/sharedTemplateMicrogame.o Shared/states/sharedTemplateMicrogame.c
C:\gbdk\bin\lcc -Wa-l -Wf-bo0 -c -o Shared/o/microgameManagerState.o Shared/states/microgameManagerState.c

c:\gbdk\bin\lcc -Wa-l -Wf-ba0 -c -o Shared/o/ram.o Shared/ram.c

