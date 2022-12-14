#include <gb/gb.h>

#include "ram.h"
#include "database/microgameData.h"


UBYTE ram_data[16U];
extern UBYTE *data;
extern UINT8 i;


void saveLanguageSetting(UINT8 lang)
{
    SWITCH_RAM(0U);
    data = &ram_data[RAM_LANGUAGE_ADDR];
    *data = lang;
}

UINT8 loadLanguageSetting()
{
    SWITCH_RAM(0U);
    return ram_data[RAM_LANGUAGE_ADDR];
}

void wipeLanguageSetting()
{
    SWITCH_RAM(0U);
    ram_data[RAM_LANGUAGE_ADDR] = 0U;
}


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

void wipeHighScore()
{
    SWITCH_RAM(0U);
    ram_data[RAM_HIGHSCORE_ADDR] = 0U;
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


void wipeAllMGScores()
{
    SWITCH_RAM(0U);
    for (i = 0; i != MICROGAME_COUNT; ++i)
    {
        ram_data[RAM_HIGHSCORE_ADDR + i] = 0U;
    }
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

void wipeAllMGToggles()
{
    SWITCH_RAM(0U);
    for (i = 0; i != MICROGAME_COUNT; ++i)
    {
        ram_data[RAM_MG_TOGGLED_ADDR + i] = 0U;
    }    
}