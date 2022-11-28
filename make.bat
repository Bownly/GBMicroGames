call Engine\make.bat
call Bownly\make.bat
call Template\make.bat
call oshf\make.bat

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/main.o main.c
C:\gbdk\bin\lcc -Wl-yt3 -Wl-yoA -Wl-ya4 -o GBMicroGames.gb ^
    hUGETracker/hUGEDriver.obj.o ^
    Engine/o/*.o Engine/res/sprites/*.c ^
    Bownly/o/*.o Bownly/res/sprites/*.c ^
    Template/o/*.o ^
    oshf/o/*.o

pause

exit 0
