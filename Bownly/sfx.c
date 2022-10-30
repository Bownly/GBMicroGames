#include <gb/gb.h>
#include "../hUGETracker/hUGEDriver.h"

void playBleepSfx()
{
    NR10_REG = 0x34U;
    NR11_REG = 0x70U;
    NR12_REG = 0xF0U;
    NR13_REG = 0xBAU;
    NR14_REG = 0xC6U;
}

void playCollisionSfx()
{
    NR41_REG = 0x1FU;
    NR42_REG = 0xF1U;
    NR43_REG = 0x40U;
    NR44_REG = 0x87U;
}

void playDingSfx()
{
    NR21_REG = 0x80U;
    NR22_REG = 0x73U;
    NR23_REG = 0x9FU;
    NR24_REG = 0xC7U;
}

void playHurtSfx()
{
    NR41_REG = 0x03U;
    NR42_REG = 0xF0U;
    NR43_REG = 0x5FU;
    NR44_REG = 0xC0U;
}

void playMoveSfx()
{
    NR41_REG = 0x1FU;
    NR42_REG = 0xF1U;
    NR43_REG = 0x20U;
    NR44_REG = 0xC0U;
}

void playUnlockSfx()
{
    NR10_REG = 0x1EU;
    NR11_REG = 0x10U;
    NR12_REG = 0xF3U;
    NR13_REG = 0x00U;
    NR14_REG = 0x87U;
}
