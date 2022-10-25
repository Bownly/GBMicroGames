#include <gb/gb.h>
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
