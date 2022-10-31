call Engine\make.bat
call Bownly\make.bat
call Template\make.bat

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/main.o main.c
C:\gbdk\bin\lcc -Wl-yt3 -Wl-yo8 -Wl-ya4 -o GBMicroGames.gb ^
    hUGETracker/hUGEDriver.obj.o ^
    Engine/o/*.o ^
    Bownly/o/*.o Bownly/res/sprites/*.c ^
    Template/o/*.o 

exit 0
