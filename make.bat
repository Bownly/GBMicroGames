call Engine\make.bat
call Bownly\make.bat
call Template\make.bat
call dovesam\make.bat
call joaomakesgames\make.bat
call oshf\make.bat
call AdrianJG\make.bat
call SynchingFeeling\make.bat

C:\gbdk\bin\lcc -Wa-l -c -o Engine/o/main.o main.c
C:\gbdk\bin\lcc -Wl-yt3 -Wl-yoA -Wl-ya4 -o GBMicroGames.gb ^
    hUGETracker/hUGEDriver.obj.o ^
    Engine/o/*.o Engine/res/sprites/*.c ^
    Bownly/o/*.o Bownly/res/sprites/*.c ^
    dovesam/o/*.o dovesam/res/assets/*.c ^
    joaomakesgames/o/*.o ^
    oshf/o/*.o ^
    AdrianJG/o/*.o ^
    SynchingFeeling/o/*.o SynchingFeeling/res/sprites/*.c ^
    Template/o/*.o 

exit 0
