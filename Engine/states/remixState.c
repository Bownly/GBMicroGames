#include <gb/gb.h>
#include <rand.h>

// #include "../../Engine/common.h"
// #include "../../Engine/enums.h"
// #include "../../Engine/fade.h"
#include "../common.h"
#include "../enums.h"
#include "../fade.h"

#include "../res/sprites/engineCartArts.h"

extern UINT8 curJoypad;
extern UINT8 prevJoypad;
extern UINT8 i;  // Used mostly for loops
extern UINT8 j;  // Used mostly for loops
extern UINT8 k;  // Used for whatever
extern INT8 l;  // Used for whatever
extern UINT8 m;  // Used for menus generally
extern UINT8 n;  // Used for menus generally
extern UINT8 r;  // Used for randomization stuff

extern UINT8 substate;
extern UINT8 mgDifficulty;  // Readonly!
extern UINT8 mgSpeed;  // Readonly!
extern UINT8 mgStatus;

extern UINT8 animTick;
extern UINT8 animFrame;


/* SUBSTATE METHODS */
void phaseRemixInit();
void phaseRemixLoop();

/* INPUT METHODS */

/* HELPER METHODS */

/* DISPLAY METHODS */


void remixStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseRemixInit();
            break;
        case SUB_LOOP:
            phaseRemixLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseRemixInit()
{
    // Initializations
    init_bkg(0xFFU);
    // init_bkg(0x01U);
    animTick = 0U;
    HIDE_WIN;
  
    drawPopupWindow(2U, 0U, 15U, 12U);
    for (i = 0U; i != 20U; ++i)
    {
        set_bkg_tile_xy(i, 13U, 0xF1U);
        // set_bkg_tile_xy(i, 12, 0xF6U);
    }

    set_bkg_data(0x40, engineCartArts_TILE_COUNT, engineCartArts_tiles);
    for (i = 0U; i != 5U; ++i)
    {
        for (j = 0U; j != 4U; ++j)
            set_bkg_tiles(3U + i * 3U, 1U + j * 3U, 2U, 2U, engineCartArts_map + (i+j*5U) *4U);
    }

    substate = SUB_LOOP;
    fadein();
}

void phaseRemixLoop()
{
    ++animTick;
    
    // if ((animTick % 64U) / 48U == 0U)
    // {
    //     printLine(4U, 13U, "PRESS START", FALSE);
    // }
    // else
    // {
    //     for (i = 4U; i != 15U; ++i)
    //         set_bkg_tile_xy(i, 13U, 0xFFU);
    // }

    if (curJoypad & J_START && !(prevJoypad & J_START))
    {
        fadeout();
        initrand(DIV_REG);
        move_bkg(0U, 0U);

        gamestate = STATE_MICROGAME_MANAGER;
        substate = SUB_INIT;
        mgStatus = PLAYING;
    }  
}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
