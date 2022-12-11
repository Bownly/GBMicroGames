#include <gb/gb.h>
#include "../hUGETracker/hUGEDriver.h"

#include "common.h"
#include "enums.h"

extern const hUGESong_t engineSloopygoopBoogieWoogieEx;
extern const hUGESong_t premgJingle;
extern const hUGESong_t wonJingle;
extern const hUGESong_t lostJingle;

extern UINT8 mgSpeed;
extern UINT8 oldBank;

void playSong(const hUGESong_t * song)
{
    NR12_REG = NR22_REG = NR32_REG = NR42_REG = 0;
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

void playOutsideSong(UINT8 songName)
{
    switch (songName)
    {
        default:
        case BOOGIE_WOOGIE:
            oldBank = CURRENT_BANK;
            SWITCH_ROM(5U);
            playSong(&engineSloopygoopBoogieWoogieEx);
            SWITCH_ROM(oldBank);
            break;
        case WON_JINGLE_1:
            SWITCH_ROM(14U);
            playSong(&wonJingle);
            break;
        case LOST_JINGLE_1:
            SWITCH_ROM(14U);
            playSong(&lostJingle);
            break;
        case PRE_MG_JINGLE_1:
            SWITCH_ROM(14U);
            playSong(&premgJingle);
            break;
    }
}

void stopSong()
{
    NR12_REG = NR22_REG = NR32_REG = NR42_REG = 0;
    remove_VBL(hUGE_dosound);
}
