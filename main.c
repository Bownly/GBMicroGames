#include <gb/gb.h>
#include <rand.h>

#include "Engine/common.h"
#include "Engine/enums.h"
#include "Engine/fade.h"
#include "Engine/ram.h"

#include "Engine/structs/Microgame.h"

#include "Engine/states/creditsState.h"
#include "Engine/states/deleteSaveState.h"
#include "Engine/states/gameoverState.h"
#include "Engine/states/mainMenuState.h"
#include "Engine/states/microgameManagerState.h"
#include "Engine/states/remixState.h"
#include "Engine/states/titleState.h"

#include "Engine/res/tiles/borderTiles.h"
#include "Engine/res/tiles/fontTiles.h"
#include "Engine/res/tiles/alBhedFontTiles.h"

// Save data stuff
const UBYTE RAM_SIG[4U] = {'G','B','M','G'};
UBYTE *data;

UINT8 vbl_count;
UINT8 curJoypad;
UINT8 prevJoypad;
UINT8 i;  // Used mostly for loops
UINT8 j;  // Used mostly for loops
UINT8 k;  // Used for whatever
UINT8 l;  // Used for whatever
UINT8 m;  // Used for menus generally
UINT8 n;  // Used for menus generally
UINT8 r;  // Used for randomization stuff

UINT8 gamestate = STATE_TITLE;
UINT8 substate;
UINT8 oldBank;
UINT8 curSongBank;
UINT8 mgDifficulty = 0U;
UINT8 mgSpeed = 0U;
UINT8 mgStatus;
Microgame mgCurrentMG;
MGPOOLTYPE mgPoolType;
UINT8 language;
UINT8 shouldRestartSong;

UINT8 animFrame = 0U;
UINT8 animTick = 0U;


void initRAM(UBYTE);

void main()
{
    init_bkg(0xFFU);
 	initRAM(0U);

    // Sound stuff
    NR52_REG = 0x80; // is 1000 0000 in binary and turns on sound
    NR50_REG = 0x77; // sets the volume for both left and right channel just set to max 0x77
    NR51_REG = 0xFF; // is 1111 1111 in binary, select which chanels we want to use in this case all of them. One bit for the L one bit for the R of all four channels
    set_interrupts(LCD_IFLAG | TIM_IFLAG | VBL_IFLAG);
    shouldRestartSong = TRUE;

    set_bkg_data(0xF0U, 8U, borderTiles);

    ENABLE_RAM;
    language = loadLanguageSetting();
    if (language == 1U)
        set_bkg_data(0U, 46U, alBhedFontTiles);
    else
        set_bkg_data(0U, 46U, fontTiles);
    DISABLE_RAM;

    DISPLAY_ON;
    SHOW_SPRITES;
    SHOW_BKG;
    SHOW_WIN;
    move_win(160U,144U);

    gamestate = STATE_TITLE;
    substate = SUB_INIT;

    while(1U)
    {
        wait_vbl_done();

        switch(gamestate)
        {
            case STATE_TITLE:
                SWITCH_ROM(4U);
                titleStateMain();
                break;
            case STATE_MAIN_MENU:
                SWITCH_ROM(4U);
                mainMenuStateMain();
                break;
            case STATE_DELETE_SAVE:
                SWITCH_ROM(4U);
                deleteSaveStateMain();
                break;
            case STATE_MICROGAME_MANAGER:
                // SWITCH_ROM(0U);
                microgameManagerStateMain();
                break;
            case STATE_MICROGAME:
                microgameManagerGameLoop();
                break;
            case STATE_REMIX:
                SWITCH_ROM(4U);
                remixStateMain();
                SWITCH_ROM(5U);  // The song data lies in bank 5
                break;
            case STATE_GAMEOVER:
                SWITCH_ROM(1U);
                gameoverStateMain();
                break;
            case STATE_CREDITS:
                SWITCH_ROM(4U);
                creditsStateMain();
                break;
        }
    }
}


void initRAM(UBYTE force_clear)
{
    UBYTE initialized;

    ENABLE_RAM_MBC1;
    SWITCH_RAM_MBC1(0U);

    // Check for signature
    initialized = 1U;
    for (i = 0U; i != 4U; ++i)
    {
        if (ram_data[RAM_SIG_ADDR + i] != RAM_SIG[i])
        {
            initialized = 0U;
            break;
        }
    }

    // Initialize memory
    if (initialized == 0U || force_clear)
    {
        for(i = 0U; i != 255U; ++i) {
            ram_data[i] = 0U;
        }

        for (i = 0U; i != 7U; ++i) {
            ram_data[RAM_SIG_ADDR + i] = RAM_SIG[i];
        }
    }

    DISABLE_RAM_MBC1;
}

