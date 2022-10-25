#include <gb/gb.h>
#include "gbt_player.h"
#include "../hUGETracker/hUGEDriver.h"

#include "common.h"
#include "enums.h"

void playSong(const hUGESong_t * song)
{
    remove_VBL(hUGE_dosound);
    add_VBL(hUGE_dosound);
    hUGE_init(song);
}

void stopSong()
{
    NR12_REG = NR22_REG = NR32_REG = NR42_REG = 0;
    remove_VBL(hUGE_dosound);
}


void playCollisionSfx()
{
    NR41_REG = 0x1F;
    NR42_REG = 0xF1;
    NR43_REG = 0x40;
    NR44_REG = 0x87;
}

void playHurtSfx()
{
    NR41_REG=0x03;
    NR42_REG=0xF0;
    NR43_REG=0x5F;
    NR44_REG=0xC0;
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
