#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"

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
static void phaseGameoverInit();
static void phaseGameoverLoop();

/* INPUT METHODS */

/* HELPER METHODS */

/* DISPLAY METHODS */


void gameoverStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseGameoverInit();
            break;
        case SUB_LOOP:
            phaseGameoverLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseGameoverInit()
{
    // Initializations
    init_bkg(0xFFU);
    animTick = 0U;
  
    HIDE_WIN;
    scroll_bkg(-4, 0U);  // For centering the text

    printLine(5U, 7U, "GAME OVER", FALSE);
    printLine(5U, 8U, "SCORE:", FALSE);

    set_bkg_tile_xy(11U, 8U, k/100U);
    set_bkg_tile_xy(12U, 8U, (k/10U)%10U);
    set_bkg_tile_xy(13U, 8U, k%10U);
    
    substate = SUB_LOOP;
    fadein();
}

void phaseGameoverLoop()
{
    ++animTick;
    
    if ((animTick % 64U) / 48U == 0U)
    {
        printLine(4U, 13U, "PRESS START", FALSE);
    }
    else
    {
        for (i = 4U; i != 15U; ++i)
            set_bkg_tile_xy(i, 13U, 0xFFU);
    }

    if (curJoypad & J_START && !(prevJoypad & J_START))
    {
        // fadeout();
        init_bkg(0xFFU);
        
        move_bkg(0U, 0U);

        gamestate = STATE_TITLE;
        substate = SUB_INIT;
    }  
}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
