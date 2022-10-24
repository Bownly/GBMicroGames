#include <gb/gb.h>
#include "gbt_player.h"

#include "common.h"
#include "enums.h"

extern const unsigned char* twsong_Data[];

void playSong(UINT8 songName, UINT8 songSpeed)
{
    // switch(songName)
    // {
    //     default:
            gbt_play(twsong_Data, 2U, songSpeed);
    //         break;
    // }
}

void stopSong()
{
    gbt_stop();
    NR52_REG = 0x80; //Enables sound, you should always setup this first
    NR51_REG = 0xFF; //Enables all channels (left and right)
    NR50_REG = 0x77; //Max volume
}

void pauseSong(UINT8 newState)
{
    if (newState == 0)
    {
        NR52_REG = 0x80; //Enables sound, you should always setup this first
        NR51_REG = 0xFF; //Enables all channels (left and right)
        NR50_REG = 0x77; //Max volume
    }
    else if (newState == 1)
    {
        NR51_REG = 0x00; //Disable all channels (left and right)
        NR50_REG = 0x00; //Lowest volume
    }
}

void songPlayerUpdate()
{
    gbt_update(); // This will change to ROM bank 1.
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
