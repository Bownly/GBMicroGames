#include <gb/gb.h>
#include "../hUGETracker/hUGEDriver.h"

void playGoodHitSfx()
{
    NR41_REG = 0x1FU;
    NR42_REG = 0xF1U;
    NR43_REG = 0x40U;
    NR44_REG = 0x87U;
}

void playBadHitSfx()
{
    NR41_REG = 0x03U;
    NR42_REG = 0xF0U;
    NR43_REG = 0x5FU;
    NR44_REG = 0xC0U;
}

void playGhostSpotSfx()
{
    NR21_REG = 0x80U;
    NR22_REG = 0x73U;
    NR23_REG = 0x9FU;
    NR24_REG = 0xC7U;
}

void playGhostFailSfx()
{
    NR41_REG = 0x03U;
    NR42_REG = 0xF0U;
    NR43_REG = 0x5FU;
    NR44_REG = 0xC0U;
}
