#include <gb/gb.h>
#include "../hUGETracker/hUGEDriver.h"

#include "common.h"
#include "enums.h"

extern UINT8 mgSpeed;

void playSong(const hUGESong_t * song)
{
    remove_VBL(hUGE_dosound);
    add_VBL(hUGE_dosound);
    
    // All this just to increase the tempo. Is there a better way to do this? Probably.
    hUGESong_t modifiedSong;
    modifiedSong.tempo = song->tempo - mgSpeed;
    modifiedSong.order_cnt = song->order_cnt;
    modifiedSong.order1 = song->order1;
    modifiedSong.order2 = song->order2;
    modifiedSong.order3 = song->order3;
    modifiedSong.order4 = song->order4;
    modifiedSong.duty_instruments = song->duty_instruments;
    modifiedSong.wave_instruments = song->wave_instruments;
    modifiedSong.noise_instruments = song->noise_instruments;
    modifiedSong.routines = song->routines;
    modifiedSong.waves = song->waves;

    hUGE_init(&modifiedSong);
}

void stopSong()
{
    NR12_REG = NR22_REG = NR32_REG = NR42_REG = 0;
    remove_VBL(hUGE_dosound);
}
