#include <gb/gb.h>

#include "ram.h"


UBYTE ram_data[16U];
extern UBYTE *data;


void saveHighScore(UINT8 score)
{
    SWITCH_RAM(0U);
    data = &ram_data[RAM_HIGHSCORE_ADDR];
    *data = score;
}

UINT8 loadHighScore()
{
    SWITCH_RAM(0U);
    return ram_data[RAM_HIGHSCORE_ADDR];
}

void saveMGScore(UINT8 mgId, UINT8 score)
{
    SWITCH_RAM(0U);
    data = &ram_data[RAM_MG_HIGHSCORE_ADDR + mgId];
    *data = score;
}

UINT8 loadMGScore(UINT8 mgId)
{
    SWITCH_RAM(0U);
    data = &ram_data[RAM_MG_HIGHSCORE_ADDR + mgId];
    return ram_data[RAM_MG_HIGHSCORE_ADDR + mgId];
}

void saveMGToggle(UINT8 mgId, UINT8 toggleOnOrOff)
{
    SWITCH_RAM(0U);
    data = &ram_data[RAM_MG_TOGGLED_ADDR + mgId];
    *data = toggleOnOrOff;
}

UINT8 loadMGToggle(UINT8 mgId)
{
    SWITCH_RAM(0U);
    return ram_data[RAM_MG_TOGGLED_ADDR + mgId];
}
