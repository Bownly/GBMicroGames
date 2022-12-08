
del bbbbbr/o/*.o
del bbbbbr/o/*.lst
del bbbbbr/o/*.asm
del bbbbbr/o/*.sym

# No music for now
# C:\gbdk\bin\lcc  -Wa-l -Wf-bo13 -c -o bbbbbr/o/bbbbbrSomeSong.o bbbbbr/res/audio/bbbbbrSomeSong.c

# C:\gbdk\bin\png2asset bbbbbr/res/maps/bbbbbr_getstars_map.png -map -noflip -b 13
C:\gbdk\bin\lcc  -Wa-l -c -o bbbbbr/o/bbbbbr_getstars_map.o bbbbbr/res/maps/bbbbbr_getstars_map.c

# -px -8 -py -16 to cancel out GB sprite offsets so upper left coord of metasprites match screen
# Only need to run once when changed (easier in a makefile)
# C:\gbdk\bin\png2asset bbbbbr/res/sprites/bbbbbr_stars.png            -spr8x8 -sw 16 -sh 48 -b 13 -px -8 -py -16
# C:\gbdk\bin\png2asset bbbbbr/res/sprites/bbbbbr_singlestar.png       -spr8x8 -sw 16 -sh 16 -b 13 -px -8 -py -16
# C:\gbdk\bin\png2asset bbbbbr/res/sprites/bbbbbr_bomb.png             -spr8x8 -sw 16 -sh 16 -b 13 -px -8 -py -16
# C:\gbdk\bin\png2asset bbbbbr/res/sprites/bbbbbr_getstars_player.png  -spr8x8 -sw 24 -sh 32 -b 13 -px -8 -py -16 -pw 10 -ph 28
C:\gbdk\bin\lcc  -Wa-l -c -o bbbbbr/o/bbbbbr_stars.o bbbbbr/res/sprites/bbbbbr_stars.c
C:\gbdk\bin\lcc  -Wa-l -c -o bbbbbr/o/bbbbbr_singlestar.o bbbbbr/res/sprites/bbbbbr_singlestar.c
C:\gbdk\bin\lcc  -Wa-l -c -o bbbbbr/o/bbbbbr_bomb.o bbbbbr/res/sprites/bbbbbr_bomb.c
C:\gbdk\bin\lcc  -Wa-l -c -o bbbbbr/o/bbbbbr_getstars_player.o bbbbbr/res/sprites/bbbbbr_getstars_player.c

C:\gbdk\bin\lcc  -Wa-l -Wf-bo13 -c -o bbbbbr/o/bbbbbrGetstarsMicrogame.o bbbbbr/states/bbbbbrGetstarsMicrogame.c
