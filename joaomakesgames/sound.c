#include <gb/gb.h>

void j_playDing()
{
    NR10_REG = 0x48;
    NR11_REG = 0x87;
    NR12_REG = 0x43;
    NR13_REG = 0x6C;
    NR14_REG = 0x87;
}

void j_playDong()
{
    NR10_REG = 0x48;
    NR11_REG = 0xC7;
    NR12_REG = 0x43;
    NR13_REG = 0x6C;
    NR14_REG = 0x87;
}

void j_playBalloonPop()
{
    NR10_REG = 0x1F;
    NR11_REG = 0xC1;
    NR12_REG = 0xE2;
    NR13_REG = 0xE8;
    NR14_REG = 0x83; 
}