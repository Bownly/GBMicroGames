#include <gb/gb.h>
#include "../hUGETracker/hUGEDriver.h"

void playCollisionSfx()
{
    NR41_REG = 0x1F;
    NR42_REG = 0xF1;
    NR43_REG = 0x40;
    NR44_REG = 0x87;
}

void playHurtSfx()
{
    NR41_REG = 0x03;
    NR42_REG = 0xF0;
    NR43_REG = 0x5F;
    NR44_REG = 0xC0;
}

void playMoveSfx()
{
    NR41_REG = 0x1F;
    NR42_REG = 0xF1;
    NR43_REG = 0x20;
    NR44_REG = 0xC0;
}

void playUnlockSfx()
{
    NR10_REG = 0x1E;
    NR11_REG = 0x10;
    NR12_REG = 0xF3;
    NR13_REG = 0x00;
    NR14_REG = 0x87;

    NR21_REG = 0x00;
    NR22_REG = 0x00;
    NR23_REG = 0x00;
    NR24_REG = 0x00;

    NR31_REG = 0x00;
    NR32_REG = 0x00;
    NR33_REG = 0x00;
    NR34_REG = 0x00;

    NR41_REG = 0x00;
    NR42_REG = 0x00;
    NR43_REG = 0x00;
    NR44_REG = 0x00;
}
